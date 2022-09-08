#!/bin/sh

if [ -z "$1" ]
  then
    echo "missing TAG"
    exit
fi

echo "TAG:$1"

BASEDIR=$(cd $(dirname $0) && pwd)

#
# The following is demonstrating how to store `icCube-data` in the host and how to use
# configuration files (i.e., the whole /bin directory) from the host using Docker bind mounts.
#

ICCUBE=/home/mpo/icCube/docker-data

ICCUBE_BIN=$ICCUBE/bin
ICCUBE_WEB_DATA=$ICCUBE/data
ICCUBE_DATA=$ICCUBE/icCube-data

#
# Starting Chrome/Chromium headless, use one of the following:
#
#     -e ICCUBE_CHROME_NO_SANDBOX=1                    (--no-sandbox option)
#     --security-opt seccomp=$BASEDIR/chrome.json
#
docker run -d --name icCube --restart unless-stopped -p 8282:8282 \
            --security-opt seccomp=$BASEDIR/chrome.json \
            -v $ICCUBE_BIN:/opt/icCube/bin \
            -v $ICCUBE_WEB_DATA:/home/ic3/data \
            -v $ICCUBE_DATA:/home/ic3/icCube-data \
            "ic3software/iccube:$1"

# docker logs -f icCube

