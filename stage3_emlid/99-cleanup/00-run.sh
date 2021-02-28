#!/bin/bash -ex

on_chroot << EOF
readlink -e /home/* | grep -v $FIRST_USER_NAME | xargs rm -rf

EOF
