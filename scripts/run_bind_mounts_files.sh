#!/bin/sh

# -----------------------------------------------------------------------------
#
# The following is demonstrating both how to store `icCube-data` in the host
# and how to use specific configuration files (e.g., license, JAVA memory
# configuration) from the host using Docker bind mounts.
#
# -----------------------------------------------------------------------------

ICCUBE=/home/mpo/icCube/docker-data

ICCUBE_BIN=$ICCUBE/bin

BASEDIR=$(cd $(dirname $0) && pwd)

docker run -d --name icCube --restart unless-stopped -p 8282:8282 \
            --security-opt seccomp=$BASEDIR/chrome.json \
            -v $ICCUBE_BIN/icCube-4.lic:/opt/icCube/bin/icCube-4.lic \
            -v $ICCUBE_BIN/icCube.sh:/opt/icCube/bin/icCube.sh \
            ic3software/iccube:latest

# docker logs -f icCube

