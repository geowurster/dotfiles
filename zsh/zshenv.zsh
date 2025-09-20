# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# '.zshenv' is sourced on all invocations of the shell, unless the
# -f option is set. It should contain commands to set the command search
# path, plus other important environment variables. `.zshenv' should not
# contain commands that produce output or assume the shell is attached to
# a tty.


###############################################################################
# Local Overrides

# Source '~/.zshenv_local' if it exists

P="${HOME}/.zshenv_local"
if [ -f "${P}" ]; then
  source "${P}"
fi
unset P
