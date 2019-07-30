# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# Sourced in interactive shells. It should contain commands to set up
# aliases, functions, options, key bindings, etc.


# General
setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents)
                            # with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.


# Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.


export PAGER="less"


if [[ -x "$(which nvim)" ]]; then
    export EDITOR="nvim"
    export VISUAL="nvim -R"
elif [[ -x "$(which vim)" ]]; then
    export EDITOR="vim"
    export VISUAL="vim"
elif [[ -x "$(which vi)" ]]; then
    export EDITOR="vi"
    export VISUAL="vi -R"
else
    echo "WARNING: Did not set \$EDITOR" >> /dev/stderr
fi


# Smart URLs.
# See: https://github.com/sorin-ionescu/prezto/blob/5566a9c7927ed1ee166e92f8ecb72aa7a2d0ce09/modules/environment/init.zsh#L17
autoload -Uz is-at-least
if [[ ${ZSH_VERSION} != 5.1.1 && ${TERM} != "dumb" ]]; then
  if is-at-least 5.2; then
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
  else
    if is-at-least 5.1; then
      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic
    fi
  fi
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic
fi


# Put work specific configurations in '.work_zshrc'
init-work ${(%):-%N}


# Run Prezto after setting up environment so that it can access global
# variables like '$EDITOR'.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
