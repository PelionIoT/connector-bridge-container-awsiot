#!/bin/sh

set -x

docker run -d -p 28519:28519 -p 28520:28520 -p 2222:22 -p 8234:8234 -t mbed/connector-bridge  /home/arm/start_instance.sh
