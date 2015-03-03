#!/bin/bash

#check if root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Copy the old hosts file
cp /etc/hosts /etc/hosts.old


#now add all the sites to be blocked
while read -r line
do
    echo "0.0.0.0 $line #Anticrastination" >> /etc/hosts
    echo "blocked $line"
done < ~/.anticrastination.lst

#And your done
