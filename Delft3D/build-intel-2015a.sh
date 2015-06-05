#!/bin/bash

#!/bin/bash

DELFT_REV=$(svn info | grep "Revision" | awk '{print $2}')
INSTALL_DIR=/projects/uoa00035/local/Delft3D/$DELFT_REV-intel-2015a

rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

module purge
module load NetCDF/4.3.3.1-intel-2015a

export CC=$EBROOTICC/bin/icc
export FC=$EBROOTIFORT/bin/ifort
export CXX=$EBROOTICC/bin/icpc
export MPICCXX=$EBROOTIMPI/bin64/mpiicpc
export MPIFC=$EBROOTIMPI/bin64/mpiifort
export MPIF77=$EBROOTIMPI/bin64/mpiifort
export CFLAGS='-O2'
export CXXFLAGS='-O2'
export FFLAGS='-O2'
export FCFLAGS='-O2'
make clean
./configure --prefix=$INSTALL_DIR --with-mpi --with-netcdf
make ds-install
