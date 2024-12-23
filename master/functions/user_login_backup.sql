CREATE OR REPLACE FUNCTION master.user_login_backup(p_input jsonb, OUT p_ret_type numeric, OUT p_user_data jsonb)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
/*

{
  "user_details": {
    "user_name": "abc",
    "password": "easrdtfygad1233"
  }
}

*/
DECLARE

    v_user_name TEXT;
    v_password  TEXT;
    v_exists    NUMERIC;
    v_userid    TEXT;


BEGIN

    SELECT p_input -> 'user_details' ->> 'user_name',
           p_input -> 'user_details' ->> 'password'
    INTO v_user_name,
        v_password;

    SELECT 1,
           user_id
    INTO v_exists,
        v_userid
    FROM master.users
    WHERE user_name = v_user_name
      AND user_password = v_password;

    IF v_exists = 1 THEN
        SELECT ROW_TO_JSON(a)
        INTO p_user_data
        FROM (SELECT v_userid    AS user_id,
                     v_user_name AS user_name) a;

        p_ret_type := 1;

    ELSE
        p_user_data := NULL;
        p_ret_type := 2;
    END IF;

END;

$function$
