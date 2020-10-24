#!/bin/bash

#IPTables configuration
sudo iptables -F
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -i lo -j ACCEPT
sudo iptables -P INPUT DROP

sudo apt install -y iptables-persistent


#Snort Configuration
mkdir ~/snort_src && cd ~/snort_src
wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
tar -xvzf daq-2.0.6.tar.gz
cd daq-2.0.6
./configure && make && sudo make install
cd ~/snort_src
wget https://www.snort.org/downloads/snort/snort-2.9.12.tar.gz
tar -xvzf snort-2.9.12.tar.gz
cd snort-2.9.12
./configure --enable-sourcefire && make && sudo make install
sudo ldconfig
sudo ln -s /usr/local/bin/snort /usr/sbin/snort
sudo groupadd snort
sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

#Create directories
sudo mkdir -p /etc/snort/rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules

#Fix file/dir permissions
sudo chmod -R 5775 /etc/snort
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
sudo cp ~/snort_src/snort-2.9.12/etc/*.conf* /etc/snort
sudo cp ~/snort_src/snort-2.9.12/etc/*.map /etc/snort


wget https://www.snort.org/rules/community -O ~/community.tar.gz
sudo tar -xvf ~/community.tar.gz -C ~/
sudo cp ~/community-rules/* /etc/snort/rules
#sudo sed -i 's/include \$RULE\_PATH/#include \$RULE\_PATH/' /etc/snort/snort.conf

#Copy config files
cd /home/ubuntu/424project/group-project-comp-424/scripts
cp snort.conf /etc/snort
cp local.rules /etc/snort/rules
cp snort.service /lib/systemd/system
cp apache2.conf /etc/apache2

#Fix mods for apache
a2dismod mpm_event
a2enmod mpm_prefork
a2enmod php7.2

#Start/reload necessary services
sudo systemctl apache2 restart
sudo systemctl daemon-reload
sudo systemctl start snort

#Copy website files
#cp -r /Comp424-FinalProject/scripts/html/. /var/www/html
#cd /var/www/html
#rm index.html
