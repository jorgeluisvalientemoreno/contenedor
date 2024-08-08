--facturas_por_producto
select f.*
from factura  f
inner join servsusc  ss  on ss.sesususc = f.factsusc
where ss.sesunuse in (51877218)
and   f.factpefa = 107378
order by f.factfege desc

