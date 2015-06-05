#!/bin/bash

module purge
module load HDF5/1.8.15-intel-2015a

INSTALL_DIR=/projects/uoa00035/local/NetCDF/4.3.3.1-intel-2015a
rm -rf $INSTALL_DIR
mkdir -p INSTALL_DIR

unset I_MPI_PMI_LIBRARY
CC=$EBROOTIMPI/bin64/mpiicc ./configure --prefix=$INSTALL_DIR --enable-parallel-tests
make clean
make check install

