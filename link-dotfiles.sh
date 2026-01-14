#!/bin/bash


# Note that in some cases '/bin/bash' may not be the same version as provided
# by '$ bash'. For example, MacOS Ships with Bash v3, but a much more recent
# version can be provided by Homebrew. This script should probably be as
# portable as possible.


set -eu -o pipefail


# This is kind of hard to get right, and we need it in several places.
CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"


###############################################################################
# Mapping

# Mapping between file in this repository and its target path. Ideally this
# would use:
#
#   $ declare -A mapping
#
# however this key/value feature was introduced in Bash 4, which is not yet
# available everywhere. Solution based on:
#   https://stackoverflow.com/a/4444841
#  "test-dotfile.sh:${HOME}/.test-dotfile"

# Keys are relative paths to files in this repository. It is assumed that this
# script will be run from the root of this directory.
mapping=(
  "bash/bashrc.sh:${HOME}/.bashrc"
  "bash/bash_profile.sh:${HOME}/.bash_profile"
  # "editorconfig/editorconfig.ini:${HOME}/.editorconfig"

  "ghostty:${CONFIG_HOME}/ghostty"

  "git/gitconfig.ini:${HOME}/.gitconfig"
  "git/gitignore-global.ini:${HOME}/.gitignore-global"

  "nano:${CONFIG_HOME}/nano"
  "nvim:${CONFIG_HOME}/nvim"

  "python/pythonrc.py:${HOME}/.pythonrc.py"

  "zsh/zlogin.zsh:${HOME}/.zlogin"
  "zsh/zlogout.zsh:${HOME}/.zlogout"
  "zsh/zprofile.zsh:${HOME}/.zprofile"
  "zsh/zshenv.zsh:${HOME}/.zshenv"
  "zsh/zshrc.zsh:${HOME}/.zshrc"
)


###############################################################################
# Functions

function manage-link() {

  # Link a dotfile like: $ link-dotfile bashrc.sh ~/.bashrc

  if [ $# -ne 4 ]; then
    echo "ERROR: invalid arguments: $*"
    return 1
  fi

  repo_path="${1}"
  home_path="${2}"
  link=${3}
  dry_run=${4}

  # We need the absolute path for the repo, and will assume that the home
  # path is both absolute and correct.
  repo_path=$(realpath "${repo_path}")

  # We will check to see if the target directory for each link exists.
  dst_dirname=$(dirname "${home_path}")

  #############################################################################
  # Validate Input File

  if [ ! -e "${repo_path}" ]; then
    echo "ERROR: repo path does not exist: ${repo_path}"
    return 1

  #############################################################################
  # Target Directory Does Not Exist

  elif [ "${link}" -eq 1 ] && [ ! -d "${dst_dirname}" ]; then
    echo "ERROR: target basedir does not exist: ${home_path}"
    return 1

  #############################################################################
  # Link

  elif [ "${link}" -eq 1 ]; then

    # Be sure to make a _symbolic_ link.
    cmd="ln -s ${repo_path} '${home_path}'"

    if [ -e "${home_path}" ]; then

      # Home path and repo path are identical
      if [ "${home_path}" -ef "${repo_path}" ]; then
        echo "Already linked: ${home_path}"
        return 0

      # Home path and repo path are not identical, which probably means a
      # dotfile already exists from some other source.
      else
        echo "ERROR: file in home directory not linked to repo"
        echo "  Home path: ${home_path}"
        echo "  Repo path: ${repo_path}"
        return 1
      fi

    elif [ "${dry_run}" -eq 0 ]; then
      echo "Linking: ${cmd}"
      eval "${cmd}"

    else
      echo "DRY RUN - Linking: ${cmd}"
    fi

  #############################################################################
  # Unlink

  elif [ "${link}" -eq 0 ]; then

    cmd="rm ${home_path}"

    if [ ! -e "${home_path}" ]; then
      echo "Skipping unlinking - does not exist: ${home_path}"
      return 0
    elif [ ! "${home_path}" -ef "${repo_path}" ]; then
      echo "ERROR: dotfile not linked to repo"
      echo "  Home path: ${home_path}"
      echo "  Repo path: ${repo_path}"
      return 1
    elif [ "${dry_run}" -eq 0 ]; then
      echo "Unlinking: ${cmd}"
      eval "${cmd}"
    else
      echo "DRY RUN - Unlinking: ${cmd}"
    fi

  fi

}


###############################################################################
# Parse Arguments

link=1
dry_run=0

while [ $# -gt 0 ]; do
  case "${1}" in

    # Delete dotfile links.
    --unlink)
      link=0
      shift 1
      ;;

    # Echo information about what would happen, but do not actually do it.
    --dry-run)
      dry_run=1
      shift 1
      ;;

    *)
      echo "ERROR: unexpected option: ${1}"
      return 1
      ;;

    esac
done


###############################################################################
# Create Required Directories

# Some config files end up here. It is common for this directory to exist, so
# it is safe to blindly create if it does not already exist.
mkdir -p "${CONFIG_HOME}"


###############################################################################
# Link Files

# !! Be careful with 'mapping' !!
# It is not a true associative array. 'declare -A' was added in Bash v4, but
# plenty of platforms still have Bash v3, so this is a hack based on:
#   https://stackoverflow.com/a/4444841
for item in "${mapping[@]}"; do
  repo_path="${item%%:*}"
  home_path="${item#*:}"

  # Gracefully link as many files as possible.
  set +e
  manage-link "${repo_path}" "${home_path}" "${link}" "${dry_run}"
  set -e

done
