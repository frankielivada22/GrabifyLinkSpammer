#!/bin/bash
lgreen="\e[92m"
lred="\e[91m"
nc="\e[39m"
count="0"
ping="0"
torrestart="0"
clear
if [[ -f history.txt ]]; then
	echo "Found history folder"
	clear
else
	> URLhistory.txt
fi

while :
do
read -p "Please enter the url:" url
echo "$url" > URLhistory.txt
echo ""
read -p "How many times do you want the url pinged:" ping

echo -e $lgreen"Starting..."

echo -e $lgreen""
echo "starting mac changer..."
macchanger -r wlan0 > /dev/null
echo "starting tor might take a while"
anonym8 start > /dev/null


if [[ $count == 0 ]]; then

	while [[ $count -lt $ping ]]; do

		echo -e $lgreen""
		echo "opening $url"
		firefox -safe-mode "$url" & > /dev/null
		sleep 1
		xdotool key Return
		sleep 4
		echo ""
		echo "closeing $url"
		kill -9 $(ps -x | grep firefox) > /dev/null
		if [[ $torrestart == "5" ]]; then
			torrestart="0"
			anonym8 change
		fi
		let torrestart="$torrestart+1"
		let count="$count+1"

	done

else

	echo -e $lred"Error :|"

fi

echo "Done :)"
read








done