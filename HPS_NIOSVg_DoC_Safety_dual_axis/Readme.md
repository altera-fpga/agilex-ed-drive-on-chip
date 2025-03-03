# Drive-On-Chip with Functional Safety Design Example based on NIOSV/g with Hard Processor System - Hardware Repository (**HW**).
<br>

## Overview.

This repository contains the necessary files and collateral to build and create a Quartus Prime Project variant of the Drive-On-Chip (DoC) with Functional Safety with an HPS instance for speed monitoring.

This design demonstrates how to achieve IEC 61508 SIL 2 and ISO 13849 Cat 3 PLd safety certification using Agilex SoC devices.
The design is based on the TÜV Rheinland approved Intel Cyclone V SoC FPGA Cat 3 PLd and SIL 2 safety concept Altera does not intend you to certify the design.
Therefore, Altera only applies the safety design process described in IEC 61508 only where relevant. The design shows how you apply the Altera SoC FPGA Cat 3 PL d and SIL 2 safety concept. The
architecture is based around a particular component of the drive-on-chip, the speed limit.
You can extend the concept to monitor, cross-compare, and control other relevant physical and logical variables that are key for safety.

This design demonstrates synchronous control of up to two three-phase permanent magnet synchronous motors (PMSMs) or brushless DC (BLDC) motors.
The design includes a motor and power board model that removes the need for a physical motor setup.
This design is an extension of the existing Drive-on-Chip Design Example for Agilex Devices. It includes safety function to demonstrate how Agilex SoC devices may achieve IEC 61508 SIL 2 or ISO 13849 Cat 3 PL d safety certification.
You need a Development Kit to run the design. The motor and power model helps you tune and test the control system before using a physical power stage. The motor and power board model are based on the former Tandem Motion 48V board, described in [AN 994](https://www.intel.com/content/www/us/en/design-example/780360/intel-agilex-7-fpga-drive-on-chip-for-intel-agilex-7-devices-design-example.html) Drive-on-Chip Design Example for Agilex 7 Devices.

The products of this repository are a SOF, JIC and, RBF files.
**Note: To produce the JIC/RBF pair files known as "Flash image for HPS First configuration bitstream, phase 1" and  "HPS First configuration bitstream, phase 2" respectively; a **u-boot-spl-dtb.hex** file is needed which is a product of the **"OS"** component compilation.
<br>
<br>

### a. Software Requirements.

The Modular Design Toolkit (MDT) requires the following software and versions (in Linux or Windows):
1. Intel Quartus Prime Pro version (24.2 or above).
2. Device Support.
3. FPGA NiosV/g Open-Source Tools 24.2 (installed with Quartus Prime).

Optional
— MATLAB 2021b with Simulink (Optional).
— DSP Builder for Intel FPGAs Pro Edition v23.3.

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
### a. Create the "Drive-On-Chip with Functional Safety Design Example based on NIOSV/g with Hard Processor System" Quartus and Platform Designer Project based on the Modular Design Toolkit.
Follow the next steps to create the Quartus and Platform Designer Project for [Agilex™ 5 FPGA E-Series 065B Modular Development Kit](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/a5e065b-modular.html) You can select any other available XML targeting other boards from the "HPS_NIOSVg_DoC_Safety_dual_axis" directory.
**Clone the repository using "--recurse-submodules" and create the Quartus project:**
```
cd <workspace> 
git clone -b <QUARTUS_REL_TAG> --recurse-submodules https://github.com/intel-innersource/applications.fpga.reference-designs.projects.doc-variants.git
cd applications.fpga.reference-designs.projects.doc-variants
quartus_sh -t ./modular_design_toolkit/scripts/create/create_shell.tcl -xml_path ./HPS_NIOSVg_DoC_Safety_dual_axis/AGX_5E_Modular_Devkit_HPS_NIOSVg_DoC_safe_dual_axis.xml -proj_path <project> -o
```
This will create your Quartus Prime and Platform Designer Project in \<project>. The folder structure is consistent with the "Modular Design Toolkit" methodology documented in [Readme.md](https://github.com/intel-innersource/applications.fpga.reference-designs.projects.modular-designs-toolkit/blob/main/Readme.md) file.
<br>
<br>

### b. Build the "Drive-On-Chip with Functional Safety Design Examples based on NIOSV/g with Hard Processor System" Quartus and Platform Designer Project based on the Modular Design Toolkit.
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
The following block diagram shows the main components and subsystems of the "Drive-On-Chip with Functional Example Design"
<br>
<br>

![image](https://github.com/user-attachments/assets/d81ec1fb-591e-4bcb-bc7f-74e5701169e0)

<br>
<br>
The diagram is color-coded to match the Platform Designer view and the XML contained in the "designs" folder in this repository. The following figure correlates the block diagram, the XML file and the Platform Designer view:
<br>
<br>

![image](https://github.com/user-attachments/assets/e45e85a1-4af8-43bb-b537-1d9a1c1a5aea)

<br>

## Safety-specific Hardware Subsystems and Components.

### a. Safety Subsystem.
The safety subsystem consists of various submodules that collect appropriate
information to indicate the status and actions of the whole system, which passes into
the external safety logic.
The safety subsystem comprises the following blocks:

   * Safety block (FPGA implementation of the safety channel)   
   * Quadrature encoder pulse
   * Interval timer
   * Push button debounce (for reset)
   * Bridges for control and device access.
<br>

![image](https://github.com/user-attachments/assets/82e88831-c121-4777-a5a5-9ea46deffe45)
<br>

#### a.1. Safety Block.
This block implements the FPGA safety channel. It has two main functional blocks: FPGA safety function block and the FPGA cross-comparison function for HPS-FPGA payloads.
<br>
<br>
##### a.1.1 Safety Function Block
Contains the FUSA and timer heartbeat generator, speed estimator, and payload generator.
<br>

 * FUSA and Timer Heartbeat Generator: The heartbeat generator monitors the condition of all the other IPs in the FPGA and HPS channels. The generate bit is a control signal that toggles the heartbeat. For the FPGA, the generate input is derived from the FPGA Comparison Function state machine's start output, which in turn triggers from the timeout. Therefore, the FPGA heartbeat signal indicates correct restarting controlled by the software and operating comparison function state machine.
  * Speed Estimator: The speed estimator estimates the speeds of the motor model based off quadrature encoder pulse count. Using this calculated value, the module determines respective safety bits, which pass into the external safety logic. The main algorithm of the estimator is similar to the one in drive on chip, with additional safety diagnostics. The speed estimator module controls local parameters and modifies sampling frequencies.
  * Payload Generator: The payload generator takes in many different signals from around the overall safety block and generates a payload with all the relevant information. The FPGA-side payload is passed into the cross-comparison block for relevant and respective checks.
    <br>
    The following table shows the format for the payload data.
    <br>
    | Bit range          |  Length  | Intended Data               |   Description                   |
    | ---                |   ---    |  ---                        |   ---                           |
    |     [0]            |  1 bit   |  Overspeed indication       |   1 for Overspeed               |
    |     \[25:1]        |  25 bits |  Estimated speed            |   Measured in rpm               |
    |     \[31:26]       |  6 bits  |  Sequence                   |   Implemented an internal counter to register the sequence of measurements.(0-128) always looping around. |

    <br>
  
##### a.1.2 Cross-Comparison Block.
The cross-comparison block consists mainly of a state machine which, when triggered by the timer, writes to and reads from the shared memory to compare the FPGA payload with the HPS payload. The following diagram specifies the in-built states of the state machine.
<br>
    
![image](https://github.com/user-attachments/assets/150a19e3-140f-4115-8cc6-b6534dd13321)
<br>
<br>
When triggered in the initial *init* state by the timer, the state machine waits a clock cycle for the payload to be generated before writing it to the shared memory. The
FPGA status location is then updated in the shared memory to indicate that the FPGA payload is valid. The state machine then waits, checking the shared memory location
for the HPS status to determine when the HPS writes its payload data to the shared memory. The design performs cross comparison that verifies that the payload
sequence number in the two payloads matches and also that the two speeds match to within the allowed tolerance. Various factors determine the acceptable tolerance between the two speed estimations:
The maximum acceleration of the motor
    - The interrupt response time in the HPS software
    - The alignment of the 4 kHz speed estimation sampling between the HPS and FPGA
    - Clock cycle tolerance in the sampling of the encoder quadrature. One decoder can sample a change in the quadrature signals one clock cycle after the other.
    
Although the overspeed flag is in the payload data, the design does not cross compare flags because tolerances in the speed estimation means that one speed estimation can
be just over the threshold and one just under. Hence the overspeed flags not matching is a valid condition.
The state machine then updates the FPGA status in the shared memory to indicate when the FGPA completes its cross comparison. The state machine then waits,
monitoring the HPS status for its cross comparison to be complete. The FPGA state machine then clears the HPS status in the shared memory and the
HPS reciprocally clears the FPGA status in the shared memory. This handshaking ensures that state machines in the FPGA and HPS remain synchronized with each
other. The FPGA state machine then returns to the initial state and the process repeats.

Between the *generate* state and returning to the *init* state, the design enables a watchdog timer. This watchdog prevents the FPGA state machine from waiting
indefinitely for the HPS. If the watchdog expires, the state machine transitions to the error state and the *compare_good_p/n* output pair is asserted. The design only exits the error state when the *reset_safety_n* input is asserted (active-low).
<br>

#### a.2. Quadrature Encoder Pulse.
The quadrature encoder pulse IP decodes the quadrature inputs from the position encoder, signals A, B and I. The Drive-on-Chip with Functional Safety Design Example
design reuses the IP from the Drive-on-Chip Design Example. However, it now exposes the count value to pass it for further analysis. The IP also monitors any errors due to overspeed.where both A and B phases
of the quadrature change in the same sampling period. The IP may monitor the encoder’s error output.

#### a.3. Interval Timer.
The interval timer from the Quartus or Platform Designer IP catalog is the source of synchronization of the FPGA channel and the HPS channel. Calculating the speed in
both the channels, the cross comparison, and evaluating the safety function must occur in the interval between the timer timeout and interrupt signals.

The interval timer provides the safety response time. In this design, the safety response time is 1 ms. During that time, the FPGA channel generates a payload,
writes the payload to shared memory, retrieves the payload from the HPS, and runs the comparison. Similar for the HPS safety channel. The HPS uses the interrupt line
from Linux to start the safety function.

In this design, the timer is set to 1 ms interval by writing a count value according by the clock frequency of the timer (in this case 100 MHz). This IP writes to the registers
periodl and periodh. Then, the timer runs in free running mode by writing a 0x7 in the control register. When the count reach 0x0, the timer issues an Interrupt for the
Linux system (the timer is registered as a UIO device in the Linux DTS with its corresponding interrupt number) and the design assert the timeout output. These
signals trigger the safety function in the FPGA and HPS channel respectively. When the interrupt occurs, the systems clears the interrupt and the timeout signal and sets the
timer to free running mode again

### b. Shared Memory Subsystem.
The shared memory is a 4x32 bit dual-port block RAM. One side connects via AXI to the HPS. The other side connects via APB interface to the
FPGA cross comparison block. The design implements error correction codes (ECC) on both ports, allowing single-bit errors to be automatically corrected and multibit errors
to be detected. The correction of single-bit errors allows the safety function to continue despite a single fault. If uncorrectable multibit errors are detected, the
*memory_fault_p/n* complementary-pair output is asserted. You can only deassert this output by the active-low *reset_safety_n* input.

####  Intended Shared Memory Address Map. 

| Address       |   Data                     | 
| ---           |   ---                      |
|     0x0       |         FPGA payload       |
|     0x4       |         FPGA status        |
|     0x8       |         HPS payload        |
|     0xC       |         HPS status         |

####  Intended definition of Status Bit

| FPGA status / HPS status bit       |   Meaning                     | 
| ---                                |   ---                         |
|     0                              |         Valid data from the channel is ready to be compared. Comparison pending.|
|     1                              |         Comparison done in the corresponding channel|
<br>

### c. External Safety Logic Subsystem.
The external safety logic identifies common causes of failures and disparities in the overall system. You can model the external safety logic via internal logic when no
external device is present. The following descriptions state each of the diagnostics external safety logic Implements.
<br>

  *  **Results of payload comparison:** Both the FPGA and HPS process their own comparisons to ensure both values of payload agree. The design passes these outputs into the external safety logic to ensure that both comparison checks agree.
  *  **Clock Checker:** The external safety logic actively takes in respective FPGA and HPS clocks as inputs of different frequencies. The design processes these signals through the clock checker to ensure frequencies are in a tolerable range.
      The clock checker takes a fixed reference clock and its respective reset, and compares it to a clock under comparison. Using fixed parameterizable thresholds, the clock checker determines whether the clock under test falls into appropriate and safe
      frequencies. The external safety logic uses the clock checker to ensure that HPS and PGA clocks operate at appropriate frequencies, and the design has no instances of
      skewing or jitter when passing through various blocks.
  *  **Channel Operation:** Refers to the two heartbeat signals present in FPGA and HPS operations. These signals help to identify that everything is functional within a process safety time. The external
     safety logic receives these signals as inputs, which the design then delays using two flip-flops to prevent any metastable values that might fluctuate through. The design
     applies a window check to allow for the heartbeat to arrive within a determinable time span.
  *  **CRAM Configuration Check:** Ensures that no soft errors or transient faults occur.
  *  **Power Supply Check:** Ensures no failures because of loss of power or unsafe operating voltage conditions. The design checks the power supply by using the Mailbox Client with Avalon
     Streaming Interface IP. The design compares the voltages to optimal operating voltage conditions. Refer to Agilex User Guide.
  * **Temperature Check:** Ensures no failures because of unsafe temperatures. The design checks the temperature by using the Mailbox Client with Avalon Streaming Interface IP. The design compares the temperature values against parameterizable temperature limits
    to ensure they are in a safe range. For more details on power supply and temperature check, refer to Agilex Power Management User Guide.
  * **Complementary Bit Package**: The complementary bit package contains a typedef for a definition of type called **compli** which allows effective storage of complementary bit pairs. The complementary bit check also contains fault checking functions to ensure that received
    complementary pairs are organized into the correct format. The design processes external safety logic's I/O in a complementary manner to detect any stuck bits during transmissions. To accommodate any timing delays, complementary pairs can arrive within a preset and adjustable window.
<br>

### d. Hardware Subsystem.
The hardware subsystem collects information about the system, which the external safety logic can use. Agilex devices contain on-chip voltage and temperature sensors.
<br>

The secure device manager stores sampled data, which you can access by using the Mailbox Client with Avalon Streaming Interface Intel FPGA IP. Using the relevant information, external safety logic can determine unsafe temperatures and inoperable
voltage conditions.
<br>

The subsystem comprises command, response, a set of command addresses, and a mailbox client. During the command stage, the mailbox receives preprogrammed addresses. The response stage receives results from the mailbox and sorts into corresponding arrays.
<br>

The following table details the hardware dubsystem's I/O and a description of the signal. All I/O signals are asynchronous to the input clock, to avoid metastability these are synchronized.

![image](https://github.com/user-attachments/assets/8e29bc4d-ad9c-457a-9635-a4bec532966e)
<br>
<br>

## Drive-On-Chip-related Hardware Subsystems and Components.
<br>

This project variant is based on the "Drive-On-Chip Example Design for Agilex Devices" see [AN994](https://www.intel.com/content/www/us/en/docs/programmable/780361/23-1/about-the-drive-on-chip-design-example.html) and [AN1000](https://www.intel.com/content/www/us/en/docs/programmable/826207/24-1/about-the-drive-on-chip-design-example.html). Enhancing it with an instance of the HPS Subsystem (Hard Processor System) to provide a higher level of abstraction for motion control. The subsystems instantiated in the XML file are described below.
<br>
<br>

#### a. HPS Subsystem.
The HPS Subsystem is mainly an instance of the “Hard Processor System Agilex (or other) FPGA IP” and is configured consistently with the GSRD.
The HPS in this design should run all the necessary SW components to implement the HPS safety channel( e.g., OS, RTOS, containers, drivers, user application, etc). Internally, the subsystem comprises the HPS, EMIF for external DDR4 on the development kit, and lightweight and full HPS-to-FPGA bridges.
The lightweight bridge accesses blocks related to the Drive-On-Chip application (drives, motor models, encoders, control memory, GUI memories). The full HPS-to-FPGA bridge connects safety-related blocks (shared safety memory, FPGA safety blocks). The HPS controls the timer that controls the safety function, reads and writes safety payloads, and cleans the FPGA channel control registers if necessary.
<br>

The connection from the HPS2FPGA LW bridge to all drive-on-chip subsystem blocks. This connection allows the HPS to change parameters of the motor control. The connection allows the HPS to run speed estimation using the drive0 encoder.
This design connects the HPS to the block hps_fpga_gpio for the inputs for the external safety logic if any of the safe state conditions in the HPS safety channel is
asserted.
This design subsystem connects the HPS to the hps_fpga_gpio block. The outputs from hps_fpga_gpio are inputs the external safety logic. Asserting the signals from hps_fpga_gpio triggers the safe state condition from the HPS safety channel.
<br>

<br>
<br>

![image](https://github.com/user-attachments/assets/3cc69c8b-1b14-452c-80dc-5d4bdd12259f)
<br>
<br>

#### b. CPU (dnios_) Subsystem.
The Drive-On-Chip Design Example NiosV/g processor subsystem offers a fully functional processor system with debugging capabilities. The NiosV/g processor subsystem comprises the following Platform Designer components: NiosV/g soft processor, on-chip RAM, JTAG master, IRQ management, JTAG UART, timers and, performance counters.
<br>
<br>

![image](https://github.com/user-attachments/assets/613f12f0-460b-4cf9-8ae1-029e39f60723)
<br>
<br>
The ISR uses the memory blocks for code and data to ensure fast, predictable execution time for the motor control algorithm. The NiosV/g subsystem uses the JTAG master and debug memories to allow real-time interactions between the GUI and the processor.
<br>
<br>

#### c. Drive Subsystem.
There are two instances of the "drive_subsystem" in this variant. This subsystem is a collection of IPs to enable interfaces, signals and ports for motor control using FPGA. The main components of this subsystem are Six-channel PWM Interface IP (doc_pwm), a Drive System Monitor IP (doc_sm), Quadrature Encoder Interface IP (doc_qep),  Sigma-Delta ADC interfaces for Drive Axes (doc_adc and doc_adc_pow), an instance of Field-Oriented Control Algorithm IP generated with DSP Builder (doc_foc_fixp), resolver SPI interface IP (doc_rslvr_spi*), and Parallel IO IP (hall pio) for hall interface. More details about these blocks can be found in Application Notes [AN994](https://www.intel.com/content/www/us/en/docs/programmable/780361/23-1/about-the-drive-on-chip-design-example.html) and [AN1000](https://www.intel.com/content/www/us/en/docs/programmable/826207/24-1/about-the-drive-on-chip-design-example.html)
<br>
<br>

![image](https://github.com/user-attachments/assets/c3223df6-86cf-44d6-93de-29a8bcd85335)
<br>
<br>

#### d. Control Subsystem.
The Drive-On-Chip Design uses the debugging RAM to send commands and receive status information. The debugging dump memory stores trace data that you can display as time graphs in the GUI (doc_svm_dump). The  debug memory (doc_sys__debug_ram) is used to interact and provide commands to the Drive-On-Chip control application. The memories contained in the control subsystem are fundamental to interacting with the DoC capabilities and getting feedback signals for debugging and external control.
<br>
In this safety-oriented variant an additional doc_safety_dump memory in the control_subsystem to show safety-related values in another interface e.g. a GUI.
<br>
<br>

![image](https://github.com/user-attachments/assets/942b684b-079e-4b31-a23b-66b1d0219c92)
<br>
<br>

#### e. Motor Model Subsystem.
The Drive-On-Chip Design Example for Intel Agilex Devices implements a motor and power board model instead of a real motor kit. The motor and power board model is a DSP Builder model, which generates the RTL for the motor and power board model. By integrating the Avalon interface, motor parameters are accurately configured to represent a tandem motor kit. You can experiment with the design without investing in an expensive motor kit. You can explore and optimize your designs. The motor model included in this design example is based on the Tandem Motion 48V power board parameter specifications with a Tamagawa TS4747N3200E600 motor. There are two instances of the motor_model_subsystem in this design.
<br>
To expand safety capabilities, the connection between the motor_model subsystem and the esl_subsystem allows you to disconnect the motor from power supply if the system goes into safe state whenever the design detects an unsafe condition. The external safety logic asserts the signal to disconnect the motor.
<br>
<br>

![image](https://github.com/user-attachments/assets/a5a5ea98-0a8d-4f19-9834-05a0f0b37fe2)
<br>
<br>

## General Use Hardware Subsystems and Components.

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

