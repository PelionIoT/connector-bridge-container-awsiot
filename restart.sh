#!/bin/sh

cd ${HOME}/service
./killService.sh
./runService.sh &
cd ${HOME}
