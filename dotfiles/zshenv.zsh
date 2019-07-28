# 1. zshenv
# 2. zprofile
# 3. zshrc
# 4. zlogin
# 5. zlogout
#
# From the zsh docs: http://zsh.sourceforge.net/Intro/intro_3.html
#
# '.zshenv' is sourced on all invocations of the shell, unless the
# -f option is set. It should contain commands to set the command search
# path, plus other important environment variables. `.zshenv' should not
# contain commands that produce output or assume the shell is attached to
# a tty.


# Must be defined in 'zshenv', which is sourced first.
function init-work() {

    # Load the work-specific version of each configuration file.  Add this
    # to the bottom of any config file that may have a work counterpart:
    #
    #   init-work ${(%):-%N}
    #
    # The ${(%):-%N} points to the current startup file and is used to find
    # the partner work-specific file.

    if [[ $# -ne 1 && -o INTERACTIVE && -t 2 ]]; then
        echo "WARNING: Skipped sourcing a work config file: $@" >&2
        return 1
    fi

    # Translate a path like ~/.zshenv to ~/.work_zshenv
    WORK_DOTFILE="${HOME}/.work_$(echo $(basename $1) | sed 's/^.//')"
    if [[ -f "${WORK_DOTFILE}" ]]; then
        source "${WORK_DOTFILE}"
    fi

}


# Put work specific configurations in '.work_zshenv'
init-work ${(%):-%N}
