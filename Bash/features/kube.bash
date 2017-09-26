: ${GOPATH:?/var/tmp/you-did-not-set-gopath}

function x {
    rm -f *.test;
    go test -i -x -gcflags "-N -l" && go test -c -x -gcflags "-N -l";
}

function xr {
    rm -f *.test;
    go test -i -race -gcflags "-N -l" && go test -race -c -x -gcflags "-N -l";
}

function clone_tree {
    local working_dir=$1/src/k8s.io
    local user=frobware
    mkdir -p $working_dir
    cd $working_dir
    git clone https://github.com/$user/kubernetes.git
    git remote set-url --push upstream no_push
}

function localkube {
    export KUBERNETES_PROVIDER=local
    export PATH=$GOPATH/src/k8s.io/kubernetes:$PATH
    sudo chmod 777 /var/run/kubernetes
    sudo chmod +r /var/run/kubernetes/server-ca.crt
    sudo chmod +r /var/run/kubernetes/client-admin.crt
    sudo chmod +r /var/run/kubernetes/client-admin.key
    kubectl.sh config set-cluster local --server=https://localhost:6443 --certificate-authority=/var/run/kubernetes/server-ca.crt
    kubectl.sh config set-credentials myself --client-key=/var/run/kubernetes/client-admin.key --client-certificate=/var/run/kubernetes/client-admin.crt
    kubectl.sh config set-context local --cluster=local --user=myself
    kubectl.sh config use-context local
}

function localkubeproxy {
    kubectl.sh -s http://127.0.0.1:6443 proxy --port=8081
}

export KUBECONFIG=/var/run/kubernetes/admin.kubeconfig
export PATH=$GOPATH/src/k8s.io/kubernetes/_output/local/go/bin:$PATH
export PATH=$GOPATH/src/k8s.io/kubernetes/third_party/etcd:${PATH}

type -p kubectl >& /dev/null && source <(kubectl completion bash) 

provide kube
