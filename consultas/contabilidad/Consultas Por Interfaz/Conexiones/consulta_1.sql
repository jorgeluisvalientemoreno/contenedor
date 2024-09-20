select /* distinct cargnuse --*/cargconc, o.concdesc, sum(cargvalo)
  from open.cargos c, open.concepto o
 where c.cargnuse in (select hcecnuse from open.hicaesco h
                       where hcececan =  96
                         and hcececac =  1
                         and hcecfech >= '01-03-2015'
                         and hcecfech <  '01-04-2015'
                         and hcecserv =  7014)
   and cargfecr >= '01-03-2015'
   and cargfecr <  '01-04-2015'
   and cargconc in (19,30, 674)
   and cargcaca = 53
   and cargconc = conccodi
group by cargconc, o.concdesc
