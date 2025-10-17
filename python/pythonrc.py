# Configure interactive Python sessions.
#
# Consider keeping imports fast.
#
# References:
#   - https://nedbatchelder.com/blog/201904/startuppy.html
#   - https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP
#   - https://github.com/lonetwin/pythonrc/blob/master/pythonrc.py


from __future__ import annotations

import code
import itertools as it
from keyword import iskeyword
import os
from pprint import pprint
import readline
import subprocess as sp
import sys
from typing import (
    BinaryIO,
    TextIO
)


# Do nothing if running on IPython. Lots of conflicts between this file and
# IPython
try:
    assert '__IPYTHON__' in globals()
    exit(0)
except AssertionError:
    pass


###############################################################################
# Aliases

pp = pprint
stdin = sys.stdin


###############################################################################
# Configure 'readline' and completion

# Importing this module registers 'rlcompleter.Completer()' with 'readline'.
import rlcompleter
assert rlcompleter

# Enable tab completion on MacOS. Python 3.13 introduced 'readline.backend',
# which can likely replace this check.
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")

# and other platforms.
else:
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


###############################################################################
# InteractiveConsole()

class InteractiveConsole(code.InteractiveConsole):

    """Custom interactive console."""

    def raw_input(self, prompt: str = '') -> str:

        """Given a raw line from the console, dispatch a function."""

        line = super().raw_input(prompt)

        # We often need a version of the line without leading and trailing
        # whitespace, but in some cases it is significant, so always evaluate
        # the 'line'.
        stripped = line.strip()

        if stripped == 'exit':
            raise SystemExit(0)

        elif stripped.startswith('%paste'):
            return self._paste(line)

        elif stripped.startswith('!'):
            return self._command(line)

        # Invoke 'help(str)' with IPython's 'str?' syntax. Note that this
        # should be checked after shell commands to avoid routing things like
        # '$?' through Python's 'help()'.
        elif stripped.endswith('?'):
            return self._help(line)

        else:
            return line

    def write(self, data: str) -> None:

        """Write text to the console.

        Exists only to ensure that the text ends with a newline.
        """

        if not data.endswith(os.linesep):
            data += os.linesep
        super().write(data)

    def _command(self, line: str) -> str:

        """Execute a command like ``!ls -lrt``."""

        # TODO: Enable colored output. I think this isn't getting a full shell
        #       instance. Using '!ls --color=yes' gets colors, but not '!ls'.
        os.system(line.strip()[1:])
        return ''

    def _help(self, line: str) -> str:

        """Execute ``help(str)`` like ``str?``."""

        help(line[:-1])
        return ''

    def _paste(self, line: str) -> str:

        """Dump system clipboard into a variable like IPython.

        ``%paste variable``.
        """

        split = line.split(' ', 1)
        if len(split) != 2:
            self.write(f'FAILED: could not parse: {line}')

        directive, variable = map(str.strip, split)
        if directive != '%paste':
            self.write(
                f'FAILED: unknown directive: {line}'
            )

        elif iskeyword(variable) or not variable.isidentifier():
            self.write(
                f'ERROR: not a valid variable name: {variable}'
            )

        elif sys.platform != 'darwin':
            self.write(
                f'ERROR: platform {sys.platform} not supported: {line}'
            )

        else:

            proc = sp.Popen(
                ['pbpaste'],
                stdout=sp.PIPE,
                stderr=sp.PIPE
            )
            with proc as proc:
                proc.wait()
                if proc.returncode == 0:
                    data = proc.stdout.read()
                    self.locals[variable] = data.decode()
                else:
                    self.write(f'ERROR: Executed and failed: {line}')

        return ''


###############################################################################
# Start Interactive Console

# Pass 'globals()' as local variables to pick up all the functions we have
# defined. Manually constructing a scope would be cleaner, but this is in
# service of an interactive console, so it doesn't matter.
InteractiveConsole(locals=globals().copy()).interact(banner='')
