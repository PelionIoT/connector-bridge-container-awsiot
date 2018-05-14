#!/bin/sh

PID=`ps -ef | grep java | grep -v grep | grep connector-bridge | awk '{ print $2 }'`

if [ "${PID}X" != "X" ]; then
     echo "Killing Connector Bridge..."
     kill -9 ${PID}
else
     echo "Connector Bridge is not running (OK)"
fi
exit 0
