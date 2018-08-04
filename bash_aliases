# -*-shell-script-*-

alias amke=make
alias mkae=make
alias h='history 10'
alias lst='ls -trl | tail'
alias more=less
alias fmv8=/opt/arm/Foundation_v8pkg/models/Linux64_GCC-4.1/Foundation_v8
# Courtesy of kergoth in IRC
alias bbag="ag -G '\.(bb|bbappend|inc|conf)\$'"

# ~/.bash_aliases
# https://www.calazan.com/docker-cleanup-commands/

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'
alias dockercleandangling='docker rmi $(docker images -q --filter "dangling=true")'
##

#alias docker_remove_all_stopped_containers="docker rm $(docker ps -a | grep Exited | awk '{print $1}')"
#alias docker_clean_up_untagged_containers="docker rmi $(docker images -q --filter 'dangling=true')"
#alias docker_stop_and_remove_all_containers_including_running_containers="docker rm -f $(docker ps -a -q)"

alias nukegopkg='[ -d "$GOPATH/pkg" ] && rm -rf $GOPATH/pkg'

alias wjsm='watch juju show-machine'
alias gnus='exec emacs -f gnus --name gnus -rv'
alias tmux="env TERM=tmux-24bit tmux"

alias wrap='tput smam'
alias nowrap='tput rmam'

alias render_template='python -c "from jinja2 import Template; import sys; print(Template(sys.stdin.read()).render());"'

alias gdb='gdb -q'
alias rust-gdb='rust-gdb -q'
alias kc=kubectl

function emacsclient() {
    if [[ -z "$TMUX" ]] && [[ -f $HOME/.terminfo/x/xterm-24bit ]]; then
	command env TERM=xterm-24bit emacsclient "$@"
    else
	command emacsclient "$@"
    fi
}
