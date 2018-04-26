# Configure Python environment


if [[ ! -x "$(which python)" ]]; then
    return 1
fi


# For `$ pip install --user`
PY_USER_BIN=$(python -c "import os, site; print(os.path.join(site.getuserbase(), 'bin'))")
export PATH="${PY_USER_BIN}:${PATH}"


# It's mildly inconvenient to activate a virtual environment.  This is easier.
function vactivate(){

    DEFAULT_VENV="venv/bin/activate"

    # No arguments - look in current directory for 'venv'
    if [[ $# -eq 0 ]]; then
        if [[ -f "${DEFAULT_VENV}" ]]; then
            source "${DEFAULT_VENV}"
            return 0
        else
            echo "ERROR: Can't find venv: ${DEFAULT_VENV}"
            return 1
        fi

    # User supplied a venv - attempt to activate if it exists
    elif [[ $# -eq 1 ]]; then
        VENV="${1}/bin/activate"
        if [[ -f "${VENV}" ]]; then
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


# Get help on any python object
function pyhelp(){

    if [[ $# -ne 1 ]]; then
        echo "Calls help() on a Python object."
        echo ""
        echo "Usage: module.package.object"
        return 1
    fi

    python -c "help('''$1''')"
}


# Print Python module's version by probing module level variables
function pyversion(){

    if [[ $# -ne 1 ]]; then
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


# Print the path to a Python module
function pywhich(){

    if [[ $# -ne 1 ]]; then
        echo "Prints the path to a Python module."
        echo ""
        echo "Usage: module_name"
        return 1
    fi

    python -c "import $1; print($1.__file__)"
}


# Print a Python object's attributes
function pydir(){

    if [[ $# -ne 1 ]]; then
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


# Print a Python object's source code.  Probably not super robust.
function pysrc {

    if [[ $# -ne 1 ]]; then
        echo "Prints a Python object's source code."
        echo ""
        echo "Usage: path.to.object"
        return 1
    fi

    python -c "
from __future__ import print_function

import inspect

def importer(ipath):
    if '.' not in ipath:
        return __import__(ipath)
    base, obj = ipath.rsplit('.', 1)
    m = getattr(__import__(base, fromlist=[obj]), obj)
    return m

print(inspect.getsource(importer('$1')))
"
}
