--validacion_listas_de_costo_items_homologados
select dlc.items_id,
       i.description,
       i.item_classif_id,
       dlc.list_unitary_cost_id,
       dlc.price,
       dlc.last_update_date,
       dlc.user_id,
       dlc.terminal,
       dlc.sales_value
from ge_unit_cost_ite_lis dlc
 inner join ge_items  i  on i.items_id = dlc.items_id
where dlc.list_unitary_cost_id in (4471)
 and exists (
   select 1  from ldc_homoitmaitac hi  where hi.item_actividad = dlc.items_id and hi.empresa = 'GDCA')
order by dlc.list_unitary_cost_id desc;


select hi.item_material,
       hi.item_actividad,
       hi.empresa
from ldc_homoitmaitac hi
where 1= 1
and hi.empresa = 'GDGU'
and not exists (
   select 1  from ge_unit_cost_ite_lis dlc  where dlc.items_id = hi.item_actividad and dlc.list_unitary_cost_id in (4471))


--and  dlc.items_id = 10000241
--for update;
