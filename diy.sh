#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#添加自定义组件
git clone https://github.com/fshh1988/luci-app-nfs.git ./package/mypackage/luci-app-nfs
git clone https://github.com/kuoruan/openwrt-v2ray.git ./package/mypackage/openwrt-v2ray
git clone https://github.com/kuoruan/luci-app-v2ray.git ./package/mypackage/luci-app-v2ray
git clone https://github.com/jefferymvp/luci-app-koolproxyR.git ./package/mypackage/luci-app-koolproxyR
git clone https://github.com/sypopo/luci-theme-atmaterial.git ./package/mypackage/luci-theme-atmaterial
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git ./package/mypackage/luci-app-adguardhome
git clone https://github.com/sypopo/luci-theme-argon-mc.git ./package/mypackage/luci-theme-argon-mc

#修复核心及添加温度显示
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

#添加wifi
mkdir -p files/etc/config
cp -f ../wireless files/etc/config/

#修改机器名称
sed -i 's/OpenWrt/RaspberryPi4/g' package/base-files/files/bin/config_generate

#替换banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

# Change timezone
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

