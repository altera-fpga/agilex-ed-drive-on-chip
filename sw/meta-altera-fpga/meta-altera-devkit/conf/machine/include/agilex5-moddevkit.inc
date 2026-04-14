DTS_NAME ?= "socfpga_agilex5_socdk_modular"

UBOOT_CONFIG ??= "agilex5-socdk-atf"
UBOOT_CONFIG[agilex5-socdk-atf] = "socfpga_agilex5_modular_defconfig"

require conf/machine/include/agilex5.inc
