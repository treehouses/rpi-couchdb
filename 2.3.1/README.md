### [treehouses/couchdb:2.3.1-buster](https://cloud.docker.com/u/treehouses/repository/docker/treehouses/couchdb/tags/2.3.1-buster)
```
docker manifest create treehouses/couchdb:2.3.1-buster \
treehouses/rpi-couchdb:2.3.1-buster \
amd64/couchdb:2.3.1

docker manifest annotate treehouses/couchdb:2.3.1-buster \
treehouses/rpi-couchdb:2.3.1-buster \
--os linux --arch arm

docker manifest push treehouses/couchdb:2.3.1-buster
```

