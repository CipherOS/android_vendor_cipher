# Inherit common mobile Lineage stuff
$(call inherit-product, vendor/cipher/config/common.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    Email \
    ExactCalculator \
    Exchange2

# Lineage packages
PRODUCT_PACKAGES += \
    Backgrounds \
    Eleven \
    Etar \
    Jelly \
    Profiles \
    Seedvault \
    OmniStyle

ifneq ($(TARGET_EXCLUDES_AUDIOFX),true)
PRODUCT_PACKAGES += \
    AudioFX
endif

ifeq ($(PRODUCT_TYPE), go)
PRODUCT_PACKAGES += \
    TrebuchetQuickStepGo

PRODUCT_DEXPREOPT_SPEED_APPS += \
    TrebuchetQuickStepGo
else
PRODUCT_PACKAGES += \
    TrebuchetQuickStep

PRODUCT_DEXPREOPT_SPEED_APPS += \
    TrebuchetQuickStep
endif

# Accents
PRODUCT_PACKAGES += \
    LineageBlackTheme \
    LineageBlackAccent \
    LineageBlueAccent \
    LineageBrownAccent \
    LineageCyanAccent \
    LineageGreenAccent \
    LineageOrangeAccent \
    LineagePinkAccent \
    LineagePurpleAccent \
    LineageRedAccent \
    LineageYellowAccent

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

ifneq ($(CIPHER_CHARGER),false)
PRODUCT_PACKAGES += \
    cipher_charger_animation \
    cipher_charger_animation_vendor
endif

# Customizations
PRODUCT_PACKAGES += \
    IconShapeSquareOverlay \
    LineageNavigationBarNoHint \
    NavigationBarMode2ButtonOverlay

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet
