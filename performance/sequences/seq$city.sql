-- SEQUENCE: public.seq$city

-- DROP SEQUENCE IF EXISTS public."seq$city";

CREATE SEQUENCE IF NOT EXISTS public."seq$city"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$city"
    OWNER TO postgres;