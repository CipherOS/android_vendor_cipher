$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mini common Lineage stuff
$(call inherit-product, vendor/cipher/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Freeform window management
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

$(call inherit-product, vendor/cipher/config/wifionly.mk)
