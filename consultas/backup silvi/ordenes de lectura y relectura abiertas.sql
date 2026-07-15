select a.product_id,
       a.order_id,
       r.task_type_id,
       r.created_date,
       sesucate, 
       r.order_status_id
from or_order r
left join or_order_activity a  on a.order_id = r.order_id
left join servsusc on a.product_id = sesunuse 
where sesucicl in (1001) 
--and pecscons =101928
 and r.task_type_id in (12617,10043)
and r.order_status_id  in (0,5)
and rownum <= 1 





/*AND  PECSCONS = 101950
*/
--PKGOSFFACTURE 
