# Configure Homebrew


if [ ! -x "$(which brew)" ]; then
  return 1
fi


###############################################################################
# Telemetry

# Homebrew sends anonymous metrics about usage by default.
export HOMEBREW_NO_ANALYTICS=1
