#!/bin/bash


get_rate() {
    from=$1
    to=$2
    url="https://www.xe.com/currencyconverter/convert/?Amount=1&From=$1&To=$2"
    wget $url -O /tmp/rate -o /tmp/rate-out
    a=`cat /tmp/rate | grep \"rates\": | sed "s/.*rates.*,//" | sed "s/\].*//"`
}

get_rate EUR RUB
b=$a
get_rate EUR GBP

printf "%.2f£ %.2f₽" "$a" "$b"

