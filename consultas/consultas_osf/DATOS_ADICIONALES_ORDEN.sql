select da.*
  from open.or_order oo, open.or_requ_data_value da
 where oo.task_type_id in
       (select oo.task_type_id
          from open.or_order oo
         where oo.order_id = 284790476)
   --and oo.order_status_id = 8
   and da.order_id = oo.order_id
   --and read_date >= sysdate - 100
   ;
select da.*, rowid
  from open.or_requ_data_value da
 where da.order_id in (284790476)
