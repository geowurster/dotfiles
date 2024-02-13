PYTHONRC_PATH="$HOME/.pythonrc.py"


if [ -x "$(command -v python)" ] || [ -x "$(command -v python3)" ] && [ -f "$PYTHONRC_PATH" ]; then
  export PYTHONSTARTUP="$PYTHONRC_PATH"
fi
