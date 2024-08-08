select distinct li.items_id, price, sales_value
from open.ge_unit_cost_ite_lis li, open.ge_items i, open.ge_list_unitary_cost l
where li.items_id=i.items_id
  and li.list_unitary_cost_id=l.list_unitary_cost_id
  and l.description like '%2016%'
  and i.item_classif_id=21;
  
