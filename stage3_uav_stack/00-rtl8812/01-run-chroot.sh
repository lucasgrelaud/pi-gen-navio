#!/bin/bash -ex

# Clone the Aircrack-ng RTL8812 drivers
cd ~/
if [[ -d "rtl8812au" ]]; then
    
    rm -rf rtl8812au
fi
git clone https://github.com/aircrack-ng/rtl8812au.git
cd ~/rtl8812au

# Change the platform to a ARM CPU
## For  RPI 0,1,2,3
#sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
#sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
## For RPI 3+,4
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile

# Fix the "unrecognized command line option ‘-mgeneral-regs-only’" error
sed -i 's/^dkms build/ARCH=arm dkms build/' Makefile
sed -i 's/^MAKE="/MAKE="ARCH=arm\ /' dkms.conf

# Fix kernel version for cross compile 
BUILD_KERNEL_VERSION=$(ls /lib/modules | grep -e "-v7+" | tail -n1)
sed -i 's,KVER ?= $(shell uname -r),'"KVER=${BUILD_KERNEL_VERSION}," Makefile
sed -i 's,KVER=${kernelver},'"KVER=\"${BUILD_KERNEL_VERSION}\"," dkms.conf
sed -i 's,KSRC=/lib/modules/${kernelver}/build,'"KSRC=/lib/modules/${BUILD_KERNEL_VERSION}/build," dkms.conf
sed -i 's,dkms add,'"dkms add -k ${BUILD_KERNEL_VERSION}/arm," Makefile
sed -i 's,dkms build,'"dkms build -k ${BUILD_KERNEL_VERSION}/arm," Makefile
sed -i 's,dkms install,'"dkms install -k ${BUILD_KERNEL_VERSION}/arm," Makefile

make dkms_install
