#!/bin/bash
#SBATCH -J PROFILE
#SBATCH -A uoa00035 # Project Account
#SBATCH --time=1:00:00     # Walltime
#SBATCH --ntasks=48          # number of tasks
#SBATCH --tasks-per-node=16
#SBATCH --mem-per-cpu=2048   # memory/cpu (in MB)
#SBATCH -C ib
#SBATCH -e stderr.txt
#SBATCH -o stdout.txt

ml VTune/2015_update2
ml Delft3D/5128-intel-2015a
ml itac/9.0.3.051
source itacvars.sh impi5

unset I_MPI_PMI_LIBRARY #required

export I_MPI_FABRICS=shm:dapl
export I_MPI_FALLBACK=disable
export I_MPI_DAPL_UD=enable
export I_MPI_PIN_PROCESSOR_LIST="grain=cache2,shift=sock"
export I_MPI_WAIT_MODE=enable

#export I_MPI_DAPL_SCALABLE_PROGRESS=1 # Only useful for > 64 tasks

mpiexec.hydra -trace d_hydro.exe config_d_hydro.xml


