--facturas_por_producto
select f.*
from factura  f
inner join servsusc  ss  on ss.sesususc = f.factsusc
where ss.sesunuse in (51934529)
and   f.factpefa = 113347
order by f.factfege desc

