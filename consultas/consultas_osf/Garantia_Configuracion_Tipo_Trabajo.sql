select distinct *
  from open.ge_item_warranty    b,
       open.or_task_types_items c,
       open.LDC_GRUPTITRGARA    d
 where b.item_id = c.items_id
   and b.product_id = 1509774
   and d.task_type_id = c.task_type_id
   and d.cod_group_warranty_id = 1
