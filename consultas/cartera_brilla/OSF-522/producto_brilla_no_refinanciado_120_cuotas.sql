select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       pr.product_type_id  Tipo_Producto, 
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       s.sesuesco || '-  ' || escodesc as Estado_Corte, 
       s.sesusuca  Subcategoria,
       s.sesuesfn  Estado_Finaciero
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.categori  c on c.catecodi = s.sesucate
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where s.sesucate = 1
and s.sesuesco in (1,2)
and pr.product_type_id = 7055
and not exists(select null 
from open.cuencobr  cc 
where cc.cuconuse = pr.product_id
and cc.cucovare > 0)
and not exists (select d2.difenuse, count(distinct(d2.difecofi))
from open.diferido  d2
where d2.difenuse = pr.product_id
and d2.difeprog = 'GCNED'
having count(distinct(d2.difecofi)) > 0
group by d2.difenuse)
and exists (select null
from open.diferido  d
where d.difenuse = pr.product_id
and d.difenucu = 120
and d.difesape > 0)
and pr.product_id = 52272382;