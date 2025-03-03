SUMMARY = "Intel SoCFPGA Device Tree"
DESCRIPTION = "Custom device tree entries for Intel SoCFPGA platform"
SECTION = "bsp"

inherit devicetree

python () {
    if not d.getVar('FDT_SRC_URI'):
        raise bb.parse.SkipRecipe("FPGA device tree variables are not set!")
}

COMPATIBLE_MACHINE = "${FDT_COMPATIBLE_MACHINE}"

SRC_URI = "${FDT_SRC_URI}"
SRC_URI[sha256sum] = "${FDT_SHA256SUM}"

do_configure[depends] += "virtual/kernel:do_configure"

python do_dts_update () {
    import os

    workdir = d.getVar('WORKDIR')
    dts_files = [f for f in os.listdir(workdir) if os.path.isfile(os.path.join(workdir, f)) and f.endswith(".dts")]
    dtsi_files = [f for f in os.listdir(workdir) if os.path.isfile(os.path.join(workdir, f)) and f.endswith(".dtsi")]

    if len(dts_files) == 0 or len(dtsi_files) == 0:
        return

    dts_path = os.path.join(workdir, dts_files[0])

    # Parse dts file to get last include instance
    f = open(dts_path, "r")
    lines = f.readlines()
    inc_index = 0

    for i, l in enumerate(lines):
        if l.startswith("#include"):
            inc_index = i

    if inc_index == 0:
        return
    
    for i, p in enumerate(dtsi_files, start=1):
        lines.insert(inc_index + i, '#include "' + p + '"' + os.linesep)

    f = open(dts_path, "w")
    f.writelines(lines)
    f.close()
}
addtask dts_update after do_configure before do_compile

do_configure:append() {
    rm -f ${WORKDIR}/${FDT_NAME}.dts
    cp ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/intel/${FDT_NAME}.dts ${WORKDIR}/${FDT_NAME}.dts
}
