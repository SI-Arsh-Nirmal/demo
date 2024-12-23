CREATE OR REPLACE FUNCTION master.ins_upd_game_config_backup(p_input jsonb, OUT p_ret_type integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

DECLARE
--    {
--    "budget_and_team_config":{
--       "budget":true, -- not used
--       "budget_cap":100,
--       "currency_type":"$", -- used as currency_id=1
--       "numbering_system":1, -- not used
--       "currency_multiplayer":1000, -- not used
--       "additional_budget":0,
--       "enabled_constraints":false, -- not used
--       "min_team_per_user":1,
--       "min_picks_per_team_on_bench":1,
--       "min_picks_per_team_on_pitch":1,
--       "max_team_per_user":1,
--       "max_picks_per_team_on_pitch":1,
--       "max_picks_per_team_on_bench":0,
--       "is_additional_budget":false,
--       "constraints":[ -- not to be used
--          {
--             "constraint_id":"",
--             "min":1,
--             "max":1
--          }
--       ],
--       "skill_constraints":[
--          {
--             "max":1,
--             "min":1,
--             "skill_id":1
--          }
--       ],
--       "is_transfer_allowed":false,
--       "is_additional_transfer_allowed":false,
--       "is_transfers_carried_over_if_not_used":false,
--       "is_team_unfreezes_after":false, -- not used
--       "is_vice_captain":false, -- not used
--       "is_auto_sub":false, -- not used
--       "is_sub_allowed":false,
--       "is_captain":false -- not used
--    }
-- }
    v_application_id     NUMERIC;
    v_budget_team_config JSONB;
BEGIN
    v_budget_team_config := p_input -> 'budget_and_team_config';
    v_application_id := (p_input ->> 'application_id')::NUMERIC;

	raise notice '%',v_application_id;

    INSERT INTO master.application_budget_configuration
    (application_id,
     budget_value,
     currency_id,
     is_additional_budget_allowed,
     additional_budget_value,
     additional_budget_allowed_from_round)
    SELECT v_application_id,
           (v_budget_team_config ->> 'budget_cap')::NUMERIC,
           1, -- "$"
           (v_budget_team_config ->> 'is_additional_budget')::boolean::int,
           (v_budget_team_config ->> 'additional_budget')::NUMERIC,
           2  --(v_budget_team_config ->> 'additional_budget')::NUMERIC
    ON CONFLICT (application_id) DO UPDATE
        SET budget_value                         = EXCLUDED.budget_value,
            currency_id                          = EXCLUDED.currency_id,
            is_additional_budget_allowed         = EXCLUDED.is_additional_budget_allowed,
            additional_budget_value              = EXCLUDED.additional_budget_value,
            additional_budget_allowed_from_round = EXCLUDED.additional_budget_allowed_from_round;

    INSERT INTO master.application_user_team_transfer_configuration
    (application_id,
     is_transfer_allowed,
     is_unlimited_transfer_allowed,
     total_transfer_allowed,
     is_additional_transfer_allowed,
     is_unlimited_additional_transfer_allowed,
     total_additional_transfer_allowed,
     additional_transfer_negative_points,
     unsed_transfers_carry_over,
     all_unsed_transfers_carry_over,
     total_unsed_transfers_carry_over)
    SELECT v_application_id,
           (v_budget_team_config ->> 'transfer_allowed')::boolean::INT,
           0,
           100,
           (v_budget_team_config ->> 'additional_transfer_allowed')::boolean::INT,
           0,
           10,
           0,
           (v_budget_team_config ->> 'is_transfers_carried_over_if_not_used')::boolean::INT,
           (v_budget_team_config ->> 'is_transfers_carried_over_if_not_used')::boolean::INT,
           (v_budget_team_config ->> 'is_transfers_carried_over_if_not_used')::boolean::INT
    ON CONFLICT (application_id) DO UPDATE
        SET is_transfer_allowed                      = EXCLUDED.is_transfer_allowed,
            is_unlimited_transfer_allowed            = EXCLUDED.is_unlimited_transfer_allowed,
            total_transfer_allowed                   = EXCLUDED.total_transfer_allowed,
            is_additional_transfer_allowed           = EXCLUDED.is_additional_transfer_allowed,
            is_unlimited_additional_transfer_allowed = EXCLUDED.is_unlimited_additional_transfer_allowed,
            total_additional_transfer_allowed        = EXCLUDED.total_additional_transfer_allowed,
            additional_transfer_negative_points      = EXCLUDED.additional_transfer_negative_points,
            unsed_transfers_carry_over               = EXCLUDED.unsed_transfers_carry_over,
            all_unsed_transfers_carry_over           = EXCLUDED.all_unsed_transfers_carry_over,
            total_unsed_transfers_carry_over         = EXCLUDED.total_unsed_transfers_carry_over;

    INSERT INTO master.application_user_team_skill_configuration
    (application_id,
     skill_id,
     min_entities_per_team,
     max_entities_per_team)
    SELECT v_application_id,
           skill_id,
           min,
           max
    FROM JSONB_TO_RECORDSET(v_budget_team_config -> 'skill_constraints')
             AS x(skill_id INT, min INT, max INT)
    ON CONFLICT (application_id, skill_id) DO UPDATE
        SET min_entities_per_team = EXCLUDED.min_entities_per_team,
            max_entities_per_team = EXCLUDED.max_entities_per_team;

    INSERT INTO master.application_user_team_configuration
    (application_id,
     min_user_teams,
     max_user_teams,
     min_playing_entities_per_team,
     max_playing_entities_per_team,
     is_substitute_allowed,
     min_substitute_entities_per_team,
     max_substitute_entities_per_team)
    SELECT v_application_id,
           (v_budget_team_config ->> 'min_team_per_user') :: INT,
           (v_budget_team_config ->> 'max_team_per_user') :: INT,
           (v_budget_team_config ->> 'min_picks_per_team_on_pitch') :: INT,
           (v_budget_team_config ->> 'max_picks_per_team_on_pitch') :: INT,
           (v_budget_team_config ->> 'is_sub_allowed')::boolean:: INT,
           (v_budget_team_config ->> 'min_picks_per_team_on_bench') :: INT,
           (v_budget_team_config ->> 'max_picks_per_team_on_bench') :: INT
    ON CONFLICT (application_id) DO UPDATE
        SET min_user_teams                   = EXCLUDED.min_user_teams,
            max_user_teams                   = EXCLUDED.max_user_teams,
            min_playing_entities_per_team    = EXCLUDED.min_playing_entities_per_team,
            max_playing_entities_per_team    = EXCLUDED.max_playing_entities_per_team,
            is_substitute_allowed            = EXCLUDED.is_substitute_allowed,
            min_substitute_entities_per_team = EXCLUDED.min_substitute_entities_per_team,
            max_substitute_entities_per_team = EXCLUDED.max_substitute_entities_per_team;

    UPDATE master.applications
    SET player_points_calculation_config = p_input -> 'pointsSystem',
        draft_json                       = p_input,
        config_json                      = p_input
    WHERE application_id = v_application_id;

    p_ret_type := 1;

END;
$function$
