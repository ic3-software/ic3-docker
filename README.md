## Official icCube Docker Images

This repository is hosting the Docker definitions (and various scripts) for the official icCube Docker image.

It is hosted at [Docker Hub](https://hub.docker.com/) within the [ic3software](https://hub.docker.com/u/ic3software)
account.

### Run

For a quick trial using the embedded community license and the data being kept within the container:

    docker run -d --name icCube-community --restart unless-stopped -p 8282:8282 \
            ic3software/iccube:8.3.0

See this [page](./RUN_ADVANCED.md) for more options for running this Docker.

### Access

Once started you can access icCube by opening a browser:

    http://localhost:8282/icCube/console

Login as `anonymous` (i.e., leave blank the username) or login with `admin / admin`.

### Build 

Should you want to build your own image feel free to update the various `Dockerfile` and `scripts`
available in this project.

For building the Docker images, get the icCube ZIP URL ready. Let's call it `ICCUBE_URL` later in this document. 
Alternatively, you can have locally the ZIP and run a simple HTTP server as following:

    # mkdir /tmp/icCube
    # cp ~/icCube-8.3.0.zip /tmp/icCube
    # cd /tmp/icCube
    # python3 -m http.server 8080

Then the ICCUBE_URL would be: `http://192.168.1.47:8080/icCube-8.3.0.zip` assuming your IP is `192.168.1.47`.
You might want to use `http://host.docker.internal:8080/icCube-8.3.0.zip` on **Windows**.

Building the Docker based on Debian and Chrome headless:

    # cd ~/src/ic3-docker/docker
    # sudo ./scripts/build-debian.sh ICCUBE_URL 8.3.0

Building the (multi-architecture) Docker based on Alpine and Chromium headless:

    # cd ~/src/ic3-docker/docker
    # sudo ./scripts/buildx-alpine.sh ICCUBE_URL 8.3.0-chromium

_
