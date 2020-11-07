# Build OpenWrt's Armbian kernel for Phicomm-N1 & S905x3-Boxs

If you use Phicomm-N1 and S905x3-Boxs to install OpenWrt, you must know ‘Flippy’. He provides many versions of openwrt firmware for Phicomm-N1 & S905x3-Boxs and shares his series of Armbian kernels. If you have heard of ‘Flippy’ for the first time, you can find it through a search engine, E.g: ***` Flippy n1 `***

## Usage

You can use this script to generate a kernel package adapted to this source code. You can use the ***`Flippy’s kernel file`*** provided by him to extract.

```shell script
Path: ~/op/router/phicomm_n1/build-kernel/
 ├── flippy
 │   ├── Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img
 │   ├── OR: N1_Openwrt_R20.10.20_k5.4.73-flippy-47+o.img
 │   └── OR: S905x3_Openwrt_R20.10.20_k5.9.2-flippy-47+.img
 └── make
```

Put the ***`Flippy’s kernel file`*** E.g: ***`Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img`*** file into the ***`${flippy_folder}`*** folder, Modify ${flippy_file} to kernel file name. E.g: ***`flippy_file="Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img"`***. then run the script:
```shell script
sudo ./make
```

The generated files ***` kernel.tar.gz & modules.tar.gz `*** will be directly placed in the kernel directory of this github: ***` ~/op/router/phicomm_n1/armbian/phicomm-n1/kernel/${build_save_folder} `***

## Tips

Use this github's program for Phicomm N1: ***` ~/op/router/phicomm_n1 `*** , you can customize ` default IP, hostname, theme, add/remove software packages `, etc. to generate special firmware.
