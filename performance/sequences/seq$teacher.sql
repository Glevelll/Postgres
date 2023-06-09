-- SEQUENCE: public.seq$teacher

-- DROP SEQUENCE IF EXISTS public."seq$teacher";

CREATE SEQUENCE IF NOT EXISTS public."seq$teacher"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$teacher"
    OWNER TO postgres;