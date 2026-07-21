select a.*, rowid
  from OPEN.OR_ORDER_STAT_CHANGE a
 where a.order_id = 389872994
 order by a.stat_chg_date desc;
