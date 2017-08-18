function x {
    rm -f *.test;
    go test -i -x -gcflags "-N -l" && go test -c -x -gcflags "-N -l";
}

PATH=$HOME/go/src/k8s.io/kubernetes/_output/local/go/bin:$PATH

provide k8s
