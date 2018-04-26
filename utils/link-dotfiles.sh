#!/bin/bash


for F in $(pwd)/dotfiles/*; do
    TARGET="${HOME}"/."$(basename $F)"
    if [[ ! -f "${TARGET}" ]]; then
        ln -s "${F}" "${TARGET}"
    fi
done
