                       ddl                        
--------------------------------------------------
 CREATE TABLE master.client (                    +
     client_id smallint NOT NULL,                +
     client_name character varying(250) NOT NULL,+
     logo_url text                               +
 );
(1 row)

                      ?column?                      
----------------------------------------------------
     CONSTRAINT client_pkey PRIMARY KEY (client_id)
(1 row)

