-- Table: public.subject

-- DROP TABLE IF EXISTS public.subject;

CREATE TABLE IF NOT EXISTS public.subject
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    fk_subject integer NOT NULL,
    CONSTRAINT subject_pk PRIMARY KEY (id),
    CONSTRAINT subject_fk0 FOREIGN KEY (fk_subject)
        REFERENCES public.kafedra (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.subject
    OWNER to postgres;

-- Trigger: subject_history

-- DROP TRIGGER IF EXISTS subject_history ON public.subject;

CREATE TRIGGER subject_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.subject
    FOR EACH ROW
    EXECUTE FUNCTION public.subject_history_trigger();