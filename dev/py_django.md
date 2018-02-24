<!-- TOC -->

- [data](#data)
- [init](#init)
- [Demo](#demo)

<!-- /TOC -->

# data
    ./manage.py dumpdata > db.json
    ./manage.py dumpdata app_name[.table_name] --indent 2 --exclude ... > ...
    ./manage.py loaddata foo.json
    ./manage.py loaddata fixture_name  # app_name/fixtures/foo.json

# init
    ./manage.py makemigrations connection
    ./manage.py makemigrations
    ./manage.py migrate
    ./manage.py compilemessages
    ./manage.py shell < ./foo.py

static files not working when DEBUG=False

# Demo
A small project for testing django features: i18n/templates/admin/shell/fixture/signal/etc.  
https://github.com/fzinfz/tsadmin/commits/master