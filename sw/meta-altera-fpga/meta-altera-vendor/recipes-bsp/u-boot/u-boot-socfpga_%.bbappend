FILESEXTRAPATHS:prepend := "${THISDIR}/arrow:"
FILESEXTRAPATHS:prepend := "${THISDIR}/macnica:"

# Arrow
SRC_URI:append:agilex5_axe5_eagle = " \
    file://socfpga_agilex5_axe5_eagle_defconfig \
    file://socfpga_agilex5_axe5_eagle.dts \
    file://socfpga_agilex5_axe5_eagle-u-boot.dtsi"

# Macnica
SRC_URI:append:agilex5_sulfur = " \
    file://socfpga_agilex5_sulfur_defconfig \
    file://socfpga_agilex5_sulfur.dts \
    file://socfpga_agilex5_sulfur-u-boot.dtsi"

# Arrow AXE5-Eagle
do_configure:prepend:agilex5_axe5_eagle() {
    cp ${WORKDIR}/socfpga_agilex5_axe5_eagle_defconfig ${S}/configs/
    cp ${WORKDIR}/socfpga_agilex5_axe5_eagle.dts ${S}/arch/arm/dts/
    cp ${WORKDIR}/socfpga_agilex5_axe5_eagle-u-boot.dtsi ${S}/arch/arm/dts/

    sed -i "2i dtb-\$(CONFIG_ARCH_SOCFPGA) += socfpga_agilex5_axe5_eagle.dtb" ${S}/arch/arm/dts/Makefile
}

# Macnica Sulfur
do_configure:prepend:agilex5_sulfur() {
    cp ${WORKDIR}/socfpga_agilex5_sulfur_defconfig ${S}/configs/
    cp ${WORKDIR}/socfpga_agilex5_sulfur.dts ${S}/arch/arm/dts/
    cp ${WORKDIR}/socfpga_agilex5_sulfur-u-boot.dtsi ${S}/arch/arm/dts/

    sed -i "2i dtb-\$(CONFIG_ARCH_SOCFPGA) += socfpga_agilex5_sulfur.dtb" ${S}/arch/arm/dts/Makefile
}

