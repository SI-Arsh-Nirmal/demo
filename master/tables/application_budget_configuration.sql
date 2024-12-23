                          ddl                           
--------------------------------------------------------
 CREATE TABLE master.application_budget_configuration (+
     application_id smallint NOT NULL,                 +
     budget_value numeric,                             +
     currency_id smallint,                             +
     is_additional_budget_allowed smallint,            +
     additional_budget_value numeric,                  +
     additional_budget_allowed_from_round smallint     +
 );
(1 row)

                                     ?column?                                      
-----------------------------------------------------------------------------------
     CONSTRAINT application_budget_configuration_pkey PRIMARY KEY (application_id)
(1 row)

