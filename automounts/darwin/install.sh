#!/usr/bin/env bash

set -eu

sudo install -m 644 auto_master /etc/auto_master

# The following /etc/auto_<X> files must be 0600 when installed or
# they will silently fail.

sudo install -m 644 auto_u /etc/auto_u
sudo install -m 644 auto_r /etc/auto_r

sudo automount -vc
