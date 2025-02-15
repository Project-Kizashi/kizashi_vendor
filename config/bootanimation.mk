# Copyright (C) 2018 The Superior OS Project
# Copyright (C) 2020 Direwolf Inc for Project Sakura
# Copyright (C) 2022 Beru Shinsetsu on behalf of Project Kizashi
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

# Bootanimation
ifeq ($(TARGET_CUSTOM_BOOT_ANIMATION),)
     TARGET_BOOT_ANIMATION_RES ?= $(shell if [ $(TARGET_SCREEN_HEIGHT) -gt $(TARGET_SCREEN_WIDTH) ] ; then echo $(TARGET_SCREEN_WIDTH) ; else echo $(TARGET_SCREEN_HEIGHT) ; fi)
     ifeq ($(filter 480 720 1080 1440,$(TARGET_BOOT_ANIMATION_RES)),)
         $(warning TARGET_BOOT_ANIMATION_RES is invalid or undefined, using generic bootanimation)
         TARGET_BOOT_ANIMATION_RES := 720
     endif

     # We don't know if the maintainer added space after definition in tree.
     # (E.g. "TARGET_BOOT_ANIMATION_RES := 720 # Random thing)
     # This causes COPY_FILES to malfunction, so trim it. Everything after
     # pound sign is already filtered out by build system so nothing should
     # go wrong.
     TARGET_BOOT_ANIMATION_RES := $(strip $(TARGET_BOOT_ANIMATION_RES))
     TARGET_CUSTOM_BOOT_ANIMATION := vendor/kizashi/prebuilt/common/media/bootanimation-$(TARGET_BOOT_ANIMATION_RES).zip
endif

PRODUCT_COPY_FILES += $(TARGET_CUSTOM_BOOT_ANIMATION):$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
