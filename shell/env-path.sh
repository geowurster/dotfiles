# Configure '$PATH'


# Directories appended here are inserted into '$PATH'. Later additions take
# precedence. Only directories that exist are added to '$PATH'.
#OVERRIDES=("${HOME}/.bin/")
OVERRIDES=("$(_dotfile_repo_dirname)/bin")


###############################################################################
# Homebrew

if [ "$(uname -s)" = "Darwin" ]; then

  # Apple M Series
  BASE_M="/opt/homebrew"

  # Intel
  BASE_INTEL="/usr/local"

  if [ -x "${BASE_M}/bin/brew" ]; then
    BASE="${BASE_M}"

  elif [ -x "${BASE_INTEL}/bin/brew" ]; then
    BASE="${BASE_INTEL}"

  else
    BASE=""

  fi

  if [ "${BASE}" != "" ]; then
    OVERRIDES+=(
      "${BASE}/bin"
      "${BASE}/sbin"
      "${BASE}/opt/grep/libexec/gnubin"
      "${BASE}/opt/curl/bin"
    )
  fi

  unset BASE BASE_INTEL BASE_M

fi


###############################################################################
# Python

# macOS
if [ "$(uname -s)" = "Darwin" ]; then

  # We do not want Homebrew's '$ python'. It changes too often.
  OVERRIDES+=(
    "/Library/Frameworks/Python.framework/Versions/Current/bin"
  )

fi


###############################################################################
# Ruby

# I cannot remember exactly why this is exists. I think it was due to a problem
# with a 'TextMate.app' plugin on macOS finding the OS's outdated version of
# Ruby, and a theory that the plugin would work if pointed to a newer version
# installed via Homebrew.

#if [ -x "$(which brew)" ] && [ -d "/usr/local/opt/ruby" ]; then
#
#    # Add Homebrew Ruby to path and then gem executable directory.  Cannot
#    # combine these steps because the latter will discover Apple's Ruby because
#    # the PATH variable has not been updated with Homebrew's Ruby.
#    GEMDIR=$(gem environment gemdir)
#    OVERRIDES+=(
#      "/usr/local/opt/ruby/bin"
#      "${GEMDIR}/bin"
#    )
#    unset GEMDIR
#
#fi



###############################################################################
# Apply

for P in "${OVERRIDES[@]}"; do
  if [ -d "${P}" ]; then
    export PATH="${P}:${PATH}"
  fi
done

unset P OVERRIDES
