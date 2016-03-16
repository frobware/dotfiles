export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

[ -f ~/juju/etc/bash_completion.d/juju-core ] && \
    .  ~/juju/etc/bash_completion.d/juju-core

provide juju-dev
