function x {
    rm -f *.test;
    go test -i -x -gcflags "-N -l" && go test -c -x -gcflags "-N -l";
}

function localkube {
    export KUBERNETES_PROVIDER=local
    export PATH=$HOME/go/src/k8s.io/kubernetes/cluster:$PATH
    kubectl.sh config set-cluster local --server=https://localhost:6443 --certificate-authority=/var/run/kubernetes/server-ca.crt
    kubectl.sh config set-credentials myself --client-key=/var/run/kubernetes/client-admin.key --client-certificate=/var/run/kubernetes/client-admin.crt
    kubectl.sh config set-context local --cluster=local --user=myself
    kubectl.sh config use-context local
}

function localkubeproxy {
    kubectl.sh -s http://127.0.0.1:8080 proxy --port=8081
}

PATH=$HOME/go/src/k8s.io/kubernetes/_output/local/go/bin:$PATH
export PATH=$HOME/go/src/k8s.io/kubernetes/third_party/etcd:${PATH}

provide k8s
