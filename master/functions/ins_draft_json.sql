CREATE OR REPLACE FUNCTION master.ins_draft_json(p_application_id integer, p_draft_json jsonb, OUT p_ret_type integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE master.applications
    SET draft_json = p_draft_json
    WHERE application_id = p_application_id;

    p_ret_type := 1;

EXCEPTION
    WHEN OTHERS THEN
        p_ret_type := -1;
END;
$function$
