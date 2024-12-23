                      ddl                       
------------------------------------------------
 CREATE TABLE master.sport_skills (            +
     sport_id smallint NOT NULL,               +
     skill_id smallint NOT NULL,               +
     skill_name character varying(100) NOT NULL+
 );
(1 row)

                             ?column?                              
-------------------------------------------------------------------
     CONSTRAINT sport_skills_pkey PRIMARY KEY (sport_id, skill_id)
(1 row)

