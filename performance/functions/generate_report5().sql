-- FUNCTION: public.generate_report5()

-- DROP FUNCTION IF EXISTS public.generate_report5();

CREATE OR REPLACE FUNCTION public.generate_report5(
	)
    RETURNS TABLE(city_name character varying, average_mark numeric, average_points numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT c.name AS city_name, AVG(p.mark) AS average_mark, AVG(p.points_sem + p.points_exam) AS average_points
    FROM perfomance p
    INNER JOIN student s ON p.fk_student = s.id
    INNER JOIN city c ON s.fk_city = c.id
    GROUP BY c.name;
END;
$BODY$;

ALTER FUNCTION public.generate_report5()
    OWNER TO postgres;
