#!/bin/bash


get_rate() {
    from=$1
    to=$2
    url="https://www.xe.com/currencyconverter/convert/?Amount=1&From=$1&To=$2"
    wget $url -O /tmp/rate -o /tmp/rate-out
    a=`cat /tmp/rate | grep \"rates\": | sed "s/.*rates.*,//" | sed "s/\].*//"`
}

get_euribor() {
    url="https://www.euribor-rates.eu/euribor-rate-12-months.asp"
    euribor=`curl -s $url | grep "Current rate (by day)" -A 7 | tail -n 1 | sed 's/%//'`
    euribor=${euribor//$'\r'/}
}

get_rate EUR ZAR
c=$a
get_rate EUR RUB
b=$a
get_rate EUR GBP
get_euribor

printf "%.2f£ %.2f₽ %.1fR %s%%" "$a" "$b" "$c" "$euribor"

