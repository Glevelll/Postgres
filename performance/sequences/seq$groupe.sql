-- SEQUENCE: public.seq$groupe

-- DROP SEQUENCE IF EXISTS public."seq$groupe";

CREATE SEQUENCE IF NOT EXISTS public."seq$groupe"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$groupe"
    OWNER TO postgres;