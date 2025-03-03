SUMMARY = "Safety Function for DoC HPS"
DESCRIPTION = "EXAMPLE DESIGN PROVIDED IN INTEL DESIGN STORE"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"

DEPENDS = "ncurses"
RDEPENDS:${PN} += " bash "

SRC_URI = "\
        file://${BPN}_1.0.tar.gz;sha256sum=e5990e956e3a922180a34c6f6dbd99bc373738b6760b194acc527f074d3c952b \
        file://hpssafechannel.service;sha256sum=838a3387598ee0bf19815ffa72917a773a83f272010ce556a409c2128b6e68d5 \
        file://start_agx7.sh;sha256sum=5490bc6dac71bc781f5a76137c3128f6be4a26d43a9c1bc4134b008aed10e658 \
        file://start_agx5.sh;sha256sum=d3b531fe07db089dd8f0f734162d4390605b9943b80c55df298fd22461bd88fe \
        file://q;sha256sum=66d2cf16dab923a6de7492b0882ff642f92cbf9a8423d3fcd830bdb39bbf0c8eccb \
"

S = "${WORKDIR}"

# Pass arguments to linker
TARGET_CC_ARCH += "${LDFLAGS}"

do_compile() {
    oe_runmake all
}

do_install() {
    install -d ${D}/opt/${BPN}
    install -m 0755 ${BPN} ${D}/opt/${BPN}
    
    install -d ${D}${systemd_unitdir}/system
    install -d ${D}${bindir}

    install -m 0644 ${WORKDIR}/${BPN}.service ${D}${systemd_unitdir}/system/
    install -m 0755 ${WORKDIR}/q ${D}${bindir}

    case "${MACHINE}" in
        *"agilex7_"*)
            install -m 0755 ${WORKDIR}/start_agx7.sh ${D}${bindir}/start.sh
            ;;
        *"agilex5_"*)
            install -m 0755 ${WORKDIR}/start_agx5.sh ${D}${bindir}/start.sh
            ;;
        *)
            ;;
    esac
}

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "${BPN}.service"

FILES:${PN} = "\
	/opt/${BPN}/* \
	${bindir} \
	${systemd_unitdir} \
"
FILES:${PN} += "${systemd_unitdir}"
