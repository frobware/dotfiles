#!/bin/sh

tmpname=$(basename $0)
tmpfile=$(mktemp ${TMPDIR:-/tmp}/${tmpname}.XXXXXX || exit 1)
trap "rm -f $tmpfile" EXIT
osascript -e "tell front window of application \"Terminal\" to set selected tab to tab $1" > $tmpfile 2>&1
egrep "Can’t get tab [1-9]+ of window [1-9]+. Invalid index" $tmpfile >/dev/null 2>&1 && exit 0
cat $tmpfile
exit 1
