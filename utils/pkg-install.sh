#!/bin/bash


# =========================================================================== #
#   Homebrew
# =========================================================================== #

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export HOMEBREW_MAKE_JOBS=$(getconf _NPROCESSORS_ONLN)

brew update

brew install \
    wget \
    jq \
    ruby \
    pyenv \
    zsh \
    zsh-completions \
    git --with-brewed-curl --with-brewed-openssl --with-brewed-svn

brew install numpy

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


# =========================================================================== #
#   Python
# =========================================================================== #

pyenv install 2.7.10
pyenv rehash
pyenv install 3.4.2
pyenv rehash
pyenv

pip install --upgrade --no-cache \
    pip \
    setuptools \
    virtualenv

pip install --upgrade --no-cache \
    cython \
    numpy \
    rasterio \
    shapely \
    fiona

# GDAL python bindings
if [[ $(gdal-config --version | cut -f 1 -d .) == "1" ]]; then
    pip install "GDAL<2" --upgrade --no-cache
elif [[ $(gdal-config --version | cut -f 1 -d .) == "2" ]]; then
    pip install "GDAL<3" --upgrade --no-cache
fi


# =========================================================================== #
#   Ruby
# =========================================================================== #

gem update --system

gem install travis -v 1.8.0 --no-rdoc --no-ri
