# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
# Copyright (C) 2021 CipherOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# CipherOS OTA update package

CIPHER_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CIPHER_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CIPHER_TARGET_PACKAGE)
	$(hide) $(MD5) $(CIPHER_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CIPHER_TARGET_PACKAGE).md5sum
	@echo "Package Complete: $(CIPHER_TARGET_PACKAGE)" >&2
	@echo "Build is getting done..." >&2
	$(hide) bash vendor/cipher/build/tools/cipher.sh


# -----------------------------------------------------------------
# CipherOS fastboot package

CIPHER_TARGET_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/$(CIPHER_VERSION)-FASTBOOT.zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: fastbootpkg
fastbootpkg: $(INTERNAL_UPDATE_PACKAGE_TARGET)
              $(hide) ln -f $(INTERNAL_UPDATE_PACKAGE_TARGET) $(CIPHER_TARGET_FASTBOOT_PACKAGE)
              $(hide) $(MD5) $(CIPHER_TARGET_FASTBOOT_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CIPHER_TARGET_FASTBOOT_PACKAGE).md5sum
              @echo "Fastboot Package Complete: $(CIPHER_TARGET_FASTBOOT_PACKAGE)" >&2
              @echo "Build is getting done..." >&2
              $(hide) bash vendor/cipher/build/tools/cipher.sh
