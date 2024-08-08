--DATA Orden
select distinct oo.order_id Orden,
                oo.order_status_id || ' - ' ||
                (select oos.description
                   from open.or_order_status oos
                  where oos.order_status_id = oo.order_status_id) Estado_Orden,
                nvl(ooa.subscription_id, mm.subscription_id) Contrato,
                nvl(ooa.product_id, mm.product_id) Producto,
                DireccionOrden.address_id || ' - ' ||
                DireccionOrden.address Direccion_Orden,
                localidad_Orden.geograp_location_id || ' - ' ||
                localidad_Orden.description Localidad_Orden,
                departamento_Orden.geograp_location_id || ' - ' ||
                departamento_Orden.description Departamento_Orden,
                DireccionProducto.address_id || ' - ' ||
                DireccionProducto.address Direccion_Producto,
                oo.operating_sector_id || ' - ' ||
                (select oos.description
                   from open.or_operating_sector oos
                  where oos.operating_sector_id = oo.operating_sector_id) Sector_Operativo,
                ooa.activity_id || ' - ' ||
                (select gi.description
                   from open.ge_items gi
                  where gi.items_id = ooa.activity_id) Actividad,
                oo.task_type_id || ' - ' ||
                (select a.description
                   from open.or_task_type a
                  where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
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
                oo.created_date Fecha_Creacion_Orden,
                oo.assigned_date Fecha_Asignacion_Orden,
                oo.legalization_date Fecha_Legalizacion_Orden,
                oo.exec_initial_date Fecha_Incial_Ejecucion,
                oo.execution_final_date Fecha_Final_Ejecucion,
                ooa.comment_ Comentario_Orden,
                ooa.package_id Solicitud,
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
                  where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                mp.comment_ Comentario,
                (select a2.user_id || ' - ' ||
                        (select p.name_
                           from open.ge_person p
                          where p.user_id =
                                (select a.user_id
                                   from open.sa_user a
                                  where a.mask = a2.user_id))
                   from open.or_order_stat_change a2
                  where a2.order_id = oo.order_id
                    and (a2.initial_status_id = 0 and a2.final_status_id = 0)
                    and rownum = 1) Usuario_Crea,
                (select a2.user_id || ' - ' ||
                        (select p.name_
                           from open.ge_person p
                          where p.user_id =
                                (select a.user_id
                                   from open.sa_user a
                                  where a.mask = a2.user_id))
                   from open.or_order_stat_change a2
                  where a2.order_id = oo.order_id
                    and (a2.initial_status_id = 0 and a2.final_status_id = 5)
                    and rownum = 1) Usuario_Asigna,
                (select a2.user_id || ' - ' ||
                        (select p.name_
                           from open.ge_person p
                          where p.user_id =
                                (select a.user_id
                                   from open.sa_user a
                                  where a.mask = a2.user_id))
                   from open.or_order_stat_change a2
                  where a2.order_id = oo.order_id
                    and a2.final_status_id = 8
                    and rownum = 1) Usuario_Legaliza,
                oo.defined_contract_id Contrato_Definido_Orden,
                oo.estimated_cost Costo_Estimado,
                ooa.value_reference Valor_Referente,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id = 0
                    and oosc.final_status_id = 0
                    and rownum = 1) Cambio_Estado_creacion,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id = 0
                    and oosc.final_status_id = 5
                    and rownum = 1) Cambio_Estado_Asignado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 5)
                    and oosc.final_status_id = 6
                    and rownum = 1) Cambio_Estado_En_Ejecucion,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 6, 5)
                    and oosc.final_status_id = 7
                    and rownum = 1) Cambio_Estado_Ejecutado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 6, 5, 7)
                    and oosc.final_status_id = 8
                    and rownum = 1) Cambio_Estado_Legalizado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 6, 5, 7, 11)
                    and oosc.final_status_id = 12
                    and rownum = 1) Cambio_Estado_Anulado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 6, 5, 7)
                    and oosc.final_status_id = 11
                    and rownum = 1) Cambio_Estado_Bloqueado,
                (select decode(oou.assign_type,
                               'S',
                               'S - HORARIO',
                               'O',
                               'O - CANTIDAD DE ORDENES',
                               'N',
                               'N - NINGUNO',
                               'R',
                               'R - POR RUTA',
                               'C',
                               'C - CUPO')
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = oo.operating_unit_id) TIPO_ASIGNACION,
                mm.motive_id Motivo,
                (SELECT min(order_id)
                   FROM open.or_related_order
                  start with related_order_id in oo.order_id
                 connect BY related_order_id = prior ORDER_id) Primera_OT_Inicia_Relacion_PNO,
                ooa.value1,
                ooa.value2,
                ooa.value3,
                ooa.value4,
                ooa.value_reference,
                ooi.value,
                ooi.total_price,
                ooi.items_id || ' - ' || giooi.description ITEM_LEGALIZADO,
                (select pps.product_status_id || ' - ' || pps.description
                   from OPEN.PS_PRODUCT_STATUS pps
                  where pps.product_status_id = pp.product_status_id) Estado_Producto,
                (select ec.escocodi || ' - ' || ec.escodesc
                   from OPEN.ESTACORT ec
                  where ec.escocodi = s.sesuesco) Estado_Corte_Servicio,
                s.sesucicl Ciclo,
                orden_padre.order_id orden_padre,
                orden_hija.related_order_id orden_hija,
                ordv.name_1,
                ordv.value_1,
                ordv.name_2,
                ordv.value_2,
                ordv.name_3,
                ordv.value_3,
                ordv.name_4,
                ordv.value_4,
                ordv.name_5,
                ordv.value_5,
                ordv.name_6,
                ordv.value_6,
                ordv.name_7,
                ordv.value_7,
                ordv.name_8,
                ordv.value_8,
                ordv.name_9,
                ordv.value_9,
                ordv.name_10,
                ordv.value_10,
                decode(oo.charge_status,
                       1,
                       '[1] NO GENERO',
                       2,
                       '[2] PENDIENTE',
                       3,
                       '[3] GENERADO',
                       4,
                       '[4] NO ENCONTRO TARIFA') ESTADO_DE_GENERACION_CARGO,
                ooa.order_activity_id Orden_Actividad,
                oop.person_id || ' - ' || gp.name_ Responsable,
                ooc.order_comment Comentario_Orden,
                DireccionOrden.Geograp_Location_Id
  from open.or_order_activity ooa
  left join open.or_order oo
    on oo.order_id = ooa.order_id
  left join open.mo_packages mp
    on mp.package_id = ooa.package_id
  left join open.mo_motive mm
    on mm.package_id = ooa.package_id
  left join open.ab_address DireccionOrden
    on DireccionOrden.address_id = ooa.address_id
  left join open.ge_geogra_location localidad_Orden
    on DireccionOrden.geograp_location_id =
       localidad_Orden.geograp_location_id
  left join open.ge_geogra_location departamento_Orden
    on departamento_Orden.geograp_location_id =
       localidad_Orden.geo_loca_father_id
  left join open.pr_product pp
    on pp.product_id = ooa.product_id
  left join open.ab_address DireccionProducto
    on DireccionProducto.Address_Id = pp.address_id
  left join open.or_order_items ooi
    on ooi.order_id = oo.order_id
   and 'S' in &ConsultaItemLegalizado
  left join open.ge_items giooi
    on giooi.items_id = ooi.items_id
  left join open.servsusc s
    on s.sesunuse = ooa.product_id
  left join open.or_order_comment ooc
    on ooc.order_id = oo.order_id
   and 'S' in &ConsultaComentariosOrden
  left join open.or_related_order orden_padre
    on orden_padre.related_order_id = oo.order_id
   and 'S' in &ConsultaOrdenPadre
  left join open.or_related_order orden_hija
    on orden_hija.order_id = oo.order_id
   and 'S' in &ConsultaOrdenHija
  left join open.or_requ_data_value ordv
    on ordv.order_id = oo.order_id
   and 'S' in &ConsultaDatoAdcional
  left join OPEN.OR_ORDER_PERSON oop
    on oop.order_id = oo.order_id
  left join OPEN.ge_person gp
    on gp.person_id = oop.person_id
 where --)select ou.order_id from orden_uobysol ou)
