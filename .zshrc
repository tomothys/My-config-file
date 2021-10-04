# Path to your oh-my-zsh installation.
export ZSH="/Users/thomasschmieck/.oh-my-zsh"

ZSH_THEME="avit"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# nvm needs to be installed
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#-------------------------------
# fd - cd to selected directory
# FZF needs to be installed
#-------------------------------
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

#------------------------------------------------------------------
# fh - search in your command history and execute selected command
# FZF needs to be installed
#------------------------------------------------------------------
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

#---------
# aliases
#---------
alias clone="git clone --recurse-submodules"
alias ls=exa
alias dock-up="docker-compose up --force-recreate --build"
alias dock-down="docker-compose down"
