--homologacion_items_material_items_actividad_resumen
SELECT 
    hi.empresa,
    i.item_classif_id AS clasificacion_material,
    i2.item_classif_id AS clasificacion_actividad,
    COUNT(*) AS cantidad_items
FROM ldc_homoitmaitac hi
INNER JOIN ge_items i ON i.items_id = hi.item_material
INNER JOIN ge_items i2 ON i2.items_id = hi.item_actividad
GROUP BY 
    hi.empresa,
    i.item_classif_id,
    i2.item_classif_id
ORDER BY 
    hi.empresa,
    i.item_classif_id,
    i2.item_classif_id;

--WHERE hi.empresa = 'GDGU'


--homologacion_items_material_items_actividad_detalle

select hi.item_material,
       i.description,
       i.item_classif_id,
       hi.item_actividad,
       i2.description,
       i2.item_classif_id,
       i2.measure_unit_id,
       hi.empresa
from ldc_homoitmaitac hi
inner join ge_items  i  on i.items_id = hi.item_material
inner join ge_items  i2  on i2.items_id = hi.item_actividad
where 1= 1
AND hi.empresa = 'GDGU'


/*hi.item_material in (10000126,10000240,10000637,10000680,10000766,10000807,10000844,10000874,10000934,10000972,10001876,10002106,10002824,
10004070,10004317,10004558,10004984,10006401,10006848,10007296)*/
--hi.empresa = 'GDGU' 

--update ldc_homoitmaitac hi  set hi.item_material = 10000126 where hi.item_actividad = 100010655
-- hi.item_material = 10006401
;

/*
select max(i.items_id)+1
from ge_items  i
where */

  
