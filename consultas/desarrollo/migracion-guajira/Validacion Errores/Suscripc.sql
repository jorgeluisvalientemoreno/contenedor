with base as(
select d.lpmdprog,
       lpmddesc,
       REGEXP_SUBSTR(lpmddesc, '[^>]+', 1, LEVEL) cadena
from migragg.log_proc_migra_det d
where d.lpmdprog like '%LOAD%SUSCRIP%'
  and d.lpmdfech>='24/09/2025'
   CONNECT BY
    LEVEL <= LENGTH(lpmddesc) - LENGTH(REPLACE(lpmddesc, '>')) + 1
    AND PRIOR lpmddesc = lpmddesc
    AND PRIOR SYS_GUID() IS NOT NULL
    )
, base2 as(
select TO_NUMBER(trim(REPLACE(cadena, 'SUSCCODI=',''))) contrato
from base
where cadena like '%SUSCCODI%'
)
SELECT *
FROM MIGRAGG.SUSCRIPC
WHERE SUSCCODI IN (SELECT CONTRATO FROM BASE2)
