                                ddl                                 
--------------------------------------------------------------------
 CREATE TABLE master.application_user_team_transfer_configuration (+
     application_id smallint NOT NULL,                             +
     is_transfer_allowed smallint,                                 +
     is_unlimited_transfer_allowed smallint,                       +
     total_transfer_allowed smallint,                              +
     is_additional_transfer_allowed smallint,                      +
     is_unlimited_additional_transfer_allowed smallint,            +
     total_additional_transfer_allowed smallint,                   +
     additional_transfer_negative_points smallint,                 +
     unsed_transfers_carry_over smallint,                          +
     all_unsed_transfers_carry_over smallint,                      +
     total_unsed_transfers_carry_over smallint                     +
 );
(1 row)

                                           ?column?                                            
-----------------------------------------------------------------------------------------------
     CONSTRAINT application_user_team_transfer_configuration_pkey PRIMARY KEY (application_id)
(1 row)

