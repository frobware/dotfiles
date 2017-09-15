export GOPATH=$HOME/go-projects/origin
export PATH=$PATH:$GOPATH/bin
export OS_OUTPUT_GOPATH=1

d=$GOPATH/src/github.com/openshift/origin
cd $d

export PATH=/usr/local/go1.9/go/bin:$PATH
export PATH=/home/aim/repos/github/golang/go/bin:$PATH

export PATH="$(source hack/lib/init.sh; echo "${OS_OUTPUT_BINPATH}/$(os::build::host_platform)/"):${PATH}"

unset d

function os_write_config() {
    openshift start master --write-config=openshift.local.config/master
}

function os_start_master() {
    openshift start master --config=openshift.local.config/master
}

function os_node_oadm() {
    oadm create-node-config --node-dir openshift.local.config/node-$(uname -n) --node=node-$(uname -n) --hostnames=$(uname -n),127.0.0.1
}

function os_node_start() {
    sudo $(which openshift) start node --config=openshift.local.config/node-$(uname -n)/node-config.yaml "$@"
}

provide origin
