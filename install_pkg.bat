cd /D %~dp0

# set environment
set GLPK_LIB_DIR=C:\Anaconda3\envs\vopt\Library\lib
set GLPK_INC_DIR=C:\Anaconda3\envs\vopt\Library\include
set BUILD_GLPK=1

call activate vopt
conda install --yes --quiet ^
anaconda alembic beautifulsoup4 constantly coverage cvxcanon cvxopt ecos django flask gevent greenlet hyperlink incremental ipyparallel krb5 \
markdown pymongo psycopg2 requests scrapy simplejson sphinx sphinx_rtd_theme toolz twisted werkzeug && ^
conda install --yes --quiet -c conda-forge fabric3 fastparquet feather-format glpk jupyter_nbextensions_configurator multiprocess pyarrow && ^
pip install ^
autopep8 awscli coreapi cvxpy django-crispy-forms django-filter django-guardian django-jinja djangorestframework ^
eve flask-restplus flask-security flask_sqlalchemy json-rpc nbsphinx SQLAlchemy-Continuum tushare ^
ipcluster nbextension enable --user && ^
jupyter nbextensions_configurator enable --user && ^
pip install git+https://github.com/VeranosTech/CyLP.git@py3 ^
call deactivate
cmd.exe /K
