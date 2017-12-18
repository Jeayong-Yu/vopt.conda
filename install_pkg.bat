cd /D %~dp0

# set environment
set CYLP_USE_CYTHON=TRUE
set COIN_INSTALL_DIR=~/anaconda3/envs/vopt/
set LD_LIBRARY_PATH="~/anaconda3/envs/vopt/lib:$LD_LIBRARY_PATH"
set GLPK_LIB_DIR=~/anaconda3/envs/vopt/
set GLPK_INC_DIR=~/anaconda3/envs/vopt/include
set BUILD_GLPK=1

call activate vopt
conda install --yes --quiet ^
anaconda alembic constantly coverage ecos django flask gevent greenlet hyperlink incremental ipyparallel krb5 ^
markdown psycopg2 scrapy sphinx_rtd_theme twisted && ^
conda install --yes --quiet cvxopt && ^
conda install --yes --quiet -c conda-forge fabric3 jupyter_nbextensions_configurator && ^
pip install ^
autopep8 awscli coreapi cvxpy django-crispy-forms django-filter django-guardian django-jinja djangorestframework ^
eve flask-restplus flask-security flask_sqlalchemy json-rpc nbsphinx SQLAlchemy-Continuum tushare ^
ipcluster nbextension enable && ^
jupyter nbextensions_configurator enable --user && ^
pip install git+https://github.com/VeranosTech/CyLP.git@py3 ^
call deactivate
cmd.exe /K
