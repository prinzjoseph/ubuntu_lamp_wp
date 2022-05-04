#!/bin/bash
#Author: prinzjoseph
# Script to Install Wordpress with LAMP Stack on Ubuntu

printf "\e[1;94m __        ______            _   _ ____  _   _ _   _ _____ _   _  \e[0m\n" 
printf "\e[1;94m \ \      / /  _ \          | | | | __ )| | | | \ | |_   _| | | | \e[0m\n"
printf "\e[1;94m  \ \ /\ / /| |_) |  _____  | | | |  _ \| | | |  \| | | | | | | | \e[0m\n"
printf "\e[1;94m   \ V  V / |  __/  |_____| | |_| | |_) | |_| | |\  | | | | |_| | \e[0m\n"
printf "\e[1;94m    \_/\_/  |_|              \___/|____/ \___/|_| \_| |_|  \___/  \e[0m\n"

source ./lamp.sh
source ./wp.sh

ap=$(dpkg-query -W --showformat='${Status}\n' apache2 2> /dev/null|grep "install ok installed")
ma=$(dpkg-query -W --showformat='${Status}\n' mariadb-server 2> /dev/null|grep "install ok installed")
my=$(dpkg-query -W --showformat='${Status}\n' mysql-server 2> /dev/null|grep "install ok installed")
ph=$(dpkg-query -W --showformat='${Status}\n' php 2> /dev/null|grep "install ok installed")

lamp

echo "Enter wordpress domain name:"
read domain

wp
