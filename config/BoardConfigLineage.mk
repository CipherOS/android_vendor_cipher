include vendor/cipher/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cipher/config/BoardConfigQcom.mk
endif

include vendor/cipher/config/BoardConfigSoong.mk
