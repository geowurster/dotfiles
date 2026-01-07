# Configure '$ python' environment, helper functions, etc. Some platforms have
# One or both '$ python' and '$ python3' interpreters. On Ubuntu, the
# 'python-is-python3' package can help bridge the gap by ensuring '$ python'
# is equivalent to '$ python3'.


if [ ! -x "$(which python)" ] && [ ! -x "$(which python3)" ]; then
  return 1
fi


###############################################################################
# vactivate

function vactivate() {

  # Activate a virtual environment. Defaults to looking in the current
  # directory for 'venv' and '.venv'.

  names=()

  # User did not provide an environment. Look for one.
  if [ $# -eq 0 ]; then
    names=(
      ".venv"
      "venv"
    )

  # User provided an environment
  elif [ $# -eq 1 ]; then
    names=(
      "${0}"
    )

  else
    echo ""
    echo "Usage: vactivate [path/to/venv]"
    echo ""
    return 1
  fi

  activated=0
  for name in "${names[@]}"; do

    activate="${name}/bin/activate"

    if [ -f "${activate}" ]; then
      source "${activate}"
      activated=1
    fi

  done

  if [ "${activated}" -ne 1 ]; then
    echo "ERROR: did not find an environment: ${names[@]}"
    return 1
  fi

}
