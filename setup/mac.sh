#!/bin/bash


set -xe


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


# Install Homebrew
if ! [[ -x "$(command -v brew)" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Install baseline packages
brew bundle --file="${DIR}/Brewfile"


# Install prezto
if ! [[ -d ~/.zprezto/ ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi


# Link dotfiles
./link-dotfiles.sh


./setup/python.sh


echo ""
echo "Change shell with: chsh -s $(which zsh)"
echo ""
