#!/bin/bash

wget https://www.google.com/finance?q=EURRUB -O /tmp/rate -o /tmp/rate-out
a=`cat /tmp/rate | grep "span class=bld" | sed "s/.*d>//" | sed "s/ RUB.*//"`

wget https://www.google.com/finance?q=GBPRUB -O /tmp/rate -o /tmp/rate-out
b=`cat /tmp/rate | grep "span class=bld" | sed "s/.*d>//" | sed "s/ RUB.*//"`

echo $a  $b
