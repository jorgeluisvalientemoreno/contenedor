select p.package_id, p.package_type_id, p.request_date, p.motive_status_id, m.product_id,to_char( p.request_date, 'yyyy' ) Ano, 
(SELECT PR.PRODUCT_STATUS_ID FROM OPEN.PR_PRODUCT PR WHERE PR.PRODUCT_ID=M.PRODUCT_ID) ESTPROD,
(SELECT sesuesco FROM open.SERVSUSC SS WHERE SS.SESUNUSE=M.PRODUCT_ID) ESTCORTE,
(select max(o.LEGALIZATION_DATE)from open.or_order_activity a, open.or_order o where a.package_id=p.package_id and o.order_id=a.order_id AND o.task_type_id in(12527,10559,12529)) fecha_leg

from open.mo_packages p, open.mo_motive m
where p.package_id=m.package_id
and p.package_type_id in (300,100240,100333)
and p.motive_status_id=13
and not exists(select null from open.or_order_activity a, open.or_order o where a.package_id=p.package_id and o.order_id=a.order_id and o.order_status_id in (0,5,6,7,11))
and exists(select null from open.or_order_activity a, open.or_order o where a.package_id=p.package_id and o.order_id=a.order_id AND o.task_type_id in(12527,10559,12529) AND trunc(o.LEGALIZATION_DATE) >= '01/01/2022' and o.order_status_id in (8))
