
select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       pr.product_type_id  Tipo_Producto, 
       p.package_id  Solicitud,
       p.package_type_id || '-  ' || pt.description as Tipo_Solicitud, 
       p.motive_status_id || '-  ' || ms.description as Estado_Solicitud,
       pm.promotion_id || '-  ' || cpm.description Promocion, 
       cpd.concept_id || '-  ' || concdesc Concepto 
from open.pr_product  pr
inner join open.mo_motive  m on m.product_id = pr.product_id
inner join open.mo_packages  p on p.package_id = m.package_id 
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.mo_mot_promotion  pm on pm.motive_id = m.motive_id
inner join open.cc_promotion  cpm on cpm.promotion_id = pm.promotion_id
inner join open.cc_prom_detail  cpd on cpd.promotion_id = cpm.promotion_id
inner join open.concepto  c on c.conccodi = cpd.concept_id
where p.package_id = 61779106
and pm.promotion_id in (86, 102)