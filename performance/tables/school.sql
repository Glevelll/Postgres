-- Table: public.school

-- DROP TABLE IF EXISTS public.school;

CREATE TABLE IF NOT EXISTS public.school
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT school_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.school
    OWNER to postgres;

-- Trigger: school_history

-- DROP TRIGGER IF EXISTS school_history ON public.school;

CREATE TRIGGER school_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.school
    FOR EACH ROW
    EXECUTE FUNCTION public.school_history_trigger();