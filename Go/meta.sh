: ${PKG_ITERATION:=1}
: ${GO_VERSION?}
: ${GOROOT_FINAL:=/usr/local/${GO_VERSION}}
: ${GIT_UPDATE:=no}    

unset GOPATH
