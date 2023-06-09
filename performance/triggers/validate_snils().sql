-- FUNCTION: public.validate_snils()

-- DROP FUNCTION IF EXISTS public.validate_snils();

CREATE OR REPLACE FUNCTION public.validate_snils()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
  snils TEXT;
  factor INTEGER := 9;
  sum INTEGER := 0;
  checksum INTEGER := 0;
BEGIN
  snils := NEW.snils;
  
  -- Проверка длины СНИЛС
  IF length(snils) <> 11 THEN
    RAISE EXCEPTION 'Invalid SNILS length';
  END IF;
  
  -- Проверка наличия только цифр в СНИЛС
  IF not snils ~ '^\d+$' THEN
    RAISE EXCEPTION 'SNILS should contain only digits';
  END IF;
  
  -- Проверка диапазона значений СНИЛС
  IF snils::bigint < 10019980000 OR snils::bigint > 99999999999 THEN
    RAISE EXCEPTION 'SNILS value out of range';
  END IF;
  
  -- Вычисление контрольной суммы
  FOR i IN 1..9 LOOP
    sum := sum + (substring(snils, i, 1)::integer * factor);
    factor := factor - 1;
  END LOOP;
  
  IF sum < 100 THEN
    checksum := sum;
  ELSIF sum = 100 OR sum = 101 THEN
    checksum := 0;
  ELSE
    checksum := sum % 101;
  END IF;
  
  -- Проверка контрольной суммы
  IF checksum <> substring(snils, 10, 2)::integer THEN
    RAISE EXCEPTION 'Invalid SNILS checksum';
  END IF;
  
  -- Если все проверки пройдены успешно, возвращаем переданный аргумент
  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.validate_snils()
    OWNER TO postgres;
