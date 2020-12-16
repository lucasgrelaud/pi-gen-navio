#!/bin/bash -ex

# Install wifibroadcast configuration files
install -m 644 files/wifibroadcast.cfg "${ROOTFS_DIR}/etc/wifibroadcast.cfg"
install -m 644 files/wifibroadcast "${ROOTFS_DIR}/etc/default/wifibroadcast"

# Add build specific configuration
if [ -v WFB_CHANNEL ]; then
    sed -i "s,wifi_channel = 1,wifi_channel = ${WFB_CHANNEL},${ROOTFS_DIR}/etc/wifibroadcast.cfg"
fi
if [ -v WFB_COUNTRY ]; then
    sed -i "s,wifi_region = 'BO',wifi_region = '${WFB_COUNTRY}',${ROOTFS_DIR}/etc/wifibroadcast.cfg"
fi
if [ -v WFB_MAVLINK_PORT ]; then
    sed -i "s,'listen://0.0.0.0:14550','listen://0.0.0.0:${WFB_MAVLINK_PORT}',${ROOTFS_DIR}/etc/wifibroadcast.cfg"
fi
if [ -v WFB_VIDEO_PORT ]; then
    sed -i "s,'listen://0.0.0.0:5602','listen://0.0.0.0:${WFB_VIDEO_PORT}',${ROOTFS_DIR}/etc/wifibroadcast.cfg"
fi