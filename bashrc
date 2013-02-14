# -*-shell-script-*-

[ -f ~/.bash_bootstrap ] && . ~/.bash_bootstrap
[ -f /etc/profile ] && . /etc/profile

. ${BASH_HOME}/functions/require
. ${BASH_HOME}/functions/path-functions

# for non login ssh connections
path_append PATH /usr/X11R6/bin

XUSERFILESEARCHPATH=$HOME/lib/X11/app-defaults/%N%S

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Like many of you, I constantly have many terminals open at once. I
# wish bash would dump every command I type there instead of seemingly
# randomly keeping the history of a single one.  Ho ho ho.  This does
# the trick.  http://www.geocities.com/h2428/petar/bash_hist.htm.

# Make bash history persistent across terminal sessions.

# First we instruct Bash not to store history by overwriting but to
# append lines. PROMPT_COMMAND is an environment variable which holds
# list of commands that will be executed before Bash begins accepting
# input for the next command, by calling 'history -a' we store all
# commands to disk.

shopt -s histappend
# single line cmd history
shopt -s cmdhist
export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

# Graciously stolen from idf
function check_exit_status ()
{
    local status="$?"
    local msg=""
    local signal=""

    if [ ${status} -ne 0 ] ; then
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
export PS1='[\u@\h:\w]\n: '
