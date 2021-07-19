#!/usr/bin/env ash
cp /mnt/installOS.sh /root
setup-keymap de de
setup-hostname alpine-setup
rc-update add sshd