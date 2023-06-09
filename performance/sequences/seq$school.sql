-- SEQUENCE: public.seq$school

-- DROP SEQUENCE IF EXISTS public."seq$school";

CREATE SEQUENCE IF NOT EXISTS public."seq$school"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$school"
    OWNER TO postgres;