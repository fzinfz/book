<!-- TOC -->

- [data](#data)
- [init](#init)

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