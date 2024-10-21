# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# Sourced when login shells exit.


###############################################################################
# Local Overrides

# Source '~/.zlogout_local' if it exists

P="${HOME}/.zlogout_local"
if [ -f "${P}" ]; then
  source "${P}"
fi
unset P
