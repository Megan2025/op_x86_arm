#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 修复 vsftpd 与 vsftpd-alt 文件冲突
sed -i 's/CONFIG_PACKAGE_vsftpd-alt=y/# CONFIG_PACKAGE_vsftpd-alt is not set/g' .config
sed -i 's/CONFIG_VSFTPD_USE_UCI_SCRIPTS=y/# CONFIG_VSFTPD_USE_UCI_SCRIPTS is not set/g' .config
echo "CONFIG_PACKAGE_vsftpd=y" >> .config

# 2. 剔除引发 ucode 报错的失效旧主题
sed -i 's/CONFIG_PACKAGE_luci-theme-ifit=y/# CONFIG_PACKAGE_luci-theme-ifit is not set/g' .config
sed -i 's/CONFIG_PACKAGE_luci-theme-tomato=y/# CONFIG_PACKAGE_luci-theme-tomato is not set/g' .config

# 3. 强制开机默认主题为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/modules/luci-base/root/etc/uci-defaults/30_luci-theme 2>/dev/null || true
echo "uci set luci.main.mediaurlbase='/luci-static/argon'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci commit luci" >> package/lean/default-settings/files/zzz-default-settings

# 4. 预先下载 xray-core 避免 mirror2.openwrt.org 连接超时
mkdir -p dl
curl -fsSL --retry 3 -o dl/xray-core-26.10.29.tar.gz "https://codeload.github.com/XTLS/Xray-core/tar.gz/v26.10.29" || true
