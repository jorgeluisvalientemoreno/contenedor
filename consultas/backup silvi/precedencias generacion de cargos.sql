select *
from  cocoprci
LEFT JOIN PROCESOS ON PROCCONS = CCPCINPR
where ccpccicl = 2201 
for update
-- proceso 5 - FGCA debe quedar en 729 , son las precedencias de generacion de cargos 

select *
from servsusc where sesunuse  = 50158142 


SELECT *
FROM PERIFACT 
WHERE PEFACODI = 101934 


SELECT *
FROM SA_TAB
WHERE process_name LIKE '%FIDF%'

LDC_PKGESTIONTARITRAN.FNUGETVALIPERIFIDF(:BILLING_PERIOD_ID:) = 1
;

select * from ciclo c where c.ciclcodi=2201
