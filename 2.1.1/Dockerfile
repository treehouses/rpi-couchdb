# Licensed under the Apache License, Version 2.1 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

FROM resin/rpi-raspbian as builder
#FROM treehouses/rpi-couchdb:2.1.1 as builder

RUN mkdir /pkgs \
    && cd /pkgs  \
    && apt-get update \
    && apt-get install -y wget \
    && wget $(apt-get install --reinstall --print-uris -qq libmozjs185-dev | cut -d"'" -f2)  \
    && wget $(apt-get install --reinstall --print-uris -qq libnspr4-dev | cut -d"'" -f2 | grep "/libnspr4-dev_") \
    && wget $(apt-get install --reinstall --print-uris -qq libnspr4 | cut -d"'" -f2 | grep "/libnspr4_") \
    && for f in `ls -1 *.deb | sed 's/\(.*\)\..*/\1/'`; \
       do  \
            `dpkg-deb -x $f.deb . && rm $f.deb`; \
       done;

FROM resin/raspberry-pi-alpine
LABEL maintainer="sahil@ole.org,mappuji@ole.org"

# Add CouchDB user account
RUN addgroup -S couchdb && adduser -D -h /opt/couchdb -G couchdb couchdb

RUN apk --no-cache --update add \
    ca-certificates \
    curl \
    erlang \
    erlang-asn1 \
    erlang-hipe \
    # erlang-corba \
    erlang-crypto \
    erlang-diameter \
    erlang-erts \
    erlang-edoc \
    erlang-eldap \
    erlang-erl-docgen \
    erlang-eunit \
    erlang-ic \
    erlang-inets \
    erlang-mnesia \
    erlang-odbc \
    erlang-os-mon \
    erlang-parsetools \
    # erlang-percept \
    erlang-public-key \
    erlang-runtime-tools \
    erlang-sasl \
    erlang-snmp \
    erlang-ssh \
    erlang-ssl \
    erlang-syntax-tools \
    erlang-tools \
    # erlang-webtool \
    erlang-xmerl\
    erlang-reltool \
    haproxy \
    icu-libs \
    libc6-compat \
    help2man \
    pwgen \
    openssl

#Copy some deps from builder
#COPY --from=builder /pkgs/usr /usr/local/
COPY --from=builder /pkgs/usr/ /usr/
RUN cd /usr/lib \
    && for  des  in `ls -1 arm-linux-gnueabihf` ; \
    do \
        `ln -s  arm-linux-gnueabihf/$des ./$des` ; \
     done;
    

# grab su-exec for easy step-down from root and tini for signal handling
RUN apk --no-cache --update add su-exec


ENV TINI_VERSION 0.16.1
RUN set -ex; \
# check if tini exists
        if ! type "tini" > /dev/null; then \
        \
# if not then install tini
	wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-$dpkgArch"; \
	wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7; \
	gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini; \
	rm -r "$GNUPGHOME" /usr/local/bin/tini.asc; \
	chmod +x /usr/local/bin/tini; \
	tini --version; \
	\
	fi; \
	apk del wget
    
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
  E0AF0A194D55C84E4A19A801CDB0C0F904F4EE9B \
  29E4F38113DF707D722A6EF91FE9AF73118F1A7C \
  2EC788AE3F239FA13E82D215CDE711289384AE37
RUN set -xe \
  && for key in $GPG_KEYS; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV COUCHDB_VERSION 2.1.1

# Download dev dependencies
RUN buildDeps=' \
    build-base \
    libc6-compat \
    libcurl \
    libgcc \
    libstdc++ \
    erlang-dev \
    curl-dev \
    icu-dev \
    make \
  ' \
 && apk --update --no-cache add $buildDeps \
 # Acquire CouchDB source code
 && mkdir -p  /usr/src \
 && cd /usr/src && mkdir couchdb \
 && curl -fSL https://dist.apache.org/repos/dist/release/couchdb/source/$COUCHDB_VERSION/apache-couchdb-$COUCHDB_VERSION.tar.gz -o couchdb.tar.gz \
 && curl -fSL https://dist.apache.org/repos/dist/release/couchdb/source/$COUCHDB_VERSION/apache-couchdb-$COUCHDB_VERSION.tar.gz.asc -o couchdb.tar.gz.asc \
 && gpg --batch --verify couchdb.tar.gz.asc couchdb.tar.gz \
 && tar -xzf couchdb.tar.gz -C couchdb --strip-components=1 \
 && cd couchdb \
 # Build the release and install into /opt
 && ./configure -c --disable-docs \
 && make release \
 && mv /usr/src/couchdb/rel/couchdb /opt/ \
 # Cleanup build detritus
 && apk del $buildDeps \
 && rm -rf /var/lib/apt/lists/* /usr/src/couchdb* \
 && mkdir /opt/couchdb/data \
 && chown -R couchdb:couchdb /opt/couchdb


# Add configuration
COPY local.ini /opt/couchdb/etc/local.d/
COPY vm.args /opt/couchdb/etc/

COPY ./docker-entrypoint.sh /

# Setup directories and permissions
RUN chown -R couchdb:couchdb /opt/couchdb/etc/local.d/ /opt/couchdb/etc/vm.args

WORKDIR /opt/couchdb
EXPOSE 5984 4369 9100
VOLUME ["/opt/couchdb/data"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["/opt/couchdb/bin/couchdb"]
