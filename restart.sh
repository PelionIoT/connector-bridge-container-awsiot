#!/bin/sh

cd connector-bridge
./killService.sh
./runService.sh &
cd ${HOME}
