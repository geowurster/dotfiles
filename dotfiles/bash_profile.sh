#!/bin/bash


# This file is also source by .zshrc


# =========================================================================== #
#   Missing *nix commands and directories
# =========================================================================== #

if [ ! -a "$(which nproc)" ]; then
    function nproc() {
        if [ $# -gt 0 ]; then
            echo "System doesn't have 'nproc' - this is a stub function that doesn't take args."
            return 1
        fi
        echo $(getconf _NPROCESSORS_ONLN)
    }
fi

[ ! -d "${HOME}/bin" ] && mkdir -p "${HOME}/bin"
[ ! -d "${HOME}/.config" ] && mkdir -p "${HOME}/.config"


# =========================================================================== #
#   Enable commandline helpers
# =========================================================================== #

# Enable FS-Nav
[ -x "$(which nav)" ] && eval "$(nav startup generate)"

# Enable Travis-CI CLI
[ -f "${HOME}/.travis/travis.sh" ] && source "${HOME}/.travis/travis.sh"

# pyenv
[ -x "$(which pyenv)" ] && eval "$(pyenv init -)"


# =========================================================================== #
#   Homebrew Environment
# =========================================================================== #

if [ "$(which brew)" ];  then

    # All Homebrew make commands execute with 75% of computer's cores
    export HOMEBREW_MAKE_JOBS=$(printf %.0f $(echo "$(nproc) * 0.75" | bc))

    # Recommended by $(brew doctor)
    [ -d "/usr/local/sbin" ] && export PATH="/usr/local/sbin:${PATH}"

    # Find Homebrew installed utilities first
    [ -d "/usr/local/bin" ] && export PATH="/usr/local/bin:${PATH}"
fi


# =========================================================================== #
#   GDAL Environment
# =========================================================================== #

if [ -x "$(which gdal-config)" ];  then

    # Let GDAL find additional drivers
    [ -d "/usr/local/lib/gdalplugins" ] && export GDAL_DRIVER_PATH="/usr/local/lib/gdalplugins"

    # 1/4 available RAM
    export GDAL_CACHEMAX=$(printf %.0f $(echo "$(sysctl -n hw.memsize) / 1000 / 1000 / 4" | bc))

    export GDAL_DATA="$(gdal-config --datadir)"
fi


# =========================================================================== #
#   Set Python executable, environment, and helper functions
# =========================================================================== #

# Alert if using system python
if [ "$(which python)" = "/usr/bin/python" ] && [ "$(uname)" = "Darwin" ];  then
    echo ""
    echo "=============================================="
    echo "    WARNING: Using system Python on a Mac"
    echo "=============================================="
    echo ""
elif [ ! -x "$(which pyenv > /dev/null)" ]; then
    :  # pyenv is not present - makes the rest easier to read
elif [ "$(pyenv versions | grep 3.5.0)" != "" ]; then
    pyenv global 3.5.0
elif [ "$(pyenv versions | grep 2.7.10)" != "" ]; then
    pyenv global 2.7.10
fi


# It's mildly inconvenient to activate a virtual environment.  This is easier.
if [ -x "$(which virtualenv)" ]; then

    function vactivate(){

        DEFAULT_VENV="venv/bin/activate"

        # No arguments - look in current directory for 'venv'
        if [ $# -eq 0 ];  then
            if [ -f "${DEFAULT_VENV}" ];  then
                source "${DEFAULT_VENV}"
                return 0
            else
                echo "ERROR: Can't find venv: ${DEFAULT_VENV}"
                return 1
            fi

        # User supplied a venv - attempt to activate if it exists
        elif [ $# -eq 1 ];  then
            VENV="${1}/bin/activate"
            if [ -f "${VENV}" ];  then
                source ${VENV}
                return 0
            else
                echo "ERROR: Can't find : ${VENV}"
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
fi


# Get help on any object
function pyhelp(){

    if [ $# -ne 1 ]; then
        echo "Calls help() on a Python object."
        echo ""
        echo "Usage: module.package.object"
        return 1
    fi

    python -c "help('''$1''')"
}


function pyversion(){

    if [ $# -ne 1 ]; then
        echo "Attempts to print a Python module's version."
        echo ""
        echo "Usage: module_name"
        return 1
    fi

    python -c """
import $1
import sys

for attr in ('__version__', 'version', 'VERSION', 'Version'):
    if hasattr($1, attr):
        print(getattr($1, attr))
        sys.exit(0)
else:
    print('ERROR: Could not find a version attribute for $1')
    sys.exit(1)
"""
}


function pywhich(){

    if [ $# -ne 1 ]; then
        echo "Prints the path to a Python module."
        echo ""
        echo "Usage: module_name"
        return 1
    fi

    python -c "import $1; print($1.__file__)"
}


function pydir(){

    if [ $# -ne 1 ]; then
        echo "Prints a Python object's attributes."
        echo ""
        echo "Usage: object"
        return 1
    fi

    python -c "
import re


# Import logic borrowed from https://github.com/Russell91/pythonpy
def import_matches(query, prefix=''):
    matches = set(re.findall(r'(%s[a-zA-Z_][a-zA-Z0-9_]*)\.?' % prefix, query))
    for module_name in matches:
        try:
            module = __import__(module_name)
            globals()[module_name] = module
            import_matches(query, prefix='%s.' % module_name)
        except ImportError as e:
            pass


import_matches('$1')


for attr in dir($1):
    print(attr)
"
}


# =========================================================================== #
#   Stuff that has to happen right at the very end
# =========================================================================== #

[ -r "${HOME}/bin" ] && export PATH="${HOME}/bin:${PATH}"

if [ -n "${PYENV_ROOT}" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi


# =========================================================================== #
#   Grab work specific stuff
# =========================================================================== #

[ -f "${HOME}/.work_bash_profile" ] && source "${HOME}/.work_bash_profile"
