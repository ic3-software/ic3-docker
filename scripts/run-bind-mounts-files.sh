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
# a configuration file (i.e., the license file) from the host using Docker bind mounts
# as well as changing the JVM options using an environment variable.
#

ICCUBE_LICENSE=/home/mpo/icCube/docker-data/bin/icCube-4.lic

#
# Starting Chrome/Chromium headless, use one of the following:
#
#     -e ICCUBE_CHROME_NO_SANDBOX=1                    (--no-sandbox option)
#     --security-opt seccomp=$BASEDIR/chrome.json
#
docker run -d -e ICCUBE_JAVA_OPTS="-Xms1g -Xmx1g" \
            --name icCube --restart unless-stopped -p 8282:8282 \
            --security-opt seccomp=$BASEDIR/chrome.json \
            -v $ICCUBE_LICENSE:/opt/icCube/bin/icCube-4.lic \
            "ic3software/iccube:$1"

# docker logs -f icCube

