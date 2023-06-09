-- Table: public.changes_log

-- DROP TABLE IF EXISTS public.changes_log;

CREATE TABLE IF NOT EXISTS public.changes_log
(
    idr integer NOT NULL DEFAULT 'nextval('changes_log_idr_seq'::regclass)',
    pk character varying(255) COLLATE pg_catalog."default" NOT NULL,
    table_title character varying(50) COLLATE pg_catalog."default" NOT NULL,
    field character varying(50) COLLATE pg_catalog."default" NOT NULL,
    old_value character varying(255) COLLATE pg_catalog."default",
    new_value character varying(255) COLLATE pg_catalog."default",
    user_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    change_time timestamp without time zone NOT NULL,
    change_date date NOT NULL,
    change_type character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT changes_log_pkey PRIMARY KEY (idr)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.changes_log
    OWNER to postgres;