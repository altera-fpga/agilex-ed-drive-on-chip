LINUX_VERSION = "6.6.37"
LINUX_VERSION_SUFFIX = "-lts"
RT_LINUX_VERSION = "6.6.36"
RT_PATCH_VERSION = "35"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRCREV = "346486b5245fb21b577dbb86a0d8d609bc5d8643"

include recipes-kernel/linux/linux-socfpga.inc

SRC_URI:append = " https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-${RT_LINUX_VERSION}-rt${RT_PATCH_VERSION}.patch.gz;name=rt-patch;apply=yes"

SRC_URI[rt-patch.sha256sum] = "5723c9b8262e3f53f411a7cbc032bc3d9cbfe5c41309e28a444db8cf6f3f71f8"

