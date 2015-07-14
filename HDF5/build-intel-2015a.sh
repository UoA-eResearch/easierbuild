#!/bin/bash

# use an interactive session to build and test this:
# salloc -A uoa00035 -n 8 -C sb --time=3:00:00
MODULE_FILE=/projects/uoa00035/privatemodules/HDF5/1.8.15-intel-2015a
mkdir -p /projects/uoa00035/privatemodules/HDF5 
INSTALL_DIR=/projects/uoa00035/local/HDF5/1.8.15-intel-2015a
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

module purge
module load intel/2015a
module load zlib/1.2.8-intel-2015a
module load Szip/2.1-intel-2015a

unset I_MPI_PMI_LIBRARY
export RUNPARALLEL="mpiexec.hydra -n \$\${NPROCS:=6}"
CC=$EBROOTIMPI/bin64/mpiicc FC=$EBROOTIMPI/bin64/mpiifort ./configure --prefix=$INSTALL_DIR --with-szlib=$SZIPROOT --with-zlib=$ZLIBROOT --enable-parallel --enable-fortran --enable-fortran2003

make clean
#make -f "tools/h5dump/../h5import/Makefile" && make check && make install && make check-install
make && make check && make install && make check-install

cat >$MODULE_FILE <<EOL
#%Module

proc ModulesHelp { } {
    puts stderr {   HDF5 is a unique technology suite that makes possible the management of 
 extremely large and complex data collections. - Homepage: http://www.hdfgroup.org/HDF5/
    }
}

module-whatis {Description: HDF5 is a unique technology suite that makes possible the management of 
 extremely large and complex data collections. - Homepage: http://www.hdfgroup.org/HDF5/}

set root    $INSTALL_DIR

conflict HDF5

if { ![is-loaded intel/2015a] } {
    module load intel/2015a
}

if { ![is-loaded zlib/1.2.8-intel-2015a] } {
    module load zlib/1.2.8-intel-2015a
}

if { ![is-loaded Szip/2.1-intel-2015a] } {
    module load Szip/2.1-intel-2015a
}

prepend-path	CPATH		\$root/include
prepend-path	LD_LIBRARY_PATH		\$root/lib
prepend-path	LIBRARY_PATH		\$root/lib
prepend-path	PATH		\$root/bin
EOL

