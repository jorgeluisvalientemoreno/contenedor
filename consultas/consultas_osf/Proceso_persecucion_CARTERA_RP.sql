select oo.order_id,
       oo.causal_id || ' - ' ||
       open.dage_causal.fsbgetdescription(oo.causal_id, null) Causal,
       oo.created_date,
       oo.legalization_date,
       oo.task_type_id,
       (select a.description
          from open.or_task_type a
         where a.task_type_id = oo.task_type_id)
  from open.or_order_activity ooa, open.or_order oo
 where ooa.product_id = 2087913
   and ooa.order_id = oo.order_id
   and trunc(oo.legalization_date) = '10/03/2022'
 order by oo.legalization_date
