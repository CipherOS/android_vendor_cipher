# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= CipherOS

# Bootanimation
include vendor/cipher/config/bootanimation.mk

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Test Build Tag
ifeq ($(CIPHER_TEST),true)
    CIPHER_BUILD := DEVELOPER
    PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cipher/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cipher/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cipher/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/cipher/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/cipher/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/cipher/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/cipher/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/cipher/config/permissions/lineage-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lineage-sysconfig.xml

# permission Priv-App
PRODUCT_COPY_FILES += \
    vendor/cipher/config/permissions/privapp-permissions-omni.xml:system/etc/permissions/privapp-permissions-omni.xml

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/cipher/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/cipher/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Lineage!
PRODUCT_COPY_FILES += \
    vendor/cipher/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.lineageos.android.xml

# Disable remote keyguard animation
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.wm.enable_remote_keyguard_animation=0

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce
# Fonts
include vendor/cipher/config/fonts.mk

# Include AOSP audio files
include vendor/cipher/config/aosp_audio.mk

# Include Lineage audio files
include vendor/cipher/config/lineage_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/cipher/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/cipher/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920
PRODUCT_PACKAGES += \
    bootanimation.zip

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Lineage packages
PRODUCT_PACKAGES += \
    LineageParts \
    LineageSettingsProvider \
    LineageSetupWizard

# Themes
PRODUCT_PACKAGES += \
    CipherThemesStub \
    ThemePicker

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    wget \
    zip

# System fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/cipher/prebuilt/fonts/ttf,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    vendor/cipher/prebuilt/fonts/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cipher/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/cipher/overlay/common

### Cipher Versioning Stuff Starts here 
PRODUCT_VERSION_MAJOR = 3.4
PRODUCT_VERSION_MINOR = COMET
CIPHER_BUILD := UNOFFICIAL
CIPHER_BUILD_ZIP_TYPE := VANILLA

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cipher.version.major=$(PRODUCT_VERSION_MAJOR) \
  ro.cipher.version.minor=$(PRODUCT_VERSION_MINOR) \
  ro.cipher.maintainer=$(CIPHER_MAINTAINER)

## Cipher Build ID 
# Cipher Build ID Config:
#  - C34  => Cipher Release 3.4 , Cipher <Release Version Major> <Release Version Minor
#  - SB  => SB - Stable, BT - Beta, AL - Alpha, IT - Internal
#  - S   => Android Version
#  - 32   => Android API Level (32 = Sv2)
#  - RL03 => RL - Release, DP - Development

PLATFORM_CIPHER_BUILD_ID := C34.SB.S.32.RL03

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cipher.build.id=$(PLATFORM_CIPHER_BUILD_ID)

## Cipher Build ID Config End

# Define Official & Unofficial Builds
ifeq ($(CIPHER_OFFICIAL), true)
    CIPHER_BUILD := OFFICIAL
    PRODUCT_PACKAGES += \
    Updater \
    CipherShades \
    CipherWidget
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cipher.status=$(CIPHER_BUILD)

# Gapps
ifeq ($(CIPHER_GAPPS), true)
    $(call inherit-product, vendor/gms/products/gms.mk)
    CIPHER_BUILD_ZIP_TYPE := GAPPS
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cipher.ziptype=$(CIPHER_BUILD_ZIP_TYPE)
  
# CipherOS Go Edition
ifeq ($(CIPHER_GO), true)
    $(call inherit-product, build/make/target/product/go_defaults.mk)
    $(warning CIPHER_GO is defined, building CipherOS Go Edition)
    CIPHER_BUILD_ZIP_TYPE := GO
    PRODUCT_PACKAGES += \
    Launcher3QuickStepGo

    PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStepGo
    
endif

# ExactCalculator
ifeq ($(CIPHER_GAPPS), false)
PRODUCT_PACKAGES += \
    ExactCalculator
endif
## Cipher Versioning Vars End


# Add Face Unlock for Cipher
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Add CipherOS Stuff 
CIPHER_VERSION := CipherOS-$(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)-$(TARGET_PRODUCT)-$(shell date +%Y%m%d-%H%M)-$(CIPHER_BUILD)-$(CIPHER_BUILD_ZIP_TYPE)
CIPHER_DISPLAY_VERSION := CipherOS-$(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)-$(TARGET_PRODUCT)-$(CIPHER_BUILD)-$(CIPHER_BUILD_ZIP_TYPE)
LINEAGE_VERSION := $(CIPHER_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.cipher.build.date=$(shell LC_ALL=en_US.utf8 date "+%d_%B_%Y") \

# Blur
ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/cipher/config/partner_gms.mk
