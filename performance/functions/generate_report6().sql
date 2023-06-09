-- FUNCTION: public.generate_report6()

-- DROP FUNCTION IF EXISTS public.generate_report6();

CREATE OR REPLACE FUNCTION public.generate_report6(
	)
    RETURNS TABLE(school_name character varying, average_mark numeric, average_points numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT s.name AS school_name, AVG(p.mark) AS average_mark, AVG(p.points_sem + p.points_exam) AS average_points
    FROM perfomance p
    INNER JOIN student st ON p.fk_student = st.id
    INNER JOIN school s ON st.fk_school = s.id
    GROUP BY s.name;
END;
$BODY$;

ALTER FUNCTION public.generate_report6()
    OWNER TO postgres;
