#!/bin/bash
/*
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
*/

//echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html

sudo apt update
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctlenable apache2
echo “Hello from $(hostname -f).Created by USERDATA in Terraform. > /var/www/html/index.html
