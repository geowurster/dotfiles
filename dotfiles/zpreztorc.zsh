# prezto configuration: https://github.com/sorin-ionescu/prezto


#
# General
#

# Set case-sensitivity for completion, history lookup, etc.
# zstyle ':prezto:*:*' case-sensitive 'yes'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':prezto:*:*' color 'yes'

# Add additional directories to load prezto modules from
zstyle ':prezto:load' pmodule-dirs $(dirname ${0:A})/../prezto-modules

# Set the Prezto modules to load (browse modules). Order is significant.
zstyle ':prezto:load' pmodule \
    'terminal' \
    'editor' \
    'spectrum' \
    'utility' \
    'completion' \
    'prompt' \
    'my-homebrew' \
    'my-gdal' \
    'my-git' \
    'my-history' \
    'my-python' \
    'my-ruby' \
    'my-google-cloud-sdk' \
    'my-functions'

#
# Autosuggestions
#

# Set the query found color.
# zstyle ':prezto:module:autosuggestions:color' found ''


#
# Editor
#

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'emacs'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'


#
# History Substring Search
#

# Set the query found color.
# zstyle ':prezto:module:history-substring-search:color' found ''

# Set the query not found color.
# zstyle ':prezto:module:history-substring-search:color' not-found ''

# Set the search globbing flags.
# zstyle ':prezto:module:history-substring-search' globbing-flags ''


#
# Prompt
#

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':prezto:module:prompt' theme 'sorin'


# Set the working directory prompt display length.
# By default, it is set to 'short'. Set it to 'long' (without '~' expansion)
# for longer or 'full' (with '~' expansion) for even longer prompt display.
# zstyle ':prezto:module:prompt' pwd-length 'short'

# Set the prompt to display the return code along with an indicator for non-zero
# return codes. This is not supported by all prompts.
# zstyle ':prezto:module:prompt' show-return-val 'yes'


#
# Terminal
#

# Auto set the tab and window titles.
zstyle ':prezto:module:terminal' auto-title 'yes'

# Set the window title format.
zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'

# Set the tab title format.
# zstyle ':prezto:module:terminal:tab-title' format '%m: %s'

# Set the terminal multiplexer title format.
# zstyle ':prezto:module:terminal:multiplexer-title' format '%s'

#
# Utility
#

# Enabled safe options. This aliases cp, ln, mv and rm so that they prompt
# before deleting or overwriting files. Set to 'no' to disable this safer
# behavior.
zstyle ':prezto:module:utility' safe-ops 'yes'


# Put work specific configurations in '.work_zpreztorc'
init-work ${(%):-%N}
