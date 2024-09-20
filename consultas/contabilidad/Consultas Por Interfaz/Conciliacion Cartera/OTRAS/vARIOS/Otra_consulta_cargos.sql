select cargconc, c.concdesc, cargcaca, g.cacadesc, cargsign, sum(cargvalo)
  from open.cargos c, open.servsusc s, open.concepto c, open.causcarg g
 where cargnuse = sesunuse
   and sesuserv = 6121
   and cargfecr >= '09-02-2015'
   and cargfecr <  '01-03-2015' and cargconc = conccodi and cargcaca = g.cacacodi and carg
group by cargconc, c.concdesc, cargcaca, g.cacadesc, cargsign
