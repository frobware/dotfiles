#!/bin/bash

# Invoke this as:#
#
# cd $HOME
# ./dotfiles/install-links.sh
#

THISDIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)"

while getopts "d" opt; do
    case $opt in
	d) dry_run=1; shift;;
	\?) echo ${USAGE}
	    exit 1
	    ;;
    esac
done

function install_link() {
    local source=$1
    local target=$2

    # Create backup file if the target already exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ] && [ ! -d "$target" ]; then
	CURDATE=$(date | sed 's/ /-/g')
	echo "*** WARNING *** $target already exists; copying original to .$file.old.${CURDATE})"
	mv "$target" "$target.old.${CURDATE}"
    fi
    case $OSTYPE in
	darwin*)
	    if [ $dry_run ]; then
		echo ln -hfsv "$source" "$target"
	    else
		ln -hfsv "$source" "$target"
	    fi
	    ;;
	linux*)
	    if [ $dry_run ]; then
		echo rm -f "$target"
		echo ln -fsv "$source" "$target"
	    else
		rm -f "$target"
		ln -fsvr "$source" "$target"
	    fi
	    ;;
    esac
}

mkdir -p $HOME/bin

# Bash
for file in $(ls $THISDIR/Bash/bash*)
do
    target=$(basename "$file")
    install_link "${file}" ".${target}"
done

# Scripts
for file in $(ls $THISDIR/scripts/*.sh)
do
    target=$(basename "$file" .sh)
    install_link "$file" "bin/$target"
done

for file in $(ls $THISDIR/scripts/clean*)
do
    target=$(basename "$file")
    install_link "$file" "bin/$target"
done

install_link "$THISDIR/Resources/Xresources" ".Xresources"
install_link "$THISDIR/tmux.conf" ".tmux.conf"
install_link "$THISDIR/cmd-key-happy.lua" ".cmd-key-happy.lua"
install_link "$THISDIR/cmd-key-happy.rc" ".cmd-key-happy.rc"
install_link "$THISDIR/Resources/gnomerc" ".gnomerc"

exit 0
