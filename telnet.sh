#!/bin/bash

echo "Installing Telnet"
sudo yum update kernel -y
sudo yum install telnet -y
sudo yum install elinks -y
sudo yum install httpd -y
sudo yum install php -y
sudo systemctl restart httpd
sudo systemctl enable httpd
sudo yum install wget -y
sudo wget https://wordpress.org/wordpress-4.0.32.tar.gz
sudo tar -xf wordpress-4.0.32.tar.gz -C /var/www/html/
sudo mv /var/www/html/wordpress/* /var/www/html/
sudo yum install php-mysql -y
sudo systemctl restart httpd
sudo chown -R apache:apache /var/www/html/
sudo systemctl restart httpd

echo "Setup completed"
