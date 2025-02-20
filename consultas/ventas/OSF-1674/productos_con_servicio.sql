--productos_con_servicio
select s.sesususc,
       s.sesunuse,
       s.sesuserv,
       s.sesucate,
       s.sesusuca,
       p.address_id,
       p.product_status_id
from servsusc  s
inner join pr_product  p  on p.product_id = s.sesunuse
where s.sesuserv = 7014
and   p.product_status_id = 1
and   s.sesucate = 1
and   s.sesusuca = 2
