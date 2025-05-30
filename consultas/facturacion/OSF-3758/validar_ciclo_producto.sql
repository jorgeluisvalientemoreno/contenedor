--validar_ciclo_producto
select s.sesunuse,
       s.sesucicl,
       s.sesucico,
       s1.susccicl
from servsusc  s
inner join suscripc  s1  on s1.susccodi = s.sesususc
inner join pr_product pr on pr.product_id = s.sesunuse
inner join ab_address d on d.address_id = pr.address_id
where s.sesunuse = 2018012
