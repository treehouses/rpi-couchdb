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
	v212_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.1.2-$VERSION-$BRANCH-$COMMIT
	v212_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.1.2
	v220_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.2.0-$VERSION-$BRANCH-$COMMIT
	v220_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.2.0
	V230_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:2.3.0-$VERSION-$BRANCH-$COMMIT
	V230_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:2.3.0
	v172_DOCKER_NAME=$DOCKER_ORG/$DOCKER_REPO:1.7.2-$VERSION-$BRANCH-$COMMIT
	v172_DOCKER_NAME_LATEST=$DOCKER_ORG/$DOCKER_REPO:1.7.2
}

package_v172(){
	build_message processing $v172_DOCKER_NAME
	docker build 1.7.2/ -t $v172_DOCKER_NAME
	build_message done processing $v172_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $v172_DOCKER_NAME_LATEST
		docker tag $v172_DOCKER_NAME $v172_DOCKER_NAME_LATEST
		build_message done processing $v172_DOCKER_NAME_LATEST
	fi
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

package_v210(){
	build_message processing $V210_DOCKER_NAME
	docker build 2.1.0/ -t $V210_DOCKER_NAME
	build_message done processing $V210_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $V210_DOCKER_NAME_LATEST
		docker tag $V210_DOCKER_NAME $V210_DOCKER_NAME_LATEST
		build_message done processing $V210_DOCKER_NAME_LATEST
	fi
}

package_v212(){
	build_message processing $v212_DOCKER_NAME
	docker build 2.1.2/ -t $v212_DOCKER_NAME
	build_message done processing $v212_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $v212_DOCKER_NAME_LATEST
		docker tag $v212_DOCKER_NAME $v212_DOCKER_NAME_LATEST
		build_message done processing $v212_DOCKER_NAME_LATEST
	fi
}

package_v220(){
	build_message processing $v220_DOCKER_NAME
	docker build 2.2.0/ -t $v220_DOCKER_NAME
	build_message done processing $v220_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $v220_DOCKER_NAME_LATEST
		docker tag $v220_DOCKER_NAME $v220_DOCKER_NAME_LATEST
		build_message done processing $v220_DOCKER_NAME_LATEST
	fi
}

package_v230(){
	build_message processing $V230_DOCKER_NAME
	docker build 2.3.0/ -t $V230_DOCKER_NAME
	build_message done processing $V230_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message processing $V230_DOCKER_NAME_LATEST
		docker tag $V230_DOCKER_NAME $V230_DOCKER_NAME_LATEST
		build_message done processing $V230_DOCKER_NAME_LATEST
	fi
}

push_v172(){
	build_message pushing $v172_DOCKER_NAME
	docker push $v172_DOCKER_NAME
	build_message done pushing $v172_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $v172_DOCKER_NAME_LATEST
		docker push $v172_DOCKER_NAME_LATEST
		build_message done pushing $v172_DOCKER_NAME_LATEST
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

push_v210(){
	build_message pushing $V210_DOCKER_NAME
	docker push $V210_DOCKER_NAME
	build_message done pushing $V210_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $V210_DOCKER_NAME_LATEST
		docker push $V210_DOCKER_NAME_LATEST
		build_message done pushing $V210_DOCKER_NAME_LATEST
	fi
}

push_v212(){
	build_message pushing $v212_DOCKER_NAME
	docker push $v212_DOCKER_NAME
	build_message done pushing $v212_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $v212_DOCKER_NAME_LATEST
		docker push $v212_DOCKER_NAME_LATEST
		build_message done pushing $v212_DOCKER_NAME_LATEST
	fi
}

push_v220(){
	build_message pushing $v220_DOCKER_NAME
	docker push $v220_DOCKER_NAME
	build_message done pushing $v220_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $v220_DOCKER_NAME_LATEST
		docker push $v220_DOCKER_NAME_LATEST
		build_message done pushing $v220_DOCKER_NAME_LATEST
	fi
}

push_v230(){
	build_message pushing $V230_DOCKER_NAME
	docker push $V230_DOCKER_NAME
	build_message done pushing $V230_DOCKER_NAME
	if [ "$BRANCH" = "master" ]
	then
		build_message pushing $V230_DOCKER_NAME_LATEST
		docker push $V230_DOCKER_NAME_LATEST
		build_message done pushing $V230_DOCKER_NAME_LATEST
	fi
}

deploy_v172(){
	login_docker
	package_v172
	push_v172
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

deploy_v212(){
	login_docker
	package_v212
	push_v212
}

deploy_v220(){
	login_docker
	package_v220
	push_v220
}

deploy_v230(){
	login_docker
	package_v230
	push_v230
}

deploy_multiarch(){
    if [ "$BRANCH" = "master" ]
	then
        build_message Pushing multi-arch manifest to Docker Cloud
        login_docker
        wget -O manifest-tool https://github.com/estesp/manifest-tool/releases/download/v0.7.0/manifest-tool-linux-amd64
        chmod +x ./manifest-tool
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v2.1.2.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v2.2.0.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v2.3.0.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_v1.7.2.yml
        ./manifest-tool push from-spec ./.travis/multiarch_manifests/multiarch_manifest_latest.yml
        build_message Successfully pushed multi-arch manifest to Docker Cloud.
        build_message Removing Manifest Tool
        rm ./manifest-tool
    else
        build_message Branch is not master. So no need to push multiarch manifest.
    fi

}
