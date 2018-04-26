Environment
===========

Mostly shell configurations for `zsh <http://zsh.sourceforge.net>`_ with
`prezto <https://github.com/sorin-ionescu/prezto>`_.


*****
Setup
*****

Install `zsh <http://zsh.sourceforge.net/>`_ first.

.. code-block:: console

    $ zsh
    $ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    $ git@github.com:geowurster/Environment.git
    $ cd Environment
    $ zsh link-dotfiles.sh

Launch a new terminal session.


**********
Cheatsheet
**********


zsh Dotfile Source Order
========================

From the `zsh docs <http://zsh.sourceforge.net/Intro/intro_3.html>`_.

1. ``.zshenv``
2. ``.zprofile``
3. ``.zshrc``
4. ``.zlogin``
5. ``.zlogout``


Make TextEdit better for code
=============================

1. Preferences.
2. Change format to ``Plain text``
3. Disable ``Check spelling as you type``
4. Disable ``Check grammar with spelling``
5. Disable ``Correct spelling automatically``
6. Enable ``Smart copy/paste``
7. Disable ``Smart quotes``
8. Disable ``Smart dashes``
9. Disable ``Smart links``
10. Enable ``Text replacement``


PyCharm project browser tabs
============================

Limits the size of the panel it is in unless the ``Group tabs`` setting is
enabled in the panel settings.


Disabling the double dash to em dash conversion in Slack
========================================================

https://twitter.com/slackhq/status/528316204415746048

Text from tweet:

   Yeah... that's an OS X thing. Edit -> Substitutions -> Smart Dashes will turn it off.
