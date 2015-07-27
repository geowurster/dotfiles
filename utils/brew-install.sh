#!/bin/bash


ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Run make jobs on all cores
export HOMEBREW_MAKE_JOBS=$(getconf _NPROCESSORS_ONLN)


# =========================================================================== #
#   Easy installs
# =========================================================================== #

brew install \
    wget \
    jq \
    git --with-brewed-curl --with-brewed-openssl --with-brewed-svn


# =========================================================================== #
#   More complicated installs
# =========================================================================== #

brew install gdal \
    --with-armadillo \
    --with-complete \
    --with-libkml \
    --with-postgresql \
    --with-unsupported

# Homebrew installs freetype2 but not freetype, which some packages (like PIL)
# require - online sources recommend: Make sure freetype2 is installed, make
# sure freetype1 does not exist, make sure target directory is writable
_FT1="/usr/local/include/freetype"
_FT2="/usr/local/include/freetype2"
if [ -e "${_FT2}" ] && [ ! -e "${_FT1}" ] && [ -w "$(dirname ${_FT2})" ]; then
    ln -s "${_FT2}" "${_FT1}"
fi
