with base as
 (select oo.order_id Orden_Padre,
         ooa.subscription_id Contrato,
         ooa.product_id Producto,
         ooa.activity_id || ' - ' ||
         (select gi.description
            from open.ge_items gi
           where gi.items_id = ooa.activity_id) Actividad,
         oo.task_type_id || ' - ' ||
         (select a.description
            from open.or_task_type a
           where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
         oo.order_status_id || ' - ' ||
         (select oos.description
            from open.or_order_status oos
           where oos.order_status_id = oo.order_status_id) Estado_Orden,
         oo.causal_id || ' - ' ||
         (select gc.description
            from open.ge_causal gc
           where gc.causal_id = oo.causal_id) Causal_Legalizacion,
         (select x.class_causal_id || ' - ' || x.description
            from open.ge_class_causal x
           where x.class_causal_id =
                 (select y.class_causal_id
                    from open.ge_causal y
                   where y.causal_id = oo.causal_id)) Clasificacion_Causal,
         oo.created_date Creacion_Orden,
         oo.execution_final_date Fecha_Ejecucion_Final,
         oo.legalization_date Legalizacion_Orden,
         ooa.comment_ Comentario_Orden,
         (select a2.user_id || ' - ' ||
                 (select p.name_
                    from open.ge_person p
                   where p.user_id = (select a.user_id
                                        from open.sa_user a
                                       where a.mask = a2.user_id))
            from open.or_order_stat_change a2
           where a2.order_id = oo.order_id
             and (a2.initial_status_id = 0 and a2.final_status_id = 0)
             and rownum = 1) Usuario_Crea,
         (select a2.user_id || ' - ' ||
                 (select p.name_
                    from open.ge_person p
                   where p.user_id = (select a.user_id
                                        from open.sa_user a
                                       where a.mask = a2.user_id))
            from open.or_order_stat_change a2
           where a2.order_id = oo.order_id
             and a2.final_status_id = 8
             and rownum = 1) Usuario_Legaliza,
         (select a3.order_id || ' - Fecha Registro en PNO: ' ||
                 a3.register_date
            from open.fm_possible_ntl a3
           where a3.product_id = ooa.product_id
             and oo.order_id = a3.order_id) Registro_PNO,
         (select oro.related_order_id
            from open.or_related_order oro
           where oro.order_id = oo.order_id) Orden_Ralacionada,
         ooa.address_id codigo_direccon
    from open.or_order_activity ooa, open.or_order oo
   where ooa.order_id = oo.order_id
     and oo.task_type_id = 12669
     and oo.causal_id in (3812, 3813, 3814, 3815)
     and oo.order_status_id not in (12)
     and (select count(1)
            from open.or_related_order oro
           where oro.order_id = oo.order_id) = 0
  /*order by oo.legalization_date desc*/
  )
select base.*,
       ooa.order_id Orden_Hija,
       ooa.activity_id || ' - ' ||
       (select gi.description
          from open.ge_items gi
         where gi.items_id = ooa.activity_id) Actividad,
       oo.task_type_id || ' - ' ||
       (select a.description
          from open.or_task_type a
         where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
       oo.order_status_id || ' - ' ||
       (select oos.description
          from open.or_order_status oos
         where oos.order_status_id = oo.order_status_id) Estado_Orden,
       (select gc.description
          from open.ge_causal gc
         where gc.causal_id = oo.causal_id) Causal_Legalizacion,
       (select x.class_causal_id || ' - ' || x.description
          from open.ge_class_causal x
         where x.class_causal_id =
               (select y.class_causal_id
                  from open.ge_causal y
                 where y.causal_id = oo.causal_id)) Clasificacion_Causal,
       oo.created_date Creacion_Orden,
       oo.execution_final_date Fecha_Ejecucion_Final,
       oo.legalization_date Legalizacion_Orden,
       ooa.comment_ Comentario_Orden,
       (select a2.user_id || ' - ' ||
               (select p.name_
                  from open.ge_person p
                 where p.user_id = (select a.user_id
                                      from open.sa_user a
                                     where a.mask = a2.user_id))
          from open.or_order_stat_change a2
         where a2.order_id = oo.order_id
           and (a2.initial_status_id = 0 and a2.final_status_id = 0)
           and rownum = 1) Usuario_Crea,
       (select a2.user_id || ' - ' ||
               (select p.name_
                  from open.ge_person p
                 where p.user_id = (select a.user_id
                                      from open.sa_user a
                                     where a.mask = a2.user_id))
          from open.or_order_stat_change a2
         where a2.order_id = oo.order_id
           and a2.final_status_id = 8
           and rownum = 1) Usuario_Legaliza
  from base
  left join open.or_order_activity ooa
    on ooa.product_id(+) = base.producto
   and ooa.subscription_id(+) = base.contrato
   and ooa.register_date >= trunc(base.Legalizacion_Orden)
   and ooa.task_type_id = 10059
   and ooa.address_id = base.codigo_direccon
  left join open.or_order oo
    on oo.order_id = ooa.order_id
   and oo.task_type_id = 10059
   and oo.order_status_id not in (12)
   and oo.created_date >= trunc(base.Legalizacion_Orden)
 order by base.contrato, base.Legalizacion_Orden desc
