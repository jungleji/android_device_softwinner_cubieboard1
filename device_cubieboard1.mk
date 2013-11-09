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

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/softwinner/cubieboard1/sun4i-ir.kl:system/usr/keylayout/sun4i-ir.kl \
    device/softwinner/cubieboard1/audio/audio_policy.conf:system/etc/audio_policy.conf \

PRODUCT_PACKAGES += \
    audio.primary.sun4i \
    audio.a2dp.default \

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_cubieboard1
PRODUCT_DEVICE := cubieboard1
