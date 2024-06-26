select oo.order_id,
       oo.order_status_id,
       lo.asignacion,
       ooa.activity_id,
       ooa.package_id,
       oo.created_date
  from open.or_order oo
 inner join open.Or_Order_Activity ooa
    on ooa.order_id = oo.order_id
   and ooa.activity_id in
       (select t.items_id
          from open.LDC_PACKAGE_TYPE_OPER_UNIT t
         where (t.procesopre is not null or t.procesopost is not null)
           and (t.procesopre in ('LDC_PRUOCERTIFICACION') or
               t.procesopost in ('LDC_PRUOCERTIFICACION'))
         group by t.items_id, t.catecodi)
 inner join open.ldc_order lo
    on lo.order_id = oo.order_id
      --and lo.asignado = 'N'
   and lo.asignacion <= 10
 where oo.order_status_id = 0;
