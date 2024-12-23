CREATE OR REPLACE FUNCTION master.ins_db_details(p_input jsonb, OUT p_ret_type integer, OUT p_application_id integer)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

Declare
/*

{
  "user_details": {
  	"clientname": "dfghjkl",
    "user_name": "abc",
    "password": "easrdtfygad1233"
  },
  "sport":1,
  "variant": 1,
  "db_details": [
    {
      "name": "ut1",
      "port": 5432,
      "end_point": "sdfdgfhghj2345678",
      "db_name": "dfghj",
      "password": "gejjsrdsrr233"
    }
  ]
}

*/

v_user_id numeric;

BEGIN

 v_user_id := nextval('master.userid_seq');  

	insert into master.users
	(user_id,
	user_name,
	display_user_name,
	user_password,
	is_super_admin_user,
	status,
	created_date
	)
	select v_user_id,
		   p_input->'user_details'->>'user_name',
		   p_input->'user_details'->>'user_name',
		   p_input->'user_details'->>'password',
		   1,
		   1,
		   current_timestamp;

		-- v_client_id := nextval('master.clientid_seq');  
		
		insert into master.client
		(client_id ,
		client_name ,
		logo_url 
		)  
		select
		v_user_id,
		p_input->'user_details'->>'client_name',
		null;

		insert into master.applications
		(application_id ,
		application_name ,
  		client_id ,
	    sport_id ,
	    game_type_id 
		)
		select nextval('master.applicationid_seq'),
		p_input->'user_details'->>'client_name',
		v_user_id,
		(p_input->'sport_and_variant'->>'sport')::smallint,
		(p_input->'sport_and_variant'->>'variant')::smallint
		RETURNING application_id
		INTO p_application_id;

		insert into  master.application_databases
		(database_id,
		 database_type,
		 shard_id,
		 connection_details,
		 application_id)
		 select nextval('master.databaseid_seq'),
		 		substring(shard_name,1,1),
				 1,
				 'host='||end_point||' port='||port||' user='||name||' password='||password||' dbname='||"db_name",
				 p_application_id
		from jsonb_to_recordset(p_input->'db_config'->'db_details') 
		as x("name" text, "port" text, "end_point" text,"db_name"text,"password" text,
     	"shard_name" text);	

		   p_ret_type := 1;
		
		   
      
END;

$function$
