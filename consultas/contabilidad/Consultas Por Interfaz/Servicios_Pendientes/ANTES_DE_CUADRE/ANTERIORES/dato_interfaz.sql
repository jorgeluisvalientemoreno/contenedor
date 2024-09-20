-- DATO INTERFAZ
select cargdoso, cargconc, cargsign, sum(cargvalo)
  from open.cargos c, open.servsusc
 where c.cargnuse = sesunuse 
   and sesuserv = 6121
   and cargfecr >= '09-02-2015' and cargfecr < '01-03-2015'
   and cargdoso like 'PP%'
   and cargconc in (19,30,674,291, 137,287)
group by cargdoso, cargconc, cargsign
