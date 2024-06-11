select p.package_id  Solicitud, 
       p.package_type_id || '-  ' || pt.description as Tipo_Solicitud,  
       p.motive_status_id || '-  ' || ms.description as Estado_Solicitud, 
       o.order_id Orden, 
       o.order_status_id || ' - ' || os.description as Estado_Orden, 
       pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       pr.product_type_id  Tipo_Producto, 
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       s.sesuesco || '-  ' || escodesc as Estado_Corte, 
       s.sesucate || '-  ' || c.catedesc as Categoria
from open.mo_packages  p
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.mo_motive  m on p.package_id = m.package_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.or_order_activity  a on p.package_id = a.package_id
inner join open.or_order  o on a.order_id = o.order_id 
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
inner join open.pr_product  pr on m.product_id = pr.product_id
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.categori  c on c.catecodi = s.sesucate
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where p.package_type_id = 100240
and p.motive_status_id in (13)
and o.order_status_id = 12
and pr.product_type_id = 7014
and pr.product_id = 6527780