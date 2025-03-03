# Dual Axis Drive-On-Chip based on NIOSV/g with Hard Processor System - Hardware Repository (**HW**).
<br>

## Overview.

This repository contains the necessary files and collateral to build and create a Quartus Prime Project variant of the Dual Axis Drive-On-Chip (DoC) with an HPS instance for motion control.
<br>
<br>
The products of this repository are a SOF, JIC and, RBF files.
  **Note: To produce the JIC/RBF pair files known as "Flash image for HPS First configuration bitstream, phase 1" and  "HPS First configuration bitstream, phase 2" respectively; a **u-boot-spl-dtb.hex** file is needed which is a product of the **"OS"** component compilation.
<br>
<br>

### a. Software Requirements.

The Modular Design Toolkit (MDT) requires the following software and versions (in Linux or Windows):
1. Intel Quartus Prime Pro version (24.1 or above) 

The following open-source tools need to be installed to compile software targeting Nios V/m processors,
1. cmake/3.18.0
2. riscv_gnu/baremetal/xpack/10.2.0-1.2
For more information, please refer to this [link](https://www.intel.com/content/www/us/en/products/docs/programmable/niosv-opensource-tools-video.html).

**(Optional)** Build Toolchain for ARM processor. The recommended toolchain is [gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz](https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz)
<br>
<br>

### b. Hardware Requirements.

To run example systems on hardware, the user may need the appropriate board the design is targeting and any relevant accessories like daughter cards etc.
<br>
<br>

## Getting Started.
### a. Create the "Dual Axis Drive-On-Chip based on NIOSV/g with Hard Processor System" Quartus and Platform Designer Project based on the Modular Design Toolkit.
Follow the next steps to create the Quartus and Platform Designer Project for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) You can select any other available XML targeting other boards from the "HPS_NIOSVg_dual_axis" directory.
**Clone the repository using "--recurse-submodules" and create the Quartus project:**
```
cd <workspace> 
git clone -b <QUARTUS_REL_TAG> --recurse-submodules https://github.com/intel-innersource/applications.fpga.reference-designs.projects.doc-variants.git
cd applications.fpga.reference-designs.projects.doc-variants
quartus_sh -t ./modular_design_toolkit/scripts/create/create_shell.tcl -xml_path ./HPS_NIOSVg_DoC_dual_axis/AGX_5E_Modular_Devkit_HPS_NIOSVg_DoC_dual_axis_241.xml -proj_path <project> -o
```
This will create your Quartus Prime and Platform Designer Project in \<project>. The folder structure is consistent with the "Modular Design Toolkit" methodology documented in [Readme.md](https://github.com/intel-innersource/applications.fpga.reference-designs.projects.modular-designs-toolkit/blob/main/Readme.md) file.
<br>
<br>

### b. Build the "Dual Axis Drive-On-Chip based on NIOSV/g with Hard Processor System" Quartus and Platform Designer Project based on the Modular Design Toolkit.
**Using the comandline and the Modular Design Toolkit build scripts and the project created in the previous step, build the Quartus project:**
```
cd <project>/scripts 
quartus_sh -t ./build_shell.tcl -hw_compile -sw_compile
```
<br>

The FPGA programming file is located in <project>/quartus/output_files/*.sof. Note the "-sw_compile" generates the corresponding **"\*.elf"** and **"\*.hex"** files for any embedded NiosV/g processor in the cpu_subsystem and is located in \<project>/software/dniosv_subsystem
<br>
<br>

### c. (Optional) Create phase 1 and phase 2 configuration bitstreams for "HPS First" Flow (Optional).
Follow these steps if the "HPS init" property for the hps_subsystem in the XML is set to "HPS FIRST". You can check this property by executing the following Quartus command and the **"\*.sof"** file. For example:
```
quartus_pfg -i top.sof
```
In the log, look for the property "HPS/FPGA configuration order" SET TO "HPS_FIRST"

![image](https://github.com/user-attachments/assets/7e9f5e33-1b59-41d5-84cf-26e0c6515b41)


**Important!** The following step depends on the output of u-boot compilation specifically the file **u-boot-spl-dtb.hex**. To generate the pair top.core.rbf and top.hps.jic for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) execute:

```
quartus_pfg -c top.sof top.jic -o device=MT25QU02G -o flash_loader=A5ED065BB32AE6SR0 -o hps_path=u-boot-spl-dtb.hex -o mode=ASX4 -o hps=1
```
Program the QSPI flash with the JIC file and paste the RBF file in the **"boot"** partition of your SD card image. To program the QSPI flash:
1. Set the MSEL dipswitch S4 on SOM to JTAG: OFF-OFF
2. Execute: quartus_pgm -c 1 -m jtag -o "pvi;top.hps.jic"
3. Power down the board and Set the MSEL dipswitch S4 on SOM to ASX4 (QSPI): ON-ON

If a valid SD card is used, the system boots Linux after powering up the board.
<br>
<br>

### d. (Optional) Create phase 1 and phase 2 configuration bitstream for "FPGA First" Flow (Optional)
Follow these steps if the "HPS init" property for the hps_subsystem in the XML is set to "AFTER INIT_DONE". You can check this property by executing the following Quartus command and the **"\*.sof"** file. For example:
```
quartus_pfg -i top.sof
```
In the log, look for the property "HPS/FPGA configuration order" SET TO "HPS_FIRST"

![image](https://github.com/user-attachments/assets/bdfd3600-60e1-4723-8055-fa331620a3b0)

**Important!** The following step depends on the output of u-boot compilation specifically the file **u-boot-spl-dtb.hex**. To generate the top.jic for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) execute:


```
quartus_pfg -c -o hps_path=u-boot-spl-dtb.hex -o mode=ASX4 -o device=MT25QU02G -o flash_loader=A5ED065BB32AE6SR0 ../top.sof top.jic
```

Program the QSPI flash with the JIC file:
1. Set the MSEL dipswitch S4 on SOM to JTAG: OFF-OFF
2. Execute: quartus_pgm -c 1 -m jtag -o "pvi;top.hps.jic"
3. Power down the board and Set the MSEL dipswitch S4 on SOM to ASX4 (QSPI): ON-ON

If a valid SD card is used, the system boots Linux after powering up the board.
<br>
<br>

## Hardware Description.
The following block diagram shows the main components and subsystems of the "Drive-On-Chip with PLC Example Design"
<br>
<br>

![image](https://github.com/user-attachments/assets/74fb9558-9fc6-41ed-a67e-1184b5d137c7)

<br>
<br>
The diagram is color-coded to match the Platform Designer view and the XML contained in the "designs" folder in this repository. The following figure correlates the block diagram, the XML file and the Platform Designer view:
<br>
<br>

![image](https://github.com/user-attachments/assets/0f47f69d-5d71-46a0-b912-ca57b76b254c)
<br>
<br>

### Hardware Subsystems and Components.
<br>

This project variant is based on the "Drive-On-Chip Example Design for Agilex Devices" see [AN994](https://www.intel.com/content/www/us/en/docs/programmable/780361/23-1/about-the-drive-on-chip-design-example.html) and [AN1000](https://www.intel.com/content/www/us/en/docs/programmable/826207/24-1/about-the-drive-on-chip-design-example.html). Enhancing it with an instance of the HPS Subsystem (Hard Processor System) to provide a higher level of abstraction for motion control. The subsystems instantiated in the XML file are described below.
<br>
<br>

#### a. Clock and Board Subsystems.
The clock Subsystem alongside the board subsystem contains blocks related to the board resources such as buttons, switches, LEDs, reference clocks, and resets. They provide the clocks and resets for the other subsystems.
<br>
<br>

![image](https://github.com/user-attachments/assets/fdbd6915-070c-4c73-b105-8ac28c2c5160)
<br>
<br>
For this design, the clock and reset are fed from board resources and the generated clocks by the PLL are used in other subsystems.
<br>
<br>

#### b. HPS Subsystem.
The HPS Subsystem is mainly an instance of the “Hard Processor System Agilex (or other) FPGA IP” and is configured consistently with the GSRD. The HPS in this design boots a custom version of Linux based on Yocto to implement any higher-level abstraction motion control interface with the Drive-On-Chip. Internally the subsystem is composed of the HPS, EMIF for external DDR available on the development kit and bridges for the Lightweight and Full HPS to FPGA bridge. The full HPS-to-FPGA bridge is used to interface with the Control Subsystem block. By doing this, the HPS can modify, set and configure the motor control; eg., setting values of speed, position, speed limits, setting up proportional/integral gains of the control loops, etc.
<br>
<br>

![image](https://github.com/user-attachments/assets/e3b29e5e-19e8-4394-b3d8-d991bcd2d594)
<br>
<br>

#### c. CPU (dnios_) Subsystem.
The Drive-On-Chip Design Example NiosV/g processor subsystem offers a fully functional processor system with debugging capabilities. The NiosV/g processor subsystem comprises the following Platform Designer components: NiosV/g soft processor, on-chip RAM, JTAG master, IRQ management, JTAG UART, timers and, performance counters.
<br>
<br>

![image](https://github.com/user-attachments/assets/613f12f0-460b-4cf9-8ae1-029e39f60723)
<br>
<br>
The ISR uses the memory blocks for code and data to ensure fast, predictable execution time for the motor control algorithm. The NiosV/g subsystem uses the JTAG master and debug memories to allow real-time interactions between the GUI and the processor.
<br>
<br>

#### d. Drive Subsystem.
There are two instances of the "drive_subsystem" in this variant. This subsystem is a collection of IPs to enable interfaces, signals and ports for motor control using FPGA. The main components of this subsystem are Six-channel PWM Interface IP (doc_pwm), a Drive System Monitor IP (doc_sm), Quadrature Encoder Interface IP (doc_qep),  Sigma-Delta ADC interfaces for Drive Axes (doc_adc and doc_adc_pow), an instance of Field-Oriented Control Algorithm IP generated with DSP Builder (doc_foc_fixp), resolver SPI interface IP (doc_rslvr_spi*), and Parallel IO IP (hall pio) for hall interface. More details about these blocks can be found in Application Notes [AN994](https://www.intel.com/content/www/us/en/docs/programmable/780361/23-1/about-the-drive-on-chip-design-example.html) and [AN1000](https://www.intel.com/content/www/us/en/docs/programmable/826207/24-1/about-the-drive-on-chip-design-example.html)
<br>
<br>

![image](https://github.com/user-attachments/assets/c3223df6-86cf-44d6-93de-29a8bcd85335)
<br>
<br>

#### e. Control Subsystem.
The Drive-On-Chip Design uses the debugging RAM to send commands and receive status information. The debugging dump memory stores trace data that you can display as time graphs in the GUI (doc_svm_dump). The  debug memory (doc_sys__debug_ram) is used to interact and provide commands to the Drive-On-Chip control application. The memories contained in the control subsystem are fundamental to interacting with the DoC capabilities and getting feedback signals for debugging and external control.
<br>
<br>

![image](https://github.com/user-attachments/assets/942b684b-079e-4b31-a23b-66b1d0219c92)
<br>
<br>
To bare-metal interface with the Drive-On-Chip application to provide commands and configuration use the FULL HPS to FPGA Bridge base address with the following offsets (each a 32-bit wide value). Account for the offset between the first and the second axis.
<br>
| Axis               |   Offset from HPS bridge base                     | 
| ---                |   ---                                             |
|     Axis0          |         0x0008_0000                               |
|     Axis1          |         0x0008_0108                               |
<br>
**Note:** in the previous table the address 0x0008_0000 is the base address of the  debug memory (doc_sys__debug_ram), each Axis has 66 32-bit wide data locations (hence the first axis initiates at 0x0 and the second axis memory space initiates at 0x108).
<br>
<br>
The user can interact with the motor control application by reading or writing to the following memory locations from the Axis* base.
<br>
<br>

| Offset from Axis base  |   Register Name             | Read/Write | Description   |
| ---                    |   ---                       | ---        | ---           |
|     0x00               |   DOC_DBG_DRIVE_STATE       |    R       | State of the Drive System Monitor IP, refer to source code if the Drive-On-Chip app running on NiosV for more details. |
|     0x04               |   DOC_DBG_RUNTIME           |    R       | Time in seconds the DoC App has been running. |
|     0x08               |   DOC_DBG_DSP_MODE          |    R       | Software (0x0) or DSP Builder IP (0x1) Field Oriented Control Algorithm execution. |
|     0x0C               |   DOC_DBG_APP_STATE         |    R       | Drive-On-Chip Embedded Software Application State, refer to source code if the Drive-On-Chip app running on NiosV for more details. |
|     0x10               |   DOC_DBG_LATENCY1          |    R       | Latency of the FOC algorithm calculation. |
|     0x28               |   DOC_DBG_SPEED             |    R       | Measured Speed in RPM of the axis.|
|     0x30               |   DOC_DBG_POSITION          |    R       | Measured postion of the encoder, need to decode the value to get degrees = <value> * 360 / 65536 |
|     0x34               |   DOC_DBG_BUTTON_DSP_MODE   |    R/W     | Software (0x0) or DSP Builder IP (0x1) Field Oriented Control Algorithm execution|
|     0x38               |   DOC_DBG_BUTTON_DRIVE_RESET|    R/W     | Write a 0x1 to the first axis of the array, to reset all axes controlled by a single Nios, this register clears automatically. |
|     0x3C               |   DOC_DBG_DEMO_MODE         |    R/W     | Close-loop, Open-loop, with 16kHz, 32kHz and 64kHz variants, refer to source code if the Drive-On-Chip app running on NiosV for more details. |
|     0x48               |   DOC_DBG_I_PI_KP           |    R/W     | Current Loop Proportional Gain. |
|     0X4C               |   DOC_DBG_I_PI_KI           |    R/W     | Current Loop Integral Gain. |
|     0x50               |   DOC_DBG_SPEED_PI_KP       |    R/W     | Speed Loop Proportional Gain. |
|     0x54               |   DOC_DBG_SPEED_PI_KI       |    R/W     | Speed Loop Integral Gain. |
|     0x58               |   DOC_DBG_SPEED_SETP0       |    R/W     | Speed setpoint for the axis in RPM. |
|     0x64               |   DOC_DBG_POS_SETP0         |    R/W     | Position setpoint. E.g: If you want 1500 degrees then write to the memory location 1500 * 65536 / 360 = 273066 => 0x42AAA |
|     0x74               |   DOC_DBG_WAVE_DEMO_MODE    |    R/W     | Motor control mode 0x0 for speed mode, 0x1 for position mode. |
|     0x78               |   DOC_DBG_POS_SPEED_LIMIT   |    R/W     | Speed limit in position mode in RPM. |
|     0x7C               |   DOC_DBG_POS_PI_KP         |    R/W     | Position Loop Proportional Gain. |
|     0xE0               |   DOC_DBG_LATENCY2          |    R       | ISR Latency. |

<br>
For other values, refer to the source code of the Drive-On-Chip app running on NiosV for more details.
The resulting addressing is as the following:  Target = HPS_bridge_base + _Debug_Memory_Base + (Axis_Number * Axis_Mem_Space_Span) + Offset_from_Axis_Base_Reg. Where Axis_Mem_Space_Span is 0x108.
<br>
For example: to change the speed in RPM of axis1 in an Agilex5 device using the FULL HPS-to-FPGA bridge:
<br>
<br>

 - **DOC_DBG_SPEED_SETP0_add_from_HPS** = HPS_bridge_base + Axis_Base + Offset_from_Axis_Base_Reg
 - **DOC_DBG_SPEED_SETP0_add_from_HPS** = 0x4000_0000 + 0x0008_0108 + DOC_DBG_POS_SETP0; where DOC_DBG_POS_SETP0 is 0x58
 - **DOC_DBG_SPEED_SETP0_add_from_HPS** = 0x4008_0160
<br>

#### f. Motor Model Subsystem.
The Drive-On-Chip Design Example for Intel Agilex Devices implements a motor and power board model instead of a real motor kit. The motor and power board model is a DSP Builder model, which generates the RTL for the motor and power board model. By integrating the Avalon interface, motor parameters are accurately configured to represent a tandem motor kit. You can experiment with the design without investing in an expensive motor kit. You can explore and optimize your designs. The motor model included in this design example is based on the Tandem Motion 48V power board parameter specifications with a Tamagawa TS4747N3200E600 motor. There are two instances of the motor_model_subsystem in this design.
<br>
<br>

![image](https://github.com/user-attachments/assets/a5a5ea98-0a8d-4f19-9834-05a0f0b37fe2)
<br>
<br>


