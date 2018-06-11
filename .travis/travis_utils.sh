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
    yes | docker login --username=$DOCKER_USER --password=$DOCKER_PASS
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
	V200_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.0.0-$VERSION-$BRANCH-$COMMIT
	V200_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.0.0
	V210_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.1.0-$VERSION-$BRANCH-$COMMIT
	V210_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.1.0
	V211_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.1.1-$VERSION-$BRANCH-$COMMIT
	V211_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.1.1
	V171_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:1.7.1-$VERSION-$BRANCH-$COMMIT
	V171_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:1.7.1
}

package_v171(){
	build_message processing $V171_DOCKER_NAME
	docker build 1.7.1/ -t $V171_DOCKER_NAME
	build_message done processing $V171_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message processing $V171_DOCKER_NAME_LATEST
		docker tag $V171_DOCKER_NAME $V171_DOCKER_NAME_LATEST
		build_message done processing $V171_DOCKER_NAME_LATEST
	fi
}

package_v200(){
	build_message processing $V200_DOCKER_NAME
	docker build 2.0.0/ -t $V200_DOCKER_NAME
	build_message done processing $V200_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message processing $V200_DOCKER_NAME_LATEST
		docker tag $V200_DOCKER_NAME $V200_DOCKER_NAME_LATEST
		build_message done processing $V200_DOCKER_NAME_LATEST
	fi
}

package_v210(){
	build_message processing $V210_DOCKER_NAME
	docker build 2.1.0/ -t $V210_DOCKER_NAME
	build_message done processing $V210_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message processing $V210_DOCKER_NAME_LATEST
		docker tag $V210_DOCKER_NAME $V210_DOCKER_NAME_LATEST
		build_message done processing $V210_DOCKER_NAME_LATEST
	fi
}

package_v211(){
	build_message processing $V211_DOCKER_NAME
	docker build 2.1.1/ -t $V211_DOCKER_NAME
	build_message done processing $V211_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message processing $V211_DOCKER_NAME_LATEST
		docker tag $V211_DOCKER_NAME $V211_DOCKER_NAME_LATEST
		build_message done processing $V211_DOCKER_NAME_LATEST
	fi
}

push_v171(){
	build_message pushing $V171_DOCKER_NAME
	docker push $V171_DOCKER_NAME
	build_message done pushing $V171_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message pushing $V171_DOCKER_NAME_LATEST
		docker push $V171_DOCKER_NAME_LATEST
		build_message done pushing $V171_DOCKER_NAME_LATEST
	fi
}

push_v200(){
	build_message pushing $V200_DOCKER_NAME
	docker push $V200_DOCKER_NAME
	build_message done pushing $V200_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message pushing $V200_DOCKER_NAME_LATEST
		docker push $V200_DOCKER_NAME_LATEST
		build_message done pushing $V200_DOCKER_NAME_LATEST
	fi
}

push_v210(){
	build_message pushing $V210_DOCKER_NAME
	docker push $V210_DOCKER_NAME
	build_message done pushing $V210_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message pushing $V210_DOCKER_NAME_LATEST
		docker push $V210_DOCKER_NAME_LATEST
		build_message done pushing $V210_DOCKER_NAME_LATEST
	fi
}

push_v211(){
	build_message pushing $V211_DOCKER_NAME
	docker push $V211_DOCKER_NAME
	build_message done pushing $V211_DOCKER_NAME
	if [ "$BRANCH" = "add-arm64-support" ]
	then
		build_message pushing $V211_DOCKER_NAME_LATEST
		docker push $V211_DOCKER_NAME_LATEST
		build_message done pushing $V211_DOCKER_NAME_LATEST
	fi
}

deploy_v171(){
	login_docker
	package_v171
	push_v171
}

deploy_v200(){
	login_docker
	package_v200
	push_v200
}

deploy_v210(){
	login_docker
	package_v210
	push_v210
}

deploy_v211(){
	login_docker
	package_v211
	push_v211
}

deploy_v171_arm64(){
	login_docker
	sed -i -e "s/\(resin\/rpi-raspbian\)/resin\/aarch64-debian/" 1.7.1/Dockerfile
	V171_DOCKER_NAME_LATEST="$DOCKER_ORG/$DOCKER_REPO:arm64-1.7.1"
	V171_DOCKER_NAME="$DOCKER_ORG/$DOCKER_REPO:arm64-1.7.1-$VERSION-$BRANCH-$COMMIT"
	package_v171
	push_v171
}

deploy_v211_arm64(){
	login_docker
	rm 2.1.1/Dockerfile
    mv 2.1.1/Dockerfile-arm64 2.1.1/Dockerfile
    if [ "$BRANCH" = "add-arm64-support" ]
	then
        sed -i -e "s/\(treehouses\/rpi-couchdb:2\.1\.1\)/$V211_DOCKER_NAME_LATEST/" 2.1.1/Dockerfile
    else
        sed -i -e "s/\(treehouses\/rpi-couchdb:2\.1\.1\)/$V211_DOCKER_NAME/" 2.1.1/Dockerfile
    fi
	V211_DOCKER_NAME_LATEST="$DOCKER_ORG/$DOCKER_REPO:arm64-2.1.1"
	V211_DOCKER_NAME="$DOCKER_ORG/$DOCKER_REPO:arm64-2.1.1-$VERSION-$BRANCH-$COMMIT"
	package_v211
	push_v211
}

deploy_multiarch(){
    if [ "$BRANCH" = "add-arm64-support" ]
	then
        build_message Pushing multi-arch manifest to Docker Cloud
        login_docker
        wget -O manifest-tool https://github.com/estesp/manifest-tool/releases/download/v0.7.0/manifest-tool-linux-amd64
        chmod +x ./manifest-tool
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v2.1.1.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v1.7.1.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_latest.yml
        build_message Successfully pushed multi-arch manifest to Docker Cloud.
        build_message Removing Manifest Tool
        rm ./manifest-tool
    else
        build_message Branch is not master. So no need to push multiarch manifest.
    fi

}
