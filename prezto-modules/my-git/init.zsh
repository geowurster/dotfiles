

if [[ ! -x $(which git) ]]; then
    return 1
fi


export GIT_EDITOR="$EDITOR"


alias gg="git grep"
alias gsu="git gsu"
