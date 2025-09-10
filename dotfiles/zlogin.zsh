# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# Not the place for alias definitions, options, environment
# variable settings, etc.; as a general rule, it should not change the
# shell environment at all. Rather, it should be used to set the terminal
# type and run a series of external commands (fortune, msgs, etc).


# Prezto default by Sorin Ionescu <sorin.ionescu@gmail.com>
# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!


# Put work specific configurations in '.work_zlogin'
init-work ${(%):-%N}
