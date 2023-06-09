-- FUNCTION: public.groupe_history_trigger()

-- DROP FUNCTION IF EXISTS public.groupe_history_trigger();

CREATE OR REPLACE FUNCTION public.groupe_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
		IF (OLD.fk_faculty <> NEW.fk_faculty) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.number, 'groupe', 'fk_faculty', OLD.fk_faculty, NEW.fk_faculty, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.number, 'groupe', 'groupe', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.number, 'groupe', 'groupe', NULL, NEW.number, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.groupe_history_trigger()
    OWNER TO postgres;
