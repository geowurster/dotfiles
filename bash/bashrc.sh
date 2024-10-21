# From '$ man bash':
#   The individual per-interactive-shell startup file

# If not running interactively, don't do anything.
case $- in
    *i*)
        ;;
      *)
      return
esac


###############################################################################
# Common Shell Setup

function _dotfile_repo_dirname(){

  # Get an absolute path to the directory containing this file.
  # Keep in sync with an implementation in 'zshrc.zsh'.

  source_dir="${BASH_SOURCE[0]}"
  source_dir=$(realpath "${source_dir}")
  source_dir=$(dirname "${source_dir}")
  source_dir=$(dirname "${source_dir}/..")

  echo "${source_dir}"
}

# Where this file lives, which is assumed to be the root of the dotfile repo.
dotfile_repo_dir=$(_dotfile_repo_dirname)

# '$PATH' and other environment variables.
source "${dotfile_repo_dir}/shell/env.sh"

# Keybindings and other interactive settings.
source "${dotfile_repo_dir}/shell/interactive.sh"

unset dotfile_repo_dir

###############################################################################
# History

# Append rather than overwriting.
shopt -s histappend

# Duplicate commands and commands starting with a space are not appended.
HISTCONTROL="ignorespace:ignoredups"

# Save at most N entries.
HISTSIZE="10000"
HISTFILESIZE="10000"


###############################################################################
# Terminal

# Check window size after each command.
shopt -s checkwinsize


###############################################################################
# Local Overrides

# Source '~/.bashrc_local' if it exists

P="${HOME}/.bashrc_local"
if [ -f "${P}" ]; then
  source "${P}"
fi
unset P
