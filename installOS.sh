#!/usr/bin/env ash

echo "Setting up network with DHCP"
setup-interfaces -a
rc-service networking start
rc-update add networking boot

echo "Setting up packages"
apk update
apk upgrade

echo "Please enter hostname: "
read hostname
setup-hostname $hostname

echo "Setting up Disk"
export DEFAULT_DISK=vda
setup-disk -m sys -q