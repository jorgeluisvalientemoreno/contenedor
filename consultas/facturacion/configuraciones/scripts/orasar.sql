select a.order_id||';'||'4938'
from or_order r
left join or_order_activity a  on a.order_id = r.order_id
left join servsusc on a.product_id = sesunuse
where sesucicl in (6054)
--and pecscons =101928
 and r.task_type_id in (10043)
and r.order_status_id  in (0)
