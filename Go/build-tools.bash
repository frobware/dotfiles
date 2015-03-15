#!/bin/bash

set -o errtrace
set -o errexit
set -o nounset

TOP_DIR=$(cd $(dirname "$0") && pwd)
source $TOP_DIR/meta.sh

PATH=$TOP_DIR/go/bin:$PATH
export GOROOT=$TOP_DIR/go
go env

#export GOPATH=$(mktemp -d)
export GOPATH=/tmp/tmp.VfXokl3LZM
mkdir -p $GOPATH

trap "exit 1;" SIGINT

go ${GET:-get} golang.org/x/tools/cmd/...
go ${GET:-get} code.google.com/p/rog-go/exp/cmd/godef
go ${GET:-get} github.com/dougm/goflymake
go ${GET:-get} github.com/jstemmer/gotags
go ${GET:-get} github.com/kisielk/errcheck
go ${GET:-get} github.com/nsf/gocode
go ${GET:-get} github.com/inconshreveable/gonative
go ${GET:-get} github.com/golang/lint/golint

cp $GOPATH/bin/* $TOP_DIR/go/bin
