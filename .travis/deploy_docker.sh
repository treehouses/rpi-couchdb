#!/usr/bin/env bash

source ./.travis/travis_utils.sh

build_message Preparing builds...
prepare_package

build_message Now building for ARM...
ssh -i ./.travis/deploy_rsa -o StrictHostKeyChecking=no -p 22 travis@kraken.ole.org 'bash -s' -- < ./.travis/deploy_docker_rpi.sh  --branch="$BRANCH" --commit="$COMMIT" --duser="$DOCKER_USER" --dpass="$DOCKER_PASS"

