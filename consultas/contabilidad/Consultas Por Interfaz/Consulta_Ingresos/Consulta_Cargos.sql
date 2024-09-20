/*  begin  
    setsystemenviroment;  
    end;  */
select /*cargcaca,*/ substr(cargdoso, 1, 2), cargconc, o.concdesc, o.concclco, i.clcodesc, cargsign, sum(cargvalo)  
  from open.cargos c, open.concepto o, open.ic_clascont i
 where cargcaca in (/*20,23,46,47,50,*/51)
   and c.cargfecr >= '09-02-2015'
   and c.cargfecr <  '01-03-2015' and cargconc = conccodi and o.concclco = i.clcocodi
group by /*cargcaca,*/ substr(cargdoso, 1, 2), cargconc, o.concdesc, o.concclco, i.clcodesc, cargsign
