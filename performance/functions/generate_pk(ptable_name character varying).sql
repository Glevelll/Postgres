-- FUNCTION: public.generate_pk(character varying)

-- DROP FUNCTION IF EXISTS public.generate_pk(character varying);

CREATE OR REPLACE FUNCTION public.generate_pk(
	ptable_name character varying)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
xResult VARCHAR(10);
xNextVal INT;
xSQL VARCHAR(1000);

lcRegistr1 VARCHAR(1);
lcRegistr2 VARCHAR(1);
lcRegistr3 VARCHAR(1);
lcRegistr4 VARCHAR(1);
lcRegistr5 VARCHAR(1);

lnRegistr1 Int;
lnRegistr2 Int;
lnRegistr3 Int;
lnRegistr4 Int;
lnRegistr5 Int;

rGet RECORD;

xArrayLV Varchar(1)[];

BEGIN
SELECT pk INTO rGet FROM sys_table WHERE title = pTABLE_NAME;

-- проверка на существование таблицы
IF rGet.pk IS NULL THEN
RAISE EXCEPTION '-20000, ID таблицы не найдено в title!';
Return NULL;
END IF;

xSQL := 'SELECT nextval(' || '''seq$'||lower(replace(trim(pTABLE_NAME),'_','')) ||''')';
EXECUTE xSQL INTO xNextVal;

-- проверка на наличие следующего значения id
if (xNextVal is null) then
raise Exception '-20000, Не получен следующий ID из последовательности!';
Return NULL;
end if;

-- проверка на то, что id может состоять из 5 символов
if (62 * 62 * 62 * 62 * 62) < xNextVal then
raise EXCEPTION '-20000, Не возможно приращение кода!';
Return NULL;
end if;

-- значение соответствующее номеру
lcRegistr1:= '0';
lcRegistr2:= '0';
lcRegistr3:= '0';
lcRegistr4:= '0';
lcRegistr5:= '0';

-- номер соответсвтующий значению
lnRegistr1:= 0;
lnRegistr2:= 0;
lnRegistr3:= 0;
lnRegistr4:= 0;
lnRegistr5:= 0;

xArrayLV = Array['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
--смотрим первый регистр
IF (1 * 62 * 62 * 62 * 62) < xNextVal then
FOR i in 1..62 loop
IF (i * 62 * 62 * 62 * 62) < xNextVal then
lnRegistr1:= i * 62 * 62 * 62 * 62;
lcRegistr1:= xArrayLV[i + 1];
end if;
end loop;
END IF;

xNextVal:= xNextVal - lnRegistr1;

--смотрим второй регистр
IF (1 * 62 * 62 * 62 ) < xNextVal then
FOR i in 1..62 loop
IF (i * 62 * 62 * 62) < xNextVal then
lnRegistr2:= i * 62 * 62 * 62;
lcRegistr2:= xArrayLV[i + 1];
END IF;
end loop;
END IF;

xNextVal:= xNextVal - lnRegistr2;

--смотрим третий регистр
IF (1 * 62 * 62) < xNextVal then
FOR i in 1..61 loop
IF (i * 62 * 62) < xNextVal then
lnRegistr3:= i * 62 * 62;
lcRegistr3:= xArrayLV[i + 1];
END IF;
end loop;
END IF;

xNextVal:= xNextVal - lnRegistr3;

--смотрим четвертый регистр
IF (1 * 62) < xNextVal then
FOR i in 1..61 loop
IF (i * 62) < xNextVal then
lnRegistr4:= i * 62;
lcRegistr4:= xArrayLV[i + 1];
END IF;
end loop;
END IF;

xNextVal:= xNextVal - lnRegistr4;

--смотрим пятый регистр
IF xNextVal BETWEEN 1 and 62 then
lcRegistr5:= xArrayLV[xNextVal];
END IF;

xResult:= lcRegistr1 || lcRegistr2 || lcRegistr3 || lcRegistr4 || lcRegistr5;

return rGet.pk||'!'||xResult;
end;

$BODY$;

ALTER FUNCTION public.generate_pk(character varying)
    OWNER TO postgres;
