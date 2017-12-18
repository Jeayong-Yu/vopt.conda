#!/usr/bin/env bash

# set environment
export COIN_INSTALL_DIR=~/anaconda3/envs/vopt/
export LD_LIBRARY_PATH="~/anaconda3/envs/vopt/lib:$LD_LIBRARY_PATH"
export MACOSX_DEPLOYMENT_TARGET=10.10

echo "Python package installing..."
source activate vopt && \
conda install --yes --quiet \
anaconda alembic constantly coverage ecos django=1.10 flask gevent greenlet hyperlink incremental ipyparallel krb5 \
markdown psycopg2 scrapy sphinx_rtd_theme twisted && \
conda install --yes --quiet -c conda-forge coincbc fabric3 fastparquet feather-format jupyter_nbextensions_configurator pyarrow && \
conda update --yes --quiet libgcc && \
pip install \
gunicorn pudb uwsgi \
&& \
pip install \
autopep8 awscli coreapi cvxopt cvxpy django-crispy-forms django-filter django-guardian django-jinja djangorestframework \
eve flask-restplus flask-security flask_sqlalchemy json-rpc nbsphinx SQLAlchemy-Continuum tushare \
&& \
ipcluster nbextension enable && \
jupyter nbextensions_configurator enable --user && \
echo

echo "CyLP package for Python3 installing..."
pip install git+https://github.com/VeranosTech/CyLP.git@py3

case `uname` in

  Linux)
    if type lsb_release >/dev/null 2>&1; then
      OS=$(lsb_release -si)
      VER=$(lsb_release -sr)

      if [ "$OS" == "Ubuntu" ] && [ "$VER" == "16.04" ]; then
	  pip install py3_ortools-6.4.4495-cp35-cp35m-manylinux1_x86_64.whl
	  return
      else
          echo "Error! Support Ubuntu 16.04 only."
          return
      fi

    else
       echo "Error! Cannot find linux version."
       return
    fi
    ;;

  Darwin)
     pip install py3_ortools-6.4.4495-cp35-cp35m-macosx_10_6_intel.whl
     return
     ;;

  *)
     echo "Error! Unsupported OS."
     return
     ;;

esac

source deactivate
