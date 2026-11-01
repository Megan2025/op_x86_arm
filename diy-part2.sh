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

# 4. 修复 xray-core 下载源，直接指向 GitHub 官方源并支持重定向
find feeds/ -name Makefile -path "*/xray-core/*" | while read -r file; do
    sed -i 's|https://mirror2.openwrt.org/sources|https://github.com/XTLS/Xray-core/archive/refs/tags|g' "$file"
    sed -i 's|v\$(PKG_VERSION).tar.gz|v\$(PKG_VERSION).tar.gz?|g' "$file"
done

# 5. 提前下载 xray-core 并校验文件大小大于 1MB，确保不被清理脚本误删
mkdir -p dl
if [ ! -s "dl/xray-core-26.10.29.tar.gz" ] || [ $(wc -c < "dl/xray-core-26.10.29.tar.gz") -lt 1048576 ]; then
    curl -fL --retry 5 -o dl/xray-core-26.10.29.tar.gz "https://github.com/XTLS/Xray-core/archive/refs/tags/v26.10.29.tar.gz"
fi
