#!/bin/bash
#SBATCH -J Te_Puru_Run_08_grid3
#SBATCH -A uoa00035 # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --ntasks=32          # number of tasks
#SBATCH --tasks-per-node=16 # WARNING: 8 tasks per node is horrifically bad
#SBATCH --mem-per-cpu=2048   # memory/cpu (in MB)
#SBATCH -C sb
#SBATCH -e stderr.txt
#SBATCH -o stdout.txt

ml Delft3D/5128-intel-mpi

unset I_MPI_PMI_LIBRARY #required

mpiexec.hydra d_hydro.exe config_d_hydro.xml


