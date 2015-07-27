#!/bin/bash


# =========================================================================== #
#   Shell Modifications
# =========================================================================== #

[ ! -d ~/.local ] && mkdir -p ~/.local
[ ! -d ~/.config ] && mkdir -p ~/.config

[ -r "~/bin" ] && export PATH="~/bin:${PATH}"

[ -x "$(which nav)" ] && eval $(nav startup generate)
[ -e $(which pyin) ] && export PYIN_NO_WARN="I_read_the_rules_and_accept_the_consequences"

# It's mildly inconvenient to activate a virtual environment.  This function makes it easier
if [ -e $(which virtualenv) ]; then

    function vactivate(){

        DEFAULT_VENV="venv/bin/activate"

        # No arguments - look in current directory for 'venv'
        if [ $# -eq 0 ]; then
            if [ -f ${DEFAULT_VENV} ]; then
                source ${DEFAULT_VENV}
                return 0
            else
                echo "ERROR: Can't find venv: ${DEFAULT_VENV}"
                return 1
            fi

        # User supplied a venv - attempt to activate if it exists
        elif [ $# -eq 1 ]; then
            VENV="${1}/bin/activate"
            if [ -f ${VENV} ]; then
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


# =========================================================================== #    
#   Homebrew Modifications
# =========================================================================== #

if [ -x $(which brew 2> /dev/null) ]; then

    # All Homebrew make commands execute with 75% of computer's cores
    export HOMEBREW_MAKE_JOBS=$(printf %.0f $(echo "$(getconf _NPROCESSORS_ONLN) * 0.75" | bc))

    # Recommended by $(brew doctor)
    [ -r "/usr/local/sbin" ] && export PATH="/usr/local/sbin:${PATH}"

    # Find Homebrew installed utilities first
    [ -r "/usr/local/bin" ] && export PATH="/usr/local/bin:${PATH}"
fi


# =========================================================================== #
#   GDAL Environment
# =========================================================================== #

if [ -x $(which gdal-config 2> /dev/null) ]; then

    # Let GDAL find additional drivers
    _DIR="/usr/local/lib/gdalplugins"
    [ -d "/usr/local/lib/gdalplugins" ] && mkdir -p ${_DIR} && export GDAL_DRIVER_PATH="${_DIR}"
    unset _DIR

    # Set max GDAL cache to 1/4 available RAM
    export GDAL_CACHEMAX=$(printf %.0f $(echo "$(sysctl -n hw.memsize) / 1000 / 1000 / 4" | bc))
fi


# =========================================================================== #
#   Python modifications
# =========================================================================== #

# Alert if using system python
if [ $(which python) == "/usr/bin/python" ] && [ $(uname) == "Darwin" ]; then
    echo ""
    echo "=============================================="
    echo "    WARNING: Using system Python on a Mac"
    echo "=============================================="
    echo ""

# Make sure pip is pointing to the right place
elif [ $(uname) == "Darwin" ]; then

    # So many `dirname`s ... THERE HAS GOT TO BE A BETTER WAY!
    export PYTHONUSERBASE="$(dirname $(dirname $(dirname $(which python))/$(readlink $(which python))))"
    _V=$(python --version 2>&1 | sed 's/Python //g' | sed 's/\.[^.]*$//')
    export PYTHONUSERSITE="/usr/local/lib/python${_V}/site-packages"
    unset _V

# Environment should be vanilla forw hatever system this is runnign on
else
    echo "Warning: Python environment is unknown and may be jacked."

fi


# Get help on any object
function pyhelp(){

    [ $# -ne 1 ] && echo "Usage: module.package.object" && return 1

    python -c "help('''$1''')"
}

# Try to get the version of a module
function pyversion(){

    [ $# -ne 1 ] && echo "Usage: module_name" && return 1

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

    [ $# -ne 1 ] && echo "Usage: module_name" && return 1

    python -c "import $1; print($1.__file__)"
}

function pydir(){

    [ $# -ne 1 ] && echo "Usage: object" && return 1

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
#   Remote connections
# =========================================================================== #

[ -r "~/.bashrc" ] && source "~/.bashrc"


# =========================================================================== #
#   Work related nonsense
# =========================================================================== #

[ -r "~/.work_bash_profile" ] && source "~/.work_bash_profile"
[ -r "~/.work_bashrc" ] && source "~/.work_bashrc"
