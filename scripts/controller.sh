#!/bin/bash
USER=$1
PASSWORD=$2
WORDPRESS_IP=$3
MYSQL_IP=$4

# install ansible and sshpass
apt update
apt install -y ansible sshpass
# fix ansible file
sed -i.bak '430s/'\''/[`'\'']/g' /usr/lib/python3/dist-packages/ansible/modules/database/mysql/mysql_user.py
# create user
useradd -m -s /bin/bash -p $(openssl passwd $PASSWORD) $USER
# add user to sudo group
usermod -aG sudo $USER
# create ssh key
sudo -u $USER ssh-keygen -t rsa -f /home/$USER/.ssh/id_rsa -N ""
# send ssh key to workers
sleep 1
cat /home/$USER/.ssh/id_rsa.pub | sudo -u $USER sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORDPRESS_IP "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat /home/$USER/.ssh/id_rsa.pub | sudo -u $USER sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$MYSQL_IP "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
# run ansible playbook
cd /tmp/ansible/
sudo -u $USER ansible-playbook playbook.yml