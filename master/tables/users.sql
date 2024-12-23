                       ddl                       
-------------------------------------------------
 CREATE TABLE master.users (                    +
     user_id smallint NOT NULL,                 +
     user_name character varying(100) NOT NULL, +
     display_user_name character varying(100),  +
     user_password text NOT NULL,               +
     is_super_admin_user smallint,              +
     status smallint,                           +
     created_date timestamp without time zone,  +
     last_login_date timestamp without time zone+
 );
(1 row)

                    ?column?                     
-------------------------------------------------
     CONSTRAINT users_pkey PRIMARY KEY (user_id)
(1 row)

