#!/usr/bin/env bash

####### Parse commandline arguments  #####################
for i in "$@"
do
case $i in
    -u=*|--duser=*)
      DOCKER_USER="${i#*=}"
      ;;
    -k=*|--dpass=*)
      DOCKER_PASS="${i#*=}"
      ;;
    -b=*|--branch=*)
      BRANCH_INPUT="${i#*=}"
      ;;
    -c=*|--commit=*)
      COMMIT_INPUT="${i#*=}"
      ;;
    *)
    echo "usage: ./deploy_docker_rpi.sh -b=<branch-name>|--branch=<branch-name>"
    echo "usage: ./deploy_docker_rpi.sh -c=<commit-sha>|--commit=<commit-sha>"
    echo "usage: ./deploy_docker_rpi.sh -u=<docker-user-name>|--duser=<docker-user-name>"
    echo "usage: ./deploy_docker_rpi.sh -k=<docker-password>|--dpass=<docker-password>"
    exit 1;
    ;;
esac
done
##########################################################

build_message(){
    # $1 = build message
    echo
    echo =========BUILD MESSAGE=========
    echo "$@"
    echo ===============================
    echo
}

prepare_package_arm(){
	BRANCH=$BRANCH_INPUT
	COMMIT=${COMMIT_INPUT::8}
	RANDOM_FINGERPRINT=$(random_generator)
	FINGERPRINT="rpi-couchdb-$RANDOM_FINGERPRINT"
	TEST_DIRECTORY=/tmp/"$FINGERPRINT"
	REPO_LINK="https://github.com/treehouses/rpi-couchdb.git"
	FOOTPRINT_NAME=$VERSION-$BRANCH-$COMMIT
	FOOTPRINT=~/travis-build/$FOOTPRINT_NAME
}


random_generator(){
    awk -v min=10000000 -v max=99999999 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'
}

build_message Preparing builds...
prepare_package_arm

build_message setting up build utils...
source ./.travis/travis_utils.sh
prepare_package

build_message Build V172 image started...
deploy_v172
build_message Build V172 image finished, check build result!

build_message Build V212 image started...
deploy_v212
build_message Build V212 image finished, check build result!

build_message Build V171 arm64 image started...
deploy_v171_arm64
build_message Build V171 arm64 image finished, check build result!

build_message Build V211 arm64 image started...
deploy_v211_arm64
build_message Build V211 arm64 image finished, check build result!

build_message Preparing to Push multi-arch manifest to Docker Cloud ..
deploy_multiarch

