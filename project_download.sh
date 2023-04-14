#!/bin/bash

sudo su -
apt-get update 
apt-get install apache2 -y
sleep 1
cd /root
git clone https://github.com/amolshete/card-website.git
cp -rf card-website/* /var/www/html/

echo "project download successful"