--and ooa.comment_ ='Orden creada por proceso automatico de reglas de facturacion. 64 - SERVICIO DIRECTO. Se solicita verificacion del estado del CM, Gasodomesticos y lecturas.'
--and ooa.subscription_id =1041350
--and ooa.product_id in (1087616)
--and trunc(oo.legalization_date) >= '01/10/2023'
--and trunc(oo.created_date) >= '01/01/2024'
--and oo.task_type_id in (10312)
--and trunc(mp.request_date) >= '19/04/2024'
--and mp.motive_status_id = 13
--and 
oo.order_id in (326452224, 324029362, 323064307, 323177039)--(323061125)
-- and  ooa.order_activity_id in(4295602)    
--and mp.cust_care_reques_num in ('212356951', '212681274')
--   and ooa.order_id in (318396156, 318396150) --(318396156,318396150)
-- and oo.order_status_id in (8)
--and oo.causal_id = 9944--in (8, 12)
-- and oo.task_type_id in (12119)
-- and ooa.activity_id in (100010246, 100010120, 4000020)
--and mp.package_type_id = 1000101
--and (mm.subscription_id = 48052064 or mm.product_id = 50062001)
--and mp.cust_care_reques_num in ('210494274','207413106')
--and mp.package_id in (213640039)
--and pp.product_status_id = 15
--and mm.motive_id = 96953319
--and oo.operating_unit_id in (1775, 1931, 1773, 3557)
-- and rownum = 1
 order by oo.created_date desc;

--select a.*, rowid from OPEN.OR_ORDER_PERSON a where a.order_id = 298976134;
