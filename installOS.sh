#!/usr/bin/env ash

echo "Setting keymap to de"
setup-keymap de de

echo "Please enter hostname: "
read hostname
setup-hostname $hostname

echo "Setting up network with DHCP"
setup-interfaces -a
rc-service networking start
rc-update add networking boot

echo "Setting timezone up"
export TZ='Europe/Berlin' 
echo "export TZ='$TZ'" >> /etc/profile.d/timezone.sh
setup-timezone $TZ

echo "Setting up welcome message"
echo "" > /etc/motd
echo "export EDITOR=/usr/bin/nano" >> /etc/profile
echo "echo Welcome to Alpine $(grep '^VERSION' /etc/os-release | sed \"s/VERSION_ID=//\")!" >> /etc/profile

echo "Setting up SSH key"
mkdir /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5lj9tx2xeEl11qbPTQJIcSOEQPHIPUurCKWSZFyBwsJIeef3HzNcyP7yvDFGuGiHP7NIRyRzvp4hkg537ucfFk+ZqpLdaH+mwKV5zdwl5J95WnfkzBEZ0GOLMFdGnblgwpz37dlZDEZo1BvxqJkapM9BPzWfuiMhwokbNcCJLTBopFQmUqGgyo6wDDCkVU+fTFmK9LgJxRG0RNGgpJGQtLu4kLvTt04WRsMnvrLivlcFNp94RClb8CbfQmi5oBMR34zzTKew3p78Dv1cxWRMrseCWoBipcg607pPCEOaSKNlPn+mk2Um7+bDMb+0F0pAgF0y0FVFH2ZAQpRGipFUA1sburicOwg/QnZRj3TdTYDV/XApvxeBACy7CicJmjqwKb0TnK/y5YRgU5c+aEYX+TeC4WrIIks8LEwtEY5qB2JDQdoc4zXuR/GMbgnCx4xUsqlm3U7km8wewTjM9dM0EjDsUSmy3ocNKSHvcMFy6+2KZiZRaS/JdvOUPTeKj+fM= jonasled@PC
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtzgF9JctY2fGJnrKvogKvsnpsBCU4Zd9XK3qgpsATnthKyMZfRUELgNrgB8xTPjb8mN9J9/NIiKrUFPGBoULQhpbQhQ0EBMnxm1dAEUCxkdXbQaZKfYUkuiztlmZYWXmGBsVar3IhmsQk3q7a893R4620l3frmxi4QsIyYcGf9Egm0u28T2bUjRp23tVy93bk3smlqCINt1SVHSBd6wUdxPh2aB8Llqh2xA48fNoujennx9xcC4pjxJ0skd0o/lnE1lNrqRAjk8V1AN+wIL9CKVXhvfiUkrjv38dpolSwBuc2LpEMIgHiQgIY5rjfM/Mf3g4mnO8Aed5kW1lHIwkuaFrzrvf+86Jt2ny56ut4f0voc0TfyQKaoUEVh9r6ijPCXLqWPLH98sj8toP/OhkQ/bSQ9LczYSyNlKSigkr0oY1BHAgQhNZgOJemPUbw6sQ31iuK1uLwgw8kcgMnrz75kfgY3kv9ID+ONv0qjRzplsxZ5TXDQwnNC/lvaScmcrc= ansible-alpine" > /root/.ssh/authorized_keys

echo "Setting up NTP"
setup-ntp -c setup-ntp

echo "Setting up packages"
apk update
apk upgrade
rc-update add sshd

echo "Setting up Disk"
export DEFAULT_DISK=/dev/vda
setup-disk -m sys