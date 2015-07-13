#!/bin/bash

module purge
module load HDF5/1.8.15-intel-mpi
MODULE_FILE=/projects/uoa00035/privatemodules/NetCDF/4.3.3.1-intel-mpi
mkdir -p /projects/uoa00035/privatemodules/NetCDF
INSTALL_DIR=/projects/uoa00035/local/NetCDF/4.3.3.1-intel-mpi
rm -rf $INSTALL_DIR
mkdir -p INSTALL_DIR

unset I_MPI_PMI_LIBRARY
CC=$EBROOTIMPI/bin64/mpiicc ./configure --prefix=$INSTALL_DIR --enable-parallel-tests
make clean
make check install

cat >$MODULE_FILE <<EOL
#%Module

proc ModulesHelp { } {
    puts stderr {   NetCDF (network Common Data Form) is a set of software libraries 
 and machine-independent data formats that support the creation, access, and sharing of array-oriented 
 scientific data. - Homepage: http://www.unidata.ucar.edu/software/netcdf/
    }
}

module-whatis {Description: NetCDF (network Common Data Form) is a set of software libraries 
 and machine-independent data formats that support the creation, access, and sharing of array-oriented 
 scientific data. - Homepage: http://www.unidata.ucar.edu/software/netcdf/}

set root $INSTALL_DIR 

conflict netCDF

if { ![is-loaded HDF5/1.8.15-intel-mpi] } {
    module load HDF5/1.8.15-intel-mpi
}

prepend-path	CPATH		\$root/include
prepend-path	LD_LIBRARY_PATH		\$root/lib
prepend-path	LIBRARY_PATH		\$root/lib
prepend-path	MANPATH		\$root/share/man
prepend-path	PATH		\$root/bin
prepend-path	PKG_CONFIG_PATH		\$root/lib/pkgconfig

setenv	NETCDFROOT		\$root
EOL
