FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://uboot_script.its"

# Setup boot script environment
DOLLAR = "$"

do_configure:append() {
    rm -f ${WORKDIR}/uboot.txt

    if [ "${IMAGE_TYPE}" = "mmc" ]; then
        if [ ! -z "${FPGA_BST_SRC_URI}" ]; then
            echo 'load mmc 0:1 ${DOLLAR}{loadaddr} top.core.rbf && dcache flush; fpga load 0 ${DOLLAR}{loadaddr} ${DOLLAR}{filesize};' >> ${WORKDIR}/uboot.txt
        fi

        echo 'mmc rescan;' >> ${WORKDIR}/uboot.txt
        echo 'load mmc 0:1 ${KERNEL_ADDR} Image;' >> ${WORKDIR}/uboot.txt
        echo 'load mmc 0:1 ${FDT_ADDR} ${FDT_NAME}.dtb;' >> ${WORKDIR}/uboot.txt
        echo 'setenv bootargs "${IMAGE_BOOT_ARGS} root=/dev/mmcblk0p2 rw rootwait";' >> ${WORKDIR}/uboot.txt

        if [ ! -z "${FPGA_BST_SRC_URI}" ]; then
            echo 'bridge enable;' >> ${WORKDIR}/uboot.txt
        fi

        echo 'booti ${KERNEL_ADDR} - ${FDT_ADDR};' >> ${WORKDIR}/uboot.txt
        echo 'exit;' >> ${WORKDIR}/uboot.txt
    fi
}

do_compile:append() {
    mkimage -f "${WORKDIR}/uboot_script.its" ${B}/boot.scr.uimg
}

do_deploy:append() {
    install -m 0644 ${B}/boot.scr.uimg ${DEPLOYDIR}/boot.scr.uimg
}
