#!/bin/bash

echo 'Updating system packages'
sudo dnf update -y

echo 'Setting timezone to UTC'
sudo timedatectl set-timezone UTC

echo 'Installing essential packages'
sudo dnf install -y vim git curl wget

echo 'Creating a non-root user (exampleuser)'
sudo adduser exampleuser
echo 'exampleuser:ChangeMe!' | sudo chpasswd
sudo usermod -aG wheel exampleuser

echo 'Setting up SSH for exampleuser'
sudo mkdir -p /home/exampleuser/.ssh
sudo chmod 700 /home/exampleuser/.ssh
sudo cp /root/.ssh/authorized_keys /home/exampleuser/.ssh/
sudo chown -R exampleuser:exampleuser /home/exampleuser/.ssh

echo 'Disabling root SSH login'
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

echo 'Setting basic firewall rules'
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo 'Configuring auditd'
sudo dnf install -y audit audit-libs
sudo systemctl start auditd
sudo systemctl enable auditd

echo 'Machine basic setup complete'
