#!/bin/bash

pgrep -x -u $USER -f 'emacs --daemon'

if [[ $? = 0 ]]; then
    emacsclient -e '(kill-emacs)'
fi

