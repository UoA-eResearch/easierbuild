#!/bin/bash

# load modules
module purge
module load PETSc/3.8.3-foss-2017b-downloaded-deps
module load METIS/5.1.0-foss-2017b
module load netCDF-Fortran/4.4.4-foss-2017b-HDF5-1.8.19

# get Delft revision number
DELFT_REV=$(svn info | grep "Revision" | awk '{print $2}')
INSTALL_DIR=/mnt/Delft3D/$DELFT_REV
echo $INSTALL_DIR

# refresh build dir
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

./clean.sh
./autogen.sh
cd third_party_open/kdtree2
./autogen.sh
cd -
CFLAGS='-O2' CXXFLAGS='-O2' FFLAGS='-O2' FCFLAGS='-O2' ./configure --prefix=$INSTALL_DIR --with-netcdf --with-mpi --with-metis --with-petsc | tee configure-eb.log
make ds-install | tee make-eb.log
FC=mpif90 make ds-install -C engines_gpl/dflowfm | tee -a make-eb.log

