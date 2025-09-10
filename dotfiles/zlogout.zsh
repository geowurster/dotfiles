# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# Sourced when login shells exit.


# Put work specific configurations in '.work_logout'
init-work ${(%):-%N}
