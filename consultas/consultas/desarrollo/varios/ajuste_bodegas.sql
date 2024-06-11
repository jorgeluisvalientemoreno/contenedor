select reindes4, sum(reinval3), count(1)
from open.reportes, open.repoinco
where reponume=reinrepo
  and repofech>='31/01/2018'
  and repodesc like '%100-58530%'
  group by reindes4;
--  order by reincodi, reinval1
