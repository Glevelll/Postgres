-- Table: public.city

-- DROP TABLE IF EXISTS public.city;

CREATE TABLE IF NOT EXISTS public.city
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.city
    OWNER to postgres;

-- Trigger: city_history

-- DROP TRIGGER IF EXISTS city_history ON public.city;

CREATE TRIGGER city_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.city
    FOR EACH ROW
    EXECUTE FUNCTION public.city_history_trigger();