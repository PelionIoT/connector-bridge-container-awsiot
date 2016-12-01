#!/bin/sh

echo "Getting bridge container ID..."

ID=`docker ps -a | grep home | grep arm | awk '{print $1}'`

if [ "${ID}X" != "X" ]; then
    echo "Stopping $ID"
    docker stop ${ID}
    sleep 30
else
    echo "No running bridge container found... OK"
fi

if [ "${ID}X" != "X" ]; then
    echo "Removing $ID"
    docker rm --force ${ID}
    sleep 30
fi

echo "Looking for existing container image..."

ID=`docker images | grep connector-bridge | awk '{print $3}'`
if [ "${ID}X" != "X" ]; then
    echo "Removing Image $ID"
    docker rmi --force ${ID}
    sleep 30
else
    echo "No container image found... (OK)"
fi

echo "Building container image..."


if [ -f Dockerfile ]; then
    docker build -t "mbed/connector-bridge" .
else
    echo "Unable to find Dockerfile... change to repo directory and retry..."
    exit 1
fi
