#!/bin/bash

set -o errtrace
set -o errexit
set -o nounset

TOP_DIR=$(cd $(dirname "$0") && pwd)
source $TOP_DIR/meta.sh

for i in tar; do
    fpm -f --prefix=$GOROOT_FINAL \
	-s dir \
	-t $i \
	-C go \
	--name $(basename $GOROOT_FINAL)-home-devenv \
	--version 1.0.0 \
	--description "Go ${GO_VERSION} packaged with additional dev tools (godef, gocode, ...)" \
	--iteration $PKG_ITERATION bin src pkg doc
done
