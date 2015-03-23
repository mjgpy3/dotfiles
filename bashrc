# Aliases
## ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

## Navigation
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias .....="cd ....."

## Git aliases
alias rk='git remote prune origin; git fetch'
alias ac='git add -A && git commit'
alias gs='git status'

## Docker aliases
alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -a -q)'

# Env Vars
## Editor
export VISUAL=vim
export EDITOR="$VISUAL"
