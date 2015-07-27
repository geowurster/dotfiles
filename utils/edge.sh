#!/bin/bash


CURRENT_DIR=$(pwd)


# Make sure everything is set up
EDIR="~/live-code"
mkdir -p ${EDIR}

# personal environment
cd "${EDIR}"
if [[ ! -d "Environment" ]]; then
    git@github.com:geowurster/Environment.git
else
    cd "Environment" && git pull
fi

# prezto
cd "${EDIR}"
if [[ ! -d "prezto" ]] && ln -s "${ZDOTDIR:-$HOME}/.zprezto" "prezto"
cd "prezto"
git pull && git submodule update --init --recursive


# rasterio
if [[ ! -d "rasterio" ]]; then
    git@github.com:mapbox/rasterio.git
else
    cd "rasterio" && git pull && pip install -e .
fi


# Fiona
if [[ ! -d "Fiona" ]]; then
    git@github.com:Toblerity/Fiona.git
else
    cd "Fiona" && git pull && pip install -e .
fi
