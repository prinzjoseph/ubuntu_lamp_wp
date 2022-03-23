#!/bin/bash

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
