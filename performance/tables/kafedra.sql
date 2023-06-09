-- Table: public.kafedra

-- DROP TABLE IF EXISTS public.kafedra;

CREATE TABLE IF NOT EXISTS public.kafedra
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT kafedra_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.kafedra
    OWNER to postgres;

-- Trigger: kafedra_history

-- DROP TRIGGER IF EXISTS kafedra_history ON public.kafedra;

CREATE TRIGGER kafedra_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.kafedra
    FOR EACH ROW
    EXECUTE FUNCTION public.kafedra_history_trigger();