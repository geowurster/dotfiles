# Configure GDAL environment


# If 'gdal-config' is found then GDAL was likely installed with a package
# manager like Homebrew or 'apt-get', or the environment is otherwise known
# to be configured properly.  On a Mac it is worth falling back to the
# KyngChaos GDAL install, which requires a $PATH change.
KYNGCHAOS_GDAL="/Library/Frameworks/GDAL.framework"
if [[ -x "$(which gdal-config)" ]]; then
    :
elif [[ -d "${KYNGCHAOS_GDAL}" ]]; then
    export PATH="${PATH}:${KYNGCHAOS_GDAL}/Programs"
else
    return 1
fi


# Provides a more reliable install for some GDAL dependents
export GDAL_DATA="$(gdal-config --datadir)"


case "${OSTYPE}" in

    darwin*)
        RAM=$(sysctl -n hw.memsize)
        ;;
    linux*)
        RAM=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE)))
        ;;
    *)
        ;;
esac


if (( ${+RAM} )); then
    export GDAL_CACHEMAX=$(echo "${RAM}" | awk '{print int($1 / 1024 / 1024 / 4)}')
fi
