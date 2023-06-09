-- Table: public.perfomance

-- DROP TABLE IF EXISTS public.perfomance;

CREATE TABLE IF NOT EXISTS public.perfomance
(
    id integer NOT NULL,
    points_sem integer NOT NULL,
    points_exam integer NOT NULL,
    mark integer NOT NULL,
    fk_student character varying(255) COLLATE pg_catalog."default" NOT NULL,
    fk_report integer NOT NULL,
    CONSTRAINT perfomance_pk PRIMARY KEY (id),
    CONSTRAINT perfomance_fk0 FOREIGN KEY (fk_student)
        REFERENCES public.student (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT perfomance_fk1 FOREIGN KEY (fk_report)
        REFERENCES public.report (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.perfomance
    OWNER to postgres;

-- Trigger: perfomance_history

-- DROP TRIGGER IF EXISTS perfomance_history ON public.perfomance;

CREATE TRIGGER perfomance_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.perfomance
    FOR EACH ROW
    EXECUTE FUNCTION public.perfomance_history_trigger();