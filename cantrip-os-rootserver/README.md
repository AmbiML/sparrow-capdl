# cantrip-os-rootserver: the Sparrow/CantripOS rootserver

Sparrow is a project to build a low-power secure embeded platform
for Ambient ML applications. The target platform leverages
[RISC-V](https://riscv.org/) and [OpenTitan](https://opentitan.org/).

The Sparrow
software includes a home-grown operating system named CantripOS, that runs
on top of [seL4](https://github.com/seL4) and (ignoring the seL4 kernel)
is written almost entirely in [Rust](https://www.rust-lang.org/).

This is an alternative to the C-based capdl-loader-app included in the
seL4 CAmkES code base. cantrip-os-rootserver is written in Rust and supports
features needed by CantripOS to support dynamic memory allocation and running
CantripOS applications. cantrip-os-rootserver depends on code in the cantrip-os-common
crate(s); especially the cantrip-os-capdl and cantrip-os-model crates that implement
the bulk of capDL specification reading and processing (to instantiate a
running system).

cantrip-os-rootserver requires the seL4 kernel configuration. To do this it employs
the sel4-config build support and requires the SEL4_OUT_DIR environment variable
to find the kernel build artifacts.

## Source Code Headers

Every file containing source code includes copyright and license
information. For dependent / non-Google code these are inherited from
the upstream repositories. If there are Google modifications you may find
the Google Apache license found below.

Apache header:

    Copyright 2022 Google LLC

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
