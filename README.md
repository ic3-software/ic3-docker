## Official icCube Docker Images

This repository is hosting the Docker definitions (and various scripts) for the official icCube Docker image.

It is hosted at [Docker Hub](https://hub.docker.com/) within the [ic3software](https://hub.docker.com/u/ic3software)
account.

### ic3software/iccube

The official icCube image ([www](./icCube/README.md)).

Docker Hub [repository](https://hub.docker.com/r/ic3software/iccube).

### ic3software/iccube-core

The image from which the `icCube` docker is built from ([www](./core/README.md)).

Docker Hub [repository](https://hub.docker.com/r/ic3software/iccube-core).

### Run

For a quick trial using the embedded community license and the data being kept within the container:

    docker run -d --name icCube-community --restart unless-stopped -p 8282:8282 \
            ic3software/iccube:latest

See this [page](./icCube/README.md) for more options for running this Docker.

### Access

Once started you can access icCube by opening a browser:

    http://localhost:8282/icCube/console

Login as `anonymous` (i.e., leave blank the username) or login with `admin / admin`.

### Build

Get the icCube ZIP URL ready. Alternatively, you can have locally the ZIP and run a simple HTTP server:

    # mkdir /tmp/icCube
    # cp ~/icCube-8.2.2.zip /tmp/icCube
    # cd /tmp/icCube
    # python3 -m http.server 8080

Then using `http://192.168.1.47:8080/icCube-8.2.2.zip` or the icCube ZIP URL:

    # cd ~/src/ic3-docker/docker
    # sudo ./scripts/build_core.sh
    # sudo ./scripts/build.sh http://192.168.1.47:8080/icCube-8.2.2.zip

Should you want to build your own image feel free to update the various `Dockerfile` and `scripts`
available in this project.

_