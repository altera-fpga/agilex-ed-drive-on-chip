LINUX_VERSION = "6.12.19"
LINUX_VERSION_SUFFIX = "-lts"
RT_LINUX_VERSION = "6.12.16"
RT_PATCH_VERSION = "9"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRCREV = "7b497655d942b6a44a87a2367463967e433ad422"

include linux-socfpga.inc

SRC_URI:append = " https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-${RT_LINUX_VERSION}-rt${RT_PATCH_VERSION}.patch.gz;name=rt-patch;apply=yes"

SRC_URI[rt-patch.sha256sum] = "c096fa946cb71249a3bddb62818449bf0879a7a509c325f7944f9cd01735cb35"
