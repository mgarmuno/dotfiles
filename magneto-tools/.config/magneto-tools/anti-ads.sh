#!/bin/bash

hostname=$(hostname)
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

if [ -f /home/magneto/misc/BloqueosFireFox.txt ];
then
	cat /home/magneto/misc/BloqueosFireFox.txt >> /etc/hosts
fi

echo >> /etc/hosts

wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/social/hosts -O /tmp/hosts.txt

echo >> /etc/hosts

cat /tmp/hosts.txt >> /etc/hosts

sed -i '/i.reddit.com/d' /etc/hosts > /etc/null
sed -i '/nsfw.reddit.com/d' /etc/hosts > /dev/null
sed -i '/redd.it/d' /etc/hosts > /dev/null
sed -i '/reddit.com/d' /etc/hosts > /dev/null
sed -i '/www.reddit.com/d' /etc/hosts > /dev/null
sed -i '/amp-reddit-com.cdn.ampproject.org/d' /etc/hosts > /dev/null
sed -i '/odd.reddit.com/d' /etc/hosts > /dev/null
sed -i '/new.reddit.com/d' /etc/hosts > /dev/null
sed -i '/reddit.map.fastly.net/d' /etc/hosts > /dev/null
sed -i '/www.redditgifts.com/d' /etc/hosts > /dev/null
sed -i '/www.redditmedia.com/d' /etc/hosts > /dev/null
sed -i '/www.redditstatic.com/d' /etc/hosts > /dev/null
sed -i '/emoji.redditmedia.com/d' /etc/hosts > /dev/null
sed -i '/s.redditmedia.com/d' /etc/hosts > /dev/null

rm /tmp/hosts.txt

exit
