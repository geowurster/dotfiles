#!/bin/bash


# Sourced after zshenv and is intended to be used for interactive session setup.
# Should contain functions, etc.


# =========================================================================== #
#   zsh config
# =========================================================================== #

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U compinit
compinit

fpath=(/usr/local/share/zsh-completions $fpath)


# =========================================================================== #
#   Most of the real work happens in .bash_profile for portability
# =========================================================================== #

[ -f "${HOME}/.bash_profile" ] && source "${HOME}/.bash_profile"


# =========================================================================== #
#   Grab work specific stuff
# =========================================================================== #

[ -f "${HOME}/.work_zshrc" ] && source "${HOME}/.work_zshrc"
