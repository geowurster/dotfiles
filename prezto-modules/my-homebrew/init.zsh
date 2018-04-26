# Configure Homebrew environment.


if [[ "${OSTYPE}" != darwin* || ! -x /usr/local/Homebrew/bin/brew ]]; then
    return 1
fi


# Find Homebrew installed utilities first
if [[ -d "/usr/local/bin" ]]; then
    export PATH="/usr/local/bin:${PATH}"
fi


# Recommended by $(brew doctor)
if [[ -d "/usr/local/sbin" ]]; then
    export PATH="/usr/local/sbin:${PATH}"
fi

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_MAKE_JOBS=$(sysctl -n hw.ncpu | awk "{print int($1 * 0.75)}")
