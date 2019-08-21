# Raspberry Pi CouchDB Docker Image

[![Build Status](https://travis-ci.org/treehouses/rpi-couchdb.svg?branch=master)](https://travis-ci.org/treehouses/rpi-couchdb) [![Docker Stars](https://img.shields.io/docker/stars/treehouses/couchdb.svg?maxAge=604800)](https://store.docker.com/community/images/treehouses/couchdb) [![Docker Pulls](https://img.shields.io/docker/pulls/treehouses/couchdb.svg?maxAge=604800)](https://store.docker.com/community/images/treehouses/couchdb) [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/treehouses/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


## Multi Architecture CouchDB Docker Image (Tested on Raspberry Pi)

It is a fork of https://github.com/apache/couchdb-docker but for raspberrypi. This is an effort to dockerize CouchDB to be able to run on Raspberry Pi.

# Supported Tags (Versions)
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.3.1.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.3.1 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.3.1.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.3.1 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.3.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.3.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.3.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.3.0 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.2.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.2.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.2.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.2.0 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.1.2.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.2 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.1.2.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.2 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.1.1.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.1 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.1.1.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.1 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.1.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.1.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.1.0 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/rpi-couchdb:2.0.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.0.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/rpi-couchdb:2.0.0.svg)](https://microbadger.com/images/treehouses/rpi-couchdb:2.0.0 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/couchdb:1.7.2.svg)](https://microbadger.com/images/treehouses/couchdb:1.7.2 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/couchdb:1.7.2.svg)](https://microbadger.com/images/treehouses/couchdb:1.7.2 "Get your own image badge on microbadger.com")
* [![](https://images.microbadger.com/badges/version/treehouses/couchdb:1.7.1.svg)](https://microbadger.com/images/treehouses/couchdb:1.7.1 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/treehouses/couchdb:1.7.1.svg)](https://microbadger.com/images/treehouses/couchdb:1.7.1 "Get your own image badge on microbadger.com")

# Supported Architectures
`amd64`,`arm`
**Note:** v2.0.0 and v2.1.0 only supports `arm` architecture

## Where it hosted

This work is hosted in [treehouses/couchdb](https://hub.docker.com/r/treehouses/couchdb/)

## Credits
Credits to [klaemo](https://github.com/klaemo) and [apache](https://github.com/apache/couchdb-docker) for initial effort.
Credits to [Sahil Phule](https://github.com/sahilph) and [empeje](https://github.com/empeje) for maintaining this repo.

## Repository
`ARM`: https://github.com/treehouses/rpi-couchdb (For Raspberry Pi)
`AMD64`:https://github.com/docker-library/docs/tree/master/couchdb (Official Repo)

## Features
* Customize Credentials

## How to use

```
docker run -p 5984:5984 -d -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=password treehouses/couchdb:2.1.0
```

## About OLE
[OLE](https://www.ole.org/) is committed to ensuring that everyone has access to high quality, meaningful learning opportunities, especially girls and young women living in low-resource areas. We work with nation-based entrepreneurs who are transforming education into effective and affordable learning systems that benefit all of their people.

OLE’s vision is to revolutionize learning in every nation, enabling each one of us to experience personal power, meaning, and connection in our daily lives.  Beyond hardware and software, OLE leverages technology as a tool, much like a hammer, to build something greater that serves a purpose, that lasts.
