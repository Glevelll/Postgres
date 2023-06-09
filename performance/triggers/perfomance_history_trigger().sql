-- FUNCTION: public.perfomance_history_trigger()

-- DROP FUNCTION IF EXISTS public.perfomance_history_trigger();

CREATE OR REPLACE FUNCTION public.perfomance_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (OLD.points_sem <> NEW.points_sem) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'perfomance', 'points_sem', OLD.points_sem, NEW.points_sem, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.points_exam <> NEW.points_exam) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'perfomance', 'points_exam', OLD.points_exam, NEW.points_exam, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.mark <> NEW.mark) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'perfomance', 'mark', OLD.mark, NEW.mark, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.fk_student <> NEW.fk_student) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'perfomance', 'fk_student', OLD.fk_student, NEW.fk_student, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
		IF (OLD.fk_report <> NEW.fk_report) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'perfomance', 'fk_report', OLD.fk_report, NEW.fk_report, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.id, 'perfomance', 'perfomance', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.id, 'perfomance', 'perfomance', NULL, NEW.mark, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.perfomance_history_trigger()
    OWNER TO postgres;
