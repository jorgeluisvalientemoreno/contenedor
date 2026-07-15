select s.id_items_seriado, s.items_id, s.serie, s.id_items_estado_inv, e.descripcion, s.costo, s.fecha_ingreso,s.operating_unit_id
from open.ge_items_seriado  s,
     ge_items_estado_inv  e, 
     OR_OPE_UNI_TASK_TYPE O, 
     OR_OPERATING_UNIT R,
     GE_CONTRATO G 
where /*s.operating_unit_id =4259 --3592
and */s.id_items_estado_inv = 1
AND O.OPERATING_UNIT_ID = s.operating_unit_id
AND R.OPERATING_UNIT_ID = s.operating_unit_id
And s.id_items_estado_inv = e.id_items_estado_inv
AND R.CONTRACTOR_ID = G.ID_CONTRATISTA 
AND g.STATUS ='AB'
--AND operating_sector_id  = 344
AND O.TASK_TYPE_ID =12150 
ORDER BY s.fecha_ingreso DESC
--and s.costo > 0
--and s.fecha_ingreso >'01/01/2020'
/*and s.items_id in (4294783,
100006243,
100006598,
100007374,
100007371,
10011198,
10010755,
100009076
)*/
--for update
--and s.serie like '%SH-21021310-19%'
SELECT *
FROM OR_OPE_UNI_TASK_TYPE
WHERE TASK_TYPE_ID =12150 ;

SELECT *
FROM GE_CONTRATO G
WHERE G.ID_CONTRATISTA = 21 ; 

SELECT CONTRACTOR_ID 
FROM OR_OPERATING_UNIT E
WHERE OPERATING_UNIT_ID = 3335
