-- FUNCTION: public.teacher_history_trigger()

-- DROP FUNCTION IF EXISTS public.teacher_history_trigger();

CREATE OR REPLACE FUNCTION public.teacher_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (OLD.fio <> NEW.fio) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'teacher', 'fio', OLD.fio, NEW.fio, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.id, 'teacher', 'teacher', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.id, 'teacher', 'teacher', NULL, NEW.fio, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.teacher_history_trigger()
    OWNER TO postgres;
