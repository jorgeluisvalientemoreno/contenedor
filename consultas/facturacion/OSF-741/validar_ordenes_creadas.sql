 select product_id,
       o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id status ,
       o.operating_unit_id,
       o.created_date, 
       o.legalization_date
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
 left join or_order_activity a on a.order_id = o.order_id
 left join or_requ_Data_value da on da.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join or_order_person p on p.order_id= o.order_id
 left join ge_person pe on pe.person_id = p.person_id
 Where product_id in (50053840,50035937,50040254,50018681,
50052840,50052255,1173565,50296812,50037722,50035938)
 and o.created_date > '20/12/2022'
 and o.order_status_id  not in (0,5,12)
 order by o.created_date  desc 
