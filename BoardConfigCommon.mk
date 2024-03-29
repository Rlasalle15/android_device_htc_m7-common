# Copyright (C) 2013 The Android Open Source Project
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

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

# inherit from common msm8960
-include device/htc/msm8960-common/BoardConfigCommon.mk

TARGET_SPECIFIC_HEADER_PATH := device/htc/m7-common/include

# Kernel
BOARD_KERNEL_BASE := 0x80600000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01800000
TARGET_KERNEL_CONFIG := cyanogenmod_m7_defconfig
TARGET_KERNEL_SOURCE := kernel/htc/m7

# Flags
COMMON_GLOBAL_CFLAGS += -DNEW_ION_API=1
COMMON_GLOBAL_CFLAGS += -DNEW_LIBRIL_HTC

# Krait optimizations
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

# Audio
BOARD_USES_FLUENCE_INCALL := true  # use DMIC in call only
BOARD_USES_SEPERATED_AUDIO_INPUT := true  # use distinct voice recognition use case
BOARD_USES_SEPERATED_VOICE_SPEAKER := true  # use distinct voice speaker use case
BOARD_USES_SEPERATED_VOIP := true  # use distinct VOIP use cases
BOARD_AUDIO_AMPLIFIER := device/htc/m7-common/libaudioamp
BOARD_HAVE_HTC_CSDCLIENT := true

# Bluetooth
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/htc/m7-common/bluetooth
BOARD_BLUEDROID_VENDOR_CONF := device/htc/m7-common/bluetooth/libbt_vndcfg.txt
BOARD_BLUETOOTH_USES_HCIATTACH_PROPERTY := false

# Camera
BOARD_NEEDS_MEMORYHEAPPMEM := true
COMMON_GLOBAL_CFLAGS += -DDISABLE_HW_ID_MATCH_CHECK
COMMON_GLOBAL_CFLAGS += -DHTC_CAMERA_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS
USE_DEVICE_SPECIFIC_CAMERA := true

# Graphics
TARGET_DISPLAY_INSECURE_MM_HEAP := true

# USB
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# We have the new GPS driver
BOARD_HAVE_NEW_QC_GPS := true

# Tuning
BOARD_HARDWARE_CLASS := device/htc/m7-common/cmhw

# Wifi
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/firmware/fw_bcm4335_b0.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/firmware/fw_bcm4335_apsta_b0.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/system/etc/firmware/fw_bcm4335_p2p_b0.bin"

# SELinux
BOARD_SEPOLICY_DIRS := \
    device/htc/m7-common/sepolicy

BOARD_SEPOLICY_UNION := \
    app.te \
    device.te \
    file_contexts

# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16776704
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1946156032
BOARD_USERDATAIMAGE_PARTITION_SIZE := 27917287424
BOARD_FLASH_BLOCK_SIZE := 131072

# Custom Recovery
ifeq ($(TARGET_DEVICE),m7spr)
TARGET_RECOVERY_FSTAB := device/htc/m7-common/rootdir/etc/fstab.qcom.spr
else
TARGET_RECOVERY_FSTAB := device/htc/m7-common/rootdir/etc/fstab.qcom.gsm
endif
BOARD_CUSTOM_GRAPHICS := ../../../device/htc/m7-common/recovery/graphics.c
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_RECOVERY_SWIPE := true

#TWRP config:
DEVICE_RESOLUTION := 1080x1920
TW_INCLUDE_DUMLOCK := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TW_NO_USB_STORAGE := true
TW_INCLUDE_JB_CRYPTO := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "usb-otg"
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_NO_SCREEN_BLANK := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true

# Charge mode
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/htc_lpm/lpm_mode

# inherit from the proprietary version
-include vendor/htc/m7-common/BoardConfigVendor.mk
