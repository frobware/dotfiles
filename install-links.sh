#!/bin/bash

# Invoke this as:
#
# cd $HOME
# ./dotfiles/install-links.sh

THISDIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)"

while getopts "d" opt; do
    case $opt in
	d) dry_run=echo;
	   shift
	   ;;
	\?)
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
	    ${dry_run} ln -hfsv "$source" "$target"
	    ;;
	linux*)
	    ${dry_run} rm -f "$target"
	    ${dry_run} ln -fsvr "$source" "$target"
	    ;;
    esac
}

install_link "$THISDIR/Resources/Xresources" ".Xresources"
install_link "$THISDIR/tmux.conf" ".tmux.conf"

install_link $THISDIR/.bash_aliases .bash_aliases
install_link $THISDIR/.bash_bootstrap .bash_bootstrap
install_link $THISDIR/.bash_profile .bash_profile
install_link $THISDIR/.bashrc .bashrc
install_link $THISDIR/.bashrc_emacs .bashrc_emacs
install_link $THISDIR/.bash_functions .bash_functions
install_link $THISDIR/.bash_features .bash_features

exit 0
