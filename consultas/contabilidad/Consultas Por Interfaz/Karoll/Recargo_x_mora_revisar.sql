-- Recargo por mora
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, o.concdesc, sum(cargvalo)
  from open.cargos c, open.servsusc s, open.concepto o
where cargnuse = sesunuse
  and sesuserv = 7055
  and c.cargfecr >= '01-03-2015'
  and c.cargfecr <  '01-04-2015'
  and cargconc in (220,156,153,154,155,157,284,285,286,332)  
  and cargconc = conccodi
  and cargcaca = 15 --not in (20,23,46,50,58,56,73)
group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, o.concdesc;
