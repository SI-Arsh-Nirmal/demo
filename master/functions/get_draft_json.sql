CREATE OR REPLACE FUNCTION master.get_draft_json(p_application_id integer, OUT p_draft_json jsonb, OUT p_ret_type integer)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
BEGIN
    SELECT draft_json
    INTO p_draft_json
    FROM master.applications
    WHERE application_id = p_application_id;

    p_ret_type := 1;

EXCEPTION
    WHEN OTHERS THEN
        p_ret_type := -1;
END;
$function$
