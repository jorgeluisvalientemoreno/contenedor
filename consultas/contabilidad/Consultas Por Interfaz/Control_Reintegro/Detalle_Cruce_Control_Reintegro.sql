select * from open.tranbanc t where t.trbafere >= '31-03-2015' and t.trbafere <  '01-04-2015' and t.trbatitb in (1,2);
select * from open.trbadosr a, open.tranbanc t 
 where a.tbdstrba = t.trbacodi
   and t.trbafere >= '09-02-2015' and t.trbafere <  '01-04-2015' and t.trbatitb in (1,2)
   and tbdsdosr is not null
   and trbacuba = 96 order by tbdsfere, tbdstrba;
--select * from open.cuenbanc;