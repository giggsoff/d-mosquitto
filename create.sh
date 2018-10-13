#!/bin/bash
read -e -p "Enter number of container:" -i "1" number
dirname=mqtt$number
mkdir -p "$dirname/config/"
mkdir -p "$dirname/data/"
mkdir -p "$dirname/log/"
chmod 777 "$dirname/data/"
chmod 777 "$dirname/log/"
read -e -p "Enter config name:" -i "mosquitto_$number.conf" conf_name
cp "$conf_name" "$dirname/config/mosquitto.conf"
cp -r conf.d "$dirname/config/"
read -e -p "Port1:" -i "1883" port1
read -e -p "Port2:" -i "9001" port2
echo $number > $dirname/answer
echo $port1 >> $dirname/answer
echo $port2 >> $dirname/answer
docker run -d -p $port1:1883 -p $port2:9001 -v $PWD/$dirname/config:/mqtt/config:ro -v $PWD/$dirname/log:/mqtt/log -v $PWD/$dirname/data/:/mqtt/data/ --name mqtt$number toke/mosquitto
docker logs -f mqtt$number
