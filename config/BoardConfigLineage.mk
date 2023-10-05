include vendor/cipher/config/BoardConfigKernel.mk

# ART
ART_BUILD_TARGET_NDEBUG := true
ART_BUILD_TARGET_DEBUG := false
ART_BUILD_HOST_NDEBUG := true
ART_BUILD_HOST_DEBUG := false

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cipher/config/BoardConfigQcom.mk
endif

