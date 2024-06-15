#!/bin/bash

sudo apt update
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctlenable apache2
echo “Hello from $(hostname -f).Created by USERDATA in Terraform. > /var/www/html/index.html
