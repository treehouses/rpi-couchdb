# The Dockerfile is Licensed under GNU AFFERO GENERAL PUBLIC LICENSE Version 3

FROM ubuntu as builder
LABEL maintainer="sahil@ole.org,mappuji@ole.org"

COPY ./crosscompile.sh .
RUN bash ./crosscompile.sh armv7 install

FROM resin/rpi-raspbian

ENV COUCHDB_VERSION 2.0.0

#create dirs and links for the npm module
RUN mkdir -p /usr/lib/node_modules; \
    ln -s /usr/lib/node_modules/grunt-cli/bin/grunt /usr/bin/grunt

COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules

# Add CouchDB user account
RUN groupadd -r couchdb && useradd -d /opt/couchdb -g couchdb couchdb

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    erlang-nox \
    erlang-reltool \
    haproxy \
    libicu52 \
    libmozjs185-1.0 \
    openssl \
  && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root and tini for signal handling
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5; \
# check if tini exists
  if ! type "tini" > /dev/null; then \
  \
# if not then install tini  
  curl -o /usr/local/bin/tini -fSL "https://github.com/krallin/tini/releases/download/v0.14.0/tini" \
  && curl -o /usr/local/bin/tini.asc -fSL "https://github.com/krallin/tini/releases/download/v0.14.0/tini.asc" \
  && gpg --verify /usr/local/bin/tini.asc \
  && rm /usr/local/bin/tini.asc \
  && chmod +x /usr/local/bin/tini; \
  fi;

# https://www.apache.org/dist/couchdb/KEYS
ENV GPG_KEYS \
  15DD4F3B8AACA54740EB78C7B7B7C53943ECCEE1 \
  1CFBFA43C19B6DF4A0CA3934669C02FFDF3CEBA3 \
  25BBBAC113C1BFD5AA594A4C9F96B92930380381 \
  4BFCA2B99BADC6F9F105BEC9C5E32E2D6B065BFB \
  5D680346FAA3E51B29DBCB681015F68F9DA248BC \
  7BCCEB868313DDA925DF1805ECA5BCB7BB9656B0 \
  C3F4DFAEAD621E1C94523AEEC376457E61D50B88 \
  D2B17F9DA23C0A10991AF2E3D9EE01E47852AEE4 \
  E0AF0A194D55C84E4A19A801CDB0C0F904F4EE9B
RUN set -xe \
  && for key in $GPG_KEYS; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV COUCHDB_VERSION 2.0.0

# Download dev dependencies
RUN buildDeps=' \
    apt-transport-https \
    gcc \
    git \
    g++ \
    erlang-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libmozjs185-dev \
    make \
  ' \
 && apt-get update -y -qq && apt-get install -y --no-install-recommends $buildDeps \
 && curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
 && echo 'deb https://deb.nodesource.com/node_4.x jessie main' > /etc/apt/sources.list.d/nodesource.list \
 && echo 'deb-src https://deb.nodesource.com/node_4.x jessie main' >> /etc/apt/sources.list.d/nodesource.list \
 && apt-get update -y -qq \
 && apt-get install -y nodejs \ 
 # Acquire CouchDB source code
 && cd /usr/src && mkdir couchdb \
 && curl -fSL https://github.com/apache/couchdb/archive/$COUCHDB_VERSION.tar.gz -o couchdb.tar.gz \
 && tar -xzf couchdb.tar.gz -C couchdb --strip-components=1 \
 && cd couchdb \
 # Build the release and install into /opt
 && ./configure --disable-docs \
 && make release \
 && mv /usr/src/couchdb/rel/couchdb /opt/ \
 # Cleanup build detritus
 && apt-get purge -y --auto-remove $buildDeps \
 && rm -rf /var/lib/apt/lists/* /usr/lib/node_modules /usr/src/couchdb*

# Add configuration
COPY local.ini /opt/couchdb/etc/local.d/
COPY vm.args /opt/couchdb/etc/

COPY ./docker-entrypoint.sh /

# Setup directories and permissions
RUN chmod +x /docker-entrypoint.sh \
 && mkdir /opt/couchdb/data /opt/couchdb/etc/default.d \
 && chown -R couchdb:couchdb /opt/couchdb/

WORKDIR /opt/couchdb
EXPOSE 5984 4369 9100
VOLUME ["/opt/couchdb/data"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["/opt/couchdb/bin/couchdb"]
