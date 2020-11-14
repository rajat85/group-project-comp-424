#!/bin/bash

HOME_DIR=/home/ubuntu
echo "Installing the required technology stack"


# Update Package Index
sudo apt update
sudo apt update -y

# Install Nginx, MySQL, openssl, openssh server
sudo apt install nginx
sudo apt -y install mysql-server
sudo apt install -y openssh-server
sudo apt install -y gcc libpcre3-dev zlib1g-dev libluajit-5.1-dev libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev bison flex libdnet

#Install mysql client
sudo apt-get install libmysqlclient-dev

#Install NodeJS
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

#Install yarn
sudo curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

#Install Passenger module for Nginx 
sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y libnginx-mod-http-passenger

#Validate passenger install
echo | sudo /usr/bin/passenger-config validate-install 
sudo /usr/sbin/passenger-memory-stats

#Insall rvm using curl for ruby
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME_DIR/.rvm/scripts/rvm

#Start mysql
sudo service mysql start

#Start NginX
sudo systemctl start nginx

# Allow to run mysql and Nginx on boot up
sudo systemctl enable mysql
sudo systemctl enable nginx

# Adjust Firewall
sudo ufw allow 'Nginx Full'

# update ruby version
rvm install ruby-2.7.1

# use ruby v2.7.2
rvm use 2.7.1 --default


echo -e "\n"
nginx -v
mysqld --version
rvm list


