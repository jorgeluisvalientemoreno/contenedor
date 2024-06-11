--saldo_pendiente
select sesususc "Contrato",
       sesunuse "Producto",
       sesucicl "Ciclo",
       sesuserv "Tipo Producto",
       cucofact "No Factura",
       cucofeve "Fecha vencimiento",
       cucocodi "cuentas de cobro",
       nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0) "Saldo pend "
  from servsusc
  inner join cuencobr on cuconuse = sesunuse
 where sesuserv = 7055
 and   cucosacu >0
 and   rownum <= 10
 and   exists
 (select null
 from cargos
 where cargcuco = cucocodi
 and   cargconc = 220)
 group by sesunuse, cucofeve, sesuserv, cucofact, sesususc, cucocodi, sesucicl
 order by cucofeve desc;

--sesunuse = 1106855
