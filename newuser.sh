#!/bin/bash
# script to add a user to linux system
if [ $(id -u)  -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	grep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Fail to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
