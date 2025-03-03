LINUX_VERSION = "6.6.22"
LINUX_VERSION_SUFFIX = "-lts"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRCREV = "f939c80e4195178b511c7577e0dc2a570ca0a426"

include recipes-kernel/linux/linux-socfpga.inc

SRC_URI:append = " https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-${LINUX_VERSION}-rt27.patch.gz;name=rt-patch;apply=yes"

SRC_URI[rt-patch.sha256sum] = "5cdd125a3adf04f5602236ff1f915a39fc4d1667b53cbcd337bdf96eeb9b4622"

