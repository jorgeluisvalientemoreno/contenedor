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
and s.sesuesfn in ('A')
and pr.product_status_id in (1)
and pr.product_type_id = 7055
and exists(select null from open.perifact  pf
where pf.pefaactu = 'S'
and pf.pefaffmo >= '07/09/2022'
and pf.pefacicl = s.sesucico)
and exists(select null from open.diferido  d
left join open.cc_grace_peri_defe  gp on gp.deferred_id = d.difecodi
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.concepto  c on c.conccodi = d.difeconc
left join open.cc_grace_period  pc on pc.grace_period_id = gp.grace_period_id
where d.difenuse = pr.product_id
and d.difetire = 'D'                 
and d.difesign in ('DB', 'CR')                 
and d.difesape > 0)