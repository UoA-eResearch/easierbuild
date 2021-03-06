#!/bin/bash

module purge
module load NetCDF/4.3.3.1-intel-2015a

# fix calls to mpiexec in test suite
sed -i.bak 's/mpiexec /mpiexec.hydra /g' f03_test/run_f77_par_test.sh
sed -i.bak 's/mpiexec /mpiexec.hydra /g' nf_test/run_f90_par_test.sh
sed -i.bak 's/mpiexec /mpiexec.hydra /g' nf_test/run_f77_par_test.sh

unset I_MPI_PMI_LIBRARY
CC=$EBROOTIMPI/bin64/mpiicc FC=$EBROOTIMPI/bin64/mpiifort F77=$EBROOTIMPI/bin64/mpiifort ./configure --prefix=$NETCDFROOT --enable-parallel-tests
make clean
make check && make install

