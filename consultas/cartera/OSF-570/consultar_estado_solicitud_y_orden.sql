select pr.product_id  "PRODUCTO", 
       s.sesuesco ||'- '|| e.escodesc  "ESTADO DE CORTE", 
       p.package_id  "# SOLICITUD", 
       p.package_type_id || '-  ' || pt.description as "TIPO DE SOLICITUD", 
       p.motive_status_id || '-  ' || ms.description as "ESTADO DE SOLICITUD", 
       o.order_id "# ORDEN", 
       o.order_status_id || ' - ' || os.description as "ESTADO DE ORDEN", 
       o.created_date  "FECHA DE CREACION"
from open.pr_product  pr
left join open.servsusc  s on s.sesunuse = pr.product_id
left join open.estacort  e on e.escocodi = s.sesuesco
left join open.or_order_activity  a on a.product_id = pr.product_id
left join open.or_order  o on a.order_id = o.order_id
left join open.or_order_status  os on o.order_status_id = os.order_status_id
left join open.mo_packages  p on p.package_id = a.package_id
left join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
left join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
where o.order_id = 246625922