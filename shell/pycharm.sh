# Function for opening a file with PyCharm
#
#   $ charm pycharm.sh
#
# Ideally this function would only be defined if PyCharm is installed, but that
# is difficult to get right across all platforms and conditions.


function charm() {

  # macOS
  if [ -x $(which open) ]; then

    APPLICATIONS=(
      "PyCharm.app"
      "PyCharm CE.app"
    )

    for NAME in "${APPLICATIONS[@]}"; do

      open -a "${NAME}" "$@" &> /dev/null

      if [ $? -eq 0 ]; then
        break
      fi

    done

  fi

}
