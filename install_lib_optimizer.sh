#!/usr/bin/env bash

# Environment for Install COIN-OR and GLPK
export COIN_INSTALL_DIR=/usr/local/src/Cbc-2.8.9
export LD_LIBRARY_PATH="/usr/local/src/Cbc-2.8.9/lib:$LD_LIBRARY_PATH"
export GLPK_LIB_DIR=/usr/local/lib
export GLPK_INC_DIR=/usr/local/include
export BUILD_GLPK=1

sudo -s -- <<EOF

# COIN-OR CBC (required for CyLP)
mkdir -p /usr/local/src
cd /usr/local/src
wget https://www.coin-or.org/download/source/Cbc/Cbc-2.8.9.tgz
tar -xzvf Cbc-2.8.9.tgz
cd Cbc-2.8.9
./configure
make
make install
make clean

# GLPK
mkdir -p /usr/local/src
cd /usr/local/src
wget ftp://ftp.gnu.org/gnu/glpk/glpk-4.62.tar.gz
tar -xzvf glpk-4.62.tar.gz
cd glpk-4.62
./configure
make
make install
make clean

EOF
