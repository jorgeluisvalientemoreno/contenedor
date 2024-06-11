select pr.product_id  Producto, 
       pr.subscription_id  Contrato, 
       pr.product_type_id || '-  ' || s.servdesc as Tipo_Producto, 
       sc.sesucico  Ciclo,
       pr.product_status_id || '-  ' || ps.description  as Estado_Producto, 
       sp.credit_bureau_id || '-  ' || credit_bureau_desc  as Central_Riesgo,
       sc.sesuesco || '-  ' || e.escodesc  as Estado_Corte, 
       max(p.request_date)  Fecha_Registro
from open.pr_product  pr
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.servsusc  sc on sc.sesunuse = pr.product_id
inner join open.servicio  s on s.servcodi = pr.product_type_id
inner join open.estacort  e on e.escocodi = sc.sesuesco
inner join open.ld_sector_product  sp on sp.product_id = s.servcodi
inner join open.ld_credit_bureau  cr on cr.credit_bureau_id = sp.credit_bureau_id
inner join open.mo_motive  m on m.product_id = pr.product_id
inner join open.mo_packages  p on p.package_id = m.package_id
inner join open.cuencobr  cc on cc.cuconuse = pr.product_id
where pr.product_type_id in (7055,7056)
and pr.product_status_id in (1,2)
and sc.sesuesco not in (92,96,110)
and p.package_type_id = 100264
and p.request_date between '01/01/2022' and '01/07/2022'
and p.motive_status_id = 14
and sp.credit_bureau_id = 1
and cc.cucosacu > 0
and pr.product_id = 51885906
and not exists(select null 
from open.trcasesu  t
where pr.product_id = t.tcsessde)
group by pr.product_id, pr.subscription_id, pr.product_type_id || '-  ' || s.servdesc, sc.sesucico,
pr.product_status_id || '-  ' || ps.description, sp.credit_bureau_id || '-  ' || credit_bureau_desc, sc.sesuesco || '-  ' || e.escodesc
order by max(p.request_date) desc