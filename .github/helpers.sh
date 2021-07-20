#!/bin/bash

cos_version() {
    export COS_VERSION=$(yq r packages/cos/collection.yaml 'packages.[0].version')
}

create_remote_manifest() {
    MANIFEST=$1
    cp -rf $MANIFEST $MANIFEST.remote
    yq w -i $MANIFEST.remote 'luet.repositories[0].name' 'cOS'
    yq w -i $MANIFEST.remote 'luet.repositories[0].enable' true
    yq w -i $MANIFEST.remote 'luet.repositories[0].priority' 90
    yq w -i $MANIFEST.remote 'luet.repositories[0].type' 'docker'
    yq w -i $MANIFEST.remote 'luet.repositories[0].urls[0]' $FINAL_REPO
}