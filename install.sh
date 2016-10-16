#!/bin/bash 

echo -n "Enter password to be used for minecraft user: "
read -s password
echo 

sudo apt-get update
sudo apt-get install -y perl gcc g++ make automake libtool autoconf m4 gcc-multilib

# create 'minecraft' user
sudo groupadd -g 1010 minecraft
sudo su -c "useradd minecraft -s /bin/bash -m -g minecraft"
sudo chpasswd << 'END'
minecraft:$password
END

# allow ssh access without key
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# create installation directory and install server
sudo mkdir -p /home/minecraft/server
sudo chown ubuntu. /home/minecraft/server/
cd /home/minecraft/server
wget -q -O - https://raw.githubusercontent.com/PocketMine/php-build-scripts/master/installer.sh | bash -s -
# Pocketmine official edition is no longer maintained so only supports up to MCPE v0.14.0.0
# manually download phar from ClearSky - check here for latest versions: http://robskebueba.no-ip.biz/CSPhar.php?type=1&branch=php7
sudo mv PocketMine-MP.phar PocketMine-MP.phar.orig
wget -O PocketMine-MP.phar https://451-49435874-gh.circle-artifacts.com/0/tmp/circle-artifacts.C5LE68t/DevTools/ClearSky_1.1-php7.phar
sudo chown -R minecraft. /home/minecraft/

# update firewall to allow port 19132
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 19132

# configure to run as a service
sudo cp ~/minecraftpe /etc/init.d/
sudo chmod 755 /etc/init.d/minecraftpe
sudo update-rc.d minecraftpe defaults
sudo service minecraftpe start

