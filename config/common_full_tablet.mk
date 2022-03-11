# Inherit full common Lineage stuff
$(call inherit-product, vendor/cipher/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cipher/overlay/dictionaries

$(call inherit-product, vendor/cipher/config/telephony.mk)
