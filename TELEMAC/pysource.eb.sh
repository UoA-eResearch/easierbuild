
# load modules
module purge
module load HDF5/1.10.1-foss-2017b
module load MUMPS/5.1.2-foss-2017b-metis
module load SCOTCH/5.1.12b_esmumps-foss-2017b


# This file is a template for a Linux environment file
# running "source pysource.template.sh" will position all
# the necessary environment variables for telemac
# To adapt to your installation replace word <word> by their local value
###
### TELEMAC settings -----------------------------------------------------------
###
# Path to telemac root dir
export HOMETEL=/mnt/telemac/v8p1
# Adding python scripts to PATH
export PATH=$HOMETEL/scripts/python3:.:$PATH
# Configuration file
export SYSTELCFG=$HOMETEL/configs/systel.cis-eb.cfg
# Name of the configuration to use
export USETELCFG=foss2017b
# Path to this file
export SOURCEFILE=$HOMETEL/configs/pysource.eb.sh
### Python
# To force python to flush its output
export PYTHONUNBUFFERED='true'
### API
export PYTHONPATH=$HOMETEL/scripts/python3:$PYTHONPATH
export LD_LIBRARY_PATH=$HOMETEL/builds/$USETELCFG/wrap_api/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOMETEL/builds/$USETELCFG/wrap_api/lib:$PYTHONPATH
###
### COMPILERS -----------------------------------------------------------
###
# Here are a few examples for external libraries
#export SYSTEL=/data/projets/projets.002/systel.002

### MPI -----------------------------------------------------------
export MPIHOME=$EBROOTOPENMPI
#export PATH=$MPIHOME/bin:$PATH
#export LD_LIBRARY_PATH=$MPIHOME/lib:$LD_LIBRARY_PATH
###
### EXTERNAL LIBRARIES -----------------------------------------------------------
###
### HDF5 -----------------------------------------------------------
export HDF5HOME=$EBROOTHDF5
#export LD_LIBRARY_PATH=$HDF5HOME/lib:$LD_LIBRARY_PATH
#export LD_RUN_PATH=$HDF5HOME/lib:$MEDHOME/lib:$LD_RUN_PATH
### MED  -----------------------------------------------------------
#export MEDHOME=$SYSTEL/LIBRARY/med-3.2.0/arch/C9
#export LD_LIBRARY_PATH=$MEDHOME/lib:$LD_LIBRARY_PATH
#export PATH=$MEDHOME/bin:$PATH
### MUMPS -------------------------------------------------------------
export MUMPSHOME=$EBROOTMUMPS
#export SCALAPACKHOME=$SYSTEL/LIBRARY/scalapack/gnu
#export BLACSHOME=$SYSTEL/LIBRARY/blacs/gnu
### METIS -------------------------------------------------------------
export METISHOME=$EBROOTMETIS
#export LD_LIBRARY_PATH=$METISHOME/lib:$LD_LIBRARY_PATH
### SCOTCH ------------------------------------------------------------
export SCOTCHHOME=$EBROOTSCOTCH
