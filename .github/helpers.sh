#!/bin/bash

cos_version() {
    SHA=$(echo $GITHUB_SHA | cut -c1-8 )
    echo $(/usr/bin/yq r packages/cos/collection.yaml 'packages.[0].version')-g$SHA
}

create_remote_manifest() {
    MANIFEST=$1
    cp -rf $MANIFEST $MANIFEST.remote
    /usr/bin/yq w -i $MANIFEST.remote 'luet.repositories[0].name' 'cOS'
    /usr/bin/yq w -i $MANIFEST.remote 'luet.repositories[0].enable' true
    /usr/bin/yq w -i $MANIFEST.remote 'luet.repositories[0].priority' 90
    /usr/bin/yq w -i $MANIFEST.remote 'luet.repositories[0].type' 'docker'
    /usr/bin/yq w -i $MANIFEST.remote 'luet.repositories[0].urls[0]' $FINAL_REPO
}

drop_recovery() {
    MANIFEST=$1
    /usr/bin/yq d -i $MANIFEST 'packages.isoimage(.==recovery/cos-img)'
}