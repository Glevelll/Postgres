-- Table: public.groupe

-- DROP TABLE IF EXISTS public.groupe;

CREATE TABLE IF NOT EXISTS public.groupe
(
    "number" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    fk_faculty integer NOT NULL,
    CONSTRAINT group_pk PRIMARY KEY ("number"),
    CONSTRAINT group_fk0 FOREIGN KEY (fk_faculty)
        REFERENCES public.faculty (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.groupe
    OWNER to postgres;

-- Trigger: groupe_history

-- DROP TRIGGER IF EXISTS groupe_history ON public.groupe;

CREATE TRIGGER groupe_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.groupe
    FOR EACH ROW
    EXECUTE FUNCTION public.groupe_history_trigger();