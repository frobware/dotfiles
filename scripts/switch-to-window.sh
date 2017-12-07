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

# Why the double call? Because when apps are in full screen mode (in
# Unity) they only seem to switch if you invoke it twice.
#wmctrl -x -a $window
echo "$@" >> /tmp/s
wmctrl -x -a $window || exec $program "$@"

