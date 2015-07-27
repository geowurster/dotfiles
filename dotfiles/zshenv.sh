#!/bin/bash


# Sourced on all invocations of the shell.  Should contain path modifications
# and environment variables.


# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi


# Make sure some unix dirs always exist
[[ ! -d ~/bin ]] && mkdir -p ~/bin
[[ ! -d ~/.config ]] && mkdir -p ~/.config


# pyenv
export PYENV_ROOT=/usr/local/opt/pyenv  # Match homebrew
