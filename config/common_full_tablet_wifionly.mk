# Inherit full common Lineage stuff
$(call inherit-product, vendor/cipher/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cipher/overlay/dictionaries
