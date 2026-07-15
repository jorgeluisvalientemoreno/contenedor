select *
from or_task_types_items i
inner join ge_items  it on it.items_id = i.items_id
where i.task_type_id in (12669)
and   it.item_classif_id = 2
and   it.description not like '%NOVEDAD%'
