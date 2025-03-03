SUMMARY = "Serial Autologins"
DESCRIPTION = "Modify serial getty for autologin"
SECTION = "core"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"

do_install:append() {
    if [ ! -z "${SERIAL_CONSOLES}" ] ; then
        sed -i -e "s/agetty/agetty --autologin root/g" ${D}${systemd_system_unitdir}/serial-getty@.service
    fi
}
