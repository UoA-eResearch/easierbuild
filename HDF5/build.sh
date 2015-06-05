#!/bin/bash

# use an interactive session to build and test this:
# salloc -A uoa00035 -n 8 -C sb --time=3:00:00

INSTALL_DIR=/projects/uoa00035/local/HDF5/1.8.15-intel-2015a
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

module purge
module load intel/2015a
module load zlib/1.2.8-intel-2015a
module load Szip/2.1-intel-2015a 

unset I_MPI_PMI_LIBRARY
export RUNPARALLEL="mpiexec.hydra -n \$\${NPROCS:=6}"
CC=$EBROOTIMPI/bin64/mpiicc FC=$EBROOTIMPI/bin64/mpiifort ./configure --prefix=$INSTALL_DIR --with-szlib=$EBROOTSZIP --with-zlib=$EBROOTZLIB --enable-parallel --enable-fortran --enable-fortran2003
make clean
make 
make -f "tools/h5dump/../h5import/Makefile" && make check && make install && make check-install
