CREATE OR REPLACE FUNCTION master.get_dropdown_details(p_sport_id numeric, OUT p_constraints_data jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$

declare

v_team_constraints jsonb;
v_skill_constraints jsonb;

begin


	select  ('{ "team_constraints" :'||json_agg(b)||'}')::jsonb into v_team_constraints  from 
	(select constraint_id,constraint_name from master.team_constraints
	where sport_id = p_sport_id)b;
	
	select  ('{ "skill_constraints" :'||json_agg(b)||'}')::jsonb into v_skill_constraints  from 
	(select skill_id,skill_name from master.sport_skills
	 where sport_id = p_sport_id)b;
	
	p_constraints_data :=  coalesce(v_team_constraints,'{}'::jsonb) || v_skill_constraints;

end ;
$function$
