FROM azul/zulu-openjdk-alpine:21.0.1-21.30.15

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#
# Chromium (printing) : ~350m
#
RUN set -eux\
    apk upgrade --no-cache --available && apk add --no-cache chromium

ARG ICCUBE_KIT_URL

#
# icCube : ~200m
#
# Pass the actual URL (i.e., ICCUBE_KIT_URL) to the build command (e.g., http://192.168.1.22:8080/icCube-8.2.2.zip)
#
RUN set -eux \
	&& apk --no-cache add curl \
    && apk --no-cache add unzip \
    && mkdir -p /opt/icCube \
    && curl $ICCUBE_KIT_URL --output icCube.zip \
    && unzip icCube.zip -d /opt/icCube \
    && rm icCube.zip \
  	&& apk del curl unzip \
   	&& rm -rf /var/lib/apt/lists/* \
# Make fileSystemRoot visible from icCube as a shared drive.
    && sed -i 's/fileSystemRoot value=""/fileSystemRoot value="\/home\/ic3\/data"/g' /opt/icCube/bin/icCube.xml \
    && sed -i 's/fileSystemRootVisibleInDocs value="false"/fileSystemRootVisibleInDocs value="true"/g' /opt/icCube/bin/icCube.xml  \
# Printing requires an enterprise license.
    && sed -i 's/printComponentConfiguration active="false"/printComponentConfiguration active="true"/g' /opt/icCube/bin/icCube.xml \
    && sed -i 's/<!--<exec>chromium<\/exec>-->/<exec>chromium-browser<\/exec>/g' /opt/icCube/bin/icCube.xml \
# Create the ic3 user.
    && addgroup -S ic3 && adduser -S ic3 -G ic3 \
    && mkdir -p /home/ic3/data && chown -R ic3:ic3 /home/ic3

#
# Printing: cdp4j safe_process : not required (otherwise amd64 only: Windows/Linux/MacOS).
#
ENV ICCUBE_NO_SAFE_PROCESS=1

#
# icCube listening HTTP port.
#
EXPOSE 8282

USER ic3

CMD exec /opt/icCube/bin/icCube.sh