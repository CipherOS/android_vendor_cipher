# Inherit mini common Lineage stuff
$(call inherit-product, vendor/cipher/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME
