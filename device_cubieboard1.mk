$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/softwinner/cubieboard1/cubieboard1-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/softwinner/cubieboard1/overlay

LOCAL_PATH := device/softwinner/cubieboard1
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# prebuilt lichee kernel
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \

# IR keylayout
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/sun4i-ir.kl:system/usr/keylayout/sun4i-ir.kl \

# Audio
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/audio/audio_policy.conf:system/etc/audio_policy.conf \

# Media
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/media_codecs.xml:system/etc/media_codecs.xml \
    device/softwinner/cubieboard1/media_profiles.xml:system/etc/media_codecs.xml \

# init
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/ueventd.sun4i.rc:root/ueventd.sun4i.rc \
    device/softwinner/cubieboard1/init.sun4i.rc:root/init.sun4i.rc \
    device/softwinner/cubieboard1/init.sun4i.usb.rc:root/init.sun4i.usb.rc \

# bin files
PRODUCT_COPY_FILES += \
	device/softwinner/cubieboard1/bin/fsck.exfat:system/bin/fsck.exfat \
	device/softwinner/cubieboard1/bin/mkfs.exfat:system/bin/mkfs.exfat \
	device/softwinner/cubieboard1/bin/mount.exfat:system/bin/mount.exfat \
	device/softwinner/cubieboard1/bin/ntfs-3g:system/bin/ntfs-3g \
	device/softwinner/cubieboard1/bin/ntfs-3g.probe:system/bin/ntfs-3g.probe \
	device/softwinner/cubieboard1/bin/mkntfs:system/bin/mkntfs \
	device/softwinner/cubieboard1/bin/busybox:system/bin/busybox \

# for boot nand/card auto detect
PRODUCT_COPY_FILES += \
	device/softwinner/cubieboard1/bin/busybox:root/sbin/busybox \
	device/softwinner/cubieboard1/bin/init_parttion.sh:root/sbin/init_parttion.sh \
	device/softwinner/cubieboard1/bin/busybox:recovery/root/sbin/busybox \
	device/softwinner/cubieboard1/bin/init_parttion.sh:recovery/root/sbin/init_parttion.sh \

# egl config
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard2/egl.cfg:system/lib/egl/egl.cfg \

# Audio (src in device/*/*/audio, system/media/audio_utils)
PRODUCT_PACKAGES += \
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    audio.a2dp.default \
    libaudioutils \

# hwcomposer (src in device/*/*/hwcomposer)
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_BOARD_PLATFORM) \

# display (src in device/*/*/display)
PRODUCT_PACKAGES += \
    display.$(TARGET_BOARD_PLATFORM) \

# Media (src in hardware/aw)
PRODUCT_PACKAGES += \
    libI420colorconvert \
    libstagefrighthw \
    libOmxCore \
    libOmxVenc \
    libOmxVdec \

# Media (prebults in frameworks/av/media/CedarX-Projects/CedarAndroidLib/LIB_JB42_F51)
PRODUCT_PACKAGES += \
    libcedarxbase \
    libcedarxosal \
    libcedarv \
    libcedarv_base \
    libcedarv_adapter \
    libve \
    libaw_audio \
    libaw_audioa \
    libswdrm \
    libstagefright_soft_cedar_h264dec \
    libfacedetection \
    libthirdpartstream \
    libcedarxsftstream \
    libaw_h264enc \
    libsunxi_alloc \
    libjpgenc  \

# Input method (src in packages/inputmethods/)
PRODUCT_PACKAGES += \
    libjni_pinyinime \
    LatinIME \

# fs tools (src in external/e2fsprogs, system/extra/ext4_utils)
PRODUCT_PACKAGES += \
    e2fsck \
    libext2fs \
    libext2_blkid \
    libext2_uuid \
    libext2_profile \
    libext2_com_err \
    libext2_e2p \
    make_ext4fs \

# Allwinner Tvd packages (src in device/*/*/packages/)
PRODUCT_PACKAGES += \
    TvdSettings \
    TvdFileManager \
    TvdVideo \

# Wallpapers (src in packages/wallpapers)
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    LiveWallpapers \
    android.software.live_wallpaper.xml \

# securefile (src in device/*/*/securefile)
PRODUCT_PACKAGES += \
    securefileserver \
    libsecurefileservice \
    libsecurefile_jni \

# isomount (src in device/*/*/isomountmanager)
PRODUCT_PACKAGES += \
    isomountmanagerservice \
    libisomountmanager_jni \
    libisomountmanagerservice \

# gpio (src in device/*/*/gpio)
PRODUCT_PACKAGES += \
    gpioservice \
    libgpio_jni \
    libgpioservice \

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_cubieboard1
PRODUCT_DEVICE := cubieboard1
