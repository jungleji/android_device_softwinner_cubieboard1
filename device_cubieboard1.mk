$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/softwinner/cubieboard1/device-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/softwinner/cubieboard1/overlay

LOCAL_PATH := device/softwinner/cubieboard1
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    persist.sys.timezone=Asia/Shanghai \
    persist.sys.language=en \
    persist.sys.country=US \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    debug.egl.hw=1 \
    ro.display.switch=1 \
    ro.sf.lcd_density=160 \
    ro.opengles.version=131072 \
    keyguard.no_require_sim=true \
    persist.sys.strictmode.visual=0 \
    persist.sys.strictmode.disable=1 \
    hwui.render_dirty_regions=false \

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=false \

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=96m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m \
    persist.sys.usb.config=mass_storage,adb \
    ro.property.tabletUI=true \
    ro.udisk.lable=cubie \
    ro.product.firmware=v1.0 \
    ro.sw.defaultlauncherpackage=com.softwinner.launcher \
    ro.sw.defaultlauncherclass=com.softwinner.launcher.Launcher \
    audio.output.active=AUDIO_HDMI \
    audio.input.active=AUDIO_CODEC \
    ro.audio.multi.output=true \
    ro.sw.directlypoweroff=true \
    ro.sw.shortpressleadshut=false \
    ro.softmouse.left.code=6 \
    ro.softmouse.right.code=14 \
    ro.softmouse.top.code=67 \
    ro.softmouse.bottom.code=10 \
    ro.softmouse.leftbtn.code=2 \
    ro.softmouse.midbtn.code=-1 \
    ro.softmouse.rightbtn.code=-1 \
    ro.sw.videotrimming=1 \

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
    device/softwinner/cubieboard1/media_profiles.xml:system/etc/media_profiles.xml \

# init
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/ueventd.sun4i.rc:root/ueventd.sun4i.rc \
    device/softwinner/cubieboard1/init.sun4i.rc:root/init.sun4i.rc \
    device/softwinner/cubieboard1/init.sun4i.usb.rc:root/init.sun4i.usb.rc \
    device/softwinner/cubieboard1/recovery.fstab:recovery.fstab \
    device/softwinner/cubieboard1/vold.fstab:system/etc/vold.fstab \

# permissions
PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \


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
    device/softwinner/cubieboard1/egl.cfg:system/lib/egl/egl.cfg \


# Audio (src in device/*/*/audio, system/media/audio_utils)
PRODUCT_PACKAGES += \
    audio.primary.sun4i \
    audio.a2dp.default \
    libaudioutils \

# hwcomposer (src in device/*/*/hwcomposer)
PRODUCT_PACKAGES += \
    hwcomposer.sun4i \

# display (src in device/*/*/display)
PRODUCT_PACKAGES += \
    display.sun4i \

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
    TvdLauncher \

# Wallpapers (src in packages/wallpapers)
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    LiveWallpapers \
    android.software.live_wallpaper.xml \

# securefile (src in frameworks/base/swextend/securefile)
PRODUCT_PACKAGES += \
    securefileserver \
    libsecurefileservice \
    libsecurefile_jni \

# isomount (src in frameworks/base/swextend/isomountmanager)
PRODUCT_PACKAGES += \
    isomountmanagerservice \
    libisomountmanager_jni \
    libisomountmanagerservice \

# gpio (src in frameworks/base/swextend/gpio)
PRODUCT_PACKAGES += \
    gpioservice \
    libgpio_jni \
    libgpioservice \

# DRM widevine
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L3 \
    libwvdrm_L3 \
    libdrmdecrypt \

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_cubieboard1
PRODUCT_DEVICE := cubieboard1
