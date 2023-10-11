# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# LineageOS System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.cipher.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.cipher.releasetype=$(CIPHER_BUILD) \
    ro.cipher.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LINEAGE_VERSION) \
    ro.url.legal=https://cipheros.org/legal \
    ro.url.legal.android_privacy=https://cipheros.org/legal

# LineageOS Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.display.version=$(LINEAGE_DISPLAY_VERSION)

# LineageOS Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
