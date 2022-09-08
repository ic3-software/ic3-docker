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
echo "TAG:$2"

#
# Assuming QEMU is being installed and a buildx builder has been created, build amd64 & arm64 images.
# The shell is being logged into a Docker repository to be able to export and push the images.
#
docker buildx build ./alpine-chromium \
        -t "ic3software/iccube:$2" \
        --platform linux/amd64,linux/arm64 --push \
        --build-arg ICCUBE_KIT_URL="$1"