 select cucofact "cuentas de cobro",cargpefa,cucosacu,cucovare,cucovrap -- (sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend "
from servsusc, cuencobr , cargos c 
where cuconuse = sesunuse
and cucocodi = cargcuco 
and cucosacu > 0
and cuconuse = 1000029 
 group by sesunuse, sesuserv, cucofact,cargpefa,cucosacu,cucovare,cucovrap