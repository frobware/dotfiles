#!/bin/bash -x

set -o errtrace
set -o errexit
set -o nounset

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

# git clone http://github.com/davecheney/golang-crosscompile
if [ -d golang-crosscompile ]; then
    source golang-crosscompile/crosscompile.bash
    go-crosscompile-build-all
else
    ./make.bash
fi
