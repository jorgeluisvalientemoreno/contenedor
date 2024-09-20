select to_char(FACTFEGE,'yyyymm') Periodo, cargtipr, concclco, ic.clcodesc, cargconc, concdesc, cargsign, substr(cargdoso,1,2) tipo,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
 from open.cargos c, open.concepto o, open.causcarg g, open.servsusc ss, OPEN.CUENCOBR, OPEN.FACTURA, open.ic_clascont ic
 where cargnuse = sesunuse
   and CARGCUCO = CUCOCODI
   AND factcodi = CUCOfact   
   and FACTFEGE BETWEEN to_date('01/07/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                    and to_date('30/09/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
   and cargtipr = 'A'
   and cargconc in (37,596,196,717)
   and cargconc = conccodi and cargcaca = cacacodi and ic.clcocodi = o.concclco
   and (cargcaca not in (20,46,50,56,73,51) or (cargcaca in (51) and cargdoso like 'ID%') /*or
        (cargcaca in (50) and cargdoso like 'RMFSIMOCAR%')*/)
group by to_char(FACTFEGE,'yyyymm'), cargtipr, cargconc, cargcaca, cargsign, cacadesc, concdesc, concclco, ic.clcodesc, substr(cargdoso,1,2)
UNION
select to_char(cargfecr,'yyyymm') Periodo, cargtipr, concclco, ic.clcodesc, cargconc, concdesc, cargsign, substr(cargdoso,1,2) tipo,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
  from open.cargos ca, open.servsusc s, open.concepto o, open.causcarg g, open.ic_clascont ic
 where cargnuse = sesunuse
   and cargfecr >= '01-07-2015'  and cargfecr < '01-10-2015'
   and ca.cargtipr = 'P'
   and cargconc in (37,596,196,717)
   and cargconc = conccodi and cargcaca = cacacodi and ic.clcocodi = o.concclco
   and (cargcaca not in (20,46,50,56,73,51) or (cargcaca in (51) and cargdoso like 'ID%')/* or
       (cargcaca in (50) and cargdoso like 'RMFSIMOCAR%')*/)
group by to_char(cargfecr,'yyyymm'), cargtipr, cargconc, cargcaca, cargsign, cacadesc, concdesc, concclco, ic.clcodesc, substr(cargdoso,1,2)
