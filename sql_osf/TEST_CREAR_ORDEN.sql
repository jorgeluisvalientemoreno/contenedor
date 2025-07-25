declare
  -- Local variables here
  i               integer;
  nuAddressId     NUMBER;
  ionuOrderId     OR_ORDER.ORDER_ID%TYPE;
  ionuActivity    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
  onuErrorCode    NUMBER(18);
  osbErrorMessage VARCHAR2(2000);
  sbComment       LDC_RESPUESTA_GRUPO.OBSERVACION%TYPE;
  NUITEMS_ID      GE_ITEMS.ITEMS_ID%TYPE := dald_parameter.fnugetNumeric_Value('COD_ACTIVITY_CREATE',
                                                                               null);

  inuitemsid          number;
  inupackageid        number;
  inumotiveid         number;
  inucomponentid      number;
  inuinstanceid       number;
  inuaddressid        number;
  inuelementid        number;
  inusubscriberid     number;
  inusubscriptionid   number;
  inuproductid        number;
  inuoperunitid       number;
  idtexecestimdate    date;
  inuprocessid        number;
  isbcomment          varchar2(4000);
  iblprocessorder     boolean;
  inupriorityid       number;
  inuordertemplateid  number;
  isbcompensate       varchar2(4000);
  inuconsecutive      number;
  inurouteid          number;
  inurouteconsecutive number;
  inulegalizetrytimes number;
  isbtagname          varchar2(4000);
  iblisacttogroup     boolean;
  inurefvalue         number;
  inuactionid         number;
  --ionuorderid         number;
  --ionuorderactivityid number;
  --onuerrorcode        number;
  --osberrormessage     varchar2(4000);

  cursor cuDATAOrden is
    select distinct ooa.activity_id, -- inuitemsid          
                    ooa.package_id, -- inupackageid        
                    mm.motive_id, -- inumotiveid         
                    --inucomponentid      
                    ooa.instance_id, -- inuinstanceid       
                    ooa.address_id, --inuaddressid        
                    --inuelementid        
                    ooa.subscriber_id, -- inusubscriberid     
                    ooa.subscription_id, -- inusubscriptionid   
                    ooa.product_id -- inuproductid        
    --inuoperunitid       
    --idtexecestimdate    
    --inuprocessid        
    --isbcomment          
    --iblprocessorder     
    --inupriorityid       
    --inuordertemplateid  
    --isbcompensate       
    --inuconsecutive      
    --inurouteid          
    --inurouteconsecutive 
    --inulegalizetrytimes 
    --isbtagname          
    --iblisacttogroup     
    --inurefvalue         
    --inuactionid    
    /*oo.order_id, ---||',',
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
    oo.created_date Creacion_Orden,
    oo.assigned_date Asignacion_Orden,
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
    oo.defined_contract_id,
    oo.estimated_cost,
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
    oo.operating_unit_id,
    (select oou.assign_type
       from open.or_operating_unit oou
      where oou.operating_unit_id = oo.operating_unit_id) assign_type,
    mm.motive_id Motivo*/
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
       and ooa.order_id in (171408873)
          --and ooa.product_id in (24000223)
          --and trunc(oo.legalization_date) >= '01/10/2023'
          --and trunc(oo.created_date) >= '01/05/2023'   
          --and oo.task_type_id in (12152,12150, 12153)
          --and oo.order_status_id = 8 
          --and oo.causal_id = 9944--in (8, 12)
          --and oo.task_type_id = 12149
          --and ooa.activity_id in (100003638)
          --and mp.package_type_id = 299
          --and (mm.subscription_id = 48052064 or mm.product_id = 50062001)
       and mm.package_id(+) = ooa.package_id
       and mp.package_id(+) = ooa.package_id
          --and mp.cust_care_reques_num = '192735615'   
          --and mp.package_id in (204748249) --(206848977, 206848984)
          --and pp.product_status_id = 15
       and ooa.address_id(+) = DireccionOrden.address_id
       and localidad_Orden.geograp_location_id(+) =
           DireccionOrden.geograp_location_id
       and departamento_Orden.geograp_location_id(+) =
           localidad_Orden.geo_loca_father_id
       and pp.product_id(+) = ooa.product_id
       and DireccionProducto.Address_Id(+) = pp.address_id;

  sbAplica varchar2(1) := 'N';

begin
  -- Test statements here
  sbComment := 'OT prueba Venta Constructora';
  --nuAddressId := dapr_product.fnugetaddress_id();
  /*OS_CREATEORDERACTIVITIES(NUITEMS_ID,
                           nuAddressId,
                           SYSDATE + (1 / 24 / 60),
                           sbComment,
                           0,
                           ionuOrderId,
                           onuErrorCode,
                           osbErrorMessage);
  
  dbms_output.put_line('TEST OS_CREATEORDERACTIVITIES');
  dbms_output.put_line('Orden: ' || ionuOrderId);
  dbms_output.put_line('Error Codigo: ' || onuErrorCode);
  dbms_output.put_line('Error Mensaje: ' || osbErrorMessage);
  commit;*/

  --
  open cuDATAOrden;
  fetch cuDATAOrden
    into inuitemsid,
         inupackageid,
         inumotiveid,
         --inucomponentid      
         inuinstanceid,
         inuaddressid,
         --inuelementid        
         inusubscriberid,
         inusubscriptionid,
         inuproductid;
  --inuoperunitid       
  --idtexecestimdate    
  --inuprocessid        
  --isbcomment          
  --iblprocessorder     
  --inupriorityid       
  --inuordertemplateid  
  --isbcompensate       
  --inuconsecutive      
  --inurouteid          
  --inurouteconsecutive 
  --inulegalizetrytimes 
  --isbtagname          
  --iblisacttogroup     
  --inurefvalue         
  --inuactionid  ;
  close cuDATAOrden;
  ----
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  api_createorder(inuitemsid,
                  inupackageid,
                  inumotiveid,
                  NULL,
                  inuinstanceid,
                  inuaddressid,
                  NULL,
                  NULL,
                  inusubscriptionid,
                  inuproductid,
                  inuoperunitid,
                  SYSDATE + (1 / 24 / 60),
                  NULL,
                  sbComment,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  0,
                  NULL,
                  ionuOrderId,
                  ionuActivity,
                  onuErrorCode,
                  osbErrorMessage);

  dbms_output.put_line('TEST api_createorder');
  dbms_output.put_line('Orden: ' || ionuOrderId);
  dbms_output.put_line('Actividad Orden: ' || ionuActivity);
  dbms_output.put_line('Error Codigo: ' || onuErrorCode);
  dbms_output.put_line('Error Mensaje: ' || osbErrorMessage);

  if sbAplica = 'S' then
    if onuErrorCode = 0 then
      commit;
    else
      Rollback;
    end iF;
  end iF;

end;
