FROM azul/zulu-openjdk-debian:17.0.3-17.34.19

# Configure the "en_US.UTF-8" locale.

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

# Several tools.

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
#	fonts-ipafont-gothic \
#	fonts-wqy-zenhei \
#	fonts-thai-tlwg \
#	fonts-kacst \
#	fonts-symbola \
#	fonts-noto \
#	fonts-freefont-ttf \
	&& apt-get purge --auto-remove -y gnupg \
	&& rm -rf /var/lib/apt/lists/*

# Add ic3 as a user (used as well to launch google-chrome for printing).

RUN set -eux \
    && groupadd -r ic3 && useradd -r -g ic3 -G audio,video ic3 \
    && mkdir -p /home/ic3 && chown -R ic3:ic3 /home/ic3