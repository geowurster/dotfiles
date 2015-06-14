# Configure Ruby environment


if [[ -x "$(which brew)" ]] && [[ -d "/usr/local/opt/ruby" ]]; then
    # Add Homebrew Ruby to path and then gem executable directory.  Cannot
    # combine these steps because the latter will discover Apple's Ruby because
    # the PATH variable has not been updated with Homebrew's Ruby.
    export PATH="/usr/local/opt/ruby/bin:${PATH}"
    export PATH="$(gem environment gemdir)/bin:${PATH}"
fi
