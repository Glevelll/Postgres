-- SEQUENCE: public.seq$subject

-- DROP SEQUENCE IF EXISTS public."seq$subject";

CREATE SEQUENCE IF NOT EXISTS public."seq$subject"
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 999999999999999999
    CACHE 1;

ALTER SEQUENCE public."seq$subject"
    OWNER TO postgres;