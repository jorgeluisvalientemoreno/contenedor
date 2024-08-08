/*---PNO
select *
  from open.fm_possible_ntl a
 where a.register_date between '01/01/2021' and '31/12/2021'
   and (select count(1)
          from open.or_order oo
         where oo.order_id = a.order_id
           and oo.order_status_id = 8) = 1;*/
select oo.order_id,
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
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       oo.execution_final_date Fecha_Ejecucion_Final,
       oo.legalization_date Legalizacion_Orden,
       ooa.comment_ Comentario_Orden,
       ooa.address_id || ' - ' ||
       (select aa.address
          from open.ab_address aa
         where aa.address_id = ooa.address_id) Direccion,
       /*ooa.package_id Solicitud,
       ooa.instance_id,
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
         where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,*/
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
           and a2.final_status_id = 7
           and rownum = 1) Usuario_Ejecuta,
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
         (select a3.status
            from open.fm_possible_ntl a3
           where oo.order_id = a3.order_id) Registro_PNO
  from open.or_order_activity ooa, open.or_order oo
 where ooa.order_id = oo.order_id
      --and ooa.order_id = 198606928
   and ooa.product_id in (52147938,
                         52145010,
                         2082501,
                         17041416,
                         17028769,
                         51997067,
                         52040272,
                         51372133,
                         3058463,
                         52213408,
                         2156635,
                         50744881,
                         6561125,
                         14510672)
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --and trunc(oo.created_date) >= '01/05/2023'
      --and oo.task_type_id = 10784
   and oo.task_type_id in (12669) --, 11302, 10059)   
--and oo.causal_id in (3812, 3813, 3814, 3815)
 order by oo.legalization_date desc;

/*--Repositorio de posibles perdidas no tecnicas
select * from open.fm_possible_ntl a where a.product_id = 17003837;
--
select * from open.or_related_order oro where oro.order_id = 292533821;
select *
  from open.or_related_order oro
 where oro.related_order_id = 292533821;

select * from open.or_order_stat_change a where a.order_id = 290845425;*/

------------------
select oo.order_id,
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
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       oo.execution_final_date Fecha_Ejecucion_Final,
       oo.legalization_date Legalizacion_Orden,
       ooa.comment_ Comentario_Orden,
       ooa.address_id || ' - ' ||
       (select aa.address
          from open.ab_address aa
         where aa.address_id = ooa.address_id) Direccion,
       /*ooa.package_id Solicitud,
       ooa.instance_id,
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
         where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,*/
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
           and a2.final_status_id = 7
           and rownum = 1) Usuario_Ejecuta,
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
         where oro.order_id = oo.order_id) Orden_Ralacionada
  from open.or_order_activity ooa, open.or_order oo --,
--open.mo_packages       mp,
--open.mo_motive         mm
 where ooa.order_id = oo.order_id
      --and ooa.order_id = 198606928
      --and (ooa.product_id = 17003837 or ooa.subscription_id = 17103154)
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --and trunc(oo.created_date) >= '01/05/2023'
      --and oo.task_type_id = 10784
      --and mm.package_id(+) = ooa.package_id
      --and mp.package_id(+) = ooa.package_id
      --and mp.cust_care_reques_num = '192735615'   
      --and mp.package_id = 194041548
   and (oo.task_type_id in (12669) and
       oo.causal_id not in (3812, 3813, 3814, 3815) or
       oo.task_type_id in (10059))
   and oo.order_status_id not in (12)
   and (select count(1)
          from open.fm_possible_ntl a3
         where a3.product_id = ooa.product_id
           and oo.order_id = a3.order_id) = 0
 order by oo.legalization_date desc;
