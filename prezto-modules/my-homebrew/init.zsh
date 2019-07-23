# Configure Homebrew environment.


if [[ "${OSTYPE}" != darwin* || ! -x /usr/local/Homebrew/bin/brew ]]; then
    return 1
fi


# Homebrew $PATH overrides.  Applied in order, so the last overrides the first.
OVERRIDES=(
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/local/opt/grep/libexec/gnubin"
)
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

unset NCPU OVERRIDES P
