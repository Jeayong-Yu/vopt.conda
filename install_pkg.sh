#!/usr/bin/env bash

if [[ "$#" -eq "0" ]]; then
  OFFLINE=""
  echo "Set online install mode."
else
  while true; do
      [ $# -eq 0 ] && break
      case $1 in
          --offline)
              shift
              OFFLINE="--offline"
              echo "Set offline install mode."
      esac
  done
fi

case `uname` in
    Linux)
        pkgs_conda="pkgs_conda_linux.txt"
        ;;
    Darwin)
        pkgs_conda="pkgs_conda_macos.txt"
        ;;
    *)
        echo "Error! Unsupported OS."
        return
        ;;
esac

# environment variables
export MACOSX_DEPLOYMENT_TARGET=10.10

export PKG_CONFIG_PATH=$HOME/anaconda3/envs/vopt/lib/pkgconfig/
export LD_LIBRARY_PATH=$HOME/anaconda3/envs/vopt/lib:$LD_LIBRARY_PATH

export COIN_INSTALL_DIR=$HOME/anaconda3/envs/vopt/
export COIN_LIB_DIR=$HOME/anaconda3/envs/vopt/lib/
export COIN_INC_DIR=$HOME/anaconda3/envs/vopt/include/coin/
export CYLP_USE_CYTHON=TRUE

export GLPK_LIB_DIR=$HOME/anaconda3/envs/vopt/
export GLPK_INC_DIR=$HOME/anaconda3/envs/vopt/include
export BUILD_GLPK=1

echo "Activate vopt environment..."
source activate vopt

if [ ! -z "$OFFLINE" ]; then
  echo "Clean conda cache..."
  rm -Rf `ls -1 -d ./pkgs/*/`

  echo "Change conda config..."
  conda config --prepend pkgs_dirs ./pkgs
  echo $(conda config --show pkgs_dirs)

  echo "Merging large file..."
  find ./pkgs -type f -name *tar.bz2.aa | sed -e 's/tar.bz2.aa/tar.bz2/g' | while read file; do
      cat ${file}.* > ${file}
      rm ${file}.*
  done

  echo "Updating pip (offline)..."
  pip install --no-deps --no-index --find-links ./pkgs_pip --upgrade pip
else
  echo "Updating pip (online)..."
  pip install --upgrade --no-deps pip
fi

echo "Updating Anaconda conda..."
conda update -n base --yes --verbose conda  ${OFFLINE}

echo "Installing Anaconda Packages..."
cat $pkgs_conda | paste -sd " " - | xargs conda install --channel anaconda --copy --yes --verbose ${OFFLINE}

echo "Installing Conda-Forge Packages..."
cat pkgs_conda-forge.txt | paste -sd " " - | xargs conda install --channel conda-forge --copy --yes --verbose ${OFFLINE}

if [ ! -z "$OFFLINE" ]; then
  echo "Recover conda config..."
  conda config --remove pkgs_dirs ./pkgs
  echo $(conda config --show pkgs_dirs)

  echo "Installing Pip Packages (offline)..."
  cat pkgs_pip.txt | paste -sd " " - | xargs pip install --no-deps --no-index --find-links ./pkgs_pip
else
  echo "Installing Pip Packages (online)..."
  cat pkgs_pip.txt | paste -sd " " - | xargs pip install --no-deps
fi

echo "Jupyter notebook setting..."

jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user

jupyter nbextension install --user --py ipyparallel
jupyter nbextension enable --user --py ipyparallel
jupyter serverextension enable --user --py ipyparallel
ipcluster nbextension enable --user

jupyter nbextension disable --user --py nbpresent
jupyter serverextension disable --user --py nbpresent


if [[ -v CYLP_SRC_DIR ]]; then
  if [ -d "$CYLP_SRC_DIR" ]; then
    echo "CyLP package for Python3 Develop Mode installing from local: $CYLP_SRC_DIR" && \
    curdir=$PWD &&
    cd "$CYLP_SRC_DIR" && \
    python setup.py develop && \
    cd $curdir
  else
    echo "$CYLP_SRC_DIR not exist!. stop."
    return
  fi
else
  if [ ! -z "$OFFLINE" ]; then
    echo "CyLP package for Python3 installing (offline mode)..."
    pip install pkgs_pip/cylp.zip
  else
    echo "CyLP package for Python3 installing from Github..."
    pip install git+https://github.com/VeranosTech/CyLP.git@py3
  fi
fi

echo "Deactivate vopt environment..."
source deactivate
