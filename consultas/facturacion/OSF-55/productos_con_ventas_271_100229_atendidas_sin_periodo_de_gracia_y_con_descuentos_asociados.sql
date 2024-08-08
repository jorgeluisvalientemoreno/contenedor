select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       pr.product_type_id  Tipo_Producto, 
       p.package_id  Solicitud,
       s.sesucico  Ciclo, 
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       s.sesuesco || '-  ' || escodesc as Estado_Corte,
       p.package_type_id || '-  ' || pt.description as Tipo_Solicitud, 
       p.motive_status_id || '-  ' || ms.description as Estado_Solicitud,
       p.messag_delivery_date  Fecha
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.cc_commercial_plan  cp on cp.commercial_plan_id = pr.commercial_plan_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
inner join open.mo_motive  m on m.product_id = pr.product_id
inner join open.mo_packages  p on p.package_id = m.package_id
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
where s.sesucate = 1
and s.sesuesco not in (5)
and pr.product_type_id = 7014
and p.package_type_id in (271,100229)
and p.motive_status_id in (14)
and not exists(select null 
from open.diferido d
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.cc_grace_period  pc on pc.grace_period_id = pd.pldipegr
left join open.cc_grace_peri_defe  pg on pg.deferred_id = d.difecodi
where d.difenuse = pr.product_id
and pd.pldipegr is not null)
and exists(select null 
from cargos  c
where c.cargnuse = pr.product_id
and c.cargconc in (102,798))
