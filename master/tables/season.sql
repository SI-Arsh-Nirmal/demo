                                           ddl                                            
------------------------------------------------------------------------------------------
 CREATE TABLE master.season (                                                            +
     season_id integer NOT NULL DEFAULT nextval('master.season_season_id_seq'::regclass),+
     application_id integer,                                                             +
     season_name character varying(255) NOT NULL,                                        +
     season_year integer NOT NULL,                                                       +
     start_date date NOT NULL,                                                           +
     end_date date NOT NULL,                                                             +
     created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,                 +
     updated_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,                 +
     is_active smallint DEFAULT 1,                                                       +
     eot smallint DEFAULT 0                                                              +
 );
(1 row)

                      ?column?                      
----------------------------------------------------
     CONSTRAINT season_pkey PRIMARY KEY (season_id)
(1 row)

