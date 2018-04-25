#!/bin/bash


# Sourced on all invocations of the shell.  Should contain path modifications
# and environment variables.


# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi


# pyenv
if [ -x $(which pyenv) ]; then
    export PYENV_ROOT=/usr/local/opt/pyenv
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
fi
