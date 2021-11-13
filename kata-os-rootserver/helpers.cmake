#
# Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
#
# SPDX-License-Identifier: BSD-2-Clause
#

cmake_minimum_required(VERSION 3.7.2)

function(BuildCapDLApplication)
    cmake_parse_arguments(PARSE_ARGV 0 CAPDL_BUILD_APP "" "C_SPEC;OUTPUT" "ELF;DEPENDS")
    if(NOT "${CAPDL_BUILD_APP_UNPARSED_ARGUMENTS}" STREQUAL "")
        message(FATAL_ERROR "Unknown arguments to BuildCapDLApplication")
    endif()
    # Require a cspec and an output
    if("${CAPDL_BUILD_APP_C_SPEC}" STREQUAL "")
        message(FATAL_ERROR "C_SPEC is required argument to BuildCapDLApplication")
    endif()
    if("${CAPDL_BUILD_APP_OUTPUT}" STREQUAL "")
        message(FATAL_ERROR "OUTPUT is required argument to BuildCapDLApplication")
    endif()

    # Build a CPIO archive out of the provided ELF files (CAmkES components)
    include(cpio)
    MakeCPIO(
        ${CAPDL_BUILD_APP_OUTPUT}_archive.o
        "${CAPDL_BUILD_APP_ELF}"
        CPIO_SYMBOL
        _capdl_archive
    )

    # Build the application
    add_executable(
        "${CAPDL_BUILD_APP_OUTPUT}"
        EXCLUDE_FROM_ALL
        ${CAPDL_BUILD_APP_OUTPUT}_archive.o
        ${CAPDL_BUILD_APP_C_SPEC}
    )

    add_dependencies("${CAPDL_BUILD_APP_OUTPUT}" ${CAPDL_BUILD_APP_DEPENDS})
    target_include_directories(
        "${CAPDL_BUILD_APP_OUTPUT}"
        PRIVATE $<TARGET_PROPERTY:capdl_app_properties,INCLUDE_DIRS>
    )
    # TODO(sleffler) kata-os-rootserver does not honor the cmake
    #   configuration but capdl_spec.c expects capdl_loader_app/gen_config.h
    #   to exist so generate it
    target_link_libraries(
        "${CAPDL_BUILD_APP_OUTPUT}"
        kata_rootserver
        sel4runtime              # NB: only uses the startup glue
        sel4utils                # NB: for building capdl_spec.c
        capdl_loader_app_Config  # NB: for building capdl_spec.c
    )
endfunction(BuildCapDLApplication)

# Hook for CAmkES build system. This allows CAmkES projects to
# propagate the capDL allocation setting into the loader.
function(SetCapDLLoaderStaticAlloc)
    set(CapDLLoaderStaticAlloc ON CACHE BOOL "" FORCE)
endfunction()
