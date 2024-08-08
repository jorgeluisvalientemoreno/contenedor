select * from LDC_ORDENTRAMITERP;-- t where t.solicitud = 166649123;
select * from LDC_ORDEASIGPROC;--  t where t.orapsoge = 166649123;
select dage_causal.fnugetclass_causal_id(or_boorder.fnugetordercausal(oa.order_id),
                                         null),
       oa.*
  from or_order_activity oa
 where oa.order_id = 198678776;
SELECT product_id,
       subscription_id,
       ot.task_type_id,
       oa.package_id,
       oa.subscriber_id,
       ot.operating_unit_id,
       m.motive_status_id estado_solicitud,
       OT.EXECUTION_FINAL_DATE
  FROM or_order_activity oa, or_order ot, open.mo_packages m
 WHERE oa.order_id = 198678776
   AND oa.package_id IS NOT NULL
   AND oa.order_id = ot.order_id
   AND oa.package_id = m.package_id
   AND rownum = 1;
