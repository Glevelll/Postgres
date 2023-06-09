-- SEQUENCE: public.seq$report

-- DROP SEQUENCE IF EXISTS public."seq$report";

CREATE SEQUENCE IF NOT EXISTS public."seq$report"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$report"
    OWNER TO postgres;