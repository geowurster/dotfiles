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
    $ git clone git@github.com:geowurster/Environment.git
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


GDAL
====

Geotransform vs. Affine
-----------------------

Given the spatial bounds:

.. code-block::

    xmin        ymin        xmax        ymax
    101985.0    2611485.0   339315.0    2826915.0

A GDAL geotransform looks like:

.. code-block::

    xmin        xres                _   ymax        _   yres
    101985.0    300.0379266750948   0.0 2826915.0   0.0 -300.041782729805

and an ``affine.Affine()`` looks like:

.. code-block::

    xres                _   xmin        _   yres                ymax
    300.0379266750948   0.0 101985.0    0.0 -300.041782729805   2826915.0

