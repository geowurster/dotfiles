Environment
===========

.. image:: https://travis-ci.org/geowurster/Environment.png?branch=master
   :target: https://travis-ci.org/geowurster/Environment

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


How do I...
-----------


Scrubbing a docstring-like string
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Make TextEdit better for code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Limits the size of the panel it is in unless the ``Group tabs`` setting is
enabled in the panel settings.


Disabling the double dash to em dash conversion in Slack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

https://twitter.com/slackhq/status/528316204415746048

Text from tweet:

   Yeah... that's an OS X thing. Edit -> Substitutions -> Smart Dashes will turn it off.


ssh agent forwarding
~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    $ ssh -A


ssh agent forwarding in Vagrant
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`In the environment's Vagrantfile <https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html>`_: ``config.ssh.forward_agent =>true``.
