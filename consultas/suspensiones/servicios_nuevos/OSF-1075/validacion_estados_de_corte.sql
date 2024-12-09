-- Validacion estados de corte_auroreconectados
select ss.sesuesco  "Estado_corte",
       c.escodesc   "Desc_Estado_corte",
       ec.coecfact  "Facturable",
       count (a.saresesu)
from ldc_susp_autoreco_rp_pl  a
inner join servsusc ss on ss.sesunuse = a.saresesu
inner join estacort c on c.escocodi = ss.sesuesco
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
where a.sareproc = 7
group by ss.sesuesco,c.escodesc, ec.coecfact
order by ec.coecfact desc

-- Validacion estados de corte_persecucion
select ss.sesuesco  "Estado_corte",
       c.escodesc   "Desc_Estado_corte",
       ec.coecfact  "Facturable",
       count (a.susp_persec_producto)
from ldc_susp_persecucion_pl  a
inner join servsusc ss on ss.sesunuse = a.susp_persec_producto
inner join estacort c on c.escocodi = ss.sesuesco
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
group by ss.sesuesco,c.escodesc, ec.coecfact
order by ec.coecfact desc

