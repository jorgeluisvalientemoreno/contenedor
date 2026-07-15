select sesususc , sesunuse , sesuserv , sesuesco , sesuesfn , sesucicl ,f.factcodi , f.factpefa, f.factfege , f.factvaap
from servsusc , factura f
where sesuserv = 7057 and factsusc = sesususc 
and sesucicl = 2201 and factpefa= 110952
and exists ( select null from cargos where cargnuse = sesunuse and cargcuco != -1 and cargconc in (983))
order by factfege desc 
