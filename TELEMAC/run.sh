#!/bin/bash

module purge
module load HDF5/1.10.1-foss-2017b
module load MUMPS/5.1.2-foss-2017b-metis
module load SCOTCH/5.1.12b_esmumps-foss-2017b

root=/mnt/telemac/v8p1/builds/foss2017b
export LD_LIBRARY_PATH=$root/lib:$LD_LIBRARY_PATH
export PATH=$root/bin:$PATH
