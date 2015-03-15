#!/bin/bash -x

set -o errtrace
set -o errexit
set -o nounset

trap "exit 1;" SIGINT

TOP_DIR=$(cd $(dirname "$0") && pwd)
source $TOP_DIR/meta.sh

if [ ! -d go ]; then
    git clone https://github.com/golang/go.git
elif [ "$GIT_UPDATE" = "yes" ]; then
    git fetch -a
fi

cd go/src
git reset --hard
git checkout ${GO_VERSION}
git clean -f -d -x

export GOROOT_FINAL

./make.bash

export GOROOT=$TOP_DIR/go
PATH=$GOROOT/bin:$PATH

go env

# git clone http://github.com/davecheney/golang-crosscompile
if [ -d $TOP_DIR/golang-crosscompile ]; then
    source $TOP_DIR/golang-crosscompile/crosscompile.bash
    go-crosscompile-build-all
fi
