 select cucofact "cuentas de cobro", (sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend "
from servsusc, cuencobr
where cuconuse = sesunuse
and cucosacu > 0
  group by sesunuse, sesuserv,cucofact;