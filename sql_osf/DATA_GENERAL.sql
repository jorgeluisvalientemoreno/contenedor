----DATA ORDEN
select distinct oo.order_id,
                oo.order_status_id || ' - ' ||
                (select oos.description
                   from open.or_order_status oos
                  where oos.order_status_id = oo.order_status_id) EstadoOrden,
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
                oo.created_date Creacion_Orden,
                oo.legalization_date Legalizacion_Orden,
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
                mp.user_id Ususario_Crea,
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
                    and a2.final_status_id = 8
                    and rownum = 1) Usuario_Legaliza,
                oo.defined_contract_id Contrato,
                oo.estimated_cost Costo_Estimado,
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
                    and oosc.initial_status_id = 5
                    and oosc.final_status_id = 6
                    and rownum = 1) Cambio_Estado_En_Ejecucion,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (5, 6)
                    and oosc.final_status_id = 7
                    and rownum = 1) Cambio_Estado_Ejecutado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (5, 6, 7)
                    and oosc.final_status_id = 8
                    and rownum = 1) Cambio_Estado_Legalizado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 5, 6, 7)
                    and oosc.final_status_id = 12
                    and rownum = 1) Cambio_Estado_Anulado,
                cliente.subscriber_name Nombre,
                cliente.subs_last_name Apellido,
                (select '[' || cliente.ident_type_id || ' - ' ||
                        git.description || ']'
                   from open.ge_identifica_type git
                  where git.ident_type_id = cliente.ident_type_id) || ' - ' ||
                cliente.identification Identificacion,
                (select contrato.susccicl || ' - ' || ci.cicldesc
                   from open.ciclo ci
                  where ci.ciclcodi = contrato.susccicl) Ciclo
  from open.or_order_activity  ooa,
       open.or_order           oo,
       open.mo_packages        mp,
       open.mo_motive          mm,
       open.ab_address         DireccionOrden,
       open.ab_address         DireccionProducto,
       open.ge_geogra_location localidad_Orden,
       open.ge_geogra_location departamento_Orden,
       open.pr_product         pp,
       open.suscripc           contrato,
       open.ge_subscriber      cliente
 where ooa.order_id = oo.order_id
   and ooa.order_id in (298062350)
      /*and ooa.product_id in (24000223)*/
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --and trunc(oo.created_date) >= '01/05/2023'   
      --and oo.task_type_id in (12152,12150, 12153)
      --and oo.order_status_id = 8 
      --and oo.causal_id = 9944--in (8, 12)
   and mm.package_id(+) = ooa.package_id
   and mp.package_id(+) = ooa.package_id
      --and mp.cust_care_reques_num = '192735615'   
      --  and mp.package_id in (195263154)
      --and pp.product_status_id = 15
   and ooa.address_id(+) = DireccionOrden.address_id
   and localidad_Orden.geograp_location_id(+) =
       DireccionOrden.geograp_location_id
   and departamento_Orden.geograp_location_id(+) =
       localidad_Orden.geo_loca_father_id
   and pp.product_id(+) = ooa.product_id
   and DireccionProducto.Address_Id(+) = pp.address_id
   and contrato.susccodi(+) = ooa.subscription_id
   and cliente.subscriber_id(+) = contrato.suscclie
 order by oo.created_date desc;

----DATA ITEMS ORDEN
select ooi.order_id,
       ooi.items_id || ' - ' || gi.description Item,
       gic.item_classif_id || ' - ' || gic.description Clasificacion_Item,
       ooi.value Valor,
       ooi.total_price Precio,
       ooi.serial_items_id Seriado,
       ooi.serie "Medidor[Serie]",
       decode(upper(gis.estado_tecnico),
              'N',
              'Nuevo',
              'R',
              'Reacondicionado',
              'D',
              'Da@ado',
              '') Estado_Tecnio,
       decode(upper(gis.propiedad),
              'E',
              'Empresa',
              'T',
              'Tercero',
              'C',
              'Traido por cliente',
              'V',
              'Vendido al cliente',
              '') Porpiedad,
       (select gis.id_items_estado_inv || ' - ' || giei.descripcion
          from open.ge_items_estado_inv giei
         where giei.id_items_estado_inv = gis.id_items_estado_inv) Estado_Inventario,
       decode(upper(gi.use_),
              'IC',
              '[instalacion en cliente]',
              'MC',
              '[mantenimiento en cliente]',
              'IR',
              '[instalacion de red]',
              'MR',
              '[mantenimiento de red]',
              'RC',
              '[retiro en cliente]',
              'RR',
              '[retiro en red]',
              'CR',
              '[revision en cliente]',
              'CF',
              '[reparacion en cliente]',
              'CW',
              '[trabajo en cliente]',
              '') USO
  from open.or_order_items   ooi,
       open.ge_items         gi,
       open.ge_item_classif  gic,
       open.ge_items_seriado gis
 where ooi.items_id = gi.items_id
   and gi.item_classif_id = gic.item_classif_id
   and ooi.serial_items_id = gis.id_items_seriado(+)
   and ooi.order_id in (298062350);

