# Configure Python


# Some environments have '$ python', some have '$ python3', and some have only
# one or the other. For example, Ubuntu has '$ python3', and an optional
# 'python-is-python3' package for providing a '$ python' executable that also
# points to Python 3.
if [ !  -x "$(which python3)" ] && [ ! -x "$(which python)" ]; then
  return 1
fi


# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP
export PYTHONSTARTUP="${HOME}/.pythonrc.py"
