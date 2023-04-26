
set -x
wget -q --spider http://github.com

if [ $? -eq 1 ] 
then
  echo " [ ERR ] no connection to www.github.com \n breaking..."
  exit 1
fi

echo " installing packages. "

apt-get update -y
apt-get upgrade -y
apt-get install -y systemd python3 python3-pip git

pip install rpi.gpio python-time

echo " [ OK ] Installation done, downloading script."

git clone www.github.com/Ludawi/fancontroller
cd fancontroller

echo " [ OK ] Download succesful, installing..."

sed -i "s/qUSER/$USER/" fan.service

mkdir /home/"$USER"/fancontroller
cp gpio.py /home/"$USER"/fancontroller/
cp fan.service /etc/systemd/system/

systemctl enable fan.service 
systemctl start fan.service

service=systemctl is-active -q --quiet fan.service

if [ $service == 0 ]
then # How does this work?
  echo " [ WARNING ] Error while running the service."
  echo " [ WARNING ] Service installed and NOT enabled."
elif [ $service == 1 ] 
then
  echo " [ OK ] Service installed and enabled."
  echo "Restarting the device is advised. \n Do you want to restart now? (y/N): "
fi

read decision

if [[ $decision == y ]]; then
  echo "rebooting ..."
  sleep 5
  reboot
fi

echo "Bye!"