----DATA ORDEN RELACIONADA
select distinct oro.order_id OT_Padre,
                oo.order_id OT_Hija_Relacionada,
                oo.order_status_id || ' - ' ||
                (select oos.description
                   from open.or_order_status oos
                  where oos.order_status_id = oo.order_status_id) EstadoOrden,
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
                oo.created_date Creacion_Orden,
                oo.legalization_date Legalizacion_Orden,
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
                mp.user_id Ususario_Crea,
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
                    and a2.final_status_id = 8
                    and rownum = 1) Usuario_Legaliza,
                oo.defined_contract_id Contrato,
                oo.estimated_cost Costo_Estimado,
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
                    and oosc.initial_status_id = 5
                    and oosc.final_status_id = 6
                    and rownum = 1) Cambio_Estado_En_Ejecucion,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (5, 6)
                    and oosc.final_status_id = 7
                    and rownum = 1) Cambio_Estado_Ejecutado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (5, 6, 7)
                    and oosc.final_status_id = 8
                    and rownum = 1) Cambio_Estado_Legalizado,
                (select 'Estado Inicial: ' || oosc.initial_status_id ||
                        ' y Estado Final: ' || oosc.final_status_id ||
                        ' por el usuario: ' || oosc.user_id
                   from open.or_order_stat_change oosc
                  where oosc.order_id = oo.order_id
                    and oosc.initial_status_id in (0, 5, 6, 7)
                    and oosc.final_status_id = 12
                    and rownum = 1) Cambio_Estado_Anulado,
                cliente.subscriber_name Nombre,
                cliente.subs_last_name Apellido,
                (select '[' || cliente.ident_type_id || ' - ' ||
                        git.description || ']'
                   from open.ge_identifica_type git
                  where git.ident_type_id = cliente.ident_type_id) || ' - ' ||
                cliente.identification Identificacion,
                (select contrato.susccicl || ' - ' || ci.cicldesc
                   from open.ciclo ci
                  where ci.ciclcodi = contrato.susccicl) Ciclo
  from open.or_order_activity  ooa,
       open.or_order           oo,
       open.mo_packages        mp,
       open.mo_motive          mm,
       open.ab_address         DireccionOrden,
       open.ab_address         DireccionProducto,
       open.ge_geogra_location localidad_Orden,
       open.ge_geogra_location departamento_Orden,
       open.pr_product         pp,
       open.suscripc           contrato,
       open.ge_subscriber      cliente,
       open.or_related_order   oro
 where oro.order_id = (295972344)
   and ooa.order_id = oro.related_order_id
   and ooa.order_id = oo.order_id
      /*and ooa.product_id in (24000223)*/
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --and trunc(oo.created_date) >= '01/05/2023'   
      --and oo.task_type_id in (12152,12150, 12153)
      --and oo.order_status_id = 8 
      --and oo.causal_id = 9944--in (8, 12)
   and mm.package_id(+) = ooa.package_id
   and mp.package_id(+) = ooa.package_id
      --and mp.cust_care_reques_num = '192735615'   
      --  and mp.package_id in (195263154)
      --and pp.product_status_id = 15
   and ooa.address_id(+) = DireccionOrden.address_id
   and localidad_Orden.geograp_location_id(+) =
       DireccionOrden.geograp_location_id
   and departamento_Orden.geograp_location_id(+) =
       localidad_Orden.geo_loca_father_id
   and pp.product_id(+) = ooa.product_id
   and DireccionProducto.Address_Id(+) = pp.address_id
   and contrato.susccodi(+) = ooa.subscription_id
   and cliente.subscriber_id(+) = contrato.suscclie
 order by oo.created_date desc;

--UNIDAD OPERATIVA
select *
  from open.or_operating_unit oou
 where oou.operating_unit_id = 4208;
select oou.operating_unit_id || ' - ' || oou.name Unidad_Operativa,
       decode(upper(oou.work_days),
              'L',
              'Habiles',
              'N',
              'No Habiles',
              'B',
              'Ambos') Tipo_Dia_Ejecutar,
       (select oou.contractor_id || ' - ' || gc.nombre_contratista
          from open.ge_contratista gc
         where gc.id_contratista = oou.contractor_id) Contratista,
       (select oou.operating_zone_id || ' - ' || ooz.description
          from open.or_operating_zone ooz
         where ooz.operating_zone_id = oou.operating_zone_id) Zona_Operativa,
       es_externa Unidad_Externa
  from open.or_operating_unit oou
 where oou.operating_unit_id = 4208;

--BODEGA
select (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = ouibm.operating_unit_id) Unidad_Operativa,
       (select gi.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = ouibm.items_id) Item_Material,
       (select ouibm.item_moveme_caus_id || ' - ' || OIMC.DESCRIPTION
          from OPEN.OR_ITEM_MOVEME_CAUS OIMC
         where OIMC.ITEM_MOVEME_CAUS_ID = ouibm.item_moveme_caus_id) Causa_Movimiento,
       ouibm.amount Cantidad,
       ouibm.move_date Fecha_Movimiento,
       ouibm.support_document Documento_Soporte,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = ouibm.target_oper_unit_id) Unidad_Operativa_Destino,
       ouibm.id_items_documento Documento,
       ouibm.id_items_seriado Item_Seriado,
       (select ouibm.ID_ITEMS_ESTADO_INV || ' - ' || GIEI.DESCRIPCION
          from open.GE_ITEMS_ESTADO_INV GIEI
         where GIEI.ID_ITEMS_ESTADO_INV = ouibm.ID_ITEMS_ESTADO_INV) Estado_Item_Iventario,
       (select ouibm.INIT_INV_STAT_ITEMS || ' - ' || GIEI.DESCRIPCION
          from open.GE_ITEMS_ESTADO_INV GIEI
         where GIEI.ID_ITEMS_ESTADO_INV = ouibm.INIT_INV_STAT_ITEMS) Estado_Inicial_Item
  from open.or_uni_item_bala_mov ouibm
 where ouibm.operating_unit_id = 3333;

--CONTRATO x TIPO DE CONTRATO
select gc.*, rowid
  from open. ge_contrato gc
 where gc.id_contratista = 4770
   and gc.id_tipo_contrato = 18;
