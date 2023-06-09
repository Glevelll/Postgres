-- FUNCTION: public.checkinn()

-- DROP FUNCTION IF EXISTS public.checkinn();

CREATE OR REPLACE FUNCTION public.checkinn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    lcInn text;
    lnSum1 integer := 0;
    lnSum2 integer := 0;
    lnKey1 integer;
    lnKey2 integer;
    lnLastDigit1 integer;
    lnLastDigit2 integer;
BEGIN
    lcInn = NEW.inn;

    IF length(lcInn) <> 12 THEN
        RAISE EXCEPTION 'INN must have 12 digits';
        RETURN NULL;
    END IF;

    FOR i IN 1..11 LOOP
        lnSum1 := lnSum1 + substr(lcInn, i, 1)::integer * CASE i
                                                            WHEN 1 THEN 7
                                                            WHEN 2 THEN 2
                                                            WHEN 3 THEN 4
                                                            WHEN 4 THEN 10
                                                            WHEN 5 THEN 3
                                                            WHEN 6 THEN 5
                                                            WHEN 7 THEN 9
                                                            WHEN 8 THEN 4
                                                            WHEN 9 THEN 6
                                                            WHEN 10 THEN 8
                                                            WHEN 11 THEN 0
                                                        END;
    END LOOP;

    lnKey1 := lnSum1 % 11;

    IF lnKey1 > 9 THEN
        lnKey1 := lnKey1 % 10;
    END IF;

    FOR i IN 1..12 LOOP
        lnSum2 := lnSum2 + substr(lcInn, i, 1)::integer * CASE i
                                                            WHEN 1 THEN 3
                                                            WHEN 2 THEN 7
                                                            WHEN 3 THEN 2
                                                            WHEN 4 THEN 4
                                                            WHEN 5 THEN 10
                                                            WHEN 6 THEN 3
                                                            WHEN 7 THEN 5
                                                            WHEN 8 THEN 9
                                                            WHEN 9 THEN 4
                                                            WHEN 10 THEN 6
                                                            WHEN 11 THEN 8
                                                            WHEN 12 THEN 0
                                                        END;
    END LOOP;

    lnKey2 := lnSum2 % 11;

    IF lnKey2 > 9 THEN
        lnKey2 := lnKey2 % 10;
    END IF;

    lnLastDigit1 := substr(lcInn, 11, 1)::integer;
    lnLastDigit2 := substr(lcInn, 12, 1)::integer;

    IF lnKey1 <> lnLastDigit1 OR lnKey2 <> lnLastDigit2 THEN
        RAISE EXCEPTION 'INN is incorrect';
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.checkinn()
    OWNER TO postgres;
