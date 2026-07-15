--cupones_disponibles_por_contrato
select c.cuponume,
       c.cupoflpa,
       c.cupotipo,
       c.cupovalo,
       c.cupofech,
       c.cupoprog
  from cupon c
 where c.cuposusc in (66400648,66400614,48179410,48179399,48179448,1124917,2189062,67118511,48179411)
  and c.cupofech >= '20/06/2025'
  and c.cupoflpa = 'S'
 order by cupofech desc
