-- Financiacion Facturada
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, o.concdesc, sum(cargvalo)
  from open.cargos c, open.servsusc s, open.concepto o
where cargnuse = sesunuse
  and sesuserv = 7055
  and cargfecr >= '01-04-2015'
  and cargfecr <  '01-05-2015'
  and cargconc = conccodi
  and concclco in (56,57,58,59,86,87,88,98,102,103,120,121,126)    
  and /*(cargcaca not in (20,23,46,50,58,56,73,51) or*/ (cargcaca in (51) and cargdoso like 'ID%') --)
  and cargtipr = 'A'
group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, o.concdesc;
