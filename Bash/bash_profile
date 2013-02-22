# -*-shell-script-*-

[ -f ~/.bash_bootstrap ] && . ~/.bash_bootstrap
[ -f /etc/profile ] && . /etc/profile

# Override/Export all of these...
set -a
EDITOR='emacsclient -c'
VISUAL='emacsclient -c'
XUSERFILESEARCHPATH=$HOME/lib/X11/app-defaults/%N%S
RLWRAP=$HOME/.rlwrap
PAGER="less -X -e -q -s -m"
LESS="-X -e -q -s -m"
BC_ENV_ARGS="$HOME/.bcrc"
MANWIDTH=80
set +a

require -q "${HOSTNAME}-bash-profile"

[ -d $HOME/bin ] && path_prepend PATH $HOME/bin

#keychain --inherit any -Q -q id_dsa id_rsa identity
#[ -f ~/.keychain/${HOSTNAME}-sh ] && source ~/.keychain/${HOSTNAME}-sh

# Load our personal bashrc.  This is located through $FPATH.
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

trimpath PATH
trimpath LD_LIBRARY_PATH

export GOPATH=$HOME/mygo
