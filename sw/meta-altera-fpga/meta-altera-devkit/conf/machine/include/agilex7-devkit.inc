UBOOT_CONFIG ??= "agilex-socdk-atf"
UBOOT_CONFIG[agilex-socdk] = "socfpga_agilex_legacy_defconfig"
UBOOT_CONFIG[agilex-socdk-atf] = "socfpga_agilex_defconfig"
UBOOT_CONFIG[agilex-socdk-qspi] = "socfpga_agilex_qspi_legacy_defconfig"
UBOOT_CONFIG[agilex-socdk-qspi-atf] = "socfpga_agilex_defconfig"

DTS_NAME ?= "socfpga_agilex_socdk"

require conf/machine/include/agilex7.inc
