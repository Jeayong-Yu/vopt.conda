#!/usr/bin/env bash

# set environment
export MACOSX_DEPLOYMENT_TARGET=10.10
export CYLP_USE_CYTHON=TRUE
export COIN_INSTALL_DIR=~/anaconda3/envs/vopt/
export LD_LIBRARY_PATH="~/anaconda3/envs/vopt/lib:$LD_LIBRARY_PATH"
export GLPK_LIB_DIR=~/anaconda3/envs/vopt/
export GLPK_INC_DIR=~/anaconda3/envs/vopt/include
export BUILD_GLPK=1

echo "Python package installing..."
source activate vopt && \
conda install --yes --quiet \
anaconda alembic constantly coverage ecos django flask gevent greenlet hyperlink incremental ipyparallel krb5 \
markdown psycopg2 scrapy sphinx_rtd_theme twisted && \
conda install --yes --quiet -c conda-forge coincbc fabric3 fastparquet feather-format glpk jupyter_nbextensions_configurator pyarrow && \
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

source deactivate
