# Configure '$ git'


if [ ! -x "$(which git)" ]; then
  return 1
fi

export GIT_EDITOR="${EDITOR}"
