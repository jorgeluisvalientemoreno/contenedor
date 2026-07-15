--validacion_listas_de_costo_items_nuevos
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
where dlc.list_unitary_cost_id in (4466)
 and not exists (
   select 1  from ge_unit_cost_ite_lis dlc2  where dlc2.items_id = dlc.items_id and dlc2.list_unitary_cost_id in (4471))
order by dlc.list_unitary_cost_id desc



--and  dlc.items_id = 10000241

