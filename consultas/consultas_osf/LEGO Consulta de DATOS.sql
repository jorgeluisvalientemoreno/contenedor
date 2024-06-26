select Lo.*,
       (select 'Producto: ' || ooa.product_id || ' - Contrato: ' ||
               OOA.SUBSCRIPTION_ID || ' - Solicitud: ' || OOA.PACKAGE_ID
          from open.Or_Order_Activity ooa
         where ooa.order_id = LO.ORDER_ID) Data_Orden
  from OPEN.LDC_OTLEGALIZAR Lo
 where lo.order_id in (select oo.order_id
                         from open.or_order oo
                        where oo.task_type_id = 12152
                          and oo.order_status_id in (5, 7));
select oo.order_id,
       oo.operating_unit_id,
       ooa.product_id,
       OOA.SUBSCRIPTION_ID,
       OOA.PACKAGE_ID
  from open.or_order oo, open.or_order_activity ooa
 where oo.task_type_id = 12152
   and oo.order_status_id in (0, 5, 7)
   and (select count(1)
          from OPEN.LDC_OTLEGALIZAR Lo
         where lo.order_id = oo.order_id) = 0
   and oo.order_id = ooa.order_id;
select Lodl.*
  from OPEN.ldc_otdalegalizar Lodl
 where lodl.order_id in (264267143, 264267044, 264037321);
select Lo.*
  from OPEN.LDC_ANEXOLEGALIZA lo
 where lo.order_id in (264267143, 264267044, 264037321);
select LR.*
  from OPEN.LDC_OTADICIONAL LR
 where lr.order_id in (264267143, 264267044, 264037321);
select LR.*
  from OPEN.ldc_otadicionalda lr
 where lr.order_id in (264267143, 264267044, 264037321);
