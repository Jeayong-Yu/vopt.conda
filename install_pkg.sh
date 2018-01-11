#!/usr/bin/env bash

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

echo "Python package installing..."
source activate vopt

echo "Common Anaconda Packages:" && \
conda install --yes --quiet -c anaconda \
anaconda alembic beautifulsoup4 constantly coverage cvxcanon cvxopt django ecos flask \
gevent greenlet hyperlink incremental ipyparallel krb5 \
matplotlib markdown nose pymongo psycopg2 requests scikit-learn scrapy seaborn simplejson sphinx sphinx_rtd_theme \
toolz twisted werkzeug \
&& \
echo "Common Anaconda Packages in Conda-Forge:" && \
conda install --yes --quiet -c conda-forge \
awscli fabric3 fastparquet feather-format glpk jupyter_nbextensions_configurator \
multiprocess pyarrow \
&& \
echo "Linux/OSX Anaconda Packages:" &&  \
conda install --yes --quiet \
gunicorn \
&& \
echo "Linux/OSX Anaconda Packages in Conda-Forge:" && \
conda install --yes --quiet -c conda-forge \
coincbc pudb uwsgi \
&& \
echo "Common pip Packages:" && \
pip install \
autopep8 awscli coreapi cvxpy django-crispy-forms django-filter django-guardian \
django-jinja djangorestframework \
eve flask-restplus flask-security flask_sqlalchemy json-rpc nbsphinx \
SQLAlchemy-Continuum tushare \
&& \
echo "Jupyter notebook setting:" && \
ipcluster nbextension enable --user && \
jupyter nbextensions_configurator enable --user && \

echo "CyLP package for Python3 installing..." && \
pip install git+https://github.com/VeranosTech/CyLP.git@py3

source deactivate
