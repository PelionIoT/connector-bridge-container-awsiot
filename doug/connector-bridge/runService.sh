#!/bin/sh

rm -f ./logs/*.log 2> /dev/null
mkdir -p ./logs
cd /home/arm/connector-bridge/target
java -Dconfig_file="../conf/service.properties" -jar connector-bridge-1.0.war 2>&1 1> ../logs/connector-bridge.log
