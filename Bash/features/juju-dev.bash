export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

[ -f ~/juju/etc/bash_completion.d/juju2 ] && \
    .  ~/juju/etc/bash_completion.d/juju2

provide juju-dev
