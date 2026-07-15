declare
    sbruta varchar2(2000):= '/smartfiles/Facturacion/Auditorias';
    sbAgrupDepa       VARCHAR2 (2) := 'S';
BEGIN
    LDC_PRGEAUDPRE;
END;


select *
from LDC_CODPERFACT 
where cod_perfact in (138444);

update LDC_CODPERFACT 
set estadprocess='P'
where cod_perfact in (138444);

SELECT *
FROM LDC_VALIDGENAUDPREVIAS P
WHERE P.COD_PEFACODI IN (138444)
