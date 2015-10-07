#!/bin/bash


# =========================================================================== #
#   Remote connection styling
# =========================================================================== #

# Change the text at the beginning of the terminal line if connecting remotely
[ "${SSH_CLIENT}${SSH_TTY}${SSH_CONNECTION}" != "" ] && export PS1="<\h>:\W \u\$ "


# =========================================================================== #
#   Grab work specific stuff
# =========================================================================== #

[ -f "${HOME}/.work_bashrc" ] && source "${HOME}/.work_bashrc"
