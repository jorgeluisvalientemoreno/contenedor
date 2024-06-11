select c.cuconuse  Producto, 
       s.sesususc Contrato, 
       s.sesucicl  Ciclo,
       s.sesucate  Categoria, 
       count (distinct c.cucocodi)  Cuenta_Cobro_Pendiente
from open.cuencobr  c  
inner join open.servsusc  s on s.sesunuse = c.cuconuse
where c.cucosacu > 0
and s.sesucate = 1
having count (distinct c.cucocodi) > 3
Group by c.cuconuse, s.sesususc, s.sesucicl, s.sesucate