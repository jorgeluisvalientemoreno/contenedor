--saldo_pendiente
select sesususc "Contrato",
       sesunuse "Producto",
       sesuserv "Tipo Producto",
       cucofact "No Factura",
       cucofeve "Fecha vencimiento",
       cucocodi "cuentas de cobro",
       nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0) "Saldo pend "
  from servsusc, cuencobr
 where sesususc = 17138177
 and cuconuse = sesunuse
 group by sesunuse, cucofeve, sesuserv, cucofact, sesususc, cucocodi
 order by cucofeve desc;
 
 
 --
 
 --and cucosacu is not null
  --and cucocodi in (3049751578)
 
 
--and  cucocodi = 3049751570
