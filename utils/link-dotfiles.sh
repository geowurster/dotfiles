#!/bin/bash


ln -s "$(pwd)/dotfiles/zshenv.sh" "${HOME}/.zshenv"
ln -s "$(pwd)/dotfiles/zshrc.sh" "${HOME}/.zshrc"

ln -s "$(pwd)/dotfiles/bash_profile.sh" "${HOME}/.bash_profile"
ln -s "$(pwd)/dotfiles/bashrc.sh" "${HOME}/.bashrc"

ln -s "$(pwd)/dotfiles/gitconfig" "${HOME}/.gitconfig"
