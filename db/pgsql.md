<!-- TOC -->

- [Info](#info)
- [Config](#config)
- [pgadmin](#pgadmin)
- [Commands](#commands)
- [user](#user)
- [db](#db)

<!-- /TOC -->

# Info
    SELECT version();
    SELECT now();

# Config
https://www.postgresql.org/docs/current/static/runtime-config-file-locations.html

    SHOW config_file;       -- /var/lib/postgresql/data/postgresql.conf
    SHOW data_directory;    -- /var/lib/postgresql/data
    SHOW hba_file;          -- /var/lib/postgresql/data/pg_hba.conf
        -- host-based authentication
        -- https://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html
    SHOW ident_file;        -- /var/lib/postgresql/data/pg_ident.conf
        -- user name mapping: SYSTEM-USERNAME PG-USERNAME
    SHOW external_pid_file;

# pgadmin

    docker run -p 80:80 \
    -e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
    -e "PGADMIN_DEFAULT_PASSWORD=SuperSecret" \
    -d dpage/pgadmin4

DB->'Schemas'->'public'->'Tables'->right click table->'View/Edit Data'->'All Rows'

# Commands
https://www.postgresql.org/docs/current/static/app-psql.html

# user

    SELECT usename FROM pg_user;
    CREATE USER fzinfz;
    \password fzinfz
    ALTER USER fzinfz WITH SUPERUSER;
    \du
        -- list user/role

# db

    CREATE database tutorial;
    \c tutorial
    psql -U postgres -h localhost -d tutorial