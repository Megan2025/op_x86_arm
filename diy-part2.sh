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

# 2. 彻底移除失效旧主题的源码目录（防止依赖再次带入）
rm -rf package/lean/luci-theme-ifit package/lean/luci-theme-tomato feeds/luci/themes/luci-theme-ifit feeds/luci/themes/luci-theme-tomato 2>/dev/null || true

# 3. 强制开机默认主题为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/modules/luci-base/root/etc/uci-defaults/30_luci-theme 2>/dev/null || true
echo "uci set luci.main.mediaurlbase='/luci-static/argon'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci commit luci" >> package/lean/default-settings/files/zzz-default-settings

# 4. 关闭引起 404/超时的外层独立 xray-core，避免中断编译
sed -i 's/CONFIG_PACKAGE_xray-core=y/# CONFIG_PACKAGE_xray-core is not set/g' .config
