                            ddl                            
-----------------------------------------------------------
 CREATE TABLE master.application_user_team_configuration (+
     application_id smallint NOT NULL,                    +
     min_user_teams smallint,                             +
     max_user_teams smallint,                             +
     min_playing_entities_per_team smallint,              +
     max_playing_entities_per_team smallint,              +
     is_substitute_allowed smallint,                      +
     min_substitute_entities_per_team smallint,           +
     max_substitute_entities_per_team smallint            +
 );
(1 row)

                                       ?column?                                       
--------------------------------------------------------------------------------------
     CONSTRAINT application_user_team_configuration_pkey PRIMARY KEY (application_id)
(1 row)

