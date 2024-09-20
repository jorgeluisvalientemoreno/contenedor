select t.trbacodi, t.trbabanc, t.trbatitb, t.trbanutr, t.trbacuba, t.trbafetr, t.trbafere, t.trbavatr, t.trbaretr, 
       t.trbanueb, t.trbanoar, t.trbabare,
       (select sum(a.tbdsvads) from open.trbadosr a
         where a.tbdstrba = t.trbacodi
           and tbdsdosr is not null) t_cruce
  from open.tranbanc t
 where t.trbafere >= '09-02-2015' and t.trbafere <  '01-04-2015' and t.trbatitb in (1,2)
   and trbacuba = 96 
 
