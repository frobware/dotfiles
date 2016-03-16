export GOPATH=~/go-projects/lxd
export PATH=$GOPATH/bin:$PATH

[ -f $HOME/go-projects/lxd/src/github.com/lxc/lxd/config/bash ] && \
 source $HOME/go-projects/lxd/src/github.com/lxc/lxd/config/bash ]

provide lxc-dev
