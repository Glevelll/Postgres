-- Table: public.sys_table

-- DROP TABLE IF EXISTS public.sys_table;

CREATE TABLE IF NOT EXISTS public.sys_table
(
    pk character varying(3) COLLATE pg_catalog."default" NOT NULL,
    title character varying(50) COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sys_table
    OWNER to postgres;