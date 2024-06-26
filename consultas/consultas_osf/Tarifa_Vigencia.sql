select a.*, rowid from ta_conftaco a; -- where a.cotccons = 728; 
select a.*, rowid from ta_tariconc a; -- where a.tacocotc = 728;
select B.*, ROWID
  from ta_vigetaco b
--where b.vitctaco = 4070
--and b.vitcfefi = to_date('31/07/2022 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
 order by 1 desc;
select c.*, ROWID
  from CONFTAIN c
 where c.cotitain = 2
 order by c.cotifefi desc;
