--cupones
select c.cuposusc,
       mc.empresa,
       c.cuponume,
       c.cupovalo
from cupon  c
 inner join servsusc  s  on s.sesususc = c.cuposusc and s.sesuserv = 7014
 inner join ciclo_facturacion  mc  on mc.ciclo = s.sesucicl
where c.cupofech >= '27/08/2025'
and   c.cuponume in (905936535, 905936532, 905936536, 905936534)
order by c.cupofech desc
