# Raspberry Pi CouchDB Docker Image

[![Build Status](https://travis-ci.org/treehouses/rpi-couchdb.svg?branch=master)](https://travis-ci.org/treehouses/rpi-couchdb)

It is a fork of https://github.com/apache/couchdb-docker but for raspberrypi.
This is an effort to dockerize CouchDB to be able to run on Raspberry Pi.

## Credits
Credits to [klaemo](https://github.com/klaemo) and [apache](https://github.com/apache/couchdb-docker) for initial effort.

## Where it hosted

This work is hosted in [treehouses/couchdb](https://hub.docker.com/r/treehouses/couchdb/). It is a multi architecture image.

## Supported architectures
 `amd64`, `arm`, `arm64`
 
 (Note: The image for `amd64` is the official couchdb docker image, which can also be found at [amd64/couchdb](https://hub.docker.com/r/amd64/couchdb/))

## Naming and Versioning

Currently we maintain multi-architecture repository of 2.x.x version as well as 1.7.1 of CouchDB.

For RPi CouchDB 1.7.1
```
docker pull treehouses/couchdb:1.7.1
```
For RPi CouchDB 2.0.0
```
docker pull treehouses/couchdb:2.0.0
```
For RPi CouchDB 2.1.0
```
docker pull treehouses/couchdb:2.1.0
```
For RPi CouchDB 2.1.1
```
docker pull treehouses/couchdb:2.1.1
```

## About OLE
[OLE](https://www.ole.org/) is committed to ensuring that everyone has access to high quality, meaningful learning opportunities, especially girls and young women living in low-resource areas. We work with nation-based entrepreneurs who are transforming education into effective and affordable learning systems that benefit all of their people.

OLE’s vision is to revolutionize learning in every nation, enabling each one of us to experience personal power, meaning, and connection in our daily lives.  Beyond hardware and software, OLE leverages technology as a tool, much like a hammer, to build something greater that serves a purpose, that lasts.
