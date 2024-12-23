                               ddl                               
-----------------------------------------------------------------
 CREATE TABLE master.application_user_team_skill_configuration (+
     application_id smallint NOT NULL,                          +
     skill_id smallint NOT NULL,                                +
     min_entities_per_team smallint,                            +
     max_entities_per_team smallint                             +
 );
(1 row)

                                               ?column?                                               
------------------------------------------------------------------------------------------------------
     CONSTRAINT application_user_team_skill_configuration_pkey PRIMARY KEY (application_id, skill_id)
(1 row)

