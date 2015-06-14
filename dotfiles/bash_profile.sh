#!/bin/bash


# =========================================================================== #
#   Modify {$PATH}
# =========================================================================== #

_DIR=~/bin
if [ -r "${_DIR}" ]; then
    export PATH=${_DIR}:${PATH}
fi


# =========================================================================== #
#   Enable FS-Nav Shortcuts
# =========================================================================== #

# == Enable FS Nav shortcuts on startup == #
if [ -x "$(which nav)" ]; then
    eval $(nav startup generate)
fi


# =========================================================================== #
#   Environment Modifications
# =========================================================================== #

_FILE=~/.bashrc
if [ -r "${_FILE}" ]; then
    source "${_FILE}"
fi

# Suppress pyin warnings if its installed
if [ -e $(which pyin) ]; then
    export PYIN_NO_WARN="I_read_the_rules_and_accept_the_consequences"
fi

# Homebrew installs freetype2 but not freetype, which some packages (like PIL) require - online sources recommend:
# Make sure freetype2 is installed, make sure freetype1 does not exist, make sure target directory is writable
_FT1="/usr/local/include/freetype"
_FT2="/usr/local/include/freetype2"
if [ -e "${_FT2}" ] && [ ! -e "${_FT1}"  ] && [ -w "$(dirname ${_FT2})" ]; then
    ln -s "${_FT2}" "${_FT1}"
fi
_FT1=
_FT2=

# It's mildly inconvenient to activate a virtual environment.  This function makes it easier
if [ -e $(which virtualenv) ]; then

    function vactivate(){

        USAGE="Usage: vactivate [path/to/venv]"
        DEFAULT_VENV="venv/bin/activate"

        # No arguments - look in current directory for 'venv'
        if [ $# -eq 0 ]; then
            if [ -f "${DEFAULT_VENV}" ]; then
                source "${DEFAULT_VENV}"
                return 0
            else
                echo "ERROR: Can't find venv: ${DEFAULT_VENV}"
                return 1
            fi

        # User supplied a venv - attempt to activate if it exists
        elif [ $# -eq 1 ]; then
            VENV="${1}/bin/activate"
            if [ -f "${VENV}" ]; then
                source ${VENV}
                return 0
            else
                echo "ERROR: Can't find : ${VENV}"
                return 1
            fi

        # Too many arguments - print usage
        else
            echo ""
            echo ${USAGE}
            echo ""
            return 1
        fi
    }

fi

# =========================================================================== #    
#   Homebrew Modifications
# =========================================================================== #

if [ -x "`which brew 2> /dev/null`" ]; then

    # All Homebrew make commands execute with 75% of computer's cores
    export HOMEBREW_MAKE_JOBS=$(printf %.0f $(echo "$(getconf _NPROCESSORS_ONLN) * 0.75" | bc))

    # Recommended by $(brew doctor)
    _DIR="/usr/local/sbin"
    if [ -r "${_DIR}" ]; then
        export PATH="${_DIR}:${PATH}"
    fi

    # Find Homebrew installed utilities first
    _DIR="/usr/local/bin"
    if [ -r "${_DIR}" ]; then
        export PATH="${_DIR}:${PATH}"
    fi
fi

# =========================================================================== #
#   GDAL Environment
# =========================================================================== #

if [ -x "`which gdal-config 2> /dev/null`" ]; then

    # Let GDAL find additional drivers
    _DIR="/usr/local/lib/gdalplugins"
    if [ -r "${_DIR}" ]; then
        export GDAL_DRIVER_PATH="${_DIR}"
    fi

    # Set max GDAL cache to 1/4 available RAM
    export GDAL_CACHEMAX=$(printf %.0f $(echo "$(sysctl -n hw.memsize) / 1000 / 1000 / 4" | bc))
fi


# =========================================================================== #
#   Python modifications
# =========================================================================== #

# Get help on any object
function pyhelp(){

    if [ $# -ne 1 ]; then
        echo "Usage: module.package.object"
    else
        python -c "help('''$@''')"
    fi


}

# Try to get the version of a module
function pyversion(){

    if [ $# -ne 1 ]; then
        echo "Usage: module_name"
    else
        python -c """
import $1
import sys

for attr in ('__version__', 'version', 'VERSION', 'Version'):
    if hasattr($1, attr):
        print(getattr($1, attr))
        exit(0)
else:
    print('ERROR: Could not find a version attribute for $1')
    exit(1)
"""
    fi

}

# Alert the user if they're using system python
if [ $(which python) == "/usr/bin/python" ] && [ $(uname) == "Darwin" ]; then
    echo "WARNING: Using system Python"
fi


# =========================================================================== #    
#   Activate '.work_bash_profile' and '.work_bash_rc' if they exist
# =========================================================================== #

# Work specific bash profile and bashrc
_FILE=~/.work_bash_profile
if [ -r ${_FILE} ]; then
    source ${_FILE}
fi
_FILE=~/.work_bashrc
if [ -r ${_FILE} ]; then
    source ${_FILE}
fi


# =========================================================================== #
#   Cleanup
# =========================================================================== #

_DIR=
_FILE=
