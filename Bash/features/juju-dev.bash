export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

[ -f ~/juju/etc/bash_completion.d/juju-2.0 ] && \
    .  ~/juju/etc/bash_completion.d/juju-2.0

provide juju-dev
