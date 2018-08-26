#!/bin/sh

cd ${HOME}/service
./killService.sh
cp ${HOME}/service/logs/connector-bridge.log ${HOME}/connector-bridge-$(date +%F-%H:%M:%S).log
sleep 2
./runService.sh &
cd ${HOME}
