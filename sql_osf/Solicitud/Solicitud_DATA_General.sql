select distinct MP.USER_ID Usuario,
                mp.package_type_id || ' - ' ||
                (select b.description
                   from open.ps_package_type b
                  where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
                mp.package_id Solicitud,
                mp.motive_status_id || ' - ' ||
                (select d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                mp.reception_type_id || ' - ' ||
                (select c.description
                   from open.ge_reception_type c
                  where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
                mp.request_date Fecha_Registro,
                mp.cust_care_reques_num Interaccion,
                mp.attention_date Fecha_Atencion,
                mp.init_register_date Fecha_Inicio_Registro,
                mp.cust_care_reques_num Interaccion,
                mp.comment_ Comentario,
                mm.motive_id Motivo,
                (select mm.motive_status_id || ' - ' || d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mm.motive_status_id) Estado_Motivo,
                (select mp.pos_oper_unit_id || ' - ' || oou.name
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = mp.pos_oper_unit_id) Punto_Venta,
                (select mp.operating_unit_id || ' - ' || oou.name
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = mp.operating_unit_id) Unidad_Operativa,
                mp.management_area_id Area_Administrativa,
                mm.product_id Producto,
                mm.subscription_id Contrato,
                mp.subscriber_id Identificacion,
                (select mm.motive_status_id || ' - ' || d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mc.motive_status_id) Estado_Componentes,
                (select count(1)
                   from open.Or_Order_Activity ooa
                  where ooa.package_id = mp.package_id) Cantidad_Ordenes,
                mm.CUSTOM_DECISION_FLAG Documentacion_Completa,
                nvl((select decode(nvl(wde.unit_type_id, 0),
                                  0,
                                  'No Tiene Flujo',
                                  'Tiene Flujo')
                      from OPEN.WF_DATA_EXTERNAL wde
                     where wde.package_id = mp.package_id
                       and rownum = 1),
                    'No Tiene Flujo') Tiene_Flujo,
                (select count(1)
                   from OPEN.OR_ORDER_ACTIVITY ooa
                  where ooa.package_id = mp.package_id) Cantidad_Ordenes,
                (select /*+ index mdfo(IDX_MO_DATA_FOR_ORDER_01)*/
                  mdfo.item_id
                   from OPEN.MO_DATA_FOR_ORDER mdfo
                  where mdfo.package_id = mp.package_id) Actividad,
                decode((select count(1)
                         from OPEN.LDCI_PACKAGE_CAMUNDA_LOG LPCL
                        where lpcl.package_id = mp.package_id),
                       1,
                       'SI',
                       'NO') Generada_CAMUNDA
  from open.mo_packages mp
  left join open.mo_motive mm
    on MP.PACKAGE_ID = MM.PACKAGE_ID
  left join open.mo_component mc
    on mc.package_id = mp.package_id
   and 'S' in upper(&ConsultaComponente)
 where 1 = 1
--and mp.package_id in (226273986)
--and mm.subscription_id is not null--= 50062691
--and mm.product_id = 17248467
--and mp.cust_care_reques_num = '213303669'   
--and mp.motive_status_id = 13
--and mp.subscriber_id in (select a2.suscclie from OPEN.SUSCRIPC a2 where a2.susccodi = 50062691)
--and mm.product_id = 50366875
--and mp.package_type_id = 100342
--and trunc(mp.request_date) >= '01/07/2025'
--and (select count(1) from open.Or_Order_Activity ooa where ooa.package_id = mp.package_id ) = 0 
--and mm.CUSTOM_DECISION_FLAG = 'N'
-- and mp.package_type_id = 100220
--and (select count(1) from OPEN.OR_ORDER_ACTIVITY ooa where ooa.package_id = mp.package_id) > 0
 order by MP.PACKAGE_ID asc;
