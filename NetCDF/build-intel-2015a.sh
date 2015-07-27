#!/bin/bash

module purge
module load HDF5/1.8.15-intel-2015a
ROOT=/projects/uoa99999
MODULE_FILE=$ROOT/privatemodules/NetCDF/4.3.3.1-intel-2015a
mkdir -p $ROOT/privatemodules/NetCDF
INSTALL_DIR=$ROOT/local/NetCDF/4.3.3.1-intel-2015a
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

unset I_MPI_PMI_LIBRARY
sed -i.bak 's/mpiexec /mpiexec.hydra /g' nc_test4/run_par_test.sh
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

if { ![is-loaded HDF5/1.8.15-intel-2015a] } {
    module load HDF5/1.8.15-intel-2015a
}

prepend-path	CPATH		\$root/include
prepend-path	LD_LIBRARY_PATH		\$root/lib
prepend-path	LIBRARY_PATH		\$root/lib
prepend-path	MANPATH		\$root/share/man
prepend-path	PATH		\$root/bin
prepend-path	PKG_CONFIG_PATH		\$root/lib/pkgconfig

setenv	NETCDFROOT		\$root
EOL
