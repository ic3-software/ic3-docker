## Official icCube Docker Images

This repository is hosting the Docker definitions (and various scripts) for the official icCube Docker image
hosted at [Docker Hub](https://hub.docker.com/) within the [ic3software](https://hub.docker.com/u/ic3software) account.

### License

You need a valid license to start icCube. Please [contact us](https://www.icCube.com/request-license) to request
an evaluation and/or community license. Academic use requires your professor to request an educational license.

### Trial/Evaluation Run

Note that once the container is deleted, **all icCube data is being deleted** as well.
Check this [page](./RUN_ADVANCED.md) for a production usage.

**amd64 / arm64**

For a trial/evaluation keeping the data (and the registered license) within the container :

    docker run -d --name icCube-eval --restart unless-stopped -p 8282:8282 \
            ic3software/iccube:8.4.8-chromium

**amd64**

You can as well use a Chrome (used for printing) based container :

    docker run -d --name icCube-eval --restart unless-stopped -p 8282:8282 \
            ic3software/iccube:8.4.8

Tags with `-j9` are using the OpenJ9 JVM.

**License Installation**

Connect as `admin` (password: `admin`) user. A single page is then being displayed for registering the license.
Use the `Register a License` button to select and upload the `icCube-4.lic` file received from icCube.

### Access

Once started you can access icCube by opening a browser:

    http://localhost:8282/icCube/console

Connect as an anonymous user by leaving blank the username or as `admin` (password: `admin`).

### Production (Advanced) Run

See this [page](./RUN_ADVANCED.md) for more options for running this Docker.

### Build

Should you want to build your own image feel free to update the various `Dockerfile` and `scripts`
available in this project.

For building the Docker images, get the icCube ZIP URL ready. Let's call it `ICCUBE_URL` later in this document.
Alternatively, you can have locally the ZIP and run a simple HTTP server as following:

    # mkdir /tmp/icCube
    # cp ~/icCube-8.4.8.zip /tmp/icCube
    # cd /tmp/icCube
    # python3 -m http.server 8080

Then the ICCUBE_URL would be: `http://192.168.1.47:8080/icCube-8.4.8.zip` assuming your IP is `192.168.1.47`.
You might want to use `http://host.docker.internal:8080/icCube-8.4.8.zip` on **Windows**.

Building the Docker based on Debian and Chrome headless:

    # cd ~/src/ic3-docker/docker
    # sudo ./scripts/build-debian.sh ICCUBE_URL 8.4.8

Building the (multi-architecture) Docker based on Alpine and Chromium headless:

    # cd ~/src/ic3-docker/docker
    # sudo ./scripts/buildx-alpine.sh ICCUBE_URL 8.4.8-chromium

_
