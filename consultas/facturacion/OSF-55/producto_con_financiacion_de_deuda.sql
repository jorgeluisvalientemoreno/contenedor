select pr.subscription_id  Contrato, pr.product_id  Producto, pr.product_type_id  Tipo_Producto, p.package_id  Solicitud,
p.package_type_id || '-  ' || pt.description as Tipo_Solicitud, p.motive_status_id || '-  ' || ms.description as Estado_Solicitud,
p.messag_delivery_date  Fecha
from open.pr_product  pr
inner join open.mo_motive  m on m.product_id = pr.product_id
inner join open.mo_packages  p on p.package_id = m.package_id 
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
where p.package_type_id = 279
and pr.product_id = 1569832