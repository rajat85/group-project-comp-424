#!/bin/bash

HOME_DIR=/home/ubuntu
echo "Installing the required technology stack"


# Update Package Index
sudo apt update
sudo apt update -y

# Install Apache2, MySQL, SNORT
sudo apt install apache2 
sudo apt -y install mysql-server
sudo apt install -y openssh-server
sudo apt install -y gcc libpcre3-dev zlib1g-dev libluajit-5.1-dev libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev bison flex libdnet

# install mysql client
sudo apt-get install libmysqlclient-dev

# Install PGP key and add HTTPS support for APT
sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add APT repository for fusion passenger
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install FusionPassenger server + Apache module
sudo apt-get install -y libapache2-mod-passenger
sudo a2enmod passenger

echo "Validate the Fusion Passenger installation"

echo | sudo /usr/bin/passenger-config validate-install 

sudo /usr/sbin/passenger-memory-stats

# insall rvm using curl for ruby
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME_DIR/.rvm/scripts/rvm

#Start mysql
sudo service mysql start

#Start Apache Web Server
sudo systemctl start apache2
sudo apache2ctl restart

# Allow to run Apache on boot up
sudo systemctl enable apache2
sudo systemctl enable mysql

# Adjust Firewall
sudo ufw allow in "Apache Full"

# Allow Read/Write for Owner
sudo chmod -R 0755 /var/www/html/

# update ruby version
rvm install ruby-2.7.1

# use ruby v2.7.2
rvm use 2.7.1 --default


echo -e "\n"

apache2 -v
mysqld --version
rvm list


