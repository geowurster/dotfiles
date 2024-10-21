# Configure interactive Python sessions.
#
# Consider keeping imports fast.
#
# References:
#   - https://nedbatchelder.com/blog/201904/startuppy.html
#   - https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP


from __future__ import annotations

import itertools as it
import os
from pprint import pprint
import readline
import sys
from typing import (
    BinaryIO,
    TextIO
)


###############################################################################
# Aliases

pp = pprint
stdin = sys.stdin


###############################################################################
# Configure 'readline'


readline.parse_and_bind("tab: complete")


###############################################################################
# Functions


def cat(
        path: os.PathLike,
        mode: str = 'r',
        quiet: bool = False
) -> str:

    """$ cat"""

    with open(path, mode) as f:
        data = f.read()

    if not quiet:
        print(data, end='')

    return data


def head(
        path: os.PathLike,
        n: int = 10,
        mode: str = 'r',
        quiet: bool = False
) -> str:

    """$ head -n"""

    with open(path, mode) as f:
        data = ''.join(it.islice(f, n))

    if not quiet:
        print(data, end='')

    return data


def paste(encoding: str | None = 'utf-8') -> str:

    """Paste from the OS's paste utility.

    On MacOS this is ``$ pbpaste``.

    Use ``encoding=None`` to get binary data.
    """

    import subprocess as sp

    with sp.Popen(['pbpaste'], stdout=sp.PIPE) as proc:
        proc.wait(10)
        data = proc.stdout.read()

    if encoding is not None:
        data = data.decode(encoding)

    return data


def sh(
        # Defaults of '-1' are equivalent to 'subprocess.PIPE'.
        cmd: str,
        stdin: BinaryIO | TextIO | None = None,
        stdout: BinaryIO | TextIO | None = None,
        stderr: BinaryIO | TextIO | None = None,
) -> None:

    """Execute a shell command.

    Like: ls -1
    """

    import shlex
    import subprocess as sp

    sp.run(
        shlex.split(cmd),
        stdin=stdin,
        stdout=stdout,
        stderr=stderr,
    )


def tail(
        path: os.PathLike,
        n: int = 10,
        mode: str = 'r',
        quiet: bool = False
) -> str:

    """$ tail -n"""

    from collections import deque

    with open(path, mode) as f:
        queue = deque(f, n)

    data = ''.join(queue)

    if not quiet:
        print(data, end='')

    return data


###############################################################################
# Local Overrides

# Include '~/.pythonrc_local.py' and '.pythonrc.py' in the current directory
# if they exist.
paths = (
    os.path.expanduser('~/.pythonrc_local.py'),
    '.pythonrc.py'
)

# Each time one of these files is executed, it triggers the same check, so
# avoid executing the currently active file again. For example, if
# '~/.pythonrc.py' exists and '$ python' is invoked from '~/', that file will
# be executed recursively until Python's open file limit is hit.
paths = (p for p in paths if os.path.abspath(p) != os.path.abspath(__file__))

for p in paths:
    if os.path.exists(p):
        with open(p) as f:
            exec(f.read(), globals(), locals())
del p, paths
