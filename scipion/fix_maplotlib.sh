#!/bin/bash

cwd=${PWD}
src=scipion

unset PYTHONPATH

cd ${src}/software/tmp/matplotlib-1.3.1
LD_LIBRARY_PATH=${cwd}/${src}/software/lib:${LD_LIBRARY_PATH} ${cwd}/${src}/software/bin/python setup.py install
