cd /D %~dp0

set BUILD_GLPK=1

call activate vopt

conda install --yes --quiet ^
anaconda constantly coverage ecos django=1.10 flask gevent greenlet hyperlink incremental krb5 markdown psycopg2 sphinx_rtd_theme twisted && ^
conda install --yes --quiet cvxopt && ^
conda install --yes --quiet -c conda-forge fabric3 && ^
pip install ^
awscli coreapi cvxpy django-crispy-forms django-filter django-guardian django-jinja djangorestframework ^
eve flask-restplus flask-security flask_sqlalchemy json-rpc SQLAlchemy-Continuum tushare && ^
pip install py3_ortools-6.4.4495-cp35-cp35m-win_amd64.whl && ^
call deactivate
cmd.exe /K
