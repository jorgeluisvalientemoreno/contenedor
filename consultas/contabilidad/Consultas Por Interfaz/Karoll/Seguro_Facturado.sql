-- Seguro Facturado
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, sum(cargvalo)
  from open.cargos c, open.servsusc s
 where cargnuse = sesunuse
   and sesuserv = 7055
   and cargfecr >= '01-04-2015'
   and cargfecr <  '01-05-2015'
   and cargconc in (177)
   AND cargcaca = 15 --not in (20,23,46,50,58,56,73)
group by substr(cargdoso, 1, 2), cargcaca, cargsign;