select sesucicl , count(distinct (sesususc )) contratos_fact
from servsusc 
where  sesuesco not in ( 112,111,5,92,107,94,110,90,95) and sesuserv= 7014
group by sesucicl
order by contratos_fact desc  
;

--select * from confesco 
