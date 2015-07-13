easierbuild
===========

Build scripts and instructions for software on the NeSI Auckland cluster that is too hard to build with easybuild.

# General notes

## Private Modules

Private modules are useful for custom software builds and when admin privileges do not allow global installs. They can be setup in a project or home dir e.g:

`/projects/uoa00035/privatemodules/HDF5/1.8.15-intel-2015a`

To use modules in this location, execute `module use /projects/uoa00035/privatemodules`
This is best placed in the ~/.bashrc

## Building and testing with Intel

Building binaries is pretty straight forward, just load the appropriate Intel module and set the compiler flag e.g:

```bash
module load intel/2015a
export CC=$EBROOTICC/bin/icc
export CXX=$EBROOTICC/bin/icpc
export FC=$EBROOTIFORT/bin/ifort
export F77=$EBROOTIFORT/bin/ifort

./configure --prefix=/install/path
make
```

If you have MPI code to build, generally you would do something like this:

```bash
module load intel/2015a
export CC=$EBROOTIMPI/bin64/mpiicc
export MPICC=$EBROOTIMPI/bin64/mpiicc
export CXX=$EBROOTIMPI/bin64/mpiicpc
export MPICXX=$EBROOTIMPI/bin64/mpiicpc
export FC=$EBROOTIMPI/bin64/mpiifort
export F77=$EBROOTIMPI/bin64/mpiifort

./configure --prefix=/install/path
make

```

If you want to test Intel build MPI code, e.g if one of the make targets is 'check' you may encounter a problem with running mpiexec/mpirun, e.g:
```bash
... cannot connect to local mpd ...
1. no mpd is running on this host
2. an mpd is running but was started without a "console" (-n option)
```

This is because Intel MPI is not built against SLURM, so to make it work we need to reference mpiexec.hydra which is in $EBROOTIMPI/bin64.

So have a look to see where mpiexec/mpirun is being referenced and replace with mpiexec.hydra.

Then use an interactive session:

salloc -A uoa00035 --ntasks=8 -C avx --time=5:00:00

Next unset I_MPI_PMI_LIBRARY as this may cause some conflicts in access the correct MPI environment.

Now run the make check and hopefully it should work.
