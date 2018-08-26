#!/bin/sh

cd ${HOME}/service
./killService.sh
mkdir -p ${HOME}/log_archive 2>&1 1>/dev/null
cp ${HOME}/service/logs/connector-bridge.log ${HOME}/log_archive/connector-bridge-$(date +%F-%H:%M:%S).log
sleep 2
./runService.sh &
cd ${HOME}
