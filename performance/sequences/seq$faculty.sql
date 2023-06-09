-- SEQUENCE: public.seq$faculty

-- DROP SEQUENCE IF EXISTS public."seq$faculty";

CREATE SEQUENCE IF NOT EXISTS public."seq$faculty"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$faculty"
    OWNER TO postgres;