: ${GOPATH:?you-did-not-set-gopath}

cd $GOPATH/src/github.com/openshift/origin

# git clone git@github.com:frobware/ose origin

# git remote add upstream https://github.com/openshift/ose

# Go1.9 gives better debug support
# export PATH=/usr/local/go1.9/go/bin:$PATH
# export PATH=/home/aim/repos/github/golang/go/bin:$PATH

export PATH="$(source hack/lib/init.sh; echo "${OS_OUTPUT_BINPATH}/$( os::build::host_platform )/":${PATH})"
export KUBECONFIG=$PWD/openshift.local.config/master/admin.kubeconfig

function os_master_write_config() {
    openshift start master --write-config=openshift.local.config/master "$@"
}

function os_master_start() {
    openshift start master --config=openshift.local.config/master/master-config.yaml "$@"
}

function os_node_oadm() {
    # e.g., --dns-ip=127.0.0.1
    oadm create-node-config --node-dir openshift.local.config/node-$(uname -n) --node=node-$(uname -n) --hostnames=$(uname -n),127.0.0.1 "$@"
}

function os_node_start() {
    sudo $(which openshift) start node --config=openshift.local.config/node-$(uname -n)/node-config.yaml "$@"
}

provide ose
