#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# File name: diy-part2.sh
#

# 1. 修复 vsftpd 与 vsftpd-alt 文件冲突
sed -i 's/CONFIG_PACKAGE_vsftpd-alt=y/# CONFIG_PACKAGE_vsftpd-alt is not set/g' .config
sed -i 's/CONFIG_VSFTPD_USE_UCI_SCRIPTS=y/# CONFIG_VSFTPD_USE_UCI_SCRIPTS is not set/g' .config
echo "CONFIG_PACKAGE_vsftpd=y" >> .config

# 2. 彻底移除失效旧主题的源码目录（防止依赖再次带入）
rm -rf package/lean/luci-theme-ifit package/lean/luci-theme-tomato feeds/luci/themes/luci-theme-ifit feeds/luci/themes/luci-theme-tomato 2>/dev/null || true
sed -i 's/CONFIG_PACKAGE_luci-theme-ifit=y/# CONFIG_PACKAGE_luci-theme-ifit is not set/g' .config
sed -i 's/CONFIG_PACKAGE_luci-theme-tomato=y/# CONFIG_PACKAGE_luci-theme-tomato is not set/g' .config

# 3. 强制开机默认主题为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/modules/luci-base/root/etc/uci-defaults/30_luci-theme 2>/dev/null || true
echo "uci set luci.main.mediaurlbase='/luci-static/argon'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci commit luci" >> package/lean/default-settings/files/zzz-default-settings

# 4. 关闭引起下载超时的独立 xray-core
sed -i 's/CONFIG_PACKAGE_xray-core=y/# CONFIG_PACKAGE_xray-core is not set/g' .config
