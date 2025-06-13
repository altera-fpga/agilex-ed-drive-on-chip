# Drive-on-Chip Yocto Linux
Config and Yocto layers for building a Linux image to run on supported Altera SoC FPGA Devkits.

## Supported Designs
 - `3x2_axis`
 - `dual_axis`
 - `safety_dual_axis`

## Supported Machines

 - `agilex5_mk_a5e065bb32aes1`

## Supported Image Types

 - `mmc` (SD Card)

## Building An Image
 > **Make sure you have installed the [required dependencies](meta-altera-fpga/README.md#dependencies) before proceeding.**

```bash
KAS_MACHINE=${MACHINE} kas build kas_${DESIGN}.yml
```
For example:

```bash
KAS_MACHINE=agilex5_mk_a5e065bb32aes1 kas build kas-safety_dual_axis.yml
```

See above for a list of supported `MACHINE` and `DESIGN` identifiers.

Once the build has finished successfully you will have a `.wic.gz` image available in `build/tmp/deploy/images/${MACHINE}` which can be [flashed to an SD card](meta-altera-fpga/docs/flash_sd_card.md).

### Custom Core Bitstream

If you have not checked out a release branch or you would like to use your own core bitstream (`.rbf`) it needs to be placed in `meta-driveonchip/recipes-bsp/fpga-bitstream/files`.

You also need to add the following line to the design configuration file `kas_${DESIGN}.yml`

```
    FPGA_BST_SRC_URI = "file://top.core.rbf"
```

Remove other references to `FPGA_BST_SRC_URI` and `FPGA_BST_SHA256SUM`.

