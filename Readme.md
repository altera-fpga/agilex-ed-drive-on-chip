# Drive-on-Chip variants - Hardware Repository (**HW**)

## Overview

This repository contains a collection of Drive-On-Chip variants based on modular design
methodology. Different variants are targeted for various industrial and robotics use
cases. The project variants are described using XML files that add subsystems to the
designs.

## Available Variants

* **HPS_NIOSVg_DoC_dual_axis**: Drive-On-Chip Example Design with dual axis and Hard
  Processor System for higher-level motion control applications.
  See [HPS_NIOSVg_DoC_dual_axis](./HPS_NIOSVg_DoC_dual_axis) to create and build.
* **HPS_NIOSVg_DoC_3x2_axis**: Drive-On-Chip Example Design with 6 axis and Hard
  Processor System for higher-level motion control applications.
  See [HPS_NIOSVg_DoC_3x2_axis](./HPS_NIOSVg_DoC_3x2_axis) to create and build.
* **HPS_NIOSVg_DoC_Safety_dual_axis**: Drive-On-Chip Example Design with dual axis,
  Hard Processor System and safety blocks to showcase Altera FPGA Safety Concept.
  See [HPS_NIOSVg_DoC_Safety_dual_axis](./HPS_NIOSVg_DoC_Safety_dual_axis)
  to create and build.

## Supporting Repositories

* **modular_design_toolkit**: This is an instance of the "Modular Design Toolkit" (MDT)
  repository to create and build Quartus® Prime and Platform Designer projects. You must use
  `--recurse-submodules` when cloning this repository to populate the MDT sources.
  See [modular_design_toolkit](https://github.com/altera-fpga/modular-design-toolkit)
  to know more.

MDT is currently available in Linux.
