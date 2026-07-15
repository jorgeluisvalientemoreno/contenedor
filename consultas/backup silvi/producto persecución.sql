select sesunuse , sesususc,o.order_id , o.order_status_id , o.subscriber_id, o.task_type_id ,sesuesco ,sesuesfn
from or_order o , servsusc , OR_ORDER_ACTIVITY t
where o.order_id = t.order_id
and sesunuse  = t.PRODUCT_ID
and o.task_type_id in (12521,10169,10884, 10918) 
 AND  o.order_status_id in (0,5)
and sesuesco  in (3);
 
 SELECT *
 FROM CUPON
 WHERE CUPOSUSC = 66455407
 ORDER BY CUPOFECH DESC;
