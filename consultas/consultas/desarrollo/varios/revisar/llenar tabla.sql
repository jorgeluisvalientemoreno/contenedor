select seq_ldc_taskactcostprom.nextval ,cons.*
from (select  distinct ti.task_type_id, i.items_id, 0, null
from ct_tasktype_contype c, or_task_types_items ti, ge_items i
where contract_type_id in (9  ,10 ,11 ,12 ,13 ,14 ,21 ,22 ,141, 870)
  and c.task_type_id =ti.task_type_id
  and ti.items_id = i.items_id
  and i.item_classif_id=2) cons;
 
select *
from ldc_taskactcostprom
for update
