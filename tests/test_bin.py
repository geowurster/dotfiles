"""
Unittests for bin/*
"""


import os
import subprocess


def test_iterdates():
    result = subprocess.check_output(
        ['./bin/iterdates', '2015-01-30', '2015-02-02']).decode('utf-8')

    expected = ['2015-01-30', '2015-01-31', '2015-02-01', '2015-02-02']
    print(result)
    assert result.strip() == os.linesep.join(expected).strip()
