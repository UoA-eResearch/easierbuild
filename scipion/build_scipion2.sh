#!/bin/bash

src=scipion

unset PYTHONPATH
module load Python/2.7.8-goolf-1.5.14
module load Xmipp/3.1-goolf-1.5.14
module load Java/1.8.0_5

cd ${src}
./scipion install --with-xmipp=$XMIPP_HOME 

