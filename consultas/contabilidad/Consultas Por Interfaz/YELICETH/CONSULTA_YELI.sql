select 'F' tipo, sesuserv, sesususc Contrato, cargnuse Producto, o.concclco, i.clcodesc, cargconc, o.concdesc, cargcaca, g.cacadesc,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
  from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.servsusc ss, open.concepto o, open.ic_clascont i, open.causcarg g
 where cargnuse = sesunuse
   and CARGCUCO = CUCOCODI
   and factcodi = CUCOfact
   and FACTFEGE BETWEEN to_date('01/10/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
                    and to_date('31/10/2016 23:59:59','dd/mm/yyyy hh24:mi:ss')
   and cargtipr = 'A'
   and cargsign NOT IN ('PA','AP','SA')
   and cargcaca not in (51,50)
   and cargconc = conccodi  and concclco = i.clcocodi
   and concclco in (52,53)
   AND cargcaca = g.cacacodi
Group by sesuserv, o.concclco, i.clcodesc, cargconc, o.concdesc, sesususc, cargnuse, cargcaca, g.cacadesc
union all
select 'N' tipo, sesuserv, sesususc Contrato, cargnuse Producto, o.concclco, i.clcodesc, cargconc, o.concdesc, cargcaca, g.cacadesc,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
  from open.cargos c, open.servsusc ss, open.concepto o, open.ic_clascont i, open.causcarg g
 where cargnuse = sesunuse
   and cargfecr BETWEEN to_date('01/10/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
                    and to_date('31/10/2016 23:59:59','dd/mm/yyyy hh24:mi:ss')
   and cargtipr = 'P'
   and cargsign NOT IN ('PA','AP','SA')
   and cargcaca not in (51,50,20,46,73)
   and cargconc = conccodi  and concclco = i.clcocodi
   and concclco in (52,53)
   AND cargcaca = g.cacacodi
Group by sesuserv, o.concclco, i.clcodesc, cargconc, o.concdesc, sesususc, cargnuse, cargcaca, g.cacadesc
