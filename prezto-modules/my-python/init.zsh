# Configure Python environment


# Just assume environment is configured properly.
if [[ -x "$(which python)" ]]; then
    :

# On a Mac look for a Python Framework, likely from python.org
elif [[ -d "/Library/Frameworks/Python.framework/Versions" ]]; then

    for VERSION in $(echo "2.7 3.7"); do
        PY_BIN="/Library/Frameworks/Python.framework/Versions/${VERSION}/bin"
        if [[ -d "${PY_BIN}" ]]; then
            export PATH="${PY_BIN}:${PATH}"
        fi
    done
    unset PY_BIN

else
    return 1
fi


# For 'pip install --user'
# Note that Python 2 will appear first in the PATH.
for INTERP in $(echo "python3 python"); do
    PY_USER_BIN=$(${INTERP} -c "import os, site; print(os.path.join(site.getuserbase(), 'bin'))")
    export PATH="${PY_USER_BIN}:${PATH}"
done
unset INTERP PY_USER_BIN
