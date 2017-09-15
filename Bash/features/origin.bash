export GOPATH=$HOME/go-projects/origin
export PATH=$PATH:$GOPATH/bin
export OS_OUTPUT_GOPATH=1

d=$GOPATH/src/github.com/openshift/origin

export PATH=/usr/local/go1.9/go/bin:$PATH
export PATH=/home/aim/repos/github/golang/go/bin:$PATH

##export PATH="$(source $d/hack/lib/init.sh; echo "${OS_OUTPUT_BINPATH}/$(os::build::host_platform)/"):${PATH}"

provide origin
