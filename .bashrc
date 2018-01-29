# -*-shell-script-*-

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function source_if_exists {
    local fname=$1
    [[ -f $fname ]] && . $fname
}

source_if_exists /etc/skel/.bashrc
source_if_exists /etc/profile

#source_if_exists ~/.bash_bootstrap

. ${BASH_HOME}/.bash_functions/require
. ${BASH_HOME}/.bash_functions/path-functions

# Like many of you, I constantly have many terminals open at once. I
# wish bash would dump every command I type there instead of seemingly
# randomly keeping the history of a single one.  Ho ho ho.  This does
# the trick.  http://www.geocities.com/h2428/petar/bash_hist.htm.

# Make bash history persistent across terminal sessions.

# First we instruct Bash not to store history by overwriting but to
# append lines.

shopt -s histappend
# single line cmd history
shopt -s cmdhist
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTSIZE=5000000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

GPG_TTY=$(tty)
export GPG_TTY

[ -f /etc/bash_completion ] && . /etc/bash_completion

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

current_juju_environment() {
    local juju_home=${JUJU_HOME:-$HOME/.local/share/juju}
    if [[ -f ${juju_home}/current-controller ]]; then
	read -r jjenv < ${juju_home}/current-controller
	if [[ ! -f ${juju_home}/environments/${jjenv}.jenv ]]; then
	    jjenv=$(strikethrough $jjenv)
	fi
    fi
}

declare -x current_juju_environment

export PROMPT_COMMAND="current_juju_environment; $PROMPT_COMMAND"

function __vpn_active() {
    if [ -e /proc/sys/net/ipv4/conf/tun0 ]; then
	vpn_active=$(red $(bold "VPN"))
    else
	vpn_active=
    fi
}

declare -x __vpn_active

export PROMPT_COMMAND="__vpn_active; $PROMPT_COMMAND"

if ! type __git_ps1 &> /dev/null && [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
        . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if type __git_ps1 &> /dev/null; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWCOLORHINTS=1
        # export PROMPT_DIRTRIM=2
        # export PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'
fi

#export PS1='${vpn_active:+[${vpn_active}] }\u@\h:\w$(__git_ps1)\n$ '
export PS1='${vpn_active:+[${vpn_active}] }\u@\h:\w\n$ '

shopt -s checkwinsize

if type -p brew 2>/dev/null >/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
    fi
fi

[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# [ -f ~/.bashrc_emacs ] && . ~/.bashrc_emacs

man() {
	env \
		LESS_TERMCAP_md=$'\e[1;36m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;40;92m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;32m' \
		man "$@"
}

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

type -p direnv &>/dev/null && eval "$(direnv hook bash)"
type -p minikube &>/dev/null && source <(minikube completion bash)
type -p kubectl &>/dev/null && source <(kubectl completion bash)
type -p oc &>/dev/null && source <(oc completion bash)

cover () {
    local t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/aim/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/home/aim/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/aim/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/home/aim/Downloads/google-cloud-sdk/completion.bash.inc'; fi
