select b.product_id , b.order_id ,  b.order_id||'|'||9865||'|'||38963||'|'||''||'|'||b.order_activity_id ||'>1;>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||3;Se genera orden para reclasificar categoría del usuario según PL-02-PD-O-08 Política de Cambio de Uso según el inciso 5.4 y el Procedimiento de Venta de Gas Natural a Gran Industria'||'|'||trunc(sysdate)||';'||sysdate 
from open.OR_ORDER a 
inner join open.or_order_activity b on  b.order_id=a.order_id
inner join open.mo_packages m on m.package_id = b.package_id 
where b.task_type_id=10430
and   a.ORDER_STATUS_ID  in (5) 
and m.package_type_id= 100225
and m.request_date >= trunc (sysdate) 
and b.subscription_id  in (6703945)
and created_date >= trunc(sysdate) 


--13549 person id de german polo
--revisar que comentario dejar 
