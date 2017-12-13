
# Storage Engines
https://dev.mysql.com/doc/refman/5.7/en/storage-engines.html  
Compare: Table 15.1 Storage Engines Feature Summary

Feature	MyISAM	Memory	InnoDB	Archive	NDB
Storage limits	256TB	RAM	64TB	None	384EB
Transactions	No	No	Yes	No	Yes
Locking granularity	Table	Table	Row	Row	Row
MVCC	No	No	Yes	No	No
Geospatial data type support	Yes	No	Yes	Yes	Yes
Geospatial indexing support	Yes	No	Yes[a]	No	No
B-tree indexes	Yes	Yes	Yes	No	No
T-tree indexes	No	No	No	No	Yes
Hash indexes	No	Yes	No[b]	No	Yes
Full-text search indexes	Yes	No	Yes[c]	No	No
Clustered indexes	No	No	Yes	No	No
Data caches	No	N/A	Yes	No	Yes
Index caches	Yes	N/A	Yes	No	Yes
Compressed data	Yes[d]	No	Yes[e]	Yes	No
Encrypted data[f]	Yes	Yes	Yes	Yes	Yes
Cluster database support	No	No	No	No	Yes
Replication support[g]	Yes	Limited[h]	Yes	Yes	Yes
Foreign key support	No	No	Yes	No	Yes[i]
Backup / point-in-time recovery[j]	Yes	Yes	Yes	Yes	Yes
Query cache support	Yes	Yes	Yes	Yes	Yes
Update statistics for data dictionary	Yes	Yes	Yes	Yes	Yes

    CREATE TABLE t1 (i INT) ENGINE = INNODB;

    InnoDB: default in MySQL 5.7. 
        transaction-safe (ACID compliant)：commit, rollback, and crash-recovery
        row-level locking (without escalation to coarser granularity locks) 
        Oracle-style consistent nonlocking reads
        clustered indexes to reduce I/O for common queries based on primary keys
        FOREIGN KEY referential-integrity constraints
    MyISAM: 
        Table-level locking. 
        often used in read-only or read-mostly workloads.
    Merge: 
        logically group a series of identical MyISAM tables and reference them as one object.     
    Memory or HEAP:
        Its use cases are decreasing:
            InnoDB with its buffer pool memory area
            NDBCLUSTER provides fast key-value lookups for huge distributed data sets
    NDB or NDBCLUSTER: highest possible degree of uptime and availability.
    Federated: link separate MySQL servers to create one logical database
    CSV: Its tables are really text files with comma-separated values.
    Archive: compact, unindexed tables
    Blackhole: 
        not store data, Queries always return an empty set. 
        can be used in replication configurations
    Example: illustrates how to begin writing new storage engines.

# JSON
## MySQL 5.7+
https://dev.mysql.com/doc/refman/5.7/en/json.html

    CREATE TABLE t1 (jdoc JSON);
    INSERT INTO t1 VALUES('{"key1": "value1", "key2": "value2"}');

    SELECT JSON_ARRAY('a', 1, NOW());
    SELECT JSON_OBJECT('key1', 1, 'key2', 'abc');
    SELECT JSON_MERGE('["a", 1]', '{"key": "value"}');

    SET @j = JSON_OBJECT('key', 'value');
    SELECT @j;

    # escape quote character
    '{"mascot": "... \\"Sakila\\"."}'
    JSON_OBJECT("mascot", "... \"Sakila\".")
    JSON_OBJECT('mascot', '... "Sakila".')    # NO_BACKSLASH_ESCAPES

    # JSON values is case sensitive
    SELECT CAST('null' AS JSON); # `null`, `true`, and `false` always lowercase

    SELECT col->"$.mascot" FROM qtest;          # "... \"Sakila\"."
    SELECT sentence->>"$.mascot" FROM facts;    # ... "Sakila".

    ORDER BY CAST(JSON_EXTRACT(jdoc, '$.id') AS UNSIGNED)

## MariaDB 10.2+

https://mariadb.com/resources/blog/json-mariadb-102

    CREATE TABLE products(id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(9,2) NOT NULL,
    stock INTEGER NOT NULL,
    attr VARCHAR(1024),
    CHECK (attr IS NULL OR JSON_VALID(attr)));

    INSERT INTO products VALUES(NULL, 'Blouse', 17, 15, '{"colour": "white"}');
    UPDATE products SET attr = JSON_REPLACE(attr, '$.colour', 'red') WHERE name = 'Blouse';

    ALTER TABLE products ADD attr_colour VARCHAR(32) AS (JSON_VALUE(attr, '$.colour'));

    CREATE INDEX products_attr_colour_ix ON products(attr_colour);
    EXPLAIN SELECT * FROM products WHERE attr_colour = 'white';     # verify index