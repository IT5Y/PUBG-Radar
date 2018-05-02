#!/bin/bash
echo "欢迎使用PUBG-Radar一键脚本"
echo "版本：05-02"
echo "请在下面输入你的内网ip" 
read -p "内网ip： " ip
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log

echo "雷达加速器搭建成功，请记住您的雷达信息"
read -p "任意键继续" 

curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v9.8.0
nvm alias default v9.8.0
yum -y install gcc-c++
yum -y install flex
yum -y install bison
wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz
tar -zxvf libpcap-1.8.1.tar.gz
cd libpcap-1.8.1
./configure
make
make install

git clone https://github.com/IT5Y/PUBG-Radar.git
cd PUBG-Radar/
npm i
npm i -g pino
npm install -g forever
forever start index.js sniff eth0 $ip | pino
cp /root/libpcap-1.8.1/PUBG-Radar/restart.sh /root/restart.sh
chmod +x restart.sh

echo "搭建完成"
