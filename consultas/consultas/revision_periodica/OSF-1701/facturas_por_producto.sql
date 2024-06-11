--facturas_por_producto
select *
from factura  f
where f.factsusc = 48202612
and   f.factpefa = 107378
order by f.factfege desc

