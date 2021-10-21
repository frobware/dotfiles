#!/usr/bin/env bash

# Depends on ambr(1) - https://lib.rs/crates/amber

set -eux

mkdir -p /tmp/lib/haproxy/run /tmp/run/configmaps

ambr --no-interactive /var/lib /tmp/lib ${1:-haproxy.config}

for i in $(grep -o '/tmp/lib/.*map' ${1:-haproxy.config})
do
    mkdir -p $(dirname $i)
    touch $i
done

for i in $(grep -o '/tmp/lib/.*\.pem' ${1:-haproxy.config})
do
    mkdir -p $(dirname $i)
    # in case you've run this script before and perms of domain.pem are 0444.
    rm -f $(dirname $i)/$(basename $i)
    cp ${2:-~/domain.pem} $i
done

ambr --no-interactive 'ca-file /var/run/configmaps/service-ca/service-ca.crt' "verify none" ${1:-haproxy.config}
ambr --no-interactive 'no option http-use-htx' "" ${1:-haproxy.config}
ambr --no-interactive 'errorfile 503 /tmp/lib/haproxy/conf/error-page-503.http' "" ${1:-haproxy.config}
ambr --no-interactive "verify required" "verify none" ${1:-haproxy.config}
ambr --no-interactive "bind :443" "bind :1443" ${1:-haproxy.config}
ambr --no-interactive "bind :80" "bind :8181" ${1:-haproxy.config}

haproxy -c -f ${1:-haproxy.config}
