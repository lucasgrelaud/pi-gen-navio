#!/bin/bash -e

install -m 644 files/modules ${ROOTFS_DIR}/etc/modules
install -m 644 files/cmdline.txt ${ROOTFS_DIR}/boot
install -m 644 files/environment ${ROOTFS_DIR}/etc
install -m 644 /dev/null ${ROOTFS_DIR}/boot/ssh
install -m 644 files/interfaces ${ROOTFS_DIR}/etc/network

on_chroot << EOF
rm -f /etc/motd
systemctl disable hciuart
EOF
