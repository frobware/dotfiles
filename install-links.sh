#!/bin/bash

DOT_FILES="
bash_aliases
bash_bootstrap
bash_logout
bash_profile
bashrc
"

OTHER_FILES="
Bash
defaultzoom2.css
"

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
    if [ -e "$target" ] && [ ! -L "$target" ]; then
	CURDATE=$(date | sed 's/ /-/g')
	echo "*** WARNING *** $target already exists; copying original to .$file.old.${CURDATE})"
	mv "$target" "$target.old.${CURDATE}"
    fi
    case $OSTYPE in
	darwin*)
	    if [ $dry_run ]; then
		echo "WOULD: " ln -hfsv "$source" "$target"
	    else
		ln -hfsv "$source" "$target"
	    fi
	    ;;
	linux*)
	    if [ $dry_run ]; then
		echo "WOULD: " ln -fsv "$source" "$target"
	    else
		ln -fsv "$source" "$target"
	    fi
	    ;;
    esac
}

for file in $DOT_FILES
do
    install_link "$PWD/$file" "$HOME/.$file"
done

for file in $OTHER_FILES
do
    install_link "$PWD/$file" "$HOME/$file"
done

exit 0
