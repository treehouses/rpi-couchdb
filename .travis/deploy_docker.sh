#!/usr/bin/env bash

source ./.travis/travis_utils.sh

build_message Preparing builds...
prepare_package

build_message Now building for ARM...
bash ./.travis/deploy_docker_rpi.sh  --branch="$BRANCH" --commit="$COMMIT" --duser="$DOCKER_USER" --dpass="$DOCKER_PASS"

