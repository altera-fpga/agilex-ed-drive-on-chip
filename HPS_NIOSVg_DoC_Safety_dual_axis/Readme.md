# Drive-On-Chip with Functional Safety Design Example based on NIOSV/g with Hard Processor System - Hardware Repository (**HW**)

## Overview

This repository contains the necessary files and collateral to build and create a Quartus Prime Project variant of the Drive-On-Chip (DoC) with Functional Safety with an HPS instance for speed monitoring.

The products of this repository is a SOF file.

**Note:** To produce the JIC/RBF pair files known as "Flash image for HPS First configuration bitstream, phase 1" and  "HPS First configuration bitstream, phase 2" respectively; a **u-boot-spl-dtb.hex** file is needed which is a product of the **"OS"** component compilation.

<br>

## Software Requirements

The Modular Design Toolkit (MDT) requires the following software and versions (in Linux or Windows):

* Altera Quartus® Prime Pro version (24.3 or above).
* Device Support.
* FPGA NiosV/g Open-Source Tools 24.3 (installed with Quartus® Prime).

Optional

* DSP Builder for Altera® FPGAs Pro Edition v24.3.

The following open-source tools need to be installed to compile software targeting Nios V/m processors:

* cmake/3.18.0
* riscv_gnu/baremetal/xpack/10.2.0-1.2
For more information, please refer to this [link](https://www.intel.com/content/www/us/en/products/docs/programmable/niosv-opensource-tools-video.html).

<br>

## Hardware Requirements

To run example systems on hardware, the user may need the appropriate board the design is targeting and any relevant accessories like daughter cards etc.
<br>
<br>

## Creating and compiling the hardware

### Create this Design Example using the Modular Design Toolkit (MDT)

Follow the next steps to create the Quartus® and Platform Designer Project for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) You can select any other available XML targeting other boards from the "HPS_NIOSVg_DoC_Safety_dual_axis" directory.

* Create your workspace and clone the repository using "--recurse-submodules":

```bash
cd <workspace> 
git clone -b <TAG> --recurse-submodules https://github.com/altera-fpga/agilex-ed-drive-on-chip.git doc-variants
```

* Navigate to `doc-variants` directory and create your project in a location of your choice `\<project\>`

```bash
cd doc-variants
quartus_sh -t ./modular_design_toolkit/scripts/create/create_shell.tcl \
   -xml_path ./HPS_NIOSVg_DoC_Safety_dual_axis/AGX_5E_Modular_Devkit_HPS_NIOSVg_DoC_safe_dual_axis.xml \
   -proj_path <project> -o
```

This will create your Quartus® Prime and Platform Designer Project in \<project>. The folder structure is consistent with the "Modular Design Toolkit" methodology.

<br>

### Build this Design Example using the Modular Design Toolkit (MDT)

* Using the command line and the Modular Design Toolkit build script and the project created in the previous step, build the Quartus® project:

```bash
cd <project>/scripts 
quartus_sh -t ./build_shell.tcl -hw_compile -sw_compile
```

<br>

The FPGA programming file is located in `\<project\>/quartus/output_files/top.sof`. Note the `-sw_compile` generates the corresponding **`.elf`** and **`.hex`** files for any embedded NiosV/g processor in the cpu_subsystem and is located in `\<project\>/software/dniosv_subsystem`

**Note:** The user must generate the RBF/JIC pair to boot and program this design example into a boar using the output `top.sof` and a `u-boot-spl-dtb.hex` from the YOCTO and u-boot compilation process

<br>
