#!/bin/bash

#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt firmware for s905x3
# Function: Use Flippy's Armbian_*_Aml-s9xxx_buster_*.img to build armbian kernel
# Copyright (C) 2020 Flippy's OpenWrt firmware for s905x3
# Copyright (C) 2020 https://github.com/ophub/op
#========================================================================================================================
#
# example: ~/op/router/s905x3/kernel/build_kernel/
# ├── flippy
# │   └── Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img
# └── make_use_armbian.sh
#
# Usage: Use Ubuntu 18 LTS 64-bit
# 01. Log in to the home directory of the local Ubuntu system
# 02. git clone https://github.com/ophub/op.git
# 03. cd ~/op/router/s905x3/kernel/build_kernel/
# 04. Put Flippy's ${flippy_file} file into ${flippy_folder}
# 05. Run: sudo ./make_use_armbian.sh
# 06. The generated files path: ~/op/router/s905x3/kernel/armbian/${build_save_folder}
# 07. git push to your github
# 08. Github.com Build openwrt: ~/op/.github/workflows/build-openwrt-s905x3.yml
#
# Tips: If run 'sudo ./make_use_armbian.sh' is 'Command not found'. Run: sudo chmod +x make_use_armbian.sh
#
#========================================================================================================================

# Modify Flippy's kernel folder & Armbian*.img file name
flippy_folder=${PWD}/"flippy"
flippy_file="Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img"

# Default setting ( Don't modify )
build_tmp_folder=${PWD}/"build_tmp"
armbian_boot=${build_tmp_folder}/armbian_boot
armbian_root=${build_tmp_folder}/armbian_root
kernel_boot=${build_tmp_folder}/kernel_boot
kernel_root=${build_tmp_folder}/kernel_root

#Installation dependencies
sudo apt-get update
sudo apt-get install -y -q tar xz-utils unzip bzip2 p7zip p7zip-full btrfs-progs btrfs-tools dosfstools uuid-runtime mount util-linux tree

# echo color codes
echo_color() {

    this_color=${1}
        case "${this_color}" in
        red)
            echo -e " \033[1;31m[ ${2} ]\033[0m ${3}"
            echo -e "--------------------------------------------"
            echo -e "Current path -PWD-: [ ${PWD} ]"
            echo -e "Situation -lsblk-: [ $(lsblk) ]"
            echo -e "Directory file list -ls-: [ $(ls .) ]"
            echo -e "--------------------------------------------"
            exit 1
            ;;
        green)
            echo -e " \033[1;32m[ ${2} ]\033[0m ${3}"
            ;;
        yellow)
            echo -e " \033[1;33m[ ${2} ]\033[0m ${3}"
            ;;
        blue)
            echo -e " \033[1;34m[ ${2} ]\033[0m ${3}"
            ;;
        purple)
            echo -e " \033[1;35m[ ${2} ]\033[0m ${3}"
            ;;
        *)
            echo -e " \033[1;30m[ ${2} ]\033[0m ${3}"
            ;;
        esac

}

# Check files
check_build_files() {

      if  [  ! -f ${flippy_folder}/${flippy_file} ]; then
        echo_color "red" "(1/7) Error: Files does not exist"  "\n \
        Please check if the following files exist: \n \
        ${flippy_folder}/${flippy_file} "
      else
        # begin run the script
        echo_color "purple" "Start building" "Use ${flippy_file} ..."
        echo_color "green" "(1/7) End check_build_files"  "..."
      fi

}

#losetup & mount ${flippy_file}
losetup_mount_img() {

   [ -d ${build_tmp_folder} ] && rm -rf ${build_tmp_folder} 2>/dev/null
   mkdir -p ${armbian_boot} ${armbian_root} ${kernel_boot} ${kernel_root}

   lodev=$(losetup -P -f --show ${flippy_folder}/${flippy_file})
   [ $? = 0 ] || echo_color "red" "(2/7) losetup ${flippy_file} failed!" "..."
   mount -o ro ${lodev}p1 ${armbian_boot}
   [ $? = 0 ] || echo_color "red" "(2/7) mount ${lodev}p1 failed!" "..."
   mount -o ro ${lodev}p2 ${armbian_root}
   [ $? = 0 ] || echo_color "red" "(2/7) mount ${lodev}p2 failed!""..."

   echo_color "green" "(2/7) End losetup_mount_img"  "Use: ${lodev} ..."

}

#copy ${armbian_boot} & ${armbian_root} Related files to ${kernel_boot} & ${kernel_root}
copy_boot_root() {

   #unpacking the armbian boot files
   cd ${armbian_boot}
   tar cf - . | (cd ${kernel_boot}; tar xf - )

   #unpacking the armbian root files
   cd ${armbian_root}
   tar cf - ./etc/armbian* ./etc/default/armbian* ./etc/default/cpufreq* ./lib/init ./lib/lsb ./lib/firmware ./usr/lib/armbian ./lib/modules | (cd ${kernel_root}; tar xf -)

   sync

   echo_color "green" "(3/7) End copy_boot_root"  "..."

}

#get version
get_flippy_version() {

  cd ${armbian_root}/lib/modules
     flippy_version=$(ls .)
     build_save_folder=$(echo ${flippy_version} | grep -oE '^[1-9].[0-9]{1,2}.[0-9]+')
     cd ../../../../
     mkdir -p ${build_save_folder}

     echo_color "green" "(4/7) End get_flippy_version"  "${build_save_folder} ..."

}

# build armbian_boot.tar.xz & armbian_root.tar.xz
build_boot_root() {

  cd ${kernel_boot}
     tar -cf armbian_boot.tar *
     xz -z armbian_boot.tar
     mv -f armbian_boot.tar.xz ../../${build_save_folder}

  cd ${kernel_root}
     tar -cf armbian_root.tar *
     xz -z armbian_root.tar
     mv -f armbian_root.tar.xz ../../${build_save_folder}
     
     sync

     echo_color "green" "(5/7) End build_boot_root"  "..."

}

# copy armbian_boot.tar.xz & armbian_root.tar.xz to ~/op/router/s905x3/kernel/armbian/${build_save_folder}
copy_armbian_kernel() {

   cd ../../
   cp -rf ${build_save_folder} ../armbian/
   sync

   echo_color "green" "(6/7) End copy_armbian_kernel"  "Copy /${build_save_folder} to ../armbian/ ..."

}

#umount& del losetup
umount_ulosetup() {

   umount -f ${armbian_boot} 2>/dev/null
   umount -f ${armbian_root} 2>/dev/null
   losetup -d ${lodev} 2>/dev/null

   rm -rf ${build_tmp_folder} ${build_save_folder} ${flippy_folder}/* 2>/dev/null

   echo_color "green" "(7/7) End umount_ulosetup"  "..."

}

check_build_files
losetup_mount_img
copy_boot_root
get_flippy_version
build_boot_root
copy_armbian_kernel
umount_ulosetup

echo_color "purple" "Build completed"  "${build_save_folder} ..."

# end run the script

