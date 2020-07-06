#!/bin/bash
echo --- setup for cups docker container ---
echo

echo Location for config files 
read -p "path: [/opt/cups]" path
path=${path:-/opt/cups}
echo

echo Please provide cups user name 
read -p 'User: [print]' uservar
uservar=${uservar:-print}
echo

echo Please provide password for $uservar
read -p 'Password: [print]' passvar
passvar=${passvar:-print} 
echo

echo -n "Run container priviledged to access USB devices? (y/n)? "
read setpriv
if [ "$setpriv" != "${setpriv#[Yy]}" ] ;then
	setpriv="setting priviledged"
	echo $setpriv
	priv="--privileged -v /dev/bus/usb:/dev/bus/usb"
else
    setpriv="Not setting priviledged"
    echo $setpriv
fi

echo
echo Options
echo path: $path
echo user: $uservar
echo pass: $passvar
echo priv: $setpriv
echo
read -p "Press enter to setup and start cups container" ppp
echo
echo Starting docker container.. 
echo

docker run \
	--name cups -p 631:631 \
	-v $path/config:/etc/cups \
	-v $path/log:/var/log/cups \
	-v $path/spool:/var/spool/cups \
	-v $patth/cache:/var/cache/cups \
	$priv \
	-e "CUPS_ADMIN=$uservar" -e "CUPS_ADMIN_PASS=$passvar" \
	-d --restart unless-stopped \
	cups

ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

echo Done, you can access cups on http://$ip:631 
