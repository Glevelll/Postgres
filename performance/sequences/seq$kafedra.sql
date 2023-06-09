-- SEQUENCE: public.seq$kafedra

-- DROP SEQUENCE IF EXISTS public."seq$kafedra";

CREATE SEQUENCE IF NOT EXISTS public."seq$kafedra"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$kafedra"
    OWNER TO postgres;