#!/bin/bash

#IPTables configuration
sudo iptables -F
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -i lo -j ACCEPT
sudo iptables -P INPUT DROP

sudo apt install -y iptables-persistent

HOME_DIR=/home/ubuntu

#Snort Configuration
mkdir $HOME_DIR/snort_src && cd ~/snort_src
wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
tar -xvzf daq-2.0.7.tar.gz
cd daq-2.0.7
autoreconf -f -i
./configure && make && sudo make install
cd ~/snort_src
wget https://www.snort.org/downloads/snort/snort-2.9.16.1.tar.gz
tar -xvzf snort-2.9.16.1.tar.gz
cd snort-2.9.16.1
./configure --enable-sourcefire && make && sudo make install
sudo ldconfig
sudo ln -s /usr/local/bin/snort /usr/sbin/snort
sudo groupadd snort
sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

#Create directories
sudo mkdir -p /etc/snort
sudo mkdir -p /etc/snort/rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules

#Fix file/dir permissions
sudo chmod -R 5775 /etc/snort
sudo chmod -R 5775 /etc/snort/rules
sudo chmod -R 5775 /var/log/snort
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules
sudo chown -R snort:snort /etc/snort
sudo chown -R snort:snort /var/log/snort
sudo chown -R snort:snort /usr/local/lib/snort_dynamicrules

#Create blank rulesets
sudo touch /etc/snort/rules/white_list.rules
sudo touch /etc/snort/rules/black_list.rules
sudo touch /etc/snort/rules/local.rules

#Copy rulesets
sudo cp $HOME_DIR/snort_src/snort-2.9.16.1/etc/*.conf* /etc/snort
sudo cp $HOME_DIR/snort_src/snort-2.9.16.1/etc/*.map /etc/snort


wget https://www.snort.org/rules/community -O ~/community.tar.gz
sudo tar -xvf $HOME_DIR/community.tar.gz -C $HOME_DIR/
sudo cp $HOME_DIR/community-rules/* /etc/snort/rules
sudo sed -i 's/include \$RULE\_PATH/#include \$RULE\_PATH/' /etc/snort/snort.conf

# Obtaining registered user rules
wget https://www.snort.org/rules/snortrules-snapshot-29160.tar.gz?oinkcode=oinkcode -O ~/registered.tar.gz
sudo tar -xvf $HOME_DIR/registered.tar.gz -C /etc/snort

# Configuring the network and rule sets
#sudo nano /etc/snort/snort.conf

# Setup the network addresses you are protecting
ipvar HOME_NET server_public_ip/32

# Set up the external network addresses. Leave as "any" in most situations
ipvar EXTERNAL_NET !$HOME_NET

# Path to your rules files (this can be a relative path)
var RULE_PATH /etc/snort/rules
var SO_RULE_PATH /etc/snort/so_rules
var PREPROC_RULE_PATH /etc/snort/preproc_rules

# Set the absolute path appropriately
var WHITE_LIST_PATH /etc/snort/rules
var BLACK_LIST_PATH /etc/snort/rules

cd $HOME_DIR/group-project-comp-424/scripts
sudo cp snort.conf /etc/snort
sudo cp local.rules /etc/snort/rules
sudo cp snort.service /lib/systemd/system
sudo cp apache2.conf /etc/apache2


# unified2
# Recommended for most installs
output unified2: filename snort.log, limit 128
include $RULE_PATH/local.rules

include $RULE_PATH/community.rules

sudo snort -T -c /etc/snort/snort.conf


#Fix mods for apache
sudo a2dismod mpm_event
sudo a2enmod mpm_prefork

#Start/reload necessary services
sudo systemctl restart apache2
sudo systemctl daemon-reload
sudo systemctl start snort

