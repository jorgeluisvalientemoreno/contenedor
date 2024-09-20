select substr(cargdoso, 1, 2) TIPO, cargconc, o.concdesc, cargcaca, g.cacadesc, sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) Total
  from open.cargos c, open.concepto o, open.causcarg g
 where c.cargconc =  o.conccodi
   and c.cargfecr >= '01-04-2015'
   and c.cargfecr <  '01-05-2015'
   and c.cargtipr =  'P'
   and o.concclco in (7, 3) and cargcaca = g.cacacodi
group by substr(cargdoso, 1, 2), cargconc, o.concdesc, cargcaca, g.cacadesc
