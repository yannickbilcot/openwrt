#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define KernelPackage/sound-arm-bcm2835
  TITLE:=Broadcom 2708,2835 SoC sound support
  KCONFIG:= \
	CONFIG_SND_ARM=y \
	CONFIG_SND_BCM2835 \
	CONFIG_SND_ARMAACI=n
  FILES:= \
	$(LINUX_DIR)/sound/arm/snd-bcm2835.ko
  AUTOLOAD:=$(call AutoLoad,68,snd-bcm2835)
  DEPENDS:=@TARGET_brcm2708
  $(call AddDepends/sound)
endef

define KernelPackage/sound-arm-bcm2835/description
  This package contains the Broadcom 2708/2835 sound driver
endef

$(eval $(call KernelPackage,sound-arm-bcm2835))

define KernelPackage/sound-soc-bcm2708-i2s
  TITLE:=SoC Audio support for the Broadcom 2708 I2S (es9023)
  KCONFIG:= \
	CONFIG_BCM2708_SPIDEV=y \
	CONFIG_SND_BCM2708_SOC_I2S \
	CONFIG_SND_BCM2708_SOC_ES9023_DAC \
	CONFIG_SND_BCM2708_SOC_HIFIBERRY_DAC=n \
	CONFIG_SND_BCM2708_SOC_HIFIBERRY_DACPLUS=n \
	CONFIG_SND_BCM2708_SOC_HIFIBERRY_DIGI=n \
	CONFIG_SND_BCM2708_SOC_HIFIBERRY_AMP=n \
	CONFIG_SND_BCM2708_SOC_RPI_DAC=n \
	CONFIG_SND_BCM2708_SOC_IQAUDIO_DAC=n \
	CONFIG_SND_SOC_DMAENGINE_PCM=y \
	CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
  FILES:= \
	$(LINUX_DIR)/drivers/base/regmap/regmap-mmio.ko \
	$(LINUX_DIR)/sound/soc/bcm/snd-soc-bcm2708-i2s.ko \
	$(LINUX_DIR)/sound/soc/codecs/snd-soc-es9023.ko \
	$(LINUX_DIR)/sound/soc/bcm/snd-soc-es9023-dac.ko
  AUTOLOAD:=$(call AutoLoad,68,snd-soc-bcm2708-i2s snd-soc-es9023 snd-soc-es9023-dac)
  DEPENDS:=@TARGET_brcm2708 +kmod-regmap +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-bcm2708-i2s/description
  This package contains support for codecs attached to the Broadcom 2708 I2S interface
endef

$(eval $(call KernelPackage,sound-soc-bcm2708-i2s))

define KernelPackage/random-bcm2708
  SUBMENU:=$(OTHER_MENU)
  TITLE:=BCM2708 H/W Random Number Generator
  KCONFIG:=CONFIG_HW_RANDOM_BCM2708
  FILES:=$(LINUX_DIR)/drivers/char/hw_random/bcm2708-rng.ko
  AUTOLOAD:=$(call AutoLoad,11,bcm2708-rng)
  DEPENDS:=@TARGET_brcm2708 +kmod-random-core
endef

define KernelPackage/random-bcm2708/description
  This package contains the Broadcom 2708 HW random number generator driver
endef

$(eval $(call KernelPackage,random-bcm2708))


define KernelPackage/spi-bcm2708
  SUBMENU:=$(SPI_MENU)
  TITLE:=BCM2708 SPI controller driver (SPI0)
  KCONFIG:=CONFIG_SPI_BCM2708 \
	   CONFIG_SPI=y \
	   CONFIG_SPI_MASTER=y \
	   CONFIG_BCM2708_SPIDEV=y
  FILES:=$(LINUX_DIR)/drivers/spi/spi-bcm2708.ko
  AUTOLOAD:=$(call AutoLoad,89,spi-bcm2708)
  DEPENDS:=@TARGET_brcm2708
endef

define KernelPackage/spi-bcm2708/description
  This package contains the Broadcom 2708 SPI master controller driver
endef

$(eval $(call KernelPackage,spi-bcm2708))


define KernelPackage/hwmon-bcm2835
  TITLE:=BCM2835 HWMON driver
  KCONFIG:=CONFIG_SENSORS_BCM2835
  FILES:=$(LINUX_DIR)/drivers/hwmon/bcm2835-hwmon.ko
  AUTOLOAD:=$(call AutoLoad,60,bcm2835-hwmon)
  DEPENDS:=@TARGET_brcm2708
  $(call AddDepends/hwmon,@TARGET_brcm2708)
endef

define KernelPackage/hwmon-bcm2835/description
  Kernel module for BCM2835 thermal monitor chip
endef

$(eval $(call KernelPackage,hwmon-bcm2835))


I2C_BCM2708_MODULES:=\
  CONFIG_I2C_BCM2708:drivers/i2c/busses/i2c-bcm2708

define KernelPackage/i2c-bcm2708
  $(call i2c_defaults,$(I2C_BCM2708_MODULES),59)
  KCONFIG+= \
	   CONFIG_I2C_BCM2708_BAUDRATE=100000
  TITLE:=Broadcom BCM2708 I2C master controller driver
  DEPENDS:=@TARGET_brcm2708 +kmod-i2c-core
endef

define KernelPackage/i2c-bcm2708/description
  This package contains the Broadcom 2708 I2C master controller driver
endef

$(eval $(call KernelPackage,i2c-bcm2708))
