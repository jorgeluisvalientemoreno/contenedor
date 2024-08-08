declare
  /*
  --and ooa.order_id in (314273836)
  --and ooa.comment_ ='Orden creada por proceso automatico de reglas de facturacion. 64 - SERVICIO DIRECTO. Se solicita verificacion del estado del CM, Gasodomesticos y lecturas.'
  --and ooa.product_id in (24000223)
  --and trunc(oo.legalization_date) >= '01/10/2023'
  --and trunc(oo.created_date) >= '01/05/2023'   
  --and oo.task_type_id in (12152,12150, 12153)
  --and oo.order_status_id in (0,5,6,7) 
  --and oo.causal_id = 9944--in (8, 12)
  --and oo.task_type_id = 12149
  --and ooa.activity_id in (100003638)
  --and mp.package_type_id = 299
  --and (mm.subscription_id = 48052064 or mm.product_id = 50062001)
  --and mp.cust_care_reques_num = '192735615'   
  --and mp.package_id in (74621764,74912609) --(206848977, 206848984)
  --and pp.product_status_id = 15
  */

  sqlCadena varchar2(32000) := 'select distinct oo.order_id Orden,
                              oo.order_status_id || '' - '' ||
                              (select oos.description
                                 from open.or_order_status oos
                                where oos.order_status_id = oo.order_status_id) Estado_Orden,
                              oo.legalization_date Fecha_Legalizacion,
                              nvl(ooa.subscription_id, mm.subscription_id) Contrato,
                              nvl(ooa.product_id, mm.product_id) Producto,
                              DireccionOrden.address_id || '' - '' ||
                              DireccionOrden.address Direccion_Orden,
                              localidad_Orden.geograp_location_id || '' - '' ||
                              localidad_Orden.description Localidad_Orden,
                              departamento_Orden.geograp_location_id || '' - '' ||
                              departamento_Orden.description Departamento_Orden,
                              DireccionProducto.address_id || '' - '' ||
                              DireccionProducto.address Direccion_Producto,
                              oo.operating_sector_id || '' - '' ||
                              (select oos.description
                                 from open.or_operating_sector oos
                                where oos.operating_sector_id = oo.operating_sector_id) Sector_Operativo,
                              ooa.activity_id || '' - '' ||
                              (select gi.description
                                 from open.ge_items gi
                                where gi.items_id = ooa.activity_id) Actividad,
                              oo.task_type_id || '' - '' ||
                              (select a.description
                                 from open.or_task_type a
                                where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
                              oo.causal_id || '' - '' ||
                              (select gc.description
                                 from open.ge_causal gc
                                where gc.causal_id = oo.causal_id) Causal_Legalizacion,
                              (select x.class_causal_id || '' - '' || x.description
                                 from open.ge_class_causal x
                                where x.class_causal_id =
                                      (select y.class_causal_id
                                         from open.ge_causal y
                                        where y.causal_id = oo.causal_id)) Clasificacion_Causal,
                              oo.operating_unit_id || '' - '' ||
                              (select h.name
                                 from open.or_operating_unit h
                                where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
                              oo.created_date Creacion_Orden,
                              oo.assigned_date Asignacion_Orden,
                              oo.legalization_date Legalizacion_Orden,
                              ooa.comment_ Comentario_Orden,
                              ooa.package_id Solicitud,
                              ooa.instance_id,
                              mp.package_type_id || '' - '' ||
                              (select b.description
                                 from open.ps_package_type b
                                where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
                              mp.reception_type_id || '' - '' ||
                              (select c.description
                                 from open.ge_reception_type c
                                where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
                              mp.request_date Registro_Solicitud,
                              mp.cust_care_reques_num Interaccion,
                              mp.motive_status_id || '' - '' ||
                              (select d.description
                                 from open.ps_motive_status d
                                where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                              mp.comment_ Comentario,
                              (select a2.user_id || '' - '' ||
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
                              (select a2.user_id || '' - '' ||
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
                              (select a2.user_id || '' - '' ||
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
                              (select ''Estado Inicial: '' || oosc.initial_status_id ||
                                      '' y Estado Final: '' || oosc.final_status_id ||
                                      '' por el usuario: '' || oosc.user_id
                                 from open.or_order_stat_change oosc
                                where oosc.order_id = oo.order_id
                                  and oosc.initial_status_id = 0
                                  and oosc.final_status_id = 0
                                  and rownum = 1) Cambio_Estado_creacion,
                              (select ''Estado Inicial: '' || oosc.initial_status_id ||
                                      '' y Estado Final: '' || oosc.final_status_id ||
                                      '' por el usuario: '' || oosc.user_id
                                 from open.or_order_stat_change oosc
                                where oosc.order_id = oo.order_id
                                  and oosc.initial_status_id = 0
                                  and oosc.final_status_id = 5
                                  and rownum = 1) Cambio_Estado_Asignado,
                              (select ''Estado Inicial: '' || oosc.initial_status_id ||
                                      '' y Estado Final: '' || oosc.final_status_id ||
                                      '' por el usuario: '' || oosc.user_id
                                 from open.or_order_stat_change oosc
                                where oosc.order_id = oo.order_id
                                  and oosc.initial_status_id in (0, 5)
                                  and oosc.final_status_id = 6
                                  and rownum = 1) Cambio_Estado_En_Ejecucion,
                              (select ''Estado Inicial: '' || oosc.initial_status_id ||
                                      '' y Estado Final: '' || oosc.final_status_id ||
                                      '' por el usuario: '' || oosc.user_id
                                 from open.or_order_stat_change oosc
                                where oosc.order_id = oo.order_id
                                  and oosc.initial_status_id in (0, 6, 5)
                                  and oosc.final_status_id = 7
                                  and rownum = 1) Cambio_Estado_Ejecutado,
                              (select ''Estado Inicial: '' || oosc.initial_status_id ||
                                      '' y Estado Final: '' || oosc.final_status_id ||
                                      '' por el usuario: '' || oosc.user_id
                                 from open.or_order_stat_change oosc
                                where oosc.order_id = oo.order_id
                                  and oosc.initial_status_id in (0, 6, 5, 7)
                                  and oosc.final_status_id = 8
                                  and rownum = 1) Cambio_Estado_Legalizado,
                              oo.operating_unit_id Unidad_Operativa_Asiganda,
                              (select oou.assign_type
                                 from open.or_operating_unit oou
                                where oou.operating_unit_id = oo.operating_unit_id) assign_type,
                              mm.motive_id Motivo
                from open.or_order_activity  ooa,
                     open.or_order           oo,
                     open.mo_packages        mp,
                     open.mo_motive          mm,
                     open.ab_address         DireccionOrden,
                     open.ab_address         DireccionProducto,
                     open.ge_geogra_location localidad_Orden,
                     open.ge_geogra_location departamento_Orden,
                     open.pr_product         pp
               where ooa.order_id = oo.order_id
                 and mm.package_id(+) = ooa.package_id
                 and mp.package_id(+) = ooa.package_id
                 and ooa.address_id(+) = DireccionOrden.address_id
                 and localidad_Orden.geograp_location_id(+) =
                     DireccionOrden.geograp_location_id
                 and departamento_Orden.geograp_location_id(+) =
                     localidad_Orden.geo_loca_father_id
                 and pp.product_id(+) = ooa.product_id
                 and DireccionProducto.Address_Id(+) = pp.address_id ';

  sbOrder_id             varchar2(4000) := ' and oo.order_id in (309939920) ';
  sbComment_             varchar2(4000) := 'Orden creada por proceso automatico de reglas de facturacion. 64 - SERVICIO DIRECTO. Se solicita verificacion del estado del CM, Gasodomesticos y lecturas.';
  sbProduct_id           varchar2(4000) := 0;
  sbLegalization_date    varchar2(4000) := '01/10/2023';
  sbCreated_date         varchar2(4000) := '01/10/2023';
  sbtask_type_id         varchar2(4000) := ' in (12152,12150, 12153)';
  sborder_status_id      varchar2(4000) := ' in (0,5,6,7)';
  sbcausal_id            varchar2(4000) := ' in ()';
  sbtask_type_id         varchar2(4000) := ' in (12149)';
  sbactivity_id          varchar2(4000) := ' in (100003638)';
  sbpackage_type_id      varchar2(4000) := ' in (299)';
  sbsubscription_id      varchar2(4000) := ' in (48052064)';
  sbproduct_id           varchar2(4000) := ' in (50062001)';
  sbcust_care_reques_num varchar2(4000) := ' in (''192735615'')';
  sbpackage_id           varchar2(4000) := ' in (74621764,74912609)';
  sbproduct_status_id    varchar2(4000) := ' in (15)';

  sbOrdenar varchar2(4000) := ' order by oo.created_date desc';

  cuCursor SYS_REFCURSOR;

  nuOrden                      number;
  sbEstado_Orden               varchar2(4000);
  dtlegalization_date          date;
  nuContrato                   number;
  nuProducto                   number;
  sbDireccion_Orden            varchar2(4000);
  Localidad_Orden              varchar2(4000);
  sbDepartamento_Orden         varchar2(4000);
  sbDireccion_Producto         varchar2(4000);
  sbSector_Operativo           varchar2(4000);
  sbActividad                  varchar2(4000);
  sbTipo_Trabajo               varchar2(4000);
  sbCausal_Legalizacion        varchar2(4000);
  sbClasificacion_Causal       varchar2(4000);
  sbUnidad_Operativa           varchar2(4000);
  dtCreacion_Orden             date;
  dtAsignacion_Orden           date;
  dtLegalizacion_Orden         date;
  sbComentario_Orden           varchar2(4000);
  nuSolicitud                  number;
  nuinstance_id                number;
  sbTipo_Solicitud             varchar2(4000);
  sbMedio_Recepcion            varchar2(4000);
  dtRegistro_Solicitud         date;
  nuInteraccion                number;
  sbEstado_Solicitud           varchar2(4000);
  sbComentario                 varchar2(4000);
  sbUsuario_Crea               varchar2(4000);
  sbUsuario_Asigna             varchar2(4000);
  sbUsuario_Legaliza           varchar2(4000);
  nuContrato_Definido_Orden    number;
  nuCosto_Estimado             number;
  nuValor_Referente            number;
  sbCambio_Estado_creacion     varchar2(4000);
  sbCambio_Estado_Asignado     varchar2(4000);
  sbCambio_Estado_En_Ejecucion varchar2(4000);
  sbCambio_Estado_Ejecutado    varchar2(4000);
  sbCambio_Estado_Legalizado   varchar2(4000);
  sbUnidad_Operativa_Asiganda  varchar2(4000);
  sbassign_type                varchar2(4000);
  nMotivo                      number;

begin

  --DBMS_OUTPUT.ENABLE (buffer_size => NULL);

  --DBMS_OUTPUT.put_line(sqlCadena || sbOrder_id || sbOrdenar);

  open cuCursor for sqlCadena || sbOrder_id || sbOrdenar;

  --/*
  LOOP
  
    FETCH cuCursor
    
      INTO nuOrden,
           sbEstado_Orden,
           dtlegalization_date,
           nuContrato,
           nuProducto,
           sbDireccion_Orden,
           Localidad_Orden,
           sbDepartamento_Orden,
           sbDireccion_Producto,
           sbSector_Operativo,
           sbActividad,
           sbTipo_Trabajo,
           sbCausal_Legalizacion,
           sbClasificacion_Causal,
           sbUnidad_Operativa,
           dtCreacion_Orden,
           dtAsignacion_Orden,
           dtLegalizacion_Orden,
           sbComentario_Orden,
           nuSolicitud,
           nuinstance_id,
           sbTipo_Solicitud,
           sbMedio_Recepcion,
           dtRegistro_Solicitud,
           nuInteraccion,
           sbEstado_Solicitud,
           sbComentario,
           sbUsuario_Crea,
           sbUsuario_Asigna,
           sbUsuario_Legaliza,
           nuContrato_Definido_Orden,
           nuCosto_Estimado,
           nuValor_Referente,
           sbCambio_Estado_creacion,
           sbCambio_Estado_Asignado,
           sbCambio_Estado_En_Ejecucion,
           sbCambio_Estado_Ejecutado,
           sbCambio_Estado_Legalizado,
           sbUnidad_Operativa_Asiganda,
           sbassign_type,
           nMotivo;

    EXIT WHEN cuCursor%NOTFOUND;

    DBMS_OUTPUT.put_line('Orden                       : ' || nuOrden);
    DBMS_OUTPUT.put_line('Estado_Orden                : ' || sbEstado_Orden);
    DBMS_OUTPUT.put_line('legalization_date           : ' || dtlegalization_date);
    DBMS_OUTPUT.put_line('Contrato                    : ' || nuContrato);
    DBMS_OUTPUT.put_line('Producto                    : ' || nuProducto);
    DBMS_OUTPUT.put_line('Direccion_Orden             : ' || sbDireccion_Orden);
    DBMS_OUTPUT.put_line('calidad_Orden               : ' || Localidad_Orden);
    DBMS_OUTPUT.put_line('Departamento_Orden          : ' || sbDepartamento_Orden);
    DBMS_OUTPUT.put_line('Direccion_Producto          : ' || sbDireccion_Producto);
    DBMS_OUTPUT.put_line('Sector_Operativo            : ' || sbSector_Operativo);
    DBMS_OUTPUT.put_line('Actividad                   : ' || sbActividad);
    DBMS_OUTPUT.put_line('Tipo_Trabajo                : ' || sbTipo_Trabajo);
    DBMS_OUTPUT.put_line('Causal_Legalizacion         : ' || sbCausal_Legalizacion);
    DBMS_OUTPUT.put_line('Clasificacion_Causal        : ' || sbClasificacion_Causal);
    DBMS_OUTPUT.put_line('Unidad_Operativa            : ' || sbUnidad_Operativa);
    DBMS_OUTPUT.put_line('Creacion_Orden              : ' || dtCreacion_Orden);
    DBMS_OUTPUT.put_line('Asignacion_Orden            : ' || dtAsignacion_Orden);
    DBMS_OUTPUT.put_line('Legalizacion_Orden          : ' || dtLegalizacion_Orden);
    DBMS_OUTPUT.put_line('Comentario_Orden            : ' || sbComentario_Orden);
    DBMS_OUTPUT.put_line('Solicitud                   : ' || nuSolicitud);
    DBMS_OUTPUT.put_line('instance_id                 : ' || nuinstance_id);
    DBMS_OUTPUT.put_line('Tipo_Solicitud              : ' || sbTipo_Solicitud);
    DBMS_OUTPUT.put_line('Medio_Recepcion             : ' || sbMedio_Recepcion);
    DBMS_OUTPUT.put_line('Registro_Solicitud          : ' || dtRegistro_Solicitud);
    DBMS_OUTPUT.put_line('Interaccion                 : ' || nuInteraccion);
    DBMS_OUTPUT.put_line('Estado_Solicitud            : ' || sbEstado_Solicitud);
    DBMS_OUTPUT.put_line('Comentario                  : ' || sbComentario);
    DBMS_OUTPUT.put_line('Usuario_Crea                : ' || sbUsuario_Crea);
    DBMS_OUTPUT.put_line('Usuario_Asigna              : ' || sbUsuario_Asigna);
    DBMS_OUTPUT.put_line('Usuario_Legaliza            : ' || sbUsuario_Legaliza);
    DBMS_OUTPUT.put_line('Contrato_Definido_Orden     : ' || nuContrato_Definido_Orden);
    DBMS_OUTPUT.put_line('Costo_Estimado              : ' || nuCosto_Estimado);
    DBMS_OUTPUT.put_line('Valor_Referente             : ' || nuValor_Referente);
    DBMS_OUTPUT.put_line('Cambio_Estado_creacion      : ' || sbCambio_Estado_creacion);
    DBMS_OUTPUT.put_line('Cambio_Estado_Asignado      : ' || sbCambio_Estado_Asignado);
    DBMS_OUTPUT.put_line('Cambio_Estado_En_Ejecucion  : ' || sbCambio_Estado_En_Ejecucion);
    DBMS_OUTPUT.put_line('Cambio_Estado_Ejecutado     : ' || sbCambio_Estado_Ejecutado);
    DBMS_OUTPUT.put_line('Cambio_Estado_Legalizado    : ' || sbCambio_Estado_Legalizado);
    DBMS_OUTPUT.put_line('Unidad_Operativa_Asiganda   : ' || sbUnidad_Operativa_Asiganda);
    DBMS_OUTPUT.put_line('Tipo_Asignacion             : ' || sbassign_type);
    DBMS_OUTPUT.put_line('Motivo                      : ' || nMotivo);
  
  END LOOP;
  --*/

  close cuCursor;

end;
