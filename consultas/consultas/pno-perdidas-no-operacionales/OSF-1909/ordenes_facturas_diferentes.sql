select *--count (*)--distinct  a.order_id 
from open.or_order o , open.or_order_activity a 
where o.order_id = a.order_id 
and o.legalization_date >= '13/02/2024'
and (
select count (distinct a1.value_reference )
from   open.or_order_activity a1 
where  a.order_id  =  a1.order_id
 and a1.task_type_id = 12626 ) > 1 
