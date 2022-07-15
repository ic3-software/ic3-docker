FROM ic3software/iccube-core:latest

ENV ICCUBE_HOME=/opt/icCube

# Pass the actual URL of the icCube ZIP to the build command
#       e.g., http://192.168.1.22:8080/icCube-8.2.0.zip
ARG ICCUBE_KIT_URL

RUN set -eux \
    && mkdir -p $ICCUBE_HOME \
    && curl $ICCUBE_KIT_URL --output icCube.zip \
    && unzip icCube.zip -d $ICCUBE_HOME \
    && rm icCube.zip \
  	&& apt-get purge --auto-remove -y curl unzip \
   	&& rm -rf /var/lib/apt/lists/* \
# icCube.xml fileSystemRoot
    && sed -i 's/fileSystemRoot value=""/fileSystemRoot value="\/home\/ic3\/data"/g' /opt/icCube/bin/icCube.xml \
    && sed -i 's/fileSystemRootVisibleInDocs value="false"/fileSystemRootVisibleInDocs value="true"/g' /opt/icCube/bin/icCube.xml \
# icCube.xml printComponentConfiguration
    && sed -i 's/printComponentConfiguration active="false"/printComponentConfiguration active="true"/g' /opt/icCube/bin/icCube.xml

# Run icCube (and google-chrome for printing as well) non-privileged.

USER ic3

RUN set -eux \
    && mkdir /home/ic3/data

EXPOSE 8282

CMD exec /opt/icCube/bin/icCube.sh