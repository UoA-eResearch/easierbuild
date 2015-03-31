#!/bin/bash

# Build scipion

# Start building sciption. It fails when it tries to install matplotlib
./build_scipion.sh

# Build matplotlib
./fix_maplotlib.sh

# Continue building scipion
./build_scipion2.sh

