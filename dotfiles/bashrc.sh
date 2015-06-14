# =========================================================================== #
#   Commandline Styling
# =========================================================================== #

# Change the text at the beginning of the terminal line if connecting remotely
[[ "${SSH_CLIENT}${SSH_TTY}${SSH_CONNECTION}" != "" ]] && export PS1="<\h>:\W \u\$ "


# =========================================================================== #
#   Work
# =========================================================================== #

# Work specific bashrc
_FILE=~/.work_bashrc
[[ -r ${_FILE} ]] && source ${_FILE}
