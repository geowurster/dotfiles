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


###############################################################################
# Common Shell Setup

function _dotfile_repo_dirname() {

  # Get an absolute path to the directory containing this file.
  # Keep in sync with an implementation in 'bashrc.sh'.

  # I don't even know what to make of this bizarre expansion. The internet says
  # it is close to '$BASH_SOURCE[0]', but WOW.
  #   https://stackoverflow.com/a/28336473
  source_dir="${(%):-%x}"
  source_dir=$(realpath "${source_dir}")
  source_dir=$(dirname "${source_dir}")
  source_dir=$(realpath "${source_dir}/..")
  echo "${source_dir}"

}


dotfile_repo_dir=$(_dotfile_repo_dirname)


# '$PATH' and other environment variables.
source "${dotfile_repo_dir}/shell/env.sh"

# Keybindings and other interactive settings.
source "${dotfile_repo_dir}/shell/interactive.sh"

unset dotfile_repo_dir


###############################################################################
# $WORDCHARS

# Zsh considers these characters to be part of a word. The default list
# includes '/', which makes augmenting file paths difficult. The default is:
#
#   *?_-.[]~=/&;!#$%^(){}<>
#
# Bash has no direct equivalent, but it seems like key bindings may be able
# to emulate most of the intended behavior?
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"


###############################################################################
# Key Bindings

# Emacs-style keybindings for the terminal
bindkey -e


###############################################################################
# Completion

# Prezto has extended support that may be worth examining:
#   https://github.com/sorin-ionescu/prezto/tree/5566a9c7927ed1ee166e92f8ecb72aa7a2d0ce09/modules/completion

autoload -Uz compinit && compinit


###############################################################################
# General

setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents) with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
unsetopt MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.


###############################################################################
# Directories, cd, redirect, globbing, etc.

setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>. Use >! and >>! to bypass.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt MULTIOS              # Write to multiple descriptors.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.


###############################################################################
# Jobs

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.


###############################################################################
# History

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"  # The path to the history file.
HISTSIZE=10000                # The maximum number of events to save in the internal history.
SAVEHIST=10000                # The maximum number of events to save in the history file.


###############################################################################
# Completion

setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
unsetopt MENU_COMPLETE      # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.
unsetopt CASE_GLOB          # Globbing is not case sensitive

# Substring matching. The 'upper' and 'lower' bits are to match regardless of
# case, and the remaining bit is to match regardless of substring position. For
# example, when trying to match against 'dotfiles', this means that 'otfi' is a
# valid match.
zstyle \
  ':completion:*' \
  matcher-list \
  'm:{[:lower:]}={[:upper:]}' \
  'm:{[:upper:]}={[:lower:]}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'



###############################################################################
# Smart URLs

# See: https://github.com/sorin-ionescu/prezto/blob/5566a9c7927ed1ee166e92f8ecb72aa7a2d0ce09/modules/environment/init.zsh#L17

autoload -Uz is-at-least
if [ "${ZSH_VERSION}" != 5.1.1 ] && [ "${TERM}" != "dumb" ]; then
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


###############################################################################
# Local Overrides

# Source '~/.zshrc_local' if it exists

P="${HOME}/.zshrc_local"
if [ -f "${P}" ]; then
  source "${P}"
fi
unset P
