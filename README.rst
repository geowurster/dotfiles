Environment
===========

[![Build Status](https://travis-ci.org/geowurster/Environment.svg?branch=master)](https://travis-ci.org/geowurster/Environment)

Source order: ``.zshrc`` -> ``.bash_profile`` -> ``.work_bash_profile``,
followed by a ``.workzshrc``.  The ``.bashrc`` is handled by the system but
also sources a ``.work_bashrc``.


Setup
-----

.. code-block:: console

    $ git clone https://github.com/geowurster/Environment
    $ cd Environment
    $ ./utils/link-dotfiles.sh
    # log out and then log back in
    $ ./utils/link-config.sh


Stuff I always have a hard time finding
---------------------------------------

### Scrubbing a docstring-like string ###


Use `textwrap.dedent() <https://docs.python.org/3/library/textwrap.html#textwrap.dedent>`_.

Problem: Sometimes it is easiest and cleanest to define a string literal like:

.. code-block:: python

    parser = argparse.ArgumentParser(
        description="""
        Print a date range to stdout.

            $ iterdates 2015-01-01 2015-01-04
            2015-01-01
            2015-01-02
            2015-01-03
            2015-01-04
        """, formatter_class=argparse.RawTextHelpFormatter)

but this creates some gross output:

.. code-block:: console

    $ iterdates --help
    usage: iterdates.py [-h] [--format STRFTIME] start stop

            Print a date range to stdout.

                $ iterdates 2015-01-01 2015-01-04
                2015-01-01
                2015-01-02
                2015-01-03
                2015-01-04

Wrap the string in ``textwrap.dedent()`` for better results.

### Disabling the double dash to em dash conversion in Slack ###

https://twitter.com/slackhq/status/528316204415746048
