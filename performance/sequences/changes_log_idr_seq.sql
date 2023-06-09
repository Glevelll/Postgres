-- SEQUENCE: public.changes_log_idr_seq

-- DROP SEQUENCE IF EXISTS public.changes_log_idr_seq;

CREATE SEQUENCE IF NOT EXISTS public.changes_log_idr_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY changes_log.idr;

ALTER SEQUENCE public.changes_log_idr_seq
    OWNER TO postgres;