-- FUNCTION: public.generate_report4()

-- DROP FUNCTION IF EXISTS public.generate_report4();

CREATE OR REPLACE FUNCTION public.generate_report4(
	)
    RETURNS TABLE(kafedra_name character varying, average_mark numeric, average_points numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT k.name AS kafedra_name, AVG(p.mark) AS average_mark, AVG(p.points_sem + p.points_exam) AS average_points
    FROM perfomance p
    INNER JOIN report r ON p.fk_report = r.id
    INNER JOIN subject s ON r.fk_subject = s.id
    INNER JOIN kafedra k ON s.fk_subject = k.id
    GROUP BY k.name;
END;
$BODY$;

ALTER FUNCTION public.generate_report4()
    OWNER TO postgres;
