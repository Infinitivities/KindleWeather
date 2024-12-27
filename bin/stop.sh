#!/bin/sh
pkill -f http.server
RFONT=/usr/java/lib/fonts/Caecilia_LT_65_Medium.ttf
BFONT=/usr/java/lib/fonts/Caecilia_LT_75_Bold.ttf
fbink -c 
fbink -t regular=$RFONT,bold=$BFONT,size=24,top=100,bottom=500,left=25,right=50,format "Weather Server Stoped!"
