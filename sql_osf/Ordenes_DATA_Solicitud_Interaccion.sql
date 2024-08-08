select mp.package_id Solicitud,
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
       mp.attention_date Fecha_Atencion,
       mm.annul_date Fecha_Anulacion_Motivo,
       mm.subscription_id Contrato,
       mm.product_id Producto
  from open.mo_packages mp, open.mo_motive mm
 where mp.package_id = mm.package_id
   and mp.cust_care_reques_num = '193091324';

select oo.order_id,
       (select oo.order_status_id || ' - ' || es.description
          from open.or_order_status es
         where es.order_status_id = oo.order_status_id) Estado_Orden,
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
       mp.attention_date Fecha_Atencion,
       mm.annul_date Fecha_Anulacion_Motivo,
       mm.subscription_id Contrato,
       mm.product_id Producto
  from open.or_order_activity ooa,
       open.or_order          oo,
       open.mo_packages       mp,
       open.mo_motive         mm
 where ooa.order_id = oo.order_id
      --and ooa.product_id = 1587474
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --or trunc(oo.created_date) >= '01/03/2022')   
      --and oo.task_type_id = 10784
   and mp.package_id = mm.package_id
   and mp.package_id = ooa.package_id
   and mp.cust_care_reques_num = '193091324'
 order by oo.legalization_date;

select *
  from open.or_order_comment a
 where a.order_id in
       (select oo.order_id
          from open.or_order_activity ooa,
               open.or_order          oo,
               open.mo_packages       mp,
               open.mo_motive         mm
         where ooa.order_id = oo.order_id
           and mp.package_id = mm.package_id
           and mp.package_id = ooa.package_id
           and mp.cust_care_reques_num = '193091324')
 order by a.register_date desc;

select *
  from (SELECT ORDER_COMMENT comentarioot
          FROM open.or_order_comment
         WHERE order_id = 264624012
         order by ORDER_COMMENT_ID asc)
 --where rownum = 1;
