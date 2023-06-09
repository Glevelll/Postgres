-- Table: public.faculty

-- DROP TABLE IF EXISTS public.faculty;

CREATE TABLE IF NOT EXISTS public.faculty
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT faculty_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.faculty
    OWNER to postgres;

-- Trigger: faculty_history

-- DROP TRIGGER IF EXISTS faculty_history ON public.faculty;

CREATE TRIGGER faculty_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.faculty
    FOR EACH ROW
    EXECUTE FUNCTION public.faculty_history_trigger();