<!-- TOC -->

- [Info](#info)
- [pgadmin](#pgadmin)
- [Commands](#commands)
- [user](#user)
- [db](#db)
- [timescale](#timescale)

<!-- /TOC -->

# Info
    SELECT version();
    SELECT now();

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

# timescale
http://docs.timescale.com/v0.8/getting-started/creating-hypertables

    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;

    SELECT create_hypertable('conditions', 'time');
    -- backgroud:
    CREATE INDEX conditions_time_idx
        ON public.conditions USING btree
        ("time" DESC)
        TABLESPACE pg_default;

    -- additionally partition the data on another
    --   dimension (what we call 'space partitioning').
    -- E.g., to partition `location` into 4 partitions:
    SELECT create_hypertable('conditions', 'time', 'location', 4);

    SELECT time_bucket('5 minutes', time) AS time_range,
        location, COUNT(*),
        MAX(temperature) AS max_temp,
        MAX(humidity) AS max_hum
    FROM conditions
    WHERE time > NOW() - interval '3 hours'
    GROUP BY time_range, location
    ORDER BY time_range DESC, max_temp DESC;

        time_range       | location | count | max_temp | max_hum 
    ------------------------+----------+-------+----------+---------
    2018-02-23 17:00:00+00 | office   |     3 |       70 |      50
    2018-02-23 16:35:00+00 | garage   |     1 |       77 |    65.2
    2018-02-23 16:35:00+00 | office   |     2 |     70.1 |    50.1
    2018-02-23 16:35:00+00 | basement |     1 |     66.5 |      60
    2018-02-23 16:25:00+00 | office   |     1 |       70 |      50
    (5 rows)
