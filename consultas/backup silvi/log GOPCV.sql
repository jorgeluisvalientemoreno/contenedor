select a.*, rowid
  from OPEN.LDC_PKG_OR_ITEM a
 where trunc(a.fecha) = '11/02/2026'
   --and a.package_id = 236412975
   and a.order_id is null
 order by a.fecha desc
