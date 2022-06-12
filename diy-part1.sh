#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git adguardhome https://github.com/kenzok8/openwrt-packages/tree/master/luci-app-adguardhome' >>feeds.conf.default
#echo 'src-git aliyundrive-webdav https://github.com/kenzok8/openwrt-packages/tree/master/aliyundrive-webdav' >>feeds.conf.defaul
#echo 'src-git ddnsto https://github.com/kenzok8/openwrt-packages/tree/master/ddnsto' >>feeds.conf.defaul


echo 'src-git src-git packages https://github.com/coolsnowwolf/packages' >>feeds.conf.default
echo 'src-git luci https://github.com/coolsnowwolf/luci' >>feeds.conf.default
echo 'src-git routing https://git.openwrt.org/feed/routing.git' >>feeds.conf.default
echo 'src-git telephony https://git.openwrt.org/feed/telephony.git' >>feeds.conf.default
echo 'src-git freifunk https://github.com/freifunk/openwrt-packages.git' >>feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default


