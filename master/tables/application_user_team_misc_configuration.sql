                              ddl                               
----------------------------------------------------------------
 CREATE TABLE master.application_user_team_misc_configuration (+
     application_id smallint NOT NULL,                         +
     is_captain_allowed smallint,                              +
     is_captain_changes_allowed smallint,                      +
     is_unlimited_captain_changes_allowed smallint,            +
     total_captain_changes_allowed smallint,                   +
     captain_point_multiplier smallint,                        +
     is_vice_captain_allowed smallint,                         +
     is_vice_captain_changes_allowed smallint,                 +
     is_unlimited_vice_captain_changes_allowed smallint,       +
     total_vice_captain_changes_allowed smallint,              +
     vice_captain_point_multiplier smallint,                   +
     is_substitution_allowed smallint,                         +
     is_substitution_changes_allowed smallint,                 +
     is_unlimited_substitution_changes_allowed smallint,       +
     total_substitution_changes_allowed smallint,              +
     substitution_point_multiplier smallint,                   +
     is_auto_substitution_allowed smallint                     +
 );
(1 row)

                                         ?column?                                          
-------------------------------------------------------------------------------------------
     CONSTRAINT application_user_team_misc_configuration_pkey PRIMARY KEY (application_id)
(1 row)

