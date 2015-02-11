#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
cp /etc/hosts /etc/hosts.old2
mv /etc/hosts.old /etc/hosts

for i in {300..0..-1}
do
    echo "unblocking in $i"
    sleep 1
done

mv /etc/hosts /etc/hosts.old
mv /etc/hosts.old2 /etc/hosts
