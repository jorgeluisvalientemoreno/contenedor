select count(distinct ldc_info_predio_id) Cantidad, 
       multivivienda
from open.ldc_info_predio l
inner join open.ab_address  a on a.estate_number = l.premise_id
inner join open.pr_product  p on p.address_id = a.address_id
inner join open.servsusc  s on s.sesunuse = p.product_id
where multivivienda = 7238
and p.product_type_id = 7014
and s.sesuesco not in (96,110)
group by multivivienda;