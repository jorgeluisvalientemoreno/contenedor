select p.product_id  Producto, 
       p.subscription_id  Contrato, 
       o.order_id  Orden, 
       o.task_type_id  Tipo_Trabajo, 
       o.order_status_id  Estado_Orden, 
       oa.activity_id  Actividad, 
       w.item_id  Item, 
       w.final_warranty_date  Fecha_Final_Garantia, 
       s.sesuesco || '-  ' || ec.escodesc as Estado_Corte, 
       o.operating_unit_id  Unidad_Operativa, 
       ip.multivivienda  Multifamiliar ,
       s.sesucicl
from open.or_order  o
inner join open.or_order_activity  oa on oa.order_id = o.order_id 
inner join open.pr_product  p on p.product_id = oa.product_id
inner join open.servsusc  s on s.sesunuse = p.product_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
inner join open.or_operating_unit  opu on opu.operating_unit_id = o.operating_unit_id
inner join open.ab_address  ad on ad.address_id = p.address_id
inner join open.ab_premise  ap on ap.premise_id = ad.estate_number
inner join open.ldc_info_predio ip on ip.premise_id = ap.premise_id
left join open.ge_item_warranty  w on w.product_id = p.product_id
where o.task_type_id = 12487
and oa.activity_id = 4000380
and p.product_type_id = 7014
and ip.multivivienda != -1
and o.order_status_id = 5
and w.final_warranty_date > sysdate
and o.order_id = 263103195
order by p.product_id desc

