#!/bin/bash


if [ ! "$(which brew)" ]; then
    echo "Homebrew not installed."
    exit 1
fi


brew install zsh zsh-completions

echo "Now: https://github.com/sorin-ionescu/prezto#installation"
