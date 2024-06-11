select p.product_id Producto, 
       p.subscription_id Contrato, 
       p.product_type_id Tipo_Producto, 
       s.sesucicl Ciclo, 
       s.sesuesco || '-  ' || ec.escodesc as Estado_Corte, 
       ad.address Direccion, 
       ip.multivivienda Multifamiliar
from open.pr_product  p
inner join open.ab_address  ad on ad.address_id = p.address_id
inner join open.ab_premise  ap on ap.premise_id = ad.estate_number
inner join open.ldc_info_predio ip on ip.premise_id = ap.premise_id
inner join open.servsusc  s on s.sesunuse = p.product_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where p.product_type_id = 7014
and s.sesuesco in (5)
and exists(select count(distinct ip2.ldc_info_predio_id) Cantidad, ip2.multivivienda 
from open.ldc_info_predio ip2
where ip2.multivivienda != -1
having count(distinct ip2.ldc_info_predio_id) > 6
and ip2.multivivienda = ip.multivivienda
group by ip2.multivivienda)
order by ip.multivivienda;