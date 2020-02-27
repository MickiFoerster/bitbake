#!/bin/bash

function fetch {
    dir=$1
    url=$2
    if [ -n ${dir} -a ! -d ${dir} ]; then
        git clone --branch=master ${url}
    fi
}

fetch openembedded-core "https://github.com/openembedded/openembedded-core.git"
fetch bitbake "http://git.openembedded.org/bitbake/"

export PATH=$PWD/bitbake/bin:$PATH
export BUILD_PATH=${PWD}/build
export BITBAKE_PATH=${PWD}/bitbake
export OE_PATH=${PWD}/openembedded-core

# create build folder and configuration folder
if [ ! -d build ];then mkdir build;fi
if [ ! -d build/conf ];then mkdir build/conf;fi

openssh_recipe=$(find $PWD/openembedded-core -name "openssh*.bb" | head -n 1)

# create bblayers.conf
# BBLAYERS = " ${OE_PATH}/meta "
cat <<EOF >build/conf/bblayers.conf
BBPATH = "${BUILD_PATH}:${BITBAKE_PATH}:${OE_PATH}/meta"
BBFILES = "${openssh_recipe}"
EOF

export BBPATH=${BUILD_PATH}
cd ${BBPATH} && bitbake openssh
