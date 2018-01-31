# -*-shell-script-*-

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function source_if_exists() {
    local fname=$1
    [[ -r $(readlink -f $fname) ]] && . $fname
}

if [ -z "$BASH_HOME" ]; then
    export BASH_HOME="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)"
    source_if_exists ${BASH_HOME}/.bash_bootstrap
fi

source_if_exists /etc/skel/.bashrc
source_if_exists /etc/profile

shopt -s histappend

# single line cmd history
shopt -s cmdhist
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTSIZE=5000000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

export GPG_TTY=$(tty)

source_if_exists /etc/bash_completion

if [ -x /usr/local/bin/brew ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
    fi
fi

# Graciously stolen from idf
function check_exit_status ()
{
    local status="$?"
    local msg=""
    local signal=""

    if [ ${status} -ne 0 ]; then
	if [ $((${status} < 128)) -ne 0 ] ; then
	    msg="exit (${status})"
	else
	    signal="$(builtin kill -l $((${status} - 128)) 2>/dev/null)"
	    if [ "$signal" ]; then msg="kill -$signal$msg"; fi
	fi
	echo "[${status} => ${msg}]" 1>&2
    fi
    return 0
}

declare -x check_exit_status

[ -n "$TMUX" ] && export TERM=xterm-256color

bold()          { ansi 1 "$@"; }
italic()        { ansi 3 "$@"; }
underline()     { ansi 4 "$@"; }
strikethrough() { ansi 9 "$@"; }
red()           { ansi 31 "$@"; }
green()         { ansi 32 "$@"; }
ansi()          { echo -e "\e[${1}m${*:2}\e[0m"; }

function __vpn_active() {
    if [ -e /proc/sys/net/ipv4/conf/tun0 ]; then
	vpn_active=$(red $(bold "VPN"))
    else
	vpn_active=
    fi
}

declare -x __vpn_active

export PROMPT_COMMAND="__vpn_active; $PROMPT_COMMAND"
export PS1='${vpn_active:+[${vpn_active}] }\u@\h:\w\n$ '

shopt -s checkwinsize

if type -p brew 2>/dev/null >/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
    fi
fi

source_if_exists /usr/local/etc/bash_completion

source_if_exists "$HOME/.bash_aliases"
source_if_exists '$HOME/Downloads/google-cloud-sdk/path.bash.inc'
source_if_exists '$HOME/Downloads/google-cloud-sdk/completion.bash.inc'

type -p direnv &>/dev/null && eval "$(direnv hook bash)"
type -p minikube &>/dev/null && source <(minikube completion bash)
type -p kubectl &>/dev/null && source <(kubectl completion bash)
type -p oc &>/dev/null && source <(oc completion bash)

function man() {
    env \
	LESS_TERMCAP_md=$'\e[1;36m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[1;40;92m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[1;32m' \
	man "$@"
}

function cover() {
    local t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}
