<!-- TOC -->

- [Info](#info)
- [pgadmin](#pgadmin)
- [Commands](#commands)
- [user](#user)

<!-- /TOC -->

# Info
    SELECT version();

https://www.postgresql.org/docs/current/static/runtime-config-file-locations.html

    SHOW config_file; 
    SHOW data_directory;

    SHOW hba_file; -- host-based authentication 
        -- https://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html

    SHOW ident_file;
    SHOW external_pid_file;

# pgadmin

    docker run -p 80:80 \
    -e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
    -e "PGADMIN_DEFAULT_PASSWORD=SuperSecret" \
    -d dpage/pgadmin4

# Commands
https://www.postgresql.org/docs/current/static/app-psql.html

# user

    SELECT usename FROM pg_user;
    CREATE USER fzinfz;
    \password fzinfz
    ALTER USER fzinfz WITH SUPERUSER;
    \du 'list user/role
