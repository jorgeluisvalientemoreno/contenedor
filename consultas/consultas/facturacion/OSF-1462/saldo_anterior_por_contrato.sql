select  s1.sesususc "Contrato", s1.sesunuse "Producto", s1.sesuserv "Tipo producto",cucofact "Factura",cucocodi"cuentas de cobro",cucosacu "Saldo_cuenta_cobro" ,cucovare "Valor_reclamo",cucovrap , (sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend "
from servsusc s1, cuencobr
where cuconuse = s1.sesunuse 
and cucosacu > 0  and sesususc  =48195391 and cucofact not in (2117173573) and cucovare<cucosacu
group by  s1.sesunuse, s1.sesususc,  s1.sesuserv,cucofact,cucovare,cucosacu,cucocodi ,cucovrap
order by  s1.sesususc;