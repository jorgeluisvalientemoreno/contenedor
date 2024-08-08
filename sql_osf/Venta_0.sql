select        ooa.instance_id Instancia, oo.order_id Orden,
       oo.order_status_id || ' - ' || oot.description Estado_orde,
       ooa.activity_id || ' - ' ||
       (select gi.description
          from open.ge_items gi
         where gi.items_id = ooa.activity_id) Actividad,
       oo.task_type_id || ' - ' ||
       (select a.description
          from open.or_task_type a
         where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
       oo.causal_id || ' - ' ||
       open.dage_causal.fsbgetdescription(oo.causal_id, null) Causal_Legalizacion,
       (select x.class_causal_id || ' - ' || x.description
          from open.ge_class_causal x
         where x.class_causal_id =
               (select y.class_causal_id
                  from open.ge_causal y
                 where y.causal_id = oo.causal_id)) Clasificacion_Causal,
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       oo.legalization_date Legalizacion_Orden,
       ooa.comment_ Comentario_Orden,
       ooa.package_id Solicitud,
       mp.package_type_id || ' - ' ||
       (select b.description
          from open.ps_package_type b
         where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
       mp.reception_type_id || ' - ' ||
       (select c.description
          from open.ge_reception_type c
         where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
       mp.request_date Registro_Solicitud,
       mp.cust_care_reques_num Interaccion,
       mp.motive_status_id || ' - ' ||
       (select d.description
          from open.ps_motive_status d
         where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
       mm.subscription_id Contrato,
       mm.product_id Producto
  from open.or_order_activity ooa,
       open.or_order          oo,
       open.mo_packages       mp,
       open.mo_motive         mm,
       open.or_order_status   oot
 where ooa.order_id = oo.order_id
   and oo.order_status_id = oot.order_status_id
      --and ooa.product_id = 1587474
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --or trunc(oo.created_date) >= '01/03/2022')   
      --and oo.task_type_id = 10784
   and mp.package_id = mm.package_id
   and mp.package_id = ooa.package_id
      --and mp.cust_care_reques_num = '192735615'   
      --and mp.package_id = 192735630
      --and ooa.instance_id is not null
   and mm.product_id =
      --52343586  --CASO INFORMATICA CXC NO LO COBRO
      52578292  --ERROR EN FLUJO OT CERRADAS
      --- 51010735 --ERROR EN FLUJO OT CERRADAS
--52242076  --ERROR EN FLUJO OT CERRADAS

 order by oo.legalization_date;
/*select oo.order_id,
       ooa.activity_id || ' - ' || (select gi.description from open.ge_items gi where gi.items_id= ooa.activity_id) Actividad,
       oo.task_type_id  || ' - ' || open.daor_task_type.fsbgetdescription(oo.task_type_id, null) Tipo_Trabajo,
       oo.causal_id || ' - ' || open.dage_causal.fsbgetdescription(oo.causal_id, null) Causal_Legalizacion,
       (select x.class_causal_id ||' - '|| x.description from open.ge_class_causal x where x.class_causal_id = (select y.class_causal_id from open.ge_causal y where y.causal_id = oo.causal_id)) Clasificacion_Causal,
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       oo.legalization_date Legalizacion_Orden,
       (select a.description
          from open.or_task_type a
         where a.task_type_id = oo.task_type_id),
       ooa.comment_ Comentario_Orden,
       ooa.package_id Solicitud,
       mp.package_type_id || ' - ' ||(select b.description from open.ps_package_type b where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
       mp.reception_type_id || ' - ' || (select c.description from open.ge_reception_type c where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
       mp.request_date Registro_Solicitud,
       mp.cust_care_reques_num Interaccion,
       mp.motive_status_id || ' - ' || (select d.description from open.ps_motive_status d where d.motive_status_id = mp.motive_status_id) Estado_Solicitud
  from open.or_order_activity ooa, open.or_order oo, open.mo_packages mp     
 where ooa.order_id = oo.order_id
   --and ooa.product_id = 1587474
   --and (trunc(oo.legalization_date) >= '01/03/2022'
   --or trunc(oo.created_date) >= '01/03/2022')   
   --and oo.task_type_id = 10784
   --and mp.package_id=
   and mp.package_id = ooa.package_id
   and mp.cust_care_reques_num = '192218346'   
 order by oo.legalization_date;
select oo.order_id,
       ooa.activity_id || ' - ' || (select gi.description from open.ge_items gi where gi.items_id= ooa.activity_id) Actividad,
       oo.task_type_id  || ' - ' || (select a.description from open.or_task_type a where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
       oo.causal_id || ' - ' || open.dage_causal.fsbgetdescription(oo.causal_id, null) Causal_Legalizacion,
       (select x.class_causal_id ||' - '|| x.description from open.ge_class_causal x where x.class_causal_id = (select y.class_causal_id from open.ge_causal y where y.causal_id = oo.causal_id)) Clasificacion_Causal,
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       oo.legalization_date Legalizacion_Orden,
       ooa.comment_ Comentario_Orden,
       ooa.package_id Solicitud,
       mp.package_type_id || ' - ' ||(select b.description from open.ps_package_type b where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
       mp.reception_type_id || ' - ' || (select c.description from open.ge_reception_type c where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
       mp.request_date Registro_Solicitud,
       mp.cust_care_reques_num Interaccion,
       mp.motive_status_id || ' - ' || (select d.description from open.ps_motive_status d where d.motive_status_id = mp.motive_status_id) Estado_Solicitud
  from open.or_order_activity ooa, open.or_order oo, open.mo_packages mp     
 where ooa.order_id = oo.order_id
   --and ooa.product_id = 1587474
   --and (trunc(oo.legalization_date) >= '01/03/2022'
   --or trunc(oo.created_date) >= '01/03/2022')   
   --and oo.task_type_id = 10784
   --and mp.package_id=
   and mp.package_id = ooa.package_id
   and mp.cust_care_reques_num = '187142919'   
 order by oo.legalization_date;
*/
