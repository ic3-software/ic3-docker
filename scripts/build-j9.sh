#!/bin/sh

if [ -z "$1" ]
  then
    echo "missing URL"
    exit
fi

if [ -z "$2" ]
  then
    echo "missing TAG"
    exit
fi

echo "URL:$1"
echo "TAG:$2-j9"

docker build --no-cache ./j9-chrome \
        -t "ic3software/iccube:$2-j9" \
        --build-arg ICCUBE_KIT_URL="$1"
