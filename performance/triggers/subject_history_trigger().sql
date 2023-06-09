-- FUNCTION: public.subject_history_trigger()

-- DROP FUNCTION IF EXISTS public.subject_history_trigger();

CREATE OR REPLACE FUNCTION public.subject_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (OLD.name <> NEW.name) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'subject', 'name', OLD.name, NEW.name, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.fk_subject <> NEW.fk_subject) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'subject', 'fk_subject', OLD.fk_subject, NEW.fk_subject, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.id, 'subject', 'subject', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.id, 'subject', 'subject', NULL, NEW.name, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.subject_history_trigger()
    OWNER TO postgres;
