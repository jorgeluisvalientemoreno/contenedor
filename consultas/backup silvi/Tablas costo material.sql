select ge_unit_cost_ite_lis.price
from open.ge_unit_cost_ite_lis
where ge_unit_cost_ite_lis.list_unitary_cost_id = 3966;

select *
  from OPEN.OR_OPE_UNI_ITEM_BALA a
  --where a.total_costs != 0
 where a.items_id in
       (10004070)
   and a.operating_unit_id = 3343;
