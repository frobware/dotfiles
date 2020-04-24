# -*-shell-script-*-

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function source_if_exists() {
    local fname=$1
    [[ -r $(readlink -f $fname) ]] && source $fname
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
export HISTSIZE=5000000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

source_if_exists /etc/bash_completion

if [ -x /usr/local/bin/brew ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
    fi
fi

# Graciously stolen from idf
function resolve_exit_status()
{
    local status="$1"
    local msg=""
    local signal=""

    if [ ${status} -ne 0 ]; then
	if [ $((${status} < 128)) -ne 0 ] ; then
	    msg="exit (${status})"
	else
	    signal="$(builtin kill -l $((${status} - 128)) 2>/dev/null)"
	    if [ -n "$signal" ]; then
		msg="kill -$signal$msg";
	    fi
	fi
	echo "[$status => $msg]"
    fi
}

bold()          { ansi 1 "$@"; }
italic()        { ansi 3 "$@"; }
underline()     { ansi 4 "$@"; }
reversevideo()  { ansi 7 "$@"; }
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

shopt -s checkwinsize

#if type -P brew 2>/dev/null >/dev/null; then
#    if [ -f $(brew --prefix)/etc/bash_completion ]; then
#	. $(brew --prefix)/etc/bash_completion
#    fi
#fi

source_if_exists /usr/local/etc/bash_completion

source_if_exists "$HOME/.bash_aliases"
source_if_exists '$HOME/Downloads/google-cloud-sdk/path.bash.inc'
source_if_exists '$HOME/Downloads/google-cloud-sdk/completion.bash.inc'

# type -P: means run these helpers only if the respective binary exists.
type -P direnv &>/dev/null && eval "$(direnv hook bash)"

function source_kubectl_completion() {
    type -P kubectl 2>&1 >/dev/null && source <(kubectl completion bash)
}

function source_oc_completion() {
    type -P oc 2>&1 >/dev/null && source <(oc completion bash)
}

function source_ocadm_completion() {
    type -P oc adm 2>&1 >/dev/null && source <(oc adm completion bash)
}

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

export PS1="\u@\h:\w\n$ "

# if [[ "$HOSTNAME" =~ t4[6-7]0s ]]; then
#     gpgconf --launch gpg-agent
#     export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# fi

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

source_kubectl_completion
source_oc_completion
source_ocadm_completion

export GOPACKAGESDRIVER=golist

#unalias ls

function refresh() {
    :
}

if [ -n "$TMUX" ]; then
    function refresh() {
	export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
	export $(tmux show-environment | grep "^DISPLAY")
    }
fi

function preexec {
    refresh
}
