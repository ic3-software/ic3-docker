#!/bin/sh

# -----------------------------------------------------------------------------
#
# For a quick trial using the embedded community license and the data being
# kept within the container:
#
# -----------------------------------------------------------------------------

docker run -d --name icCube --restart unless-stopped -p 8282:8282 \
            ic3software/iccube:latest

# docker logs -f icCube

