# Drive-on-Chip Yocto Linux
Config and meta-layers for building a Linux image to run on supported Altera SoC FPGA Devkits.

## Supported Designs
 - `3x2_axis`
 - `dual_axis`
 - `safety_dual_axis`

## Supported Machines

 - `agilex5_modular`
 - `agilex7_dk_si_agf014ea`


## Supported Image Types

 - `mmc` (SD Card)


## Building An Image
 > **Make sure you have read the [Dependencies](meta-fpga-embedded/README.md#dependencies) section from the main documentation before proceeding.**

A core bitstream (`.rbf`) file is required for a successful build and needs to be placed in `meta-driveonchip/recipes-bsp/fpga-bitstream/files`.

You can find prebuilt core bitstream files in the assets for your chosen release or you can build your own. The expected naming convention is `${MACHINE}_${DESIGN}.core.rbf`. For example `agilex5_modular_safety_dual_axis.core.rbf`.

Once you have the core bitstream (.rbf) file in the correct location run the following command to start a build:

```bash
KAS_MACHINE=${MACHINE} kas build kas_${DESIGN}.yml
```
For example:

```bash
KAS_MACHINE=agilex5_modular kas build kas-safety_dual_axis.yml
```

See above for a list of supported `MACHINE` and `DESIGN` identifiers.

Once the build has finished successfully you will have a `.wic` image available in `build/tmp/deploy/images/${MACHINE}` which can be flashed to an SD card.
