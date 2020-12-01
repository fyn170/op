# OpenWrt for S905x3-Boxs and Phicomm-N1

You can download the OpwnWrt for S905x3-Boxs and Phicomm-N1 firmware from [Releases](https://github.com/ophub/op/releases). Such as `openwrt_s905x3_phicomm-n1_${date}`. Then write the IMG file to the USB hard disk through software such as [balenaEtcher](https://www.balena.io/etcher/).

## Build instructions
In order to facilitate the customization of personalized openwrt firmware, the firmware compilation and packaging script have been separated. You focus on personalized OpenWrt firmware compilation. I focus on packaging for you.

- Personalized OpenWrt firmware compilation example: [https://github.com/ophub/openwrt-s905x3-phicomm-n1](https://github.com/ophub/openwrt-s905x3-phicomm-n1)
- Packaging example: [https://github.com/ophub/amlogic-s9xxx-kernel-for-openwrt](https://github.com/ophub/amlogic-s9xxx-kernel-for-openwrt)

## Firmware instructions

- `n1-v*-openwrt_*.img`: For Phicomm-N1.
- `x96-v*-openwrt_*.img`: Almost compatible with all S905x3-Boxs, you can choose different box types when installing into EMMC.
- `hk1-v*-openwrt_*.img`: For HK1-Box(S905x3).
- `h96-v*-openwrt_*.img`: For H96-Max-X3(S905x3).
- `octopus-v*-openwrt_*.img` For Octopus-Planet.

## Install to emmc partition or upgrade instructions

[For more instructions please see: install-program](https://github.com/ophub/amlogic-s9xxx-kernel-for-openwrt/tree/main/install-program).


## Compilation method

- Select ***`Build OpenWrt for S905x3 and Phicomm-N1`*** on the [Action](https://github.com/ophub/openwrt-s905x3-phicomm-n1/actions) page.
- Click the ***`Run workflow`*** button.

## Packaging method

For packaging related methods, see:
[https://github.com/ophub/amlogic-s9xxx-kernel-for-openwrt](https://github.com/ophub/amlogic-s9xxx-kernel-for-openwrt)

## Firmware information

| Name | Value |
| ---- | ---- |
| Default IP | 192.168.1.1 |
| Default username | root |
| Default password | password |
| Default WIFI name | OpenWrt |
| Default WIFI password | none |

