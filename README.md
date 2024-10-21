# `dotfiles`

## Setup

Dotfiles are managed with the [`link-dotfiles.sh`](link-dotfiles.sh) script. Add the `--dry-run` flag to operate in a mode where nothing happens, but information about what _would_ have happened is emitted.

Install:

```console
$ ./link-dotfiles.sh
```

Uninstall:

```console
$ ./link-dotfiles.sh --unlink
```

One might be tempted to use [`stow`](https://www.gnu.org/software/stow/) for this, however the version most widely available contains a bug. Plus it requires some name specific naming and organization that is not ideal.

## Shells

Some environments have `zsh` and some have `bash`. Support for both is included, and generally configured to be as similar as possible.

## References

### [`bash`](https://www.gnu.org/software/bash/)

Bourne Again SHell

* [Bash reference manual](https://www.gnu.org/software/bash/manual/bash.html)
* [Completion](https://www.gnu.org/software/bash/manual/bash.html#Programmable-Completion)
* [Completion builtins](https://www.gnu.org/software/bash/manual/bash.html#Programmable-Completion-Builtins)
* [Completion examples](https://www.gnu.org/software/bash/manual/bash.html#A-Programmable-Completion-Example)

### [`editorconfig`](https://editorconfig.org)

Universal-ish editor configuration.

* [List of all properties](https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties)

### [`git`](http://git-scm.com)

Version control

* [Git manual](https://git-scm.com/docs/user-manual.html)

### [`neovim`](https://neovim.io)

A fork of [`vim`](https://www.vim.org) providing most of the same features through a smaller code base. Supports plugins written in [Lua](https://www.lua.org).

* [LazyVim](https://www.lazyvim.org) - both a plugin manager and a distribution.
* [FAQ](https://neovim.io/doc/user/faq.html#faq)
* [Lua in Neovim](https://neovim.io/doc/user/lua.html)

#### Testing Different Configurations

Different Neovim configurations can be tested with the [`NVIM_APPNAME`](https://neovim.io/doc/user/starting.html#_nvim_appname) environment variable. Place the configuration in `$XDG_CONFIG_HOME` with a non-conflicting name like: `~/.config/nvim-new-config`. Load the config with:

```console
$ NVIM_APPNAME="nvim-new-config" nvim
```

#### Neovim + LazyVim

LazyVim's `:checkhealth` can be helpful for debugging odd behavior.

If Neovim gets in a bad state, all plugins can be synced with:

```console
$ nvim --headless "+Lazy! sync" +qa
```

and upgraded with:

```console
$ nvim --headless "+Lazy! upgrade" +qa
```

### [`python`](https://python.org)

Python supports executing a file when launching an interactive interpreter. The file can only be set via the [`PYTHONSTARTUP`](https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP) environment variable. For example:

```console
$ PYTHONSTARTUP="${HOME}/.pythonrc.py
```

Completion and other features can be configured an extended. [Ned Batchelder's configuration](https://nedbatchelder.com/blog/201904/startuppy.html) is a gentle introduction, but very advanced features are possible.

### [`shell`](shell/)

Files for supporting multiple shell configurations. See [`bashrc.sh`](bashrc.sh) and [`zshrc.zsh`](zshrc.zsh) for reference implementations of how to source these files. Contains two kinds of files:

1. `env-*` - _only_ modify environment variables.
2. All other files may perform other actions.

The idea is to allow for always configuring `$PATH`, but only defining functions for interactive shells. Be conscious of the order in which these files are source. For example, `$GIT_EDITOR` might depend on `$EDITOR`.

#### [`bin`](bin/)

Custom scripts and executables. This directory is added to `$PATH` through some of the common [`shell`](shell/) machinery.

### [`zsh`](https://www.zsh.org)

Shell with improved globbing and completion. [`prezto`](https://github.com/sorin-ionescu/prezto)
is a configuration framework for Zsh that is growing larger and larger and more
and more opinionated with time. It is a great reference, especially its [`completion`](https://github.com/sorin-ionescu/prezto/tree/master/modules/completion) module, but it just does too much.

* [Options](https://zsh.sourceforge.io/Doc/Release/Options.html#Options)
* [Completion system](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)
* [`prezto`'s completion module](https://github.com/sorin-ionescu/prezto/tree/master/modules/completion)

#### Zsh Dotfile Source Order

From the [Zsh docs](http://zsh.sourceforge.net/Intro/intro_3.html):

1. `.zshenv`
2. `.zprofile`
3. `.zshrc`
4. `.zlogin`
5. `.zlogout`

## References

* Brandon Rhodes's [`homedir`](https://github.com/brandon-rhodes/homedir/blob/master/.zshrc) repository.
* Mathias Bynens's [MacOS Configuration](https://github.com/mathiasbynens/dotfiles/blob/master/.macos).

## MacOS

### Disabling Smart Dash Conversions MacOS Slack

Edit -> Substitutions -> Smart Dashes

### Change MacOS Terminal.app Default Shell

This generally applies for other terminal emulators.

1. Add the desired shell to `/etc/shells`.
2. Set the login command to the absolute path to the shell in the desired terminal emulator.

### Todo

* Consider more advanced completion like [`prezto`](https://github.com/sorin-ionescu/prezto/tree/master/modules/completion). Note that this includes a caching mechanism that is triggered in [`.zlogin`](zsh/dot-zlogin).

