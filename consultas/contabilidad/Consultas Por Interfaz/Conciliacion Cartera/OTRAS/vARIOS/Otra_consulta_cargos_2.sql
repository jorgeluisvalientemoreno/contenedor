select cargnuse, cargconc, c.concdesc, cargcaca, g.cacadesc, cargsign, cargvalo, cargfecr
  from open.cargos c, open.concepto c, open.causcarg g
 where cargnuse = 1098884 --cargconc in (185, 139)
   and cargfecr >= '09-02-2015'
   and cargfecr <  '01-03-2015' and cargconc = conccodi and cargcaca = g.cacacodi and cargcaca not in (50,51)
group by cargnuse, cargconc, c.concdesc, cargcaca, g.cacadesc, cargsign
