# From '$ man bash':
#   The personal initialization file, executed for login shells

###############################################################################
# Local Overrides

# Source '~/.bash_profile_local' if it exists

P="${HOME}/.bash_profile_local"
if [ -f "${P}" ]; then
  source "${P}"
fi
unset P
