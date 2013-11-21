# Release name
PRODUCT_RELEASE_NAME := cubieboard1

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/softwinner/cubieboard1/device_cubieboard1.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := cubieboard1
PRODUCT_NAME := cm_cubieboard1
PRODUCT_BRAND := softwinner
PRODUCT_MODEL := cubieboard1
PRODUCT_MANUFACTURER := softwinner
