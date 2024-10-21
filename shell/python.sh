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

  # Activate a virtual environment in a standard location.

  DEFAULT_VENV="venv/bin/activate"

  # No arguments - look in current directory for 'venv'
  if [ $# -eq 0 ]; then
      if [ -f "${DEFAULT_VENV}" ]; then
          source "${DEFAULT_VENV}"
          return 0
      else
          echo "Error: Cannot find venv: ${DEFAULT_VENV}"
          return 1
      fi

  # User supplied a venv - attempt to activate if it exists
  elif [[ $# -eq 1 ]]; then
      VENV="${1}/bin/activate"
      if [[ -f "${VENV}" ]]; then
          source "${VENV}"
          return 0
      else
          echo "Error: Cannot find : ${VENV}"
          return 1
      fi

  # Too many arguments - print usage
  else
      echo ""
      echo "Usage: vactivate [path/to/venv]"
      echo ""
      return 1
  fi

}
