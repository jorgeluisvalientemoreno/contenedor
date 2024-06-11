-- datos_producto
select s.sesunuse,
       s.sesususc, 
       s.sesucate,
       s.sesusuca,
       sesuplfa, 
       s.sesuesfn,
       s.sesucicl
from servsusc  s
where s.sesunuse = 51677702

select p.product_status_id
from pr_product  p
where product_id = 51677702
