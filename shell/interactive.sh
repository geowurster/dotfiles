# Configure interactive shell sessions.


###############################################################################
# Environment Variables

# Be conscious of order. For example, '$GIT_EDITOR' is dependent on '$EDITOR'.
source "$(_dotfile_repo_dirname)/shell/env-homebrew.sh"
source "$(_dotfile_repo_dirname)/shell/env-editor.sh"
source "$(_dotfile_repo_dirname)/shell/env-git.sh"
source "$(_dotfile_repo_dirname)/shell/env-python.sh"
source "$(_dotfile_repo_dirname)/shell/python.sh"
source "$(_dotfile_repo_dirname)/shell/pycharm.sh"


###############################################################################
# Aliases

# Force destructive commands to ask for permission.
alias cp="cp -i"
alias ln="ln -i"
alias mv="mv -i"
alias rm="rm -i"

# Enable colors (-G), and append a '/' to directory names (-p)
alias ls="ls -G -p"

# Enable colors
alias grep="grep --color=auto"
alias ls="ls --color=auto"
