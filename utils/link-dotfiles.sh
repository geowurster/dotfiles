#!/bin/bash


for F in $(pwd)/dotfiles/*; do
    ln -s "${F}" "${HOME}"/."$(basename $F)"
done
