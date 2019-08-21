### [treehouses/couchdb:2.3.1-stretch](https://cloud.docker.com/u/treehouses/repository/docker/treehouses/couchdb/tags)
```
docker manifest create treehouses/couchdb:2.3.1-stretch \
treehouses/rpi-couchdb:2.3.1-stretch \
amd64/couchdb:2.3.1

docker manifest annotate treehouses/couchdb:2.3.1-stretch \
treehouses/rpi-couchdb:2.3.1-stretch \
--os linux --arch arm

docker manifest push treehouses/couchdb:2.3.1-stretch
```

