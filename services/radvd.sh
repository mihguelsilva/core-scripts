#!/bin/bash

RTR=$(ip -j -6 route show | jq length)
RT=$(ip -j -6 route show)

config() {
for i in $(seq 0 $RTR);do
  if [[ $(echo $RT | jq -r '.['$i']["dst"]') != "default" ]];then
    if [[ $(echo $RT | jq -r '.['$i']["dst"]') != "fe80::/64" ]];then
      if [[ $(echo $RT | jq -r '.['$i']["dst"]') != "::1" ]];then
        if [[ $(echo $RT | jq -r '.['$i']["dst"]') != "null" ]];then
          ADDR=$(echo $RT | jq -r '.['$i']["dst"]')
          ETHER=$(echo $RT | jq -r '.['$i']["dev"]')
cat << EOL >> etc/radvd.conf
interface $ETHER {
  AdvSendAdvert on;
  prefix $ADDR {
    AdvOnLink on;
    AdvAutonomous on;
    AdvRouterAddr on;
  };
};
EOL
        fi
      fi
    fi
  fi
done
}

start() {
  if [ -f etc/radvd.conf ];then
    if [ -s etc/radvd.conf ];then
      > etc/radvd.conf
      config
    else
      config
    fi
  else
    touch etc/radvd.conf
    config
  fi
  radvd -C etc/radvd.conf -m logfile -l var.log/radvd.log
}

stop() {
  > radvd.conf
}

case $1 in
  start) start;;
  stop) stop;;
  *) echo "Utilize os parametros start ou stop"
esac
