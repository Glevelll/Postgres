-- FUNCTION: public.generate_report3()

-- DROP FUNCTION IF EXISTS public.generate_report3();

CREATE OR REPLACE FUNCTION public.generate_report3(
	)
    RETURNS TABLE(teacher_name character varying, average_mark numeric, average_points numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT t.fio AS teacher_name, AVG(p.mark) AS average_mark, AVG(p.points_sem + p.points_exam) AS average_points
    FROM perfomance p
    INNER JOIN report r ON p.fk_report = r.id
    INNER JOIN teacher t ON r.fk_teacher = t.id
    GROUP BY t.fio;
END;
$BODY$;

ALTER FUNCTION public.generate_report3()
    OWNER TO postgres;
