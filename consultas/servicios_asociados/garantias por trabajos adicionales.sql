select distinct o.order_id, o.order_status_id, o.task_type_id, a.product_id, g.cod_group_warranty_id, g2.task_type_id
from open.or_order o
inner join open.or_order_activity a on o.order_id=a.order_id
, open.LDC_GRUPTITRGARA g 
, open.LDC_GRUPTITRGARA g2 
, LDC_TIPOTRABADICLEGO T
where o.task_type_id=12155
  and o.order_status_id in (5,7)
  and not exists(select null from open.ldc_otlegalizar l where l.order_id=o.order_id)
  and exists(select null from open.ge_item_warranty w, open.or_order ot  where w.product_id=a.product_id and w.final_warranty_date>=sysdate+30 and ot.order_id=w.order_id and g.task_type_id=ot.task_type_id)
  and a.product_id=50921153
  and g2.cod_group_warranty_id=g.cod_group_warranty_id
  AND T.TIPOTRABLEGO_ID=O.task_type_id
  AND T.TIPOTRABADICLEGO_ID=G2.TASK_TYPE_ID
