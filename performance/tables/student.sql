-- Table: public.student

-- DROP TABLE IF EXISTS public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    fio character varying(255) COLLATE pg_catalog."default" NOT NULL,
    snils character varying(255) COLLATE pg_catalog."default" NOT NULL,
    inn character varying(255) COLLATE pg_catalog."default" NOT NULL,
    och boolean NOT NULL,
    fk_city integer NOT NULL,
    fk_school integer NOT NULL,
    fk_group character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (id),
    CONSTRAINT student_inn_key UNIQUE (inn),
    CONSTRAINT student_snils_key UNIQUE (snils),
    CONSTRAINT student_fk0 FOREIGN KEY (fk_city)
        REFERENCES public.city (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT student_fk1 FOREIGN KEY (fk_school)
        REFERENCES public.school (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT student_fk2 FOREIGN KEY (fk_group)
        REFERENCES public.groupe ("number") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student
    OWNER to postgres;

-- Trigger: checkstudentinn

-- DROP TRIGGER IF EXISTS checkstudentinn ON public.student;

CREATE TRIGGER checkstudentinn
    BEFORE INSERT OR UPDATE 
    ON public.student
    FOR EACH ROW
    EXECUTE FUNCTION public.checkinn();

-- Trigger: student_history

-- DROP TRIGGER IF EXISTS student_history ON public.student;

CREATE TRIGGER student_history
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.student
    FOR EACH ROW
    EXECUTE FUNCTION public.student_history_trigger();

-- Trigger: validate_student_snils

-- DROP TRIGGER IF EXISTS validate_student_snils ON public.student;

CREATE TRIGGER validate_student_snils
    BEFORE INSERT OR UPDATE 
    ON public.student
    FOR EACH ROW
    EXECUTE FUNCTION public.validate_snils();