#!/bin/bash

: ${TOOLS_DIR:=${HOME}/.gotools}

export GOPATH=$TOOLS_DIR
mkdir -p $TOOLS_DIR

go get ${UPDATE:-} code.google.com/p/go.tools/cmd/godoc
go get ${UPDATE:-} code.google.com/p/go.tools/cmd/goimports
go get ${UPDATE:-} code.google.com/p/rog-go/exp/cmd/godef
go get ${UPDATE:-} github.com/dougm/goflymake
go get ${UPDATE:-} github.com/kisielk/errcheck
go get ${UPDATE:-} github.com/nsf/gocode
cd $GOPATH
go build ./...
