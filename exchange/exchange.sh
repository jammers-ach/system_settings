#!/bin/bash

wget https://www.google.com/finance?q=GBPRUB -O /tmp/rate -o /tmp/rate-out
cat /tmp/rate | grep "span class=bld" | sed "s/.*d>//" | sed "s/ RUB.*//"
