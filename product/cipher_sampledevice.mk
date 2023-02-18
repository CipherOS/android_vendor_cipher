#
# Copyright (C) 2023 The CipherOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile
$(call inherit-product, device/brand/sampledevice/device.mk)

# Inherit from Cipher Common
$(call inherit-product, vendor/cipher/config/common_full_phone.mk)

# CipherOS specific flags
# Bootanimation res
TARGET_BOOT_ANIMATION_RES := 720
# Faceunlock Support
TARGET_FACE_UNLOCK_SUPPORTED := true
# Maintainer
CIPHER_MAINTAINER := Maintainer
# GMS
CIPHER_GAPPS := true
# Cipher Go Edition
CIPHER_GO := true
# Battery Info
CIPHER_BATTERY := # Battery capacity of your device (in mAh)
# Screen Size
CIPHER_SCREEN :=  # Screen size in inches
# Dev Build
CIPHER_TEST := true
# Enable Blurs
CIPHER_BLUR := true

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := cipher_sampledevice
PRODUCT_DEVICE := sampledevice
PRODUCT_BRAND := brand
PRODUCT_MODEL := Cipher Sample Device
PRODUCT_MANUFACTURER := brand

# Build info
BUILD_FINGERPRINT := # Build fingerprint, should be from stock ROM.
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=sampledevice \
    PRODUCT_NAME=sampledevice \
    PRIVATE_BUILD_DESC= # Set build description here

PRODUCT_GMS_CLIENTID_BASE := android-brand

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
