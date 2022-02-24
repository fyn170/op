#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: 21.02
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' feeds/luci/collections/luci/Makefile

# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='KALYNXWRT'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# change timezone
sed -i -e "s/CST-8/WIB-7/g" -e "s/Shanghai/Jakarta/g" -e "s/zh_cn/auto/g" package/default-settings/files/zzz-default-settings

# change language
# sed -i "s/zh_cn/auto/g" zzz-default-settings

#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk package/luci-app-amlogic

# Add p7zip
# svn co https://github.com/hubutui/p7zip-lede/trunk package/lean/p7zip

# Add autocore
# svn co https://github.com/ophub/amlogic-s9xxx-openwrt/trunk/amlogic-s9xxx/common-files/patches/autocore package/lean/autocore

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# temperature
svn co https://github.com/gSpotx2f/luci-app-temp-status/trunk package/luci-app-temp-status

# def passwall
# git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall-packages
# sed -i "/DEFAULT_PACKAGES/ s/$/ brook chinadns-ng dns2socks hysteria ipt2socks kcptun microsocks naiveproxy pdnsd-alt shadowsocks-rust shadowsocksr-libev simple-obfs ssocks tcping trojan-go trojan-plus trojan v2ray-core v2ray-geodata v2ray-plugin xray-core xray-plugin/" target/linux/armvirt/Makefile

# openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openclash
sed -i "/DEFAULT_PACKAGES/ s/$/ coreutils-nohup bash iptables dnsmasq-full curl ca-certificates ipset ip-full iptables-mod-tproxy iptables-mod-extra libcap libcap-bin ruby ruby-yaml kmod-tun/" target/linux/armvirt/Makefile

# oh-my-zsh
mkdir -p files/root
pushd files/root
git clone https://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions
cp $GITHUB_WORKSPACE/amlogic-s9xxx/common-files/patches/zsh/.zshrc .
cp $GITHUB_WORKSPACE/amlogic-s9xxx/common-files/patches/zsh/example.zsh ./.oh-my-zsh/custom/example.zsh
popd

# Add luci-theme-neobird
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird

# svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openclash
# sed -i "/DEFAULT_PACKAGES/ s/$/ coreutils-nohup bash iptables dnsmasq-full curl ca-certificates ipset ip-full iptables-mod-tproxy iptables-mod-extra libcap libcap-bin ruby ruby-yaml kmod-tun/" target/linux/armvirt/Makefile
# sed -i "/DEFAULT_PACKAGES/ s/$/ nft-qos kmod-nft-netdev kmod-nft-core kmod-nft-bridge nftables-json nftables-nojson libnftnl11 jansson4/" target/linux/armvirt/Makefile
# Apply patch
# git apply ../router-config/patches/{0001*,0002*}.patch --directory=feeds/luci
# ------------------------------- Other ends -------------------------------
