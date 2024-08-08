select oo.order_id           Ordern,
       oo.task_type_id       Tipo_trabajo,
       oo.causal_id          Causal_legalizada,
       oo.legalization_date  Fecha_Legalizada,
       ooa.order_activity_id Orden_Actividad,
       ooa.address_id        Direccion,
       ooa.activity_id       Actividad,
       mp.package_id         Solicitud,
       mp.motive_status_id   Estado_Solicitud,
       mp.request_date       Fecha_Registro_Solicitud,
       mm.product_id         Producto,
       mm.subscription_id    Contrato,
       mm.motive_status_id   Estado_Motivo
  from open.mo_packages       mp,
       open.mo_motive         mm,
       open.or_order_activity ooa,
       open.or_order          oo
 where mm.package_id = mp.package_id
      --and mp.package_type_id = 328
   and mp.request_date > sysdate - 10
   and mp.package_id = ooa.package_id
   and ooa.order_id = oo.order_id
--and rownum = 1;
