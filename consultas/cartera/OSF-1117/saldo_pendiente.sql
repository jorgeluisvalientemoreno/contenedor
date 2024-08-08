 select cucofact "No Factura",cucocodi "cuentas de cobro" ,sesususc "Contrato",sesunuse "Producto" ,sesuserv  "Tipo Producto",cucofeve "Fecha vencimiento", nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)),0) "Saldo pend "
from servsusc, cuencobr
where sesususc = 14218407
and cuconuse = sesunuse
group by sesunuse,cucofeve, sesuserv,cucofact,sesususc ,cucocodi
order by cucofeve desc ;