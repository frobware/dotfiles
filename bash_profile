# -*-shell-script-*-

[ -f ~/.bash_bootstrap ] && . ~/.bash_bootstrap
[ -f /etc/profile ] && . /etc/profile

# Override/Export all of these...
set -a
EDITOR='emacsclient'
VISUAL='emacsclient'
XUSERFILESEARCHPATH=$HOME/lib/X11/app-defaults/%N%S
RLWRAP=$HOME/.rlwrap
PAGER="less -X -e -q -s -m"
LESS="-X -e -q -s -m"
BC_ENV_ARGS="$HOME/.bcrc"
MANWIDTH=80
ARMLMD_LICENSE_FILE=8224@127.0.0.1
LIBVIRT_DEFAULT_URI=qemu:///system

# For 24-bit Emacs terminals
ITERM_24BIT=yes
KONSOLE_DBUS_SESSION=1
set +a

[ -f $HOME/.bcrc ] || touch $HOME/.bcrc

require -q "${BASH_HOST_TYPE}-profile"
require -q "${HOSTNAME}-bash-profile"

[ -d $HOME/bin ] && path_prepend PATH $HOME/bin
[ -d $HOME/dotfiles/scripts ] && path_append PATH $HOME/dotfiles/scripts

# Load our personal bashrc.  This is located through $FPATH.
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

trimpath PATH
trimpath LD_LIBRARY_PATH

if [ -x /usr/local/bin/brew ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
    fi
fi

if [ ! -f ~/.terminfo/x/xterm-24bit ]; then
    cat <<EOF > /tmp/xterm-24bit-$$.src
# Use colon separators.
xterm-24bit|xterm with 24-bit direct color mode,
   use=xterm-256color,
   setb24=\E[48:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
   setf24=\E[38:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
EOF
    tic -x -o ~/.terminfo /tmp/xterm-24bit-$$.src
fi

if [ ! -f ~/.terminfo/x/xterm-24bits ]; then
    cat <<EOF > /tmp/xterm-24bits-$$.src
# Use semicolon separators; this seems to work better with tmux.
xterm-24bits|xterm with 24-bit direct color mode,
   use=xterm-256color,
   setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
   setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF
    tic -x -o ~/.terminfo /tmp/xterm-24bits-$$.src
fi

export PATH="$HOME/.cargo/bin:$PATH"
