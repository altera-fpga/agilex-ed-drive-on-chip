DESCRIPTION = "FPGA Embedded Core Packages"

inherit packagegroup

PACKAGES = "\
    ${PN} \
"

RDEPENDS:${PN} = "\
    ${@ 'device-tree' if d.getVar('FDT_SRC_URI') else ''} \
    ${@ 'fpga-bitstream' if d.getVar('FPGA_BST_SRC_URI') else ''} \
    kernel-module-uio \
    kernel-module-uio-pdrv-genirq \
"
