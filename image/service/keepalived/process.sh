#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

echo -n "Waiting config file /etc/keepalived/keepalived.conf"
while [ ! -e "/etc/keepalived/keepalived.conf" ]
do
  echo -n "."
  sleep 0.1
done
echo "ok"

(/etc/keepalived/healthy_monitor.sh) &
exec /usr/local/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console ${KEEPALIVED_COMMAND_LINE_ARGUMENTS}  
