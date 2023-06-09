-- FUNCTION: public.generate_report7(date, date)

-- DROP FUNCTION IF EXISTS public.generate_report7(date, date);

CREATE OR REPLACE FUNCTION public.generate_report7(
	start_date date,
	end_date date)
    RETURNS TABLE(subject_name character varying, student_name character varying, points_sem numeric, points_exam numeric, points numeric, mark numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT sb.name AS subject_name, st.fio AS student_name, CAST(p.points_sem AS numeric) AS points_sem, CAST(p.points_exam AS numeric) AS points_exam, CAST(p.points_sem + p.points_exam AS numeric) AS points, CAST(p.mark AS numeric) AS mark
    FROM perfomance p
    INNER JOIN student st ON p.fk_student = st.id
    INNER JOIN report r ON p.fk_report = r.id
    INNER JOIN subject sb ON r.fk_subject = sb.id
    WHERE r.date BETWEEN start_date AND end_date
    GROUP BY sb.name, st.fio, p.mark, p.points_sem, p.points_exam, p.points_sem + p.points_exam;
END;
$BODY$;

ALTER FUNCTION public.generate_report7(date, date)
    OWNER TO postgres;
