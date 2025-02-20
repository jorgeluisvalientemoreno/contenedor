--cupones_disponibles_por_producto
select s.sesunuse,
       c.cuponume,
       c.cupoflpa,
       c.cupotipo,
       c.cupovalo,
       c.cupofech,
       c.cupoprog
  from cupon c
   inner join servsusc  s  on c.cuposusc = s.sesususc
 where s.sesunuse = 52989913
   and cupoflpa = 'N'
 order by cupofech desc
