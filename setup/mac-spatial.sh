#!/bin/bash


set -xe


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


brew bundle --file="${DIR}/Brewfile-Spatial"

ln -Fs $(find $(brew --prefix) -name "QGIS.app") /Applications/QGIS.app

python2 -m pip install \
    --user \
    psycopg2 \
    matplotlib \
    pyparsing \
    requests \
    future \
    jinja2

