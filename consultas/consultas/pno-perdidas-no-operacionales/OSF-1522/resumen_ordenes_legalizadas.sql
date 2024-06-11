select   o.task_type_id,
        trunc(o.legalization_date)  "Fecha Legalizacion",
        ad.geograp_location_id,
        lo.description,
        s.sesucate, 
        o.operating_unit_id, 
        u.contractor_id,
        o.is_pending_liq,
        o.saved_data_values,
        oi.items_id,
        sum (oi.legal_item_amount)  cantidad,
        sum (oi.value)  valor,
        count (o.order_id)  ordenes
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join  or_operating_unit  u on u.operating_unit_id = o.operating_unit_id
 left join  open.pr_product  p on p.product_id = a.product_id 
 left join  open.servsusc  s on s.sesunuse = a.product_id 
 left join  open.ab_address  ad on ad.address_Id = p.address_id
 left join  ge_geogra_location  lo on lo.geograp_location_id = ad.geograp_location_id
 left join  open.ge_items  i on i.items_id = a.activity_id
 left join  open.or_order_items  oi on oi.order_id = o.order_id
 Where o.task_type_id = 12617
and   o.order_status_id = 8
and   o.legalization_date >= '01/09/2023' 
and   o.saved_data_values is not null 
and    o.operating_unit_id in (1888,1889,1890,4439,4440,4441)
--and    oi.items_id = 100010088
 group by o.task_type_id, o.legalization_date, ad.geograp_location_id,lo.description, s.sesucate, u.contractor_id, o.operating_unit_id, o.legalization_date,
        o.is_pending_liq,  o.saved_data_values, oi.items_id,oi.legal_item_amount, oi.value
 order by o.legalization_date desc, o.operating_unit_id desc;
 
 
