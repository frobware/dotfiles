#!/bin/bash

sudo apt-get install curl bzr mercurial -y

set -xu

: ${TOOLS_DIR:=${HOME}/.gotools}

export GOPATH=$TOOLS_DIR
export GOBIN=$GOPATH/bin

mkdir -p $TOOLS_DIR

go ${GET:=get} github.com/niemeyer/godeb
go ${GET:-get} code.google.com/p/go.tools/cmd/godoc
go ${GET:-get} code.google.com/p/go.tools/cmd/goimports
go ${GET:-get} code.google.com/p/rog-go/exp/cmd/godef
go ${GET:-get} github.com/dougm/goflymake
go ${GET:-get} github.com/jstemmer/gotags
go ${GET:-get} github.com/kisielk/errcheck
go ${GET:-get} github.com/nsf/gocode
go ${GET:-get} github.com/inconshreveable/gonative
go ${GET:-get} github.com/golang/lint/golint
go ${GET:-get} code.google.com/p/go.tools/cmd/oracle
