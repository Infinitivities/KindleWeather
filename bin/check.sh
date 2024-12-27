#!/bin/sh

proID=$(curl -m 20 -s -I http://127.0.0.2|grep "^HTTP"|awk '{print $2}')
if [ "$proID" == "200" ] ;
then
	logger -t "Weatcher.Qiu" "Service is OK!"
else
	logger -t "Weatcher.Qiu" "Service [NOT OK!]"
	/mnt/us/extensions/KindleWeatherCN/bin/stop.sh
	/mnt/us/extensions/KindleWeatherCN/bin/start.sh
fi