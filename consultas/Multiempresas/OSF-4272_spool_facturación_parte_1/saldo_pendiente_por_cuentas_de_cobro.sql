select sesususc "Contrato",
       sesunuse "Producto",
       sesuserv "Tipo Producto",
       cucofact "No Factura",
       cucofeve "Fecha vencimiento",
       cucocodi "cuentas de cobro",
       nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0) "Saldo pend"
from cuencobr  cc
inner join servsusc ss  on ss.sesunuse = cc.cuconuse
where 1 = 1
 and ss.sesususc in (66400648,66400614,48179410,48179399,48179448,1124917,2189062,67118511,48179411)
 and cc.cucosacu  > 0
group by sesunuse, cucofeve, sesuserv, cucofact, sesususc, cucocodi
 order by cucofeve desc;
