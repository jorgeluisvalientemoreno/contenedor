-- NOTAS FNB
select clcocodi, clcodesc, CARGCACA CausadeCargo, csc.cacadesc NombreCausadeCargo,
       CARGCONC  Concepto, co.concdesc Nombreconcepto,
       cargsign, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
 from open.cargos c,open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact
where c.cargcaca = csc.cacacodi
  and c.cargnuse = ss.sesunuse
  AND SESUSERV   = 7056
  and c.CARGCONC = CO.CONCCODI
  and c.cargfecr between to_date(to_char('01/05/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')
                     AND to_date(to_char('31/05/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')
  and cargprog = proccons
  and clcocodi(+) = concclco
  and cargpefa = pefacodi
  AND CARGCUCO > 0
  and cargtipr = 'P'
  --and cargsign NOT IN ('PA','AP')
  and cargsign not in ('PA','SA','AP','AS','NS','DV','TS','ST')
  and cargcaca NOT IN (20,23,46,50,51,56,58,73,19,2)
  --AND substr(cargdoso,1,2) NOT IN ('PA','AP')
group by clcocodi, clcodesc, CARGCACA, csc.cacadesc, CARGCONC, co.concdesc, cargsign
