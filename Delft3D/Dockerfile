FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
  autoconf \
  libtool \
  libtool-bin \
  libltdl-dev \
  libltdl7 \
  libcurl4-openssl-dev \
  flex \
  g++ \
  gfortran \
  libstdc++6 \
  byacc \
  libexpat1-dev \
  uuid-dev \
  ruby \
  build-essential \
  wget \
  pkg-config \
  subversion \
  git \
  cmake \
  vim

# build dependencies
RUN mkdir /download
WORKDIR /download

# zlib
ENV v=1.2.8
RUN wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/zlib-${v}.tar.gz \
    && tar -xf zlib-${v}.tar.gz \
    && cd zlib-${v} \
    && ./configure --prefix=/usr/local \
    && make install \
    && rm -rf /download/*

# hdf5
ENV v=1.8.13
ENV HDF5_DIR="/usr/local/hdf5-${v}"
RUN wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-${v}.tar.gz \
    && tar -xf hdf5-${v}.tar.gz \
    && cd hdf5-${v} \
    && ./configure --enable-shared --enable-hl --prefix=$HDF5_DIR \
    && make -j 2 \
    && make install \
    && rm -rf /download/*

# netcdf
ENV v=4.6.1
ENV NETCDF_DIR="/usr/local/netcdf-${v}"
RUN wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-${v}.tar.gz \
    && tar -xf netcdf-${v}.tar.gz && cd netcdf-${v} \
    && CPPFLAGS=-I$HDF5_DIR/include LDFLAGS=-L$HDF5_DIR/lib ./configure --enable-netcdf-4 --enable-shared --enable-dap --prefix=$NETCDF_DIR \
    && make \
    && make install \
    && rm -rf /download/*

ENV PATH=$PATH:$NETCDF_DIR/bin
ENV LD_LIBRARY_PATH=$NETCDF_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$NETCDF_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# netcdf fortran
ENV v=4.4.5
ENV NETCDF_FORTRAN_DIR="/usr/local/netcdf-fortran-${v}"
RUN wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-${v}.tar.gz \
    && tar -xf netcdf-fortran-${v}.tar.gz \
    && cd netcdf-fortran-${v} \
    && CPPFLAGS=-I$NETCDF_DIR/include LDFLAGS=-L$NETCDF_DIR/lib LD_LIBRARY_PATH=$NETCDF_DIR/lib:$LD_LIBRARY_PATH ./configure --prefix=$NETCDF_FORTRAN_DIR \
    && make \
    && make install \
    && rm -rf /download/*

ENV PATH=$PATH:$NETCDF_FORTRAN_DIR/bin
ENV LD_LIBRARY_PATH=$NETCDF_FORTRAN_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$NETCDF_FORTRAN_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# mpi
ENV v=3.1.2
ENV MPICH2_DIR="/usr/local/mpich-${v}"
RUN wget http://www.mpich.org/static/downloads/${v}/mpich-${v}.tar.gz \
    && tar -xzf mpich-${v}.tar.gz \
    && cd mpich-${v} \
    && ./configure --prefix=$MPICH2_DIR \
    && make \
    && make install \
    && rm -rf /download/*

ENV PATH=$PATH:$MPICH2_DIR/bin
ENV LD_LIBRARY_PATH=$MPICH2_DIR/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=$MPICH2_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# metis
ENV v=5.1.0
ENV METIS_DIR="/usr/local/METIS-${v}"
RUN wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-${v}.tar.gz \
    && tar -xzf metis-${v}.tar.gz \
    && cd metis-${v} \
    && make config shared=1 prefix=$METIS_DIR \
    && make install \
    && rm -rf /download/*

ENV PATH=$PATH:$METIS_DIR/bin
ENV LD_LIBRARY_PATH=$METIS_DIR/lib:$LD_LIBRARY_PATH

# delft3d
ADD 68819 /download/delft3d
ENV v=68819

WORKDIR /download/delft3d/src
ENV DELFT3D_DIR="/usr/local/delft3d-${v}"
RUN cp third_party_open/swan/src/*.f* third_party_open/swan/swan_mpi \
    && cp third_party_open/swan/src/*.F* third_party_open/swan/swan_mpi \
    && cp third_party_open/swan/src/*.f* third_party_open/swan/swan_omp \
    && cp third_party_open/swan/src/*.F* third_party_open/swan/swan_omp \
    && ./autogen.sh \
    && cd third_party_open/kdtree2 \
    && ./autogen.sh

RUN CFLAGS='-O2' CXXFLAGS='-O2' FFLAGS='-O2' FCFLAGS='-O2' ./configure --prefix=$DELFT3D_DIR --with-netcdf --with-mpi --with-metis=$METIS_DIR \
    && FC=mpif90 make ds-install \
    && FC=mpif90 make ds-install -C engines_gpl/dflowfm \
    && rm -rf /download/*

ENV PATH=$PATH:$DELFT3D_DIR/bin
ENV LD_LIBRARY_PATH=$DELFT3D_DIR/lib:$LD_LIBRARY_PATH

# cleanup
WORKDIR /
RUN rm -rf /download

# prepare for work
RUN mkdir /job
WORKDIR /job
