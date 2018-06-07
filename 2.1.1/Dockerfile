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

# Original Image: resin/rpi-raspbian
FROM treehouses/rpi-couchdb:2.1.1 as builder

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

#Copy libmozjs185 from builder
COPY --from=builder /usr/lib/libmozjs185.so.1.0 /usr/lib/libmozjs185.so.1.0
COPY --from=builder /usr/lib/libmozjs185.so.1.0.0 /usr/lib/libmozjs185.so.1.0.0
  
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

#From builder 
RUN mkdir -p /opt/couchdb
COPY --from=builder /opt/couchdb /opt/couchdb

#copy some librarues from builder
#COPY --from=builder /usr/lib/erlang/erts-6.2 /usr/lib/erlang/erts-6.2
RUN rm -rf /opt/couchdb/erts-6.2 && ln -s /usr/lib/erlang/erts-9.1.5 /opt/couchdb/erts-6.2
RUN ln -s libncursesw.so.6 /usr/lib/libtinfo.so.5
#RUN mkdir -p /lib/arm-linux-gnueabihf && ln -s arm-linux-gnueabihf/ld-2.19.so /lib/ld-linux-armhf.so.3
#COPY --from=builder /lib/arm-linux-gnueabihf /lib/arm-linux-gnueabihf


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
