#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
# node ka chodbhangra
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# this chodbhanga is done by Uzzi
eval "$(starship init bash)"
pokemon-colorscripts --random
#fastfetch
#fetch --shading-mode blocks

# Added by Antigravity CLI installer
export PATH="/home/uzzi/.local/bin:$PATH"
export PATH="/home/uzzi/.local/bin:$PATH"

##########################
#### SAMANTAR ############
##########################
alias sl=ls
alias dc=cd
alias ll='ls -la'
alias show='kitten icat'
fuck() {
  nvim "$(fd --type f --hidden --exclude .git | fzy)"
}
