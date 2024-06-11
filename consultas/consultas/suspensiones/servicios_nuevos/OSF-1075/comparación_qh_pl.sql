-- Comparación QH y PL
select s.sareproc, ec.coecfact, count (s.saresesu) parametro_6,
(select count (s2.saresesu)from ldc_susp_autoreco s2 
inner join servsusc ss2 on ss2.sesunuse = s2.saresesu
inner join confesco  ec2 on ec2.coecserv = ss2.sesuserv and ss2.sesuesco = ec2.coeccodi
where s2.sareproc = s.sareproc and ec.coecfact = ec2.coecfact) parametro_null
from open.ldc_susp_autoreco_jc s
inner join servsusc ss on ss.sesunuse = s.saresesu
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
where  s.sareproc = 7
group by s.sareproc, ec.coecfact
