# Configure Python environment


# If Python frameworks are available grab a list of all available versions.
FRAMEWORK="/Library/Frameworks/Python.framework"
if [[ -d "$FRAMEWORK" ]]; then
    VERSIONS=$(ls -r "$FRAMEWORK/Versions" | grep -vi current)
else
    VERSIONS=
fi


if [[ -d "$FRAMEWORK" ]] && [[ "$VERSIONS" ]]; then

    # Add all Python executables to the $PATH, preferring newer versions.
    # Also add each user bin directory (pip install --user)
    for V in $(echo "$VERSIONS" | sort); do
        PY_BIN="$FRAMEWORK/Versions/$V/bin/"
        INTERP="$PY_BIN/python$V"
        PY_USER_BIN=$("$INTERP" -c "import os, site; print(os.path.join(site.getuserbase(), 'bin'))")
        export PATH="$PY_BIN:$PY_USER_BIN:$PATH"
    done

    # Latest Python version number
    LATEST=$(echo "$VERSIONS" | head -1)

    # Ensure generic executables like 'python' and 'pip' are on $PATH.
    # Python 2 provides these, but Python 3 does not.  Note that
    # 'python-config' already exists, but 'python-config3.7' does not.
    for UTIL in idle pip pydoc python; do

        TARGET="$FRAMEWORK/Versions/$LATEST/bin/$UTIL"
        UTIL_PATH="$TARGET$LATEST"

        if [[ ! -f "$TARGET" ]]; then
            ln -s "$UTIL_PATH" "$TARGET"
        fi
        if [[ ! -x "$TARGET" ]]; then
            echo "ERROR: Failed to configure $(basename "$TARGET"): $UTIL_PATH" >> /dev/stderr
        fi
    done

    unset FRAMEWORK INTERP LATEST PIP PY_BIN PY_USER_BIN PYTHON TARGET UTIL_PATH V VERSIONS

# Found a version of Python.  Just assume it is correct.
elif [[ -x "$(which python)" ]]; then
    :

else
    return 1
fi
