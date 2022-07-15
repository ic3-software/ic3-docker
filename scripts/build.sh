#!/bin/sh

if [ -z "$1" ]
  then
    echo "missing URL"
fi

echo "KIT: $1"

docker build ./icCube \
        -t ic3software/iccube \
        --build-arg ICCUBE_KIT_URL="$1"
