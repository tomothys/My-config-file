#-----------------
# Auto-completion
#-----------------
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

zstyle ":completion:*" verbose yes
zstyle ":completion:*:descriptions" format $"\n%F{yellow} Tab-completion%f"
zstyle ":completion:*:messages" format "%d"
zstyle ":completion:*:warnings" format $"%F{red}No matches for:%f %d"
zstyle ":completion:*:corrections" format "%B%d (errors: %e)%b"
zstyle ":completion:*" group-name ""

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#-----
# FZF
#-----
export FZF_DEFAULT_OPTS='--height=40% --margin=1 --padding=1 --layout=reverse --border=sharp -i -m --keep-right --filepath-word'

#--------
# PROMPT
#--------
setopt prompt_subst

function git_branch_name() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')

    if [[ $branch == "" ]];
    then
        :
    else
        echo " %F{red} $branch%f"
    fi
}

PROMPT=$"\n%F{green}%n%f  %F{yellow}  %~%f  %F{red} $(nvm current)%f $(git_branch_name)\n ﬌ 👾 "

#-------------------------------
# fd - cd to selected directory
# FZF needs to be installed
#-------------------------------
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

#------------------------------------------------------------------
# fh - search in your command history and execute selected command
# FZF needs to be installed
#------------------------------------------------------------------
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

#-------
# ALIAS
#-------
alias ls=exa
alias cat=bat

#--------------
# Key bindings
#--------------
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
