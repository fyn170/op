# OpenWrt for S9xxx-Boxs

Support Amlogic-s9xxx chip series such as `S905x3`, `S905x2`, `S922x`, `S905x`, `S905d`, `s912`. You can download the OpwnWrt for S9xxx-Boxs firmware from [Releases](https://github.com/ophub/op/releases). Such as `openwrt_s9xxx_${date}`. Then write the IMG file to the USB hard disk through software such as [balenaEtcher](https://www.balena.io/etcher/).

This OpenWrt firmware on the `Github Actions` to packaging was using ***`Flippy's`*** [Amlogic S9xxx Kernel for OpenWrt](https://github.com/ophub/amlogic-s9xxx-openwrt), and the [Install and Upgrade scripts](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/install-program), etc. Special thanks The maker `Flippy`.

Welcome to use `forks` for personalized OpenWrt firmware configuration. If you like it, Please click the `stars`.

## Firmware instructions

- `openwrt_s905x3_v*.img`: For all Amlogic-S905x3 series boxes.
- `openwrt_s905x2_v*.img`: For all Amlogic-s905x2 series boxes.
- `openwrt_s905x_v*.img`: For all Amlogic-s905x series boxes.
- `openwrt_s905d_v*.img`: For all Amlogic-s905d series boxes.
- `openwrt_s912_v*.img`: For all Amlogic-s912 series boxes.
- `openwrt_s922x_v*.img`: For all Amlogic-s922x series boxes.
- `openwrt_x96_v*.img`: For X96-Max+(S905x3). [🔍](https://tokopedia.link/uMaH09s41db)
- `openwrt_hk1_v*.img`: For HK1-Box(S905x3). [🔍](https://tokopedia.link/pNHf5AE41db)
- `openwrt_h96_v*.img`: For H96-Max-X3(S905x3). [🔍](https://tokopedia.link/wRh6SVI41db)
- `openwrt_belink_v*.img` For Belink GT-King(S922x). [🔍](https://tokopedia.link/RAgZmOM41db)
- `openwrt_belinkpro_v*.img` For Belink GT-King Pro(S922x). [🔍](https://tokopedia.link/sfTHlfS41db)
- `openwrt_ugoos_v*.img` For UGOOS AM6 Plus(S922x). [🔍](https://tokopedia.link/pHGKXuV41db)
- `openwrt_hg680p_v*.img`: For Fiberhome HG680P(S905x). [🔍](https://tokopedia.link/NWF1Skg21db)
- `openwrt_b860h_v*.img`: For ZTE B860H(S905x). [🔍](https://tokopedia.link/fp8wG3711db)
- `openwrt_n1_v*.img`: For Phicomm-N1(S905d).
- `openwrt_octopus_v*.img` For Octopus-Planet(S912).

The ***`openwrt_s905x3_v*.img is the general OpenWrt firmware of all Amlogic-S9xxx series boxes`*** . You can write this OpenWrt firmware to the `USB hard disk` to start. When writing into EMMC through [s9xxx-install.sh](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/install-program/files/s9xxx-install.sh), `select the name` of the box you own in the menu.

For more OpenWrt firmware .dtb files are in the [dtb-amlogic](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/amlogic-dtb) directory. You can use the `openwrt_s905x3_v*.img` firmware to install via USB hard disk. When writing into EMMC through [s9xxx-install.sh](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/install-program/files/s9xxx-install.sh), [select 0: Enter the dtb file name of your box](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/amlogic-dtb), and use the S9xxx-Boxes you own.

## Install to EMMC partition and upgrade instructions

Choose the corresponding firmware according to your box. Then write the IMG file to the USB hard disk through software such as [balenaEtcher](https://www.balena.io/etcher/). Insert the USB hard disk into the S9xxx-Boxs. Common for `Phicomm-n1` and `s9xxx-Boxes`.

***`Install OpenWrt`***

- Log in to the default IP: 192.168.1.1 → `Login in to openwrt` → `system menu` → `TTYD terminal` → input command: 

```yaml
s9xxx-install.sh
```
***`Upgrade OpenWrt`***

- Log in to the default IP: 192.168.1.1 →  `Login in to openwrt` → `system menu` → `file transfer` → upload ***`openwrt*.img.gz (Support suffix: *.img.xz, *.img.gz, *.7z, *.zip)`*** to ***`/tmp/upload/`***, enter the `system menu` → `TTYD terminal` → input command: 

```yaml
s9xxx-update.sh
```

[For more instructions please see: install-program](https://github.com/ophub/amlogic-s9xxx-openwrt/tree/main/amlogic-s9xxx/install-program)


## Compilation method

- Select ***`Build OpenWrt for S9xxx`*** on the [Action](https://github.com/ophub/op/actions) page.
- Click the ***`Run workflow`*** button.

## Configuration file function description

| Folder/file name | Features |
| ---- | ---- |
| .config | Firmware related configuration, such as firmware kernel, file type, software package, luci-app, luci-theme, etc. |
| files | Create a files directory under the root directory of the warehouse and put the relevant files in. You can use custom files such as network/dhcp/wireless by default when compiling. |
| feeds.conf.default | Just put the feeds.conf.default file into the root directory of the warehouse, it will overwrite the relevant files in the OpenWrt source directory. |
| diy-part1.sh | Execute before updating and installing feeds, you can write instructions for modifying the source code into the script, such as adding/modifying/deleting feeds.conf.default. |
| diy-part2.sh | After updating and installing feeds, you can write the instructions for modifying the source code into the script, such as modifying the default IP, host name, theme, adding/removing software packages, etc. |

## .github/workflow/*.yml related environment variable description

| Environment variable | Features |
| ---- | ---- |
| REPO_URL | Source code warehouse address |
| REPO_BRANCH | Source branch |
| FEEDS_CONF | Custom feeds.conf.default file name |
| CONFIG_FILE | Custom .config file name |
| DIY_P1_SH | Custom diy-part1.sh file name |
| DIY_P2_SH | Custom diy-part2.sh file name |
| UPLOAD_BIN_DIR | Upload the bin directory (all ipk files and firmware). Default false |
| UPLOAD_FIRMWARE | Upload firmware catalog. Default true |
| UPLOAD_RELEASE | Upload firmware to release. Default true |
| UPLOAD_COWTRANSFER | Upload the firmware to CowTransfer.com. Default false |
| UPLOAD_WERANSFER | Upload the firmware to WeTransfer.com. Default failure |
| RECENT_LASTEST | maximum retention days for release, artifacts and logs in GitHub Release and Actions. |
| TZ | Time zone setting |
| GITHUB_REPOSITORY | Github.com Environment variables. The owner and repository name. For example, ophub/op. |
| secrets.GITHUB_TOKEN | Personal center: Settings → Developer settings → Personal access tokens → Generate new token ( Name: GITHUB_TOKEN, Select: public_repo ). |

## Firmware compilation parameters

| Option | Value |
| ---- | ---- |
| Target System | QEMU ARM Virtual Machine |
| Subtarget | QEMU ARMv8 Virtual Machine(cortex-a53) |
| Target Profile | Default |
| Target Images | squashfs |
| LuCI -> Applications | in the file: .config |

## Firmware information

| Name | Value |
| ---- | ---- |
| Default IP | 192.168.1.1 |
| Default username | root |
| Default password | password |
| Default WIFI name | OpenWrt |
| Default WIFI password | none |

