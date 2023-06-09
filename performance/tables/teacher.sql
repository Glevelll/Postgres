-- Table: public.teacher

-- DROP TABLE IF EXISTS public.teacher;

CREATE TABLE IF NOT EXISTS public.teacher
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    fio character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teacher_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.teacher
    OWNER to postgres;

-- Trigger: teacher_history

-- DROP TRIGGER IF EXISTS teacher_history ON public.teacher;

CREATE TRIGGER teacher_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.teacher
    FOR EACH ROW
    EXECUTE FUNCTION public.teacher_history_trigger();