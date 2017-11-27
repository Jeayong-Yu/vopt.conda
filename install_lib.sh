#!/usr/bin/env bash

case `uname` in

  Linux)
    if type lsb_release >/dev/null 2>&1; then
      OS=$(lsb_release -si)
      VER=$(lsb_release -sr)

      if [ "$OS" == "Ubuntu" ] && [ "$VER" == "16.04" ]; then
        sudo apt-get update -y -q && \
        sudo apt-get upgrade -y -q && \
        sudo apt-get install -y -q \
        apt-file gdebi-core software-properties-common pkg-config \
        sudo man htop ncdu dos2unix \
        ed emacs24 vim tmux screen zip unzip bzip2 git mercurial subversion curl wget \
        net-tools openssl apparmor \
        build-essential autoconf automake cmake make gfortran gettext libtool swig uuid-dev \
        default-jre default-jdk \
        nginx memcached openssh-server postgresql postgresql-contrib rsyslog supervisor \
        libatlas-base-dev libboost-all-dev libclang1 libclang-dev libgflags-dev libgtest-dev \
        libcurl4-gnutls-dev libspatialindex-dev libgeos-dev libgdal-dev \
        libgoogle-glog-dev libprotobuf-dev protobuf-compiler libiomp-dev libleveldb-dev \
        liblmdb-dev libjpeg-dev libpq-dev libpgm-dev libpng-dev libpng12-dev libpng++-dev libopencv-dev \
        libtiff5-dev libevent-dev libapparmor1 libssh2-1-dev libssl-dev libgl1-mesa-glx \
        coinor-clp coinor-libclp-dev coinor-cbc coinor-csdp coinor-libcbc-dev coinor-libcoinmp-dev \
        coinor-libcgl-dev coinor-libdylp-dev coinor-libflopc++-dev coinor-libipopt-dev \
        coinor-libosi-dev coinor-libsymphony-dev coinor-libvol-dev coinor-libcoinutils-dev \
        && sudo apt-get -y -q autoremove \
        && sudo apt-get -y -q clean

      else
          echo "Error! Support Ubuntu only."
          return
      fi

    else
       echo "Error! Cannot find linux version."
       return
    fi
    ;;

  Darwin)
     echo "Mac OS X."
     export MACOSX_DEPLOYMENT_TARGET=10.10
     ;;

  *)
     echo "Error! Unsupported OS."
     return
     ;;

esac


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
