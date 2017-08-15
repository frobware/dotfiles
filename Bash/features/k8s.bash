function x {
    rm -f *.test;
    go test -i -x -gcflags "-N -l" && go test -c -x -gcflags "-N -l";
}

provide k8s
