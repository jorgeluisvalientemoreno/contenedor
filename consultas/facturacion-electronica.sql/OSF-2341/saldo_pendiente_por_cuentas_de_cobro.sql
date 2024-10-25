--saldo_pendiente_por_cuentas_de_cobro
select sesususc "Contrato",
       sesunuse "Producto",
       sesuserv "Tipo Producto",
       cucofact "No Factura",
       cucofeve "Fecha vencimiento",
       cucocodi "cuentas de cobro",
       nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0) "Saldo pend"
  from servsusc, cuencobr
 where sesususc = 1131976
 and cuconuse = sesunuse
 and cucosacu  > 0
 group by sesunuse, cucofeve, sesuserv, cucofact, sesususc, cucocodi
 order by cucofeve desc;
