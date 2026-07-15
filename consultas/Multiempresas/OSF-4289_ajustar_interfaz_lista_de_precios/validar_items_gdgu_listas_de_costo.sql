--validar_items_gdgu_listas_de_costo
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
inner join ge_items  i  on  i.items_id = dlc.items_id
where dlc.list_unitary_cost_id = 4471
and   exists (select 1
      from ldc_homoitmaitac hi
      where hi.item_actividad = dlc.items_id
       AND hi.empresa = 'GDGU')
order by dlc.list_unitary_cost_id desc
