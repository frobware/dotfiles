# -*-shell-script-*-

alias amke=make
alias mkae=make
alias h='history 10'
alias lst='ls -trl | tail'
alias more=less

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

alias nukegopkg='[ -d "$GOPATH/pkg" ] && rm -rf $GOPATH/pkg'

#alias tmux="env TERM=tmux-24bit tmux"

alias wrap='tput smam'
alias nowrap='tput rmam'

alias render_template='python -c "from jinja2 import Template; import sys; print(Template(sys.stdin.read()).render());"'

alias gdb='gdb -q'
alias rust-gdb='rust-gdb -q'
alias kc=kubectl

alias emacs="TERM=tmux-24bit command emacs"
alias emacsclient="TERM=tmux-24bit command emacsclient"

alias kn='kubectl get nodes --no-headers --sort-by=.metadata.creationTimestamp |cat -n'
alias km='kubectl get machines --no-headers --sort-by=.metadata.creationTimestamp |cat -n'
alias ke='kubectl get events --no-headers --sort-by=.metadata.creationTimestamp |cat -n'
alias cat='bat --paging=always'
alias wm="dtach -A /tmp/dvtm -r winch dvtm"

export BAT_THEME="Monokai Extended Bright"
