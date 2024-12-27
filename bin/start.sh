#!/bin/sh
#cd "$(dirname "$0")"
#cd /mnt/us/extensions/KindleWeatherCN/bin/

# 恢复Root分区读写权限
mntroot rw

# 关闭屏幕保护
/usr/bin/ds.sh

# 启动本地回环地址 127.0.0.2
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
# sed -i '/127.0.0.2/d' /etc/hosts
# echo "127.0.0.2       WeatherCN" >> /etc/hosts

# 修改本地时间，GTM时间改CST，上海时区
cp /mnt/us/extensions/KindleWeatherCN/bin/Shanghai /var/local/system/tz
ntpdate ntp.aliyun.com > /tmp/1.log
hwclock -w >> /tmp/1.log

cron_flag=$(grep -c "KindleWeatherCN" /etc/crontab/root)
if [ ${cron_flag} -ne "1" ] ;
then
        echo "* */12 * * * /mnt/us/extensions/KindleWeatherCN/bin/check.sh" >> /etc/crontab/root
fi

# 屏幕加载Logo
fbink -c
fbink -c -g file=/mnt/us/extensions/KindleWeatherCN/bin/logo.png,w=600,halign=center,valign=center
sleep 3s

# 启动本地 WebServer
cd /mnt/us/extensions/KindleWeatherCN/www/
nohup python3 -m http.server 80 --bind 127.0.0.2  > /mnt/us/extensions/KindleWeatherCN/bin/log.log 2>&1 &

# Web服务器运行后，显示操作方法
RFONT=/usr/java/lib/fonts/Caecilia_LT_65_Medium.ttf
BFONT=/usr/java/lib/fonts/Caecilia_LT_75_Bold.ttf
fbink -c 
fbink -t regular=$RFONT,bold=$BFONT,size=16,top=400,bottom=200,left=20,right=20,format "Please WebBrowser Vist http://127.0.0.2"
