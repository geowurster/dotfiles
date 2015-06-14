# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# '.zprofile' is meant as an alternative to '.zlogin' for ksh fans; the
# two are not intended to be used together, although this could certainly
# be done if desired. '.zlogin' is not the place for alias definitions,
# options, environment variable settings, etc.; as a general rule, it
# should not change the shell environment at all. Rather, it should be
# used to set the terminal type and run a series of external commands
# (fortune, msgs, etc).


# Put work specific configurations in '.work_zprofile'
init-work ${(%):-%N}
