#!/bin/bash

progname=$(basename $0)

if [ $# -lt 2 ]; then
   echo "error: $progname <WINDOW-CLASS> <PROG>" >&2
   exit 1
fi

window=$1; shift
program=$1; shift
 
#if [[ "$window" = "emacs.Emacs" ]]; then
#    exit 0
#fi

wmctrl -x -a $window
wmctrl -x -a $window || exec $program "$@"
