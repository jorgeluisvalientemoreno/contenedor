--homologacion items de material - items de actividad
select hi.item_material,
       hi.item_actividad,
       hi.empresa
from ldc_homoitmaitac hi
where 1= 1
and   hi.item_material = 10000126
and hi.empresa = 'GDGU'
