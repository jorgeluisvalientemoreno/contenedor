select c.*
  from OPEN.CT_SIMPLE_CONDITION C --, OPEN.GE_ITEMS I
 WHERE 1 = 1
      --and C.ITEMS_ID IN (100002360, 100002359, 100002361)
   AND C.ITEMS_ID = I.ITEMS_ID
 order by c.simple_condition_id;
select *
  from ct_simple_cond_items r
 WHERE 1 = 1
--   and r.simple_condition_id IN (980, 978, 979)
 order by r.simple_cond_items_id;
