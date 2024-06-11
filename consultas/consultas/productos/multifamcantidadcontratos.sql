select count(distinct ldc_info_predio_id) Cantidad, multivivienda
from ldc_info_predio l
inner join ab_address  a on a.estate_number = l.premise_id
inner join pr_product  p on p.address_id = a.address_id
inner join servsusc  s on s.sesunuse = p.product_id
group by multivivienda;