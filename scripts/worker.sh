#!/bin/bash
USER=$1
PASSWORD=$2

# create user
useradd -m -s /bin/bash -p $(openssl passwd $PASSWORD) $USER
# add user to sudo group
usermod -aG sudo $USER
# allow user to run sudo commands without password
sudoers_entry="$USER ALL=(ALL:ALL) NOPASSWD:ALL"
echo $sudoers_entry | cat >> /etc/sudoers.d/$USER
# enable ssh connection with password
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# restart ssh daemon
systemctl restart ssh