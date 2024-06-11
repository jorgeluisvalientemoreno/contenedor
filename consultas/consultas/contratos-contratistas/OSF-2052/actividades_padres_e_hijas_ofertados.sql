--actividades_padres_e_hijas_ofertados
select f.actividad_padre, 
       i.description,
       f.actividad_hija,
       i2.description
from ldc_act_father_act_hija  f
inner join ge_items  i  on i.items_id = f.actividad_padre
inner join ge_items  i2  on i2.items_id = f.actividad_hija
where f.actividad_padre in (100005921)

/*,4000063, 4294537,100003629,100003630,100008489*/


-- , 100003629
