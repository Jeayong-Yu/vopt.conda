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

echo "Anaconda Packages:" && \
conda install --yes --quiet -c anaconda \
    alembic \
    anaconda \
    beautifulsoup4 \
    constantly \
    coverage \
    cvxcanon \
    cvxopt \
    cython \
    django \
    ecos \
    fastcache \
    flask \
    gevent \
    greenlet \
    gunicorn \
    hyperlink \
    incremental \
    ipyparallel \
    jinja2 \
    krb5 \
    line_profiler \
    lxml \
    markdown \
    matplotlib \
    nose \
    notebook \
    psycopg2 \
    pycodestyle \
    pymongo \
    requests \
    scikit-learn \
    scrapy \
    seaborn \
    simplejson \
    sphinx \
    sphinx_rtd_theme \
    sqlalchemy \
    toolz \
    twisted \
    werkzeug \
    && \
echo "Anaconda Packages in Conda-Forge:" && \
conda install --yes --quiet -c conda-forge \
    aniso8601 \
    autopep8 \
    awscli \
    cerberus \
    coincbc \
    django-crispy-forms \
    django-filter \
    django-guardian \
    djangorestframework \
    events \
    fabric3 \
    fastparquet \
    feather-format \
    flask-restplus \
    flask-security \
    glpk \
    json-rpc \
    jupyter_nbextensions_configurator \
    multiprocess \
    nbsphinx \
    pep8-naming \
    pudb \
    pyarrow \
    uritemplate \
    uwsgi \
    && \
echo "Pip Packages:" && \
pip install \
    cvxpy \
    django-jinja \
    fake-useragent \
    flask_sqlalchemy \
    git+https://github.com/scrapy/scrapyd-client \
    scrapyd \
    scs \
    tushare \
    && \
echo "Jupyter notebook setting:" && \
ipcluster nbextension enable --user && \
jupyter nbextensions_configurator enable --user && \

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
  echo "CyLP package for Python3 installing fro Github..." && \
  pip install git+https://github.com/VeranosTech/CyLP.git@py3
fi
source deactivate
