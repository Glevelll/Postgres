-- FUNCTION: public.report_history_trigger()

-- DROP FUNCTION IF EXISTS public.report_history_trigger();

CREATE OR REPLACE FUNCTION public.report_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (OLD.fk_group <> NEW.fk_group) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'fk_group', OLD.fk_group, NEW.fk_group, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.hours <> NEW.hours) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'hours', OLD.hours, NEW.hours, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.fk_teacher <> NEW.fk_teacher) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'fk_teacher', OLD.fk_teacher, NEW.fk_teacher, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.fk_subject <> NEW.fk_subject) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'fk_subject', OLD.fk_subject, NEW.fk_subject, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.date <> NEW.date) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'date', OLD.date, NEW.date, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.semester <> NEW.semester) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'semester', OLD.semester, NEW.semester, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.years <> NEW.years) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'years', OLD.years, NEW.years, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.audience <> NEW.audience) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'report', 'audience', OLD.audience, NEW.audience, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.id, 'report', 'report', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.id, 'report', 'report', NULL, NEW.mark, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.report_history_trigger()
    OWNER TO postgres;
