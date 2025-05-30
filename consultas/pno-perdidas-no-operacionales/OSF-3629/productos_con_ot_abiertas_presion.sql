select o.order_id,order_status_id , o.task_type_id  , product_id , register_date 
from or_order o , or_order_activity a 
where o.order_id = a.order_id and o.task_type_id = 10949 
and order_status_id = 5 
and  not exists ( select null 
             from cm_vavafaco
             where vvfcvafc= 'PRESION_OPERACION'
             and  vvfcsesu= product_id
             and vvfcfefv >= trunc(sysdate) )
and  exists ( select null 
             from cm_vavafaco
             where vvfcvafc= 'PRESION_OPERACION'
             and  vvfcsesu= product_id
             and vvfcfefv < trunc(sysdate) );