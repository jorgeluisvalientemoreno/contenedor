select cargnuse, o.conccodi, o.concdesc, sum(decode(cargsign, 'DB', 1, -1) * cargvalo) tot
  from open.cargos c, open.servsusc s, open.concepto o
 where c.cargnuse = sesunuse 
   and sesuserv = 7014
   and cargfecr >= '09-02-2015' and cargfecr < '01-03-2015'
   and cargcaca = 58 and cargconc = conccodi and cargconc in (19,30,674)
   and cargnuse not in (select m.invmsesu from OPEN.LDCI_INGREVEMI m where m.invmsesu = cargnuse)
group by cargnuse, conccodi, o.concdesc
