-- FUNCTION: public.generate_report1()

-- DROP FUNCTION IF EXISTS public.generate_report1();

CREATE OR REPLACE FUNCTION public.generate_report1(
	)
    RETURNS TABLE(student_id character varying, student_fio character varying, avg_mark numeric, avg_points numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT s.id AS student_id, s.fio AS student_fio, AVG(p.mark) AS avg_mark, AVG(p.points_sem + p.points_exam) AS avg_points
    FROM student s
    JOIN perfomance p ON s.id = p.fk_student
    GROUP BY s.id, s.fio
    ORDER BY s.id;
END;
$BODY$;

ALTER FUNCTION public.generate_report1()
    OWNER TO postgres;
