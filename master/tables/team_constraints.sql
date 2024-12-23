                         ddl                          
------------------------------------------------------
 CREATE TABLE master.team_constraints (              +
     constraint_id smallint NOT NULL,                +
     constraint_name character varying(250) NOT NULL,+
     sport_id smallint NOT NULL                      +
 );
(1 row)

                             ?column?                             
------------------------------------------------------------------
     CONSTRAINT team_constraints_pkey PRIMARY KEY (constraint_id)
(1 row)

