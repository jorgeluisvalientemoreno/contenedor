select pr.product_id  "PRODUCTO", 
       pr.subscription_id  "CONTRATO", 
       pr.product_type_id  "TIPO DE PRODUCTO", 
       s.sesuesco ||'- '|| e.escodesc  "ESTADO DE CORTE", 
       p.package_id  "# SOLICITUD", 
       p.package_type_id || '-  ' || pt.description as "TIPO DE SOLICITUD", 
       p.motive_status_id || '-  ' || ms.description as "ESTADO DE SOLICITUD", 
       o.order_id "# ORDEN", 
       o.order_status_id || ' - ' || os.description as "ESTADO DE ORDEN", 
       o.task_type_id || '-  ' || tt.description  "TIPO DE TRABAJO", 
       o.created_date  "FECHA DE CREACION"
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.estacort  e on e.escocodi = s.sesuesco
inner join open.or_order_activity  a on a.product_id = pr.product_id
inner join open.or_order  o on a.order_id = o.order_id
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
inner join open.or_task_type  tt on tt.task_type_id = o.task_type_id
inner join open.mo_packages  p on p.package_id = a.package_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
where o.order_status_id in (0,5,11)
and o.task_type_id in (10169,10546,10547,10559,12523,12525,12526,12527,12521,12528,12529,12530,12524,10917,10918,10598,10597)
and exists(select null 
from open.or_order  o2
where o2.order_id = p.package_id
and o2.order_status_id in (0,5,11)
and o2.task_type_id in (10169,10546,10547,10559,12523,12525,12526,12527,12521,12528,12529,12530,12524,10917,10918,10598,10597))