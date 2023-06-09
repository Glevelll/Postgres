-- SEQUENCE: public.seq$student

-- DROP SEQUENCE IF EXISTS public."seq$student";

CREATE SEQUENCE IF NOT EXISTS public."seq$student"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$student"
    OWNER TO postgres;