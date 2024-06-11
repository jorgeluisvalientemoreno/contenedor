select *
from open.reportes r, open.repoinco  rd
where repofech>='02/01/2019'
 and reinrepo=reponume
 and repoapli='100-85492'
-- and reindes4='BEFORE'
 and reincod1=1868
-- and reinval1=10003797
 and repofech=(select min(r2.repofech) from open.reportes r2, open.repoinco rd2 where r2.repoapli='100-85492' and rd2.reindes4='BEFORE' and r2.reponume=rd2.reinrepo and rd2.reincod1=rd.reincod1 and rd2.reinval1=rd.reinval1)
--group by reincod1, reinval1
 ;
 
select sum(reinval4)
from open.reportes r, open.repoinco  rd
where repofech>='02/01/2019'
 and reinrepo=reponume
 and repoapli='100-85492'
 and reindes4='AFTER'
 --and reincod1=1928
 --and reinval1=10003797
 and reinval4<0
 and repofech=(select max(r2.repofech) from open.reportes r2, open.repoinco rd2 where r2.repoapli='100-85492' and rd2.reindes4='AFTER' and r2.reponume=rd2.reinrepo and rd2.reincod1=rd.reincod1 and rd2.reinval1=rd.reinval1)
 ;
 select reincod1, reinval1, count(1)
from open.reportes r, open.repoinco
where repofech>='02/01/2019'
 and reinrepo=reponume
 and repoapli='100-85492'
 --and reincod1=3010
 --and reinval1=10001994
 having count(1)>2
group by reincod1, reinval1;

select *
from open.reportes r, open.repoinco  rd
where repofech>='02/01/2019'
 and reinrepo=reponume
 and repoapli='100-85492'
 --and reindes4='AFTER'
 and reincod1=1928
 and reinval1=10003797
