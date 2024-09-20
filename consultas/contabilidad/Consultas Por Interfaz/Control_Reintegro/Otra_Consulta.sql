select * from open.trbadosr a, open.tranbanc t 
 where a.tbdstrba = t.trbacodi
   and t.trbafetr >= '12-02-2015' and t.trbafetr <  '13-02-2015' and t.trbatitb in (1,2)
   and tbdsdosr is not null
   /*and trbacuba = 96*/ order by tbdsfere, tbdstrba;
