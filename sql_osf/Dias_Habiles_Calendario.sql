with base as
 (select oo.order_id Orden,
         ooa.package_id Solicitud,
         mp.request_date Fecha_Registro_Solicitud,
         count(*) Dias_Diferencia
    from open.Or_Order_Activity ooa
   inner join open.or_order oo
      on oo.order_id = ooa.order_id
   inner join open.mo_packages mp
      on mp.package_id in
         (select ooa.package_id Solicitud
            from open.or_order oo, open.or_order_activity ooa
           where oo.order_status_id in (0, 5)
             and oo.task_type_id = 10810
             and oo.order_id = ooa.order_id
             and oo.order_id in (326247165, 325619945))
     and mp.package_id = ooa.package_id
   inner join open.ge_calendar
      on TRUNC(ge_calendar.date_) > mp.request_date
     AND TRUNC(ge_calendar.date_) <= sysdate
     and ge_calendar.laboral = 'Y'
   group by oo.order_id,
            ooa.package_id,
            mp.request_date,
            oo.legalization_date)
select * from base order by dias_diferencia DESC
