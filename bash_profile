# -*-shell-script-*-

function source_if_exists() {
    local fname=$1
    [[ -r $(readlink -f $fname) ]] && source $fname
}

export BASH_HOME="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)"

source_if_exists $BASH_HOME/.bash_bootstrap
source_if_exists /etc/profile

# Addition of:
#
#  sitm=\E[3m,  // enter_italics_mode	
#  ritm=\E[23m, // exit_italics_mode
#
# comes from: https://github.com/syl20bnr/spacemacs/wiki/Terminal
if [ ! -f $HOME/.terminfo/x/xterm-24bit ]; then
    cat <<EOF > /tmp/xterm-24bit-$$.src
# Use colon separators.
xterm-24bit|xterm with 24-bit direct color mode,
   use=xterm-256color,
   sitm=\E[3m,
   ritm=\E[23m,
   setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
   setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF
    tic -x -o $HOME/.terminfo /tmp/xterm-24bit-$$.src
    rm /tmp/xterm-24bit-$$.src
fi

if [ ! -f $HOME/.terminfo/x/tmux-24bit ]; then
    cat <<EOF > /tmp/tmux-24bit-$$.src
# Use colon separators.
tmux-24bit|tmux with 24-bit direct color mode,
   use=tmux-256color,
   sitm=\E[3m,
   ritm=\E[23m,
   setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
   setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF
    tic -x -o $HOME/.terminfo /tmp/tmux-24bit-$$.src
    rm /tmp/tmux-24bit-$$.src
fi

if [ ! -f $HOME/.terminfo/x/xterm-24bits ]; then
    cat <<EOF > /tmp/xterm-24bits-$$.src
# Use semicolon separators; this seems to work better with tmux.
xterm-24bits|xterm with 24-bit direct color mode,
   use=xterm-256color,
   setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
   setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF
    tic -x -o $HOME/.terminfo /tmp/xterm-24bits-$$.src
    rm /tmp/xterm-24bits-$$.src
fi

#if [[ -z "$TMUX" ]] && [[ -f $HOME/.terminfo/x/xterm-24bit ]]; then
#    export TERM=xterm-24bit
#fi

[ -f $HOME/.bcrc ] || touch $HOME/.bcrc

source_if_exists $HOME/.bashrc
source_if_exists $HOME/.bash_aliases

path_append PATH $HOME/.cargo/bin
path_append PATH $HOME/dotfiles/scripts
path_prepend PATH $HOME/bin
path_prepend PATH /usr/libexec/openssh

set -a
XUSERFILESEARCHPATH=$HOME/lib/X11/app-defaults/%N%S
RLWRAP=$HOME/.rlwrap
PAGER="less -X -e -q -s -m"
LESS="-X -e -q -s -m"
BC_ENV_ARGS="$HOME/.bcrc"
MANWIDTH=80
# https://serverfault.com/questions/803283/how-do-i-list-virsh-networks-without-sudo/803298
LIBVIRT_DEFAULT_URI=qemu:///system
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
set +a

if type -p emacs &>/dev/null; then
    # $EDITOR should open in terminal
    export EDITOR="emacsclient -t"
fi

if type -p emacsclient &>/dev/null; then
    # $VISUAL opens in GUI with non-daemon as alternate
    export VISUAL='emacsclient -c --alternate-editor="" --frame-parameters="((reverse . t))"'
fi

trimpath PATH
trimpath LD_LIBRARY_PATH

export PATH="$HOME/.cargo/bin:$PATH"

if [[ "$HOSTNAME" =~ t4[6-7]0s ]]; then
    gpgconf --launch gpg-agent
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

path_prepend PATH $HOME/.local/bin

# Exemplary expiration date
export EXPIRATION_DATE=$( date -d '4 hours' --iso=minutes --utc )
