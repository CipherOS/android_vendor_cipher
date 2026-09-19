# ART
ART_BUILD_TARGET_NDEBUG := true
ART_BUILD_TARGET_DEBUG := false
ART_BUILD_HOST_NDEBUG := true
ART_BUILD_HOST_DEBUG := false
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
WITH_DEXPREOPT_DEBUG_INFO := false

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cipher/config/BoardConfigQcom.mk
endif

-include vendor/cipher/config/BoardConfigSoong.mk
