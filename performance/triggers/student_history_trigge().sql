-- FUNCTION: public.student_history_trigger()

-- DROP FUNCTION IF EXISTS public.student_history_trigger();

CREATE OR REPLACE FUNCTION public.student_history_trigger()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (OLD.fio <> NEW.fio) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'fio', OLD.fio, NEW.fio, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.snils <> NEW.snils) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'snils', OLD.snils, NEW.snils, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.inn <> NEW.inn) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'inn', OLD.inn, NEW.inn, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.och <> NEW.och) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'och', OLD.och, NEW.och, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.fk_city <> NEW.fk_city) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'fk_city', OLD.fk_city, NEW.fk_city, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.school <> NEW.school) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'fk_school', OLD.fk_school, NEW.fk_school, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
        IF (OLD.fk_group <> NEW.fk_group) THEN
            INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
            VALUES (OLD.id, 'student', 'fk_group', OLD.fk_group, NEW.fk_group, CURRENT_USER, NOW(), CURRENT_DATE, 'update');
        END IF;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (OLD.id, 'student', 'student', NULL, NULL, CURRENT_USER, NOW(), CURRENT_DATE, 'delete');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO changes_log (pk, table_title, field, old_value, new_value, user_name, change_time, change_date, change_type)
        VALUES (NEW.id, 'student', 'student', NULL, NEW.fio, CURRENT_USER, NOW(), CURRENT_DATE, 'insert');
    END IF;
    RETURN NEW;
END 
$BODY$;

ALTER FUNCTION public.student_history_trigger()
    OWNER TO postgres;
