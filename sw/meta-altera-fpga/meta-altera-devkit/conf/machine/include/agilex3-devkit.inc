UBOOT_CONFIG ??= "agilex3-socdk-atf"
UBOOT_CONFIG[agilex3-socdk-atf] = "socfpga_agilex3_defconfig"

DTS_NAME ?= "socfpga_agilex3_socdk"

require conf/machine/include/agilex3.inc

