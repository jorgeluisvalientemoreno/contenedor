-- CONTROL REINTEGRO
select t.* from open.tranbanc t--, open.banco b
 where trbafere >= '22-09-2015' and trbafere < '23-09-2015' --AND TRBATITB in (1,2)
   --and t.trbabare = b.banccodi
   --and b.banctier = 2
   and trbabare = 500;
select * from open.tranbanc t where t.trbavatr = 20519013.00;
select * from open.RC_DETRBAAN;
 

