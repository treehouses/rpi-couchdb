#!/usr/bin/env bash

build_message(){
    # $1 = build message
    echo
    echo =========BUILD MESSAGE=========
    echo "$@"
    echo ===============================
    echo
}

login_docker(){
    docker login --username=$DOCKER_USER --password=$DOCKER_PASS
}

prepare_package(){
	DOCKER_ORG=treehouses
	DOCKER_REPO=rpi-couchdb
	VERSION=$(cat package.json | grep version | awk '{print$2}' | awk '{print substr($0, 2, length($0) - 3)}')
	if [ -z "$BRANCH" ]; then
		BRANCH=$TRAVIS_BRANCH
	fi
	if [ -z "$COMMIT" ]; then
		COMMIT=${TRAVIS_COMMIT::8}
	fi
	V200_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:$VERSION-$BRANCH-$COMMIT
	V200_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.0.0
	V201_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:rpi-$VERSION-$BRANCH-$COMMIT
	V201_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.0.1
}

remove_temporary_folders(){
	rm -rf "$TEST_DIRECTORY"
}

create_footprint_rpi_couchdb() {
  echo $(date +%Y-%m-%d.%H-%M-%S) from rpi-couhdb >> $FOOTPRINT
}

package_v200(){
	build_message processing $V200_DOCKER_NAME
	docker build 2.0.0/ -t $V200_DOCKER_NAME
	build_message done processing $V200_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $V200_DOCKER_NAME_LATEST
		docker tag $V200_DOCKER_NAME $V200_DOCKER_NAME_LATEST
		build_message done processing $V200_DOCKER_NAME_LATEST
	fi
}

package_v201(){
	build_message processing $V201_DOCKER_NAME
	docker build 2.0.1/ -t $V201_DOCKER_NAME
	build_message done processing $V201_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $V201_DOCKER_NAME_LATEST
		docker tag $V201_DOCKER_NAME $V201_DOCKER_NAME_LATEST
		build_message done processing $V201_DOCKER_NAME_LATEST
	fi
}

push_v200(){
	build_message pushing $V200_DOCKER_NAME
	docker push $V200_DOCKER_NAME
	build_message done pushing $V200_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $V200_DOCKER_NAME_LATEST
		docker push $V200_DOCKER_NAME_LATEST
		build_message done pushing $V200_DOCKER_NAME_LATEST
	fi
}

push_v201(){
	build_message pushing $V201_DOCKER_NAME
	docker push $V201_DOCKER_NAME
	build_message done pushing $V201_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $V201_DOCKER_NAME_LATEST
		docker push $V201_DOCKER_NAME_LATEST
		build_message done pushing $V201_DOCKER_NAME_LATEST
	fi
}

deploy_v200(){
	login_docker
	package_v200
	push_v200
	docker logout
}

deploy_v201(){
	login_docker
	package_v201
	push_v201
	docker logout
}

