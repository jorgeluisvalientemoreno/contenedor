select distinct (difenuse) /*, difesusc ,difeconc , difesape , difepldi */
from diferido d
where difesusc in (select subscription_id
                  from or_order o
                  left join or_order_activity  a on o.order_id = a.order_id 
                  where  a.subscription_id = difesusc 
                  and o.order_status_id in (0,5)
                  and o.task_type_id in (11259))
and difesape >0 
and difepldi in (110,111,113) 
