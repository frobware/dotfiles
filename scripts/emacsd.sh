#!/bin/bash

pgrep -x -u $USER -f 'emacs --daemon'

if [[ $? != 0 ]]; then
    emacs --daemon
fi
