Environment
===========

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
