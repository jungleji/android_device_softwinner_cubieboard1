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
    $(LOCAL_KERNEL):kernel

# IR
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

# Audio (src in device/*/*/audio)
PRODUCT_PACKAGES += \
    audio.primary.sun4i \
    audio.a2dp.default \

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


$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_cubieboard1
PRODUCT_DEVICE := cubieboard1
