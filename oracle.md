<!-- TOC -->

- [Storage](#storage)
- [Tools](#tools)
- [User](#user)
- [Create Table](#create-table)
- [Create Procedure](#create-procedure)

<!-- /TOC -->

# Storage
https://docs.oracle.com/cloud/latest/db112/CNCPT/logical.htm#CNCPT3000  

![](https://docs.oracle.com/cloud/latest/db112/CNCPT/img/cncpt227.gif) 
![](https://docs.oracle.com/cloud/latest/db112/CNCPT/img/cncpt027.gif)

A `tablespace` is a logical storage container for segments. Segments are database objects, such as tables and indexes, that consume storage space.  
A `segment` is a set of extents allocated for a specific database object, such as a table. Each segment belongs to one and only one tablespace.  
An `extent` is a set of logically contiguous data blocks allocated for storing a specific type of information.  
One `logical data block` corresponds to a specific number of bytes of physical disk space, for example, 2 KB.

# Tools
http://www.oracle.com/technetwork/developer-tools/index.html

# User
    ALTER USER hr ACCOUNT UNLOCK;
    ALTER USER hr IDENTIFIED BY hr_password;

# Create Table
https://docs.oracle.com/cd/B28359_01/server.111/b28310/tables003.htm#ADMIN11004
![](https://docs.oracle.com/cd/B28359_01/server.111/b28286/img/create_table.gif) 


    CREATE TABLE "HR"."COUNTRIES" 
    (
    "COUNTRY_ID" CHAR(2 BYTE) 
        CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE, 

![](https://docs.oracle.com/cd/B19306_01/server.102/b14200/img/inline_constraint.gif)  
https://docs.oracle.com/cd/B19306_01/server.102/b14200/clauses002.htm

    "COUNTRY_NAME" VARCHAR2(40 BYTE), 
    "REGION_ID" NUMBER, 
        CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE, 
        CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")

![](https://docs.oracle.com/cd/B19306_01/server.102/b14200/img/out_of_line_constraint.gif)

        REFERENCES "HR"."REGIONS" ("REGION_ID") ENABLE

![](https://docs.oracle.com/cd/B19306_01/server.102/b14200/img/references_clause.gif)
![](https://docs.oracle.com/cd/B19306_01/server.102/b14200/img/constraint_state.gif)

    ) 
    ORGANIZATION INDEX -- index-organized table. 

ORGANIZATION: the order in which the data rows of the table are stored.
- HEAP: the data rows of table are stored in no particular order. This is the *default*.
- INDEX: table is created as an index-organized table. In an index-organized table, the data rows are held in an index defined on the primary key for the table.
- EXTERNAL: table is a read-only table located outside the database.

    NOCOMPRESS -- whether to compress data segments to reduce disk use
    PCTFREE 10 -- NOCOMPRESS use the PCTFREE default value of 10, to maximize compress while still allowing for some future DML changes to the data
    INITRANS 2 -- Specify the initial number of concurrent transaction entries allocated within each data block allocated to the database object.
    MAXTRANS 255 --  deprecated.
    LOGGING -- a database object will be logged in the redo log file

https://docs.oracle.com/cd/B28359_01/server.111/b28286/clauses.htm#SQLRF021

    STORAGE(
        INITIAL 65536 -- the size of the first extent of the object. allocates space when you create the schema object.
        NEXT 1048576 -- in bytes the size of the next extent to be allocated to the object.
        MINEXTENTS 1 -- In locally managed tablespaces, determine the initial segment size in conjunction with PCTINCREASE, INITIAL and NEXT
        MAXEXTENTS 2147483645 -- valid only for objects in dictionary-managed tablespaces
        PCTINCREASE 0 -- Oracle recommends a setting of 0 as a way to minimize fragmentation and avoid the possibility of very large temporary segments during processing.
        FREELISTS 1 -- each free list group contains one free list
        FREELIST GROUPS 1 -- In tablespaces with manual segment-space management, statically partition the segment free space in an Oracle Real Application Clusters environment.
        BUFFER_POOL DEFAULT 
        FLASH_CACHE DEFAULT 
        CELL_FLASH_CACHE DEFAULT
    )

![](https://docs.oracle.com/cd/B28359_01/server.111/b28286/img/storage_clause.gif)  
https://docs.oracle.com/cd/B28359_01/server.111/b28286/clauses009.htm#SQLRF30013

    TABLESPACE "USERS" 
    PCTTHRESHOLD 50;  -- when an overflow segment is being used, defines the maximum size of the portion of the row that is stored in the index block, as a percentage of block size. 1–50. The default is 50.

# Create Procedure
https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm
![](https://docs.oracle.com/cd/B19306_01/server.102/b14200/img/create_procedure.gif)

    CREATE PROCEDURE find_root
    ( x IN REAL ) 
    IS LANGUAGE C

Use the call_spec to map a Java or C method name, parameter types, and return type to their SQL counterparts.  
![](https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/img/call_spec.gif)  
![](https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/img/java_declaration.gif)

        NAME c_find_root
        LIBRARY c_utils
        PARAMETERS ( x BY REFERENCE );

![](https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/img/c_declaration.gif)

    create or replace PROCEDURE add_job_history
    (  p_emp_id          job_history.employee_id%type
    , p_start_date      job_history.start_date%type
    , p_end_date        job_history.end_date%type
    , p_job_id          job_history.job_id%type
    , p_department_id   job_history.department_id%type
    )
    IS
    BEGIN
    INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
    END add_job_history;