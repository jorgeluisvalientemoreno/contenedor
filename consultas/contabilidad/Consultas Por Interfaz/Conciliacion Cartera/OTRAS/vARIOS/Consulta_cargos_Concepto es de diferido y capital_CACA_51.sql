select substr(cargdoso, 1, 2) TIPO, cargconc, o.concdesc, o.concclco,  t.clcodesc, cargsign, sum(cargvalo)
  from open.cargos c, open.concepto o, open.ic_clascont t
 where /*cargnuse = 50284935 --cargcaca in (56)
   and*/ c.cargfecr >= '09-02-2015'
   and c.cargfecr   <  '01-03-2015'
   and cargcaca = 51   and cargconc = conccodi  and o.concclco = t.clcocodi
group by substr(cargdoso, 1, 2), cargconc, o.concdesc, o.concclco,  t.clcodesc, cargsign
