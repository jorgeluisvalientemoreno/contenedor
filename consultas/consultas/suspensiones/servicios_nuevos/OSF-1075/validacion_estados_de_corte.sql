-- Validaci�n estados de corte
select ss.sesuesco  "Estado_corte",
       c.escodesc   "Desc_Estado_corte",
       ec.coecfact  "Facturable",
       count (a.saresesu)
from ldc_susp_autoreco_sj  a
inner join servsusc ss on ss.sesunuse = a.saresesu
inner join estacort c on c.escocodi = ss.sesuesco
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
where a.sareproc = 7
and   ec.coecfact = 'N'
where a.sareproc = 7
and   ec.coecfact = 'N'
group by ss.sesuesco,c.escodesc, ec.coecfact
order by ec.coecfact desc



--
