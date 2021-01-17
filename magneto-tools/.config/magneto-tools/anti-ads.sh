#!/bin/bash

hostname=$(hostname)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ls /etc/hosts.old &> /dev/null

if [ $? -ne 0 ];
then
	cp /etc/hosts /etc/hosts.old
fi

echo "127.0.0.1		  localhost.localdomain   localhost" > /etc/hosts
echo "127.0.0.1	$hostname"
echo "::1			  localhost.localdomain   localhost" >> /etc/hosts

echo >> /etc/hosts

echo "########" >> /etc/hosts
echo "# AEDE #" >> /etc/hosts
echo "########" >> /etc/hosts

echo >> /etc/hosts

if [ -f $DIR/BloqueosFireFox.txt ];
then
	cat $DIR/BloqueosFireFox.txt >> /etc/hosts
fi

echo >> /etc/hosts

# Unified hosts + fakenews + gambling + porn + social
# wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts -O /tmp/hosts.txt

# Unified hosts + fakenews + gambling + porn 
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts -O /tmp/hosts.txt

# Unified hosts + gambling + porn
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts -O /tmp/hosts.txt

echo >> /etc/hosts

cat /tmp/hosts.txt >> /etc/hosts

rm /tmp/hosts.txt

exit
