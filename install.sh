#!/bin/bash
wget -q --spider http://github.com

set -e

if [[ $? -eq 1 ]]; then
  echo " [ ERR ] no connection to www.github.com \n breaking..."
  exit 1
fi

echo " installing packages. "

apt-get update -y
apt-get upgrade -y
apt-get install -y systemd python3 pip git

pip install rpi time

echo " [ OK ] Installation done, downloading script."

git clone www.github.com/Ludawi/nameOfProject
cd nameOfProject

echo " [ OK ] Download succesful, installing..."

sed -i "s/qUSER/$USER/" fan.service

mkdir /home/"$USER"/fancontrol
cp gpio.py /home/"$USER"/fancontrol/
cp fan.service /etc/systemd/system/

systemctl enable fan.service 
systemctl start fan.service

service = systemctl is-active --quiet fan.service

if [[ $service == 1 ]]; then
  echo " [ WARNING ] Error while running the service."
  echo " [ WARNING ] Service installed and NOT enabled."
fi

echo " [ OK ] Service installed and enabled."
echo "Restarting the device is advised. \n Do you want to restart now? (y/N): "

read decision

if [[ $decision == y ]]; then
  echo "rebooting ..."
  sleep(5)
  reboot
fi

echo "Bye!"
