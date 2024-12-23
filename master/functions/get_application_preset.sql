CREATE OR REPLACE FUNCTION master.get_application_preset(p_sport_id numeric, p_variant_id numeric, OUT p_ret_type numeric, OUT p_preset_data jsonb)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

declare

begin

	select  ('{ "preset" :'||json_agg(b)||'}')::jsonb 
	into p_preset_data
	from (select preset_id,preset_name,created_date 
		  from master.application_preset
		  where sport_id = p_sport_id 
		  and game_type_id = p_variant_id
	 )b;

	 if p_preset_data is not null then
	 p_ret_type:= 1 ;
	 else

	 p_ret_type:= 2;
	 end if;
	 
	

end ;
$function$
