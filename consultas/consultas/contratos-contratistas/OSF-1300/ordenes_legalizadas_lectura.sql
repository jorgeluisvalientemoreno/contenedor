select * /*a.activity_id,
        s.sesucicl,
        o.operating_unit_id,
        o.order_status_id,
        saved_data_values,
        o.is_pending_liq,
        oi.value,
        o.order_value,
        count (t.description)*/
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 left join open.or_order_activity a on a.order_id = o.order_id
 left join open.or_order_items oi on oi.order_id = o.order_id
 left join  open.pr_product  p on p.product_id = a.product_id 
 left join  open.servsusc  s on s.sesunuse = a.product_id 
 left join  open.ge_items  i on i.items_id = a.activity_id
 Where  o.order_status_id in (8)
 and     p.product_id = 1999573
/*and    o.operating_unit_id = 4440
--and extract(year from o.legalization_date) = 2023
---and extract(month from o.legalization_date) = 7
and o.is_pending_liq = 'Y'
 group by a.activity_id,
         s.sesucicl,
        o.operating_unit_id,
        o.order_status_id,
        saved_data_values,
        o.is_pending_liq,
        oi.value,
        o.order_value*/
 order by o.legalization_date desc;
 
/* update or_order o set o.legalization_date = '08/08/2023' Where o.task_type_id in (12617) and o.order_status_id in (8) and o.legalization_date = '09/08/2023' and  o.order_id not in (294128619,
294128620
)
*/

/*o.task_type_id in (12617)
 and 
 
 
and    oi.value > 0


 */ 
