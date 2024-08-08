select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       pr.product_type_id  Tipo_Producto, 
       pr.commercial_plan_id || '-  ' || cp.name  Plan_Comercial, 
       s.sesucico  Ciclo,
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       s.sesuesco || '-  ' || escodesc as Estado_Corte,
       s.sesuesfn  Estado_Finaciero
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.cc_commercial_plan  cp on cp.commercial_plan_id = pr.commercial_plan_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where s.sesucate = 1
and s.sesuesfn in ('M')
and pr.product_status_id in (1)
and pr.product_type_id = 7055
and exists(select null from open.perifact  pf
where pf.pefaactu = 'S'
and pf.pefaffmo >= '07/09/2022'
and pf.pefacicl = s.sesucico)
and pr.product_id = 280447