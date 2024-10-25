--cupones_disponibles_por_contrato
select s.sesunuse,
       c.cuponume,
       c.cupoflpa,
       c.cupotipo,
       c.cupovalo,
       c.cupofech,
       c.cupoprog
  from cupon c
   inner join servsusc  s  on c.cuposusc = s.sesususc
 where s.sesunuse = 13000636
   and cupoflpa = 'N'
   and cupoprog= 'FIDF'
 order by cupofech desc
