# Configure environment. Source this on all shell invocations.

# Be conscious of order. For example, '$GIT_EDITOR' is dependent on '$EDITOR'.
source "$(_dotfile_repo_dirname)/shell/env-path.sh"


###############################################################################
# $PS1

# 'bash' over SSH
if [ -v BASH_VERSINFO ] && [ -v SSH_TTY ]; then

  # Prompt builder: https://bash-prompt-generator.org
  # wursterk@b2 dirname $
  # green       blue    white
  PS1="\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \$ "

# 'bash'
elif [ -v BASH_VERSINFO ]; then

  # Prompt builder: https://bash-prompt-generator.org
  # dirname $
  # blue    white
  PS1="\[\033[01;34m\]\W\[\033[00m\] \$ "

# 'zsh' over SSH
elif [ -v ZSH_VERSION ] && [ -v SSH_TTY ]; then

  # wursterk@b2 dirname %
  # green       blue          white
  PS1="%{$(tput setaf 10)%}%n@%m %{$(tput setaf 12)%}%1~ %{$(tput sgr0)%}%%% "

# 'zsh'
elif [ -v ZSH_VERSION ]; then

  # dirname %
  # blue    white
  PS1="%{$(tput setaf 12)%}%1~ %{$(tput sgr0)%}%% "

fi
