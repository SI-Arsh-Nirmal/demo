                     ddl                     
---------------------------------------------
 CREATE TABLE master.application_databases (+
     database_id smallint NOT NULL,         +
     database_type character(1),            +
     shard_id smallint,                     +
     connection_details text,               +
     application_id smallint NOT NULL       +
 );
(1 row)

                              ?column?                               
---------------------------------------------------------------------
     CONSTRAINT application_databases_pkey PRIMARY KEY (database_id)
(1 row)

