# Set '$EDITOR', '$PAGER', '$VISUAL', etc.


export PAGER="less"
if [ -x "$(which nvim)" ]; then
  export EDITOR="nvim"
  export VISUAL="nvim -R"
elif [ -x "$(which vim)" ]; then
  export EDITOR="vim"
  export VISUAL="vim"
elif [ -x "$(which vi)" ]; then
  export EDITOR="vi"
  export VISUAL="vi -R"
else
  echo "WARNING: Did not set \$EDITOR" >> /dev/stderr
fi
