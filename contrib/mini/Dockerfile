FROM azul/zulu-openjdk-alpine:17.0.2-jre-headless

RUN set -eux \
    && addgroup -S ic3 && adduser -S ic3 -G ic3 \
    && mkdir -p /home/ic3 && chown -R ic3:ic3 /home/ic3

ENV ICCUBE_HOME=/opt/icCube

# Pass the actual URL of the icCube ZIP to the build command
#       e.g., http://192.168.1.22:8080/icCube-8.2.0.zip
ARG ICCUBE_KIT_URL

RUN set -eux \
	&& apk --no-cache add curl \
    && apk --no-cache add unzip \
    && mkdir -p $ICCUBE_HOME \
    && curl $ICCUBE_KIT_URL --output icCube.zip \
    && unzip icCube.zip -d $ICCUBE_HOME \
    && rm icCube.zip \
  	&& apk del curl unzip \
   	&& rm -rf /var/lib/apt/lists/* \
# icCube.xml fileSystemRoot
    && sed -i 's/fileSystemRoot value=""/fileSystemRoot value="\/home\/ic3\/data"/g' /opt/icCube/bin/icCube.xml \
    && sed -i 's/fileSystemRootVisibleInDocs value="false"/fileSystemRootVisibleInDocs value="true"/g' /opt/icCube/bin/icCube.xml

USER ic3

RUN set -eux \
    && mkdir /home/ic3/data

EXPOSE 8282

CMD exec /opt/icCube/bin/icCube.sh