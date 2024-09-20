-- TOTAL VENTAS DEL MES
select concclco, cargconc, cargcaca, cargsign, sum(cargvalo) TOTAL
  from open.cargos, open.servsusc, open.concepto o
 where cargcuco != -1
   and cargnuse =  sesunuse
   and sesuserv =  6121
   and cargfecr >= '01-07-2015'
   and cargfecr <= '31-07-2015 23:59:59'
   and substr(cargdoso,1,3) = 'PP-'
   and cargconc in (19,30,674,291)
   and cargconc = conccodi
group by concclco, cargconc, cargcaca, cargsign
