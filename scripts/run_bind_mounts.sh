#!/bin/sh

# -----------------------------------------------------------------------------
#
# The following is demonstrating both how to store `icCube-data` in the host
# and how to use specific configuration files from the host using Docker
# bind mounts.
#
# -----------------------------------------------------------------------------

ICCUBE=/home/mpo/icCube/docker-data

ICCUBE_BIN=$ICCUBE/bin
ICCUBE_WEB_DATA=$ICCUBE/data
ICCUBE_DATA=$ICCUBE/icCube-data

BASEDIR=$(cd $(dirname $0) && pwd)

docker run -d --name icCube --restart unless-stopped -p 8282:8282 \
            --security-opt seccomp=$BASEDIR/chrome.json \
            -v $ICCUBE_BIN:/opt/icCube/bin \
            -v $ICCUBE_WEB_DATA:/home/ic3/data \
            -v $ICCUBE_DATA:/home/ic3/icCube-data \
         ic3software/iccube:latest

# docker logs -f icCube

