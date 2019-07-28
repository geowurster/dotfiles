#!/bin/bash


set -e


EXITCODE=0
DOTFILE_DIR="$PWD/dotfiles"
for F in $(ls "$DOTFILE_DIR"); do

  # Absolute path
  F="$DOTFILE_DIR/$F"

  # Target does not include .zsh extension
  TARGET="$HOME/.$(basename ${F/.zsh/})"

  # Link exists and points to the correct file
  if [[ "$TARGET" -ef "$F" ]]; then
    echo "Skipped existing: $F -> $TARGET"

  # Target path exists and is a link.
  elif [[ -L "$TARGET" ]]; then
    echo "ERROR: Link exists: $TARGET -> $(readlink $TARGET)"
    EXITCODE=1

  # Target path exists and is a file.
  elif [[ -f "$TARGET" ]]; then
    echo "ERROR: File exists: $TARGET"

  else
    ln -s "$F" "$TARGET"
    echo "Linked: $F $TARGET"
  fi

done


exit "$EXITCODE"
