--DATA Orden
select distinct oo.order_id Orden,
                oo.order_status_id || ' - ' ||
                (select oos.description
                   from open.or_order_status oos
                  where oos.order_status_id = oo.order_status_id) Estado_Orden,
                nvl(ooa.subscription_id, mm.subscription_id) Contrato,
                nvl(ooa.product_id, mm.product_id) Producto,
                pp.product_type_id || ' - ' ||
                (select s1.servdesc
                   from OPEN.SERVICIO s1
                  where s1.servcodi = pp.product_type_id) Tipo_Producto,
                DireccionOrden.address_id || ' - ' ||
                DireccionOrden.address Direccion_Orden,
                categoriadireccion.catecodi || ' - ' ||
                categoriadireccion.catedesc Categoria_Direccion,
                subcategoriadireccion.sucacate || ' - ' ||
                subcategoriadireccion.sucadesc SubCategoria_Direccion,
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
                /*(select gsz.id_zona_operativa
                 from OPEN.GE_SECTOROPE_ZONA gsz
                where gsz.id_sector_operativo = oo.operating_sector_id) Zona_Operativa,*/
                ooa.activity_id || ' - ' ||
                (select gi.description
                   from open.ge_items gi
                  where gi.items_id = ooa.activity_id) Actividad,
                oo.task_type_id || ' - ' || ott.description Tipo_Trabajo,
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
                oo.exec_initial_date Fecha_Incial_Ejecucion,
                oo.execution_final_date Fecha_Final_Ejecucion,
                oo.legalization_date Fecha_Legalizacion_Orden,
                ooa.comment_ Comentario_Orden,
                ooa.package_id Solicitud,
                ooa.instance_id Instancia,
                mp.package_type_id || ' - ' ||
                (select b.description
                   from open.ps_package_type b
                  where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
                mp.reception_type_id || ' - ' ||
                (select grt.description
                   from open.ge_reception_type grt
                  where grt.reception_type_id = mp.reception_type_id) Medio_Recepcion,
                mp.request_date Registro_Solicitud,
                mp.cust_care_reques_num Interaccion,
                mp.motive_status_id || ' - ' ||
                (select d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                mp.comment_ Comentario_Solicitud,
                (select mp.SUBSCRIBER_ID || ' - ' || gs.subscriber_name || ' ' ||
                        gs.subs_last_name
                   from OPEN.GE_SUBSCRIBER gs
                  where gs.subscriber_id = mp.SUBSCRIBER_ID) Cliente,
                (select mp.CONTACT_ID || ' - ' || gs.subscriber_name || ' ' ||
                        gs.subs_last_name
                   from OPEN.GE_SUBSCRIBER gs
                  where gs.subscriber_id = mp.CONTACT_ID) Contacto_Solicitante,
                mp.ADDRESS_ID Direccion_Solicitud,
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
                    and (a2.initial_status_id in (0, 5, 6) and
                        a2.final_status_id = 7)
                    and rownum = 1) Usuario_Ejecuta,
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
                c.concdesc || ' - ' || ott.concept Concepto,
                ooa.order_activity_id Orden_Actividad,
                oop.person_id || ' - ' || gp.name_ Responsable,
                ooc.order_comment Comentario_Orden,
                oo.is_pending_liq Pendiente_Liquidacion,
                (select mm.motive_status_id || ' - ' || d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mm.motive_status_id) Estado_Motivo,
                (select decode(count(1),
                               0,
                               'No esta gestionada',
                               'Esta Gestionada')
                   from open.ldc_otlegalizar lo
                  where lo.order_id = oo.order_id) LEGO,
                decode(ooa.status,
                       'F',
                       ooa.status || ' - Finalizado',
                       ooa.status || ' - Registrado') Estado_Actividad,
                ooa.order_activity_id Actividad_Orden,
                (select mp.pos_oper_unit_id || ' - ' || oou.name
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = mp.pos_oper_unit_id) Punto_venta,
                pp.category_id || ' - ' || categoria.catedesc Categoria_Producto,
                pp.subcategory_id || ' - ' || Subcategoria.Sucadesc subCategoria_Producto,
                (select decode(count(1), 0, 'No Tiene Flujo', 'Tiene Flujo')
                   from OPEN.WF_DATA_EXTERNAL wde
                  where wde.package_id = mp.package_id) Tiene_Flujo,
                (select decode(count(1),
                               0,
                               'No Existe en Asignacion Automatica',
                               'Existe Asignacion Automatica')
                   from OPEN.LDC_ORDER asignacion
                  where asignacion.order_id = oo.order_id) Asignacion_Auomatica,
                (SELECT decode(count(1),
                               0,
                               'No legaliza automatica',
                               'Legaliza automatica')
                   FROM open.LDC_CONFTITRLEGA lc
                  where lc.task_type_id = oo.task_type_id) Legaliza_JOB_LDC_CONFTITRLEGA,
                ('Categoria Anterior: ' || mbdc.old_category_id ||
                ' - Nueva:' || mbdc.new_category_id) Categoria,
                ('Categoria Anterior: ' || mbdc.old_subcategory_id ||
                ' - Nueva:' || mbdc.new_subcategory_id) SubCategoria,
                SegmentoDireccion.Category_ Categoria_Segmento,
                SegmentoDireccion.Subcategory_ SubCategoria_Segmento,
                decode((select count(1)
                         from OPEN.LDCI_PACKAGE_CAMUNDA_LOG LPCL
                        where lpcl.package_id = mp.package_id),
                       1,
                       'SI',
                       'NO') Generada_CAMUNDA
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
   and 'S' in upper(&ConsultaItemLegalizado)
  left join open.ge_items giooi
    on giooi.items_id = ooi.items_id
  left join open.servsusc s
    on s.sesunuse = ooa.product_id
  left join open.or_order_comment ooc
    on ooc.order_id = oo.order_id
   and 'S' in upper(&ConsultaComentariosOrden)
  left join open.or_related_order orden_padre
    on orden_padre.related_order_id = oo.order_id
   and 'S' in upper(&ConsultaOrdenPadre)
  left join open.or_related_order orden_hija
    on orden_hija.order_id = oo.order_id
   and 'S' in upper(&ConsultaOrdenHija)
  left join open.or_requ_data_value ordv
    on ordv.order_id = oo.order_id
   and 'S' in upper(&ConsultaDatoAdcional)
  left join OPEN.OR_ORDER_PERSON oop
    on oop.order_id = oo.order_id
  left join OPEN.ge_person gp
    on gp.person_id = oop.person_id
  left join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
  left join open.concepto c
    on c.conccodi = ott.concept
  left join open.categori categoria
    on categoria.catecodi = pp.category_id
  left join open.subcateg Subcategoria
    on Subcategoria.Sucacate = pp.category_id
   and Subcategoria.Sucacodi = pp.subcategory_id
  left join open.ab_segments SegmentoDireccion
    on SegmentoDireccion.Segments_Id = DireccionOrden.Segment_Id
  left join open.categori categoriadireccion
    on categoriadireccion.catecodi = pp.category_id
  left join open.subcateg Subcategoriadireccion
    on Subcategoriadireccion.Sucacate = pp.category_id
   and Subcategoriadireccion.Sucacodi = pp.subcategory_id
  left join OPEN.MO_BILL_DATA_CHANGE mbdc
    on mbdc.package_id = ooa.package_id
   and 'S' in upper(&CambioUso)
 where
---Orden
-- ooa.order_id in (335764490)
-- and ooa.order_activity_id in(42}95152)
-- and oo.task_type_id in (12622)
-- and oo.order_status_id not in (8, 12, 0, 7, 6)
-- and oo.causal_id = 9944--in (8, 12)
-- and trunc(oo.legalization_date) >= '12/08/2024'
-- and trunc(oo.created_date) = '15/01/2024'
-- and oo.operating_unit_id in (1775, 1931, 1773, 3557)
-- and ooa.activity_id in (4295751)
-- and ooa.comment_ ='Orden creada por proceso automatico de reglas de facturacion. 64 - SERVICIO DIRECTO. Se solicita verificacion del estado del CM, Gasodomesticos y lecturas.'
-- and 
 ooa.subscription_id in (67506235)
-- and ooa.product_id in (52757573)
-- and ooa.order_activity_id in (322824237)
-- and mp.package_type_id = 100210
-- and trunc(mp.request_date) >= '07/07/2024'
-- and mp.motive_status_id = 13
-- and mp.cust_care_reques_num in ('212356951', '212681274')
-- and mp.package_type_id = 100225
-- and (mm.subscription_id = 48052064 or mm.product_id = 50062001)
-- and mp.cust_care_reques_num in ('210494274','207413106')
-- and mp.package_id in (176206149)
-- and mm.motive_id = 96953319
-- and pp.product_status_id = 15
-- and rownum = 1
--and DireccionOrden.address like '%KR GENERICA CL GENERICA - 0%'
--and SegmentoDireccion.Category_ in (3,6)
/* ooa.activity_id = 4295152
and oo.order_status_id = 8
and oo.legalization_date >= '01/08/2024'*/
 order by oo.created_date desc;
--305802917
