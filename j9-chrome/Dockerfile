FROM ibm-semeru-runtimes:open-21.0.6_7-jdk-focal
#
# Configure the "en_US.UTF-8" locale.
#
RUN set -eux; \
	if [ -f /etc/dpkg/dpkg.cfg.d/docker ]; then \
# if this file exists, we're likely in "debian:xxx-slim", and locales are thus being excluded
# so we need to remove that exclusion (since we need locales)
		grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker; \
		sed -ri '/\/usr\/share\/locale/d' /etc/dpkg/dpkg.cfg.d/docker; \
		! grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker; \
	fi \
	&& apt-get update  \
    && apt-get install -y --no-install-recommends locales \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

#
# Several tools.
#
RUN set -eux \
	&& apt-get update  \
    && apt-get install -y --no-install-recommends procps curl unzip vim \
	&& rm -rf /var/lib/apt/lists/*

# Using https://github.com/justinribeiro/dockerfiles/tree/master/chrome-headless
#   install chrome-stable for printing: can be disabled to spare around 500MB
#   in the image if printing is not required.

RUN set -eux \
    && apt-get update  \
    && apt-get install -y --no-install-recommends apt-transport-https ca-certificates gnupg \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y --no-install-recommends \
	google-chrome-stable \
	fontconfig \
	&& apt-get purge --auto-remove -y gnupg \
	&& rm -rf /var/lib/apt/lists/*

ARG ICCUBE_KIT_URL

#
# icCube : ~200m
#
# Pass the actual URL (i.e., ICCUBE_KIT_URL) to the build command (e.g., http://192.168.1.22:8080/icCube-8.2.2.zip)
#
RUN set -eux \
    && mkdir -p /opt/icCube \
    && curl $ICCUBE_KIT_URL --output icCube.zip \
    && unzip icCube.zip -d /opt/icCube \
    && rm icCube.zip \
  	&& apt-get purge --auto-remove -y curl unzip \
   	&& rm -rf /var/lib/apt/lists/* \
# Make fileSystemRoot visible from icCube as a shared drive.
    && sed -i 's/fileSystemRoot value=""/fileSystemRoot value="\/home\/ic3\/data"/g' /opt/icCube/bin/icCube.xml \
    && sed -i 's/fileSystemRootVisibleInDocs value="false"/fileSystemRootVisibleInDocs value="true"/g' /opt/icCube/bin/icCube.xml \
# Printing requires an enterprise license.
    && sed -i 's/printComponentConfiguration active="false"/printComponentConfiguration active="true"/g' /opt/icCube/bin/icCube.xml \
# Create the ic3 user.
    && groupadd -r ic3 && useradd -r -g ic3 -G audio,video ic3 \
    && mkdir -p /home/ic3/data && chown -R ic3:ic3 /home/ic3

#
# icCube listening HTTP port.
#
EXPOSE 8282

USER ic3

CMD exec /opt/icCube/bin/icCube.sh