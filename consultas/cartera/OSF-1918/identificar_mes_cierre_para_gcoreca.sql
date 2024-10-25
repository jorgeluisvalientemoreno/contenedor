--identificar_mes_cierre_para_gcoreca
select max(sc.nuano), max(sc.numes)
from ldc_osf_sesucier sc
where sc.nuano = 2024

select count(*)
from ldc_osf_sesucier sc
where sc.nuano = 2024
and   sc.numes = 8

-- Eliminar registro 
delete 
from ldc_osf_sesucier sc
where sc.nuano = 2024
and   sc.numes = 6
and rownum <= 500000;


select sysdate from dual
