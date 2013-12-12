#!/bin/bash

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
		echo ln -hfsv "$source" "$target"
	    else
		ln -hfsv "$source" "$target"
	    fi
	    ;;
	linux*)
	    if [ $dry_run ]; then
		echo ln -fsv "$source" "$target"
	    else
		ln -fsv "$source" "$target"
	    fi
	    ;;
    esac
}

mkdir -p $HOME/.emacs.d $HOME/bin

# Emacs
for file in $(ls Emacs/*.el)
do
    target=$(basename "$file")
    install_link "$PWD/$file" "$HOME/.emacs.d/$target"
done

rm -f $HOME/.emacs.d/lisp
install_link "$PWD/Emacs/lisp" "$HOME/.emacs.d/lisp"

# Bash
for file in $(ls Bash/bash*)
do
    target=$(basename "$file")
    install_link "$PWD/$file" "$HOME/.$target"
done

# Scripts
for file in $(ls scripts/*.sh)
do
    target=$(basename "$file" ".sh")
    install_link "$PWD/$file" "$HOME/bin/$target"
done

for file in $(ls scripts/clean*)
do
    target=$(basename "$file")
    install_link "$PWD/$file" "$HOME/bin/$target"
done

install_link "$PWD/Resources/Xresources" "$HOME/.Xresources"
install_link "$PWD/Mail/offlineimaprc" "$HOME/.offlineimaprc"
install_link "$PWD/Mail/offlineimap.py" "$HOME/.offlineimap.py"
install_link "$PWD/Mail/msmtprc" "$HOME/.msmtprc"

install_link "$PWD/tmux.conf" "$HOME/.tmux.conf"

exit 0
