                          ddl                          
-------------------------------------------------------
 CREATE TABLE master.applications (                   +
     application_id smallint NOT NULL,                +
     application_name character varying(250) NOT NULL,+
     client_id smallint NOT NULL,                     +
     sport_id smallint NOT NULL,                      +
     game_type_id smallint NOT NULL,                  +
     has_unlimited_budget smallint NOT NULL DEFAULT 1,+
     player_points_feed_provider smallint,            +
     player_points_calculation_config jsonb,          +
     draft_json jsonb,                                +
     config_json jsonb                                +
 );
(1 row)

                                             ?column?                                             
--------------------------------------------------------------------------------------------------
     CONSTRAINT applications_pkey PRIMARY KEY (application_id, client_id, sport_id, game_type_id)
(1 row)

