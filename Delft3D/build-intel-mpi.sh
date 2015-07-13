#!/bin/bash

DELFT_REV=$(svn info | grep "Revision" | awk '{print $2}')
MODULE_FILE=/projects/uoa00035/privatemodules/Delft3D/$DELFT_REV-intel-mpi
mkdir -p /projects/uoa00035/privatemodules/Delft3D
INSTALL_DIR=/projects/uoa00035/local/Delft3D/$DELFT_REV-intel-mpi

rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR

module purge
module load NetCDF/4.3.3.1-intel-mpi

export CC=$EBROOTICC/bin/icc
export FC=$EBROOTIFORT/bin/ifort
export F77=$EBROOTIFORT/bin/ifort
export CXX=$EBROOTICC/bin/icpc
export MPICCXX=$EBROOTIMPI/bin64/mpiicpc
export MPIFC=$EBROOTIMPI/bin64/mpiifort
export MPIF77=$EBROOTIMPI/bin64/mpiifort
export CFLAGS='-O2'
export CXXFLAGS='-O2'
export FCFLAGS='-O2'
export FCFLAGS='-O2'

#export AM_FFLAGS='-lifcoremt'
#export AM_FCFLAGS='-lifcoremt'
#export AM_LDFLAGS='-lifcoremt'
#export LIBS="-lfmpich -lmpich $LIBS"
#export LDFLAGS="-L/usr/lib64 $LDFLAGS"
#export LIBS="-lpmi $LIBS"

./clean.sh
./autogen.sh
./configure --prefix=$INSTALL_DIR --with-mpi --with-netcdf | tee configure-intel.log
make ds-install | tee make-intel.log

cat > $MODULE_FILE <<EOL
#%Module

proc ModulesHelp { } {
    puts stderr {   Delft3D is a world leading 3D modeling suite to investigate hydrodynamics, sediment transport and morphology and water quality for fluvial, estuarine and coastal environments. - Homepage: http://oss.deltares.nl/web/delft3d
    }
}

module-whatis {Description: Delft3D is a world leading 3D modeling suite to investigate hydrodynamics, sediment transport and morphology and water quality for fluvial, estuarine and coastal environments. - Homepage: http://oss.deltares.nl/web/delft3d
}

set root	$INSTALL_DIR 

conflict Delft3D

if { ![is-loaded NetCDF/4.3.3.1-intel-mpi] } {
    module load NetCDF/4.3.3.1-intel-mpi
}

prepend-path	CPATH		\$root/include
prepend-path	LD_LIBRARY_PATH		\$root/lib
prepend-path	LIBRARY_PATH		\$root/lib
prepend-path	MANPATH		\$root/share/man
prepend-path	PKG_CONFIG_PATH		\$root/lib/pkgconfig
prepend-path	PATH		\$root/bin
prepend-path	PATH		\$root/lnx/flow2d3d/bin
prepend-path	PATH		\$root/lnx/menu/bin
prepend-path	PATH		\$root/lnx/part/bin
prepend-path	PATH		\$root/lnx/plugins/bin
prepend-path	PATH		\$root/lnx/swan/bin
prepend-path	PATH		\$root/lnx/swan/scripts
prepend-path	PATH		\$root/lnx/util/bin
prepend-path	PATH		\$root/lnx/waq/bin
prepend-path	PATH		\$root/lnx/wave/bin


setenv	DELFT3DROOT		\$root
EOL
