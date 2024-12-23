                                  ddl                                  
-----------------------------------------------------------------------
 CREATE TABLE master.application_user_team_constraints_configuration (+
     application_id smallint NOT NULL,                                +
     constraint_id smallint NOT NULL,                                 +
     min_entities_per_team smallint,                                  +
     max_entities_per_team smallint                                   +
 );
(1 row)

                                                    ?column?                                                     
-----------------------------------------------------------------------------------------------------------------
     CONSTRAINT application_user_team_constraints_configuration_pkey PRIMARY KEY (application_id, constraint_id)
(1 row)

