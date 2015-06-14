# Configure Homebrew environment.


UNAME_MACHINE="$(/usr/bin/uname -m)"

# M* Apple Silicon
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then

  # Homebrew not installed
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    return 1

  # Overrides for $PATH
  else
    OVERRIDES=(
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/opt/homebrew/opt/grep/libexec/gnubin"
      "/opt/homebrew/opt/curl/bin"
    )
  fi

# Intel Mac
elif [[ "$UNAME_MACHINE" == darwin* ]]; then

  # Homebrew not installed
  if [[ ! -x /usr/local/Homebrew/bin/brew ]]; then
    return 1

  # Overrides for $PATH
  else
    OVERRIDES=(
      "/usr/local/bin"
      "/usr/local/sbin"
      "/usr/local/opt/grep/libexec/gnubin"
      "/usr/local/opt/curl/bin"
    )
  fi
fi

for P in ${OVERRIDES[@]}; do
  if [[ -d "$P" ]]; then
    export PATH="$P:$PATH"
  fi
done


# Homebrew sends anonymous metrics about usage by default.
export HOMEBREW_NO_ANALYTICS=1


# For some reason this does not work:
#   export HOMEBREW_MAKE_JOBS=$(echo "$NCPU" | awk "{printf int(int($1) * 0.75)}")
# but this does:
export HOMEBREW_MAKE_JOBS=$(printf %.0f $(echo "$(sysctl -n hw.ncpu) * 0.75" | bc))


unset OVERRIDES P
