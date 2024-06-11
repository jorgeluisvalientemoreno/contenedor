PL/SQL Developer Test script 3.0
292
-- Created on 28/03/2017 by JM - GESTION 001 
declare
  -- Local variables here
  NuOrder_Ir open.or_order.ORDER_ID%type;

  ---Cursor para obtener el comentario y la direccion
  Cursor CurOrdenActi(NUORDER_ID open.or_order.ORDER_ID%TYPE) is
    select ADDRESS_ID,
           COMMENT_,
           open.DAOR_ORDER.FNUGETOPERATING_UNIT_ID(NUORDER_ID, NULL)
      FROM open.or_order_activity
     where ORDER_ID = NUORDER_ID;

  sBcOMENTARIO      VARCHAR2(2000);
  NuCodDir          number;
  NUUNIDADOPERATIVA NUMBER;

  ---Cursor para obtener la cantidad de actividades configuradas en la orden principal
  Cursor CurcantidadACTIVIDAD(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select count(LR.ITEMS_ID) cantidadactividades
      FROM open.LDC_REGTIPOTRAADI LR
     where LR.ORDER_ID = NUORDEN
     ORDER BY LR.ITEMS_ID;

  nucantidadACTIVIDAD number;

  ---Cursor para obtener cantidad trabajo adcionales generados de la orden principal
  Cursor CurCANTIDADtrabajo(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select count(*) cantidadtabajos
      FROM open.LDC_REGTIPOTRAADI LR, open.or_related_order oro
     where LR.ORDER_ID = NUORDEN
       and lr.order_id = oro.related_order_id
       and lr.items_id in
           (SELECT OOA.Activity_Id
              FROM OPEN.OR_ORDER_ACTIVITY OOA
             WHERE OOA.Activity_Id = lr.items_id
               and ooa.order_id = oro.order_id)
     ORDER BY LR.ITEMS_ID;

  nuCANTIDADtrabajo number;

  ---Cursor para obtener LAS ACTIVIDADES
  Cursor CurACTIVIDAD(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select LR.ITEMS_ID,
           LR.CAUSAL_ID,
           LR.OBSERVACION,
           LR.TASK_TYPE_ID,
           LR.TECNICO_UNIDAD
      FROM open.LDC_REGTIPOTRAADI LR
     where LR.ORDER_ID = NUORDEN
     ORDER BY LR.ITEMS_ID;

  ---Cursor para VALIDAR SI LA ACTIVIDAD YA EXISTE COMO UN TRABAJO ADICIONAL
  --RELACIONADO CON LA ORDEN PRINCIPAL.
  Cursor CurEXISTEACTIVIDAD(NUORDEN    open.or_order.ORDER_ID%TYPE,
                            NUITEMS_ID open.GE_ITEMS.ITEMS_ID%TYPE) is
    select COUNT(LR.ITEMS_ID) CANTIDAD
      FROM open.LDC_REGTIPOTRAADI LR, open.OR_RELATED_ORDER ORO
     where LR.ORDER_ID = NUORDEN
       AND LR.ITEMS_ID = NUITEMS_ID
       AND ORO.RELATED_ORDER_ID = LR.ORDER_ID
       and lr.items_id in
           (SELECT OOA.Activity_Id
              FROM OPEN.OR_ORDER_ACTIVITY OOA
             WHERE OOA.Activity_Id = lr.items_id
               AND ORO.ORDER_ID = OOA.ORDER_ID)
     ORDER BY LR.ITEMS_ID;

  ---Cursor para obtener LOS MATERIALES
  Cursor CurMATERIAL(NUORDEN        open.or_order.ORDER_ID%TYPE,
                     NUTask_Type_Id open.or_order.Task_Type_Id%TYPE,
                     NUACTIVIDAD    open.OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) is
    select LI.MATERIAL_ID, LI.CANTIDAD
      FROM open.LDC_ITEMTIPTRAADI LI
     where LI.ORDER_ID = NUORDEN
       AND LI.TASK_TYPE_ID = NUTask_Type_Id
       AND LI.ITEMS_ID = NUACTIVIDAD
     ORDER BY LI.MATERIAL_ID;

  --CURSOR PARA GENERAR CADENA QUE SERA TULIZADA PARA LEGALIZAR LA ORDEN
  CURSOR CUCADENALEGALIZACION(NUORDER_ID          OPEN.OR_ORDER.ORDER_ID%TYPE,
                              NUCAUSAL_ID         open.GE_CAUSAL.CAUSAL_ID%TYPE,
                              SBTEXTO             VARCHAR2,
                              SBDATOS             VARCHAR2,
                              TECNICO_UNIDAD      open.LDC_REGTIPOTRAADI.TECNICO_UNIDAD%TYPE,
                              Isbcadenamateriales VARCHAR2) IS
    SELECT O.ORDER_ID || '|' || NUCAUSAL_ID || '|' || TECNICO_UNIDAD || '|' ||
           SBDATOS || '|' || A.ORDER_ACTIVITY_ID || '>1;;;;|' ||
           Isbcadenamateriales || '||1277;' || SBTEXTO CADENALEGALIZACION
      FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
     WHERE O.ORDER_ID = A.ORDER_ID
       AND O.ORDER_ID = NUORDER_ID;

  SBCADENALEGALIZACION VARCHAR2(4000);

  ---Cursor para obtener LOS MATERIALES
  Cursor CuOR_ORDER_ACTIVITY(NUORDEN open.or_order.ORDER_ID%TYPE) is
    SELECT OOA.*
      FROM OPEN.OR_ORDER_ACTIVITY OOA
     WHERE OOA.ORDER_ID = NUORDEN;

  RCCuOR_ORDER_ACTIVITY CuOR_ORDER_ACTIVITY%ROWTYPE;

  --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
  cursor cugrupo(nutask_type_id open.or_task_type.task_type_id%type,
                 NUCAUSAL_ID    open.GE_CAUSAL.CAUSAL_ID%TYPE) is
    select *
      from open.or_tasktype_add_data ottd
     where ottd.task_type_id = nutask_type_id
       and ottd.active = 'Y'
       and (ottd.use_ = decode(open.dage_causal.fnugetcausal_type_id(NUCAUSAL_ID),
                               1,
                               'C',
                               2,
                               'I') or ottd.use_ = 'B');

  cursor cudatoadicional(nuattribute_set_id open.ge_attributes_set.attribute_set_id%type) is
    select *
      from open.ge_attributes b
     where b.attribute_id in
           (select a.attribute_id
              from open.ge_attrib_set_attrib a
             where a.attribute_set_id = nuattribute_set_id);

  RCGRUPO cugrupo%ROWTYPE;

  SBDATOSADICIONALES VARCHAR2(2000);

  ionuOrderId NUMBER(15);

  onuValue       open.ge_unit_cost_ite_lis.price%type;
  onuPriceListId open.ge_list_unitary_cost.list_unitary_cost_id%type;
  idtDate        date;
  inuContract    open.ge_list_unitary_cost.contract_id%type;
  inuContractor  open.ge_list_unitary_cost.contractor_id%type;
  inuGeoLocation open.ge_list_unitary_cost.geograp_location_id%type;
  isbType        open.ge_acta.id_tipo_acta%type;

  nucantidad    number;
  SBOBSERVACION VARCHAR2(4000);

  sbcadenamateriales VARCHAR2(4000);

  -- objetos pata legalizacion de la orden principal
  cursor cuLDC_ORDTIPTRAADI(NUORDER_ID OPEN.OR_ORDER.ORDER_ID%TYPE) is
    SELECT Enc.Orden_padre,
           Enc.Causal_padre,
           nvl(Enc.ini_ejec_padre, sysdate) ini_ejec_padre,
           nvl(Enc.fin_ejec_padre, sysdate) fin_ejec_padre,
           Enc.observ_padre,
           Enc.tecnico_padre,
           Det.TipoTrabAdic,
           Det.activAdic,
           Det.Causal_Ot_Adic,
           Det.observaAdic,
           Det.Tecnico_Ot_Adic,
           detitem.itemtrabadi,
           detitem.catntrabadi
      FROM XMLTable('/legalizacionOrden/orden' Passing
                    XMLType('<?xml version="1.0" encoding="UTF-8"?><legalizacionOrden><orden><idOrden>65180470</idOrden><idCausal>9595</idCausal><idTecnico>15902</idTecnico><fechaIniEjec>24/02/17</fechaIniEjec><fechaFinEjec>24/02/17</fechaFinEjec><ordenesAdic><ordenAdic><idTipoTrab>12189</idTipoTrab><idActividad>4000089</idActividad><idCausal>9595</idCausal><observacion><![CDATA[EL DIA 24/2/2017 DE LA ORDEN 69621239 EN COMUN SE REALIZO REPARACION EN PUNTO DE TABLERO POR FUGA SE REALIZO REPARACION DE ACOMETIDA PARA EL CAMBIO DEL ELEVADOR Y VALVULA POR FUGA TRABAJOS PARA LOS MEDIDORES.U-1351599/U-769817.]]></observacion><idTecnico>15902</idTecnico><items><item><idItem>100004424</idItem><cantidad>0.50</cantidad></item></items></ordenAdic><ordenAdic><idTipoTrab>12190</idTipoTrab><idActividad>4000090</idActividad><idCausal>9595</idCausal><observacion><![CDATA[EL DIA 24/2/2017 DE LA ORDEN 69621239 EN COMUN SE REALIZO REPARACION EN PUNTO DE TABLERO POR FUGA SE REALIZO REPARACION DE ACOMETIDA PARA EL CAMBIO DEL ELEVADOR Y VALVULA POR FUGA TRABAJOS PARA LOS MEDIDORES.U-1351599/U-769817.]]></observacion><idTecnico>15902</idTecnico><items><item><idItem>100004423</idItem><cantidad>0.50</cantidad></item><item><idItem>100004426</idItem><cantidad>0.50</cantidad></item></items></ordenAdic></ordenesAdic></orden></legalizacionOrden>')
                    Columns Orden_padre NUMBER Path 'idOrden',
                    Causal_padre NUMBER Path 'idCausal',
                    ini_ejec_padre DATE PATH 'ini_eje_padre',
                    fin_ejec_padre DATE PATH 'fin_eje_padre',
                    observ_padre VARCHAR2(2000) PATH 'observ_padre',
                    tecnico_padre NUMBER Path 'idTecnico',
                    XMLOrdenesAdicionales XMLType Path 'ordenesAdic') As Enc,
           XMLTable('/ordenesAdic/ordenAdic' Passing
                    Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                    'idTipoTrab',
                    activAdic NUMBER Path 'idActividad',
                    Causal_Ot_Adic NUMBER Path 'idCausal',
                    observaAdic VARCHAR2(2000) Path 'observacion',
                    Tecnico_Ot_Adic VARCHAR2(200) Path 'idTecnico',
                    XMLitemsotadic XMLType Path 'items') As Det,
           XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                    itemtrabadi NUMBER Path 'idItem',
                    catntrabadi varchar2(200) Path 'cantidad') AS Detitem;

  tempcuLDC_ORDTIPTRAADI cuLDC_ORDTIPTRAADI%rowtype;
  ---fin legalizacion de la orden principal

  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(3200);
  sesion          number;
begin

  SELECT SYS_CONTEXT('USERENV', 'SESSIONID') into sesion FROM DUAL;

  "OPEN".ut_trace.init;
  "OPEN".ut_trace.SetOutPut("OPEN".ut_trace.cnuTRACE_OUTPUT_DB);
  "OPEN".ut_trace.SetLevel(99);
  DBMS_OUTPUT.put_line(sesion);

  -- Test statements here

  NuOrder_Ir := 65180470;

  SBOBSERVACION := NULL;

  --------------------------------------------------------------------
  ---proceso de legalizacion de orden principal
  open cuLDC_ORDTIPTRAADI(NuOrder_Ir);
  fetch cuLDC_ORDTIPTRAADI
    into tempcuLDC_ORDTIPTRAADI;
  if cuLDC_ORDTIPTRAADI%notfound then
  
    onuErrorCode    := -1;
    osbErrorMessage := 'Lo orden [' || NuOrder_Ir ||
                       '] principal tiene inconvenientes en la configuracion de la forma LDCTA';
    "OPEN".LDC_BOTRABAJOADICIONAL.PRLOGTRABADIC(tempcuLDC_ORDTIPTRAADI.Orden_Padre,
                                                0,
                                                osbErrorMessage);
    close cuLDC_ORDTIPTRAADI;
    --raise ex.CONTROLLED_ERROR;
  else
  
    --cadena datos adicionales
    SBDATOSADICIONALES := NULL;
    
    DBMS_OUTPUT.put_line("OPEN".daor_order.fnugettask_type_id(NuOrder_Ir, null));
    DBMS_OUTPUT.put_line(tempcuLDC_ORDTIPTRAADI.Causal_Padre);
    
    for rc in cugrupo("OPEN".daor_order.fnugettask_type_id(NuOrder_Ir, null),
                      tempcuLDC_ORDTIPTRAADI.Causal_Padre) loop
    
      for rcdato in cudatoadicional(rc.attribute_set_id) loop
        IF SBDATOSADICIONALES IS NULL THEN
          SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
        ELSE
          SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                RCDATO.NAME_ATTRIBUTE || '=';
        END IF;
      
      -- dbms_output.put_line('Dato adicional[' || rcdato.name_attribute || ']');
      end loop;
    end loop;
  
  end if;
  --fin cadena datos adicionales
  SBCADENALEGALIZACION := NULL;
  OPEN CUCADENALEGALIZACION(NuOrder_Ir,
                            tempcuLDC_ORDTIPTRAADI.Causal_Padre,
                            '-Legalizacion por forma LDCGTA-' ||
                            nvl(regexp_replace(tempcuLDC_ORDTIPTRAADI.observ_padre, '( *[[:punct:]])', ''), ''),
                            SBDATOSADICIONALES,
                            tempcuLDC_ORDTIPTRAADI.Tecnico_Padre,
                            null);
  FETCH CUCADENALEGALIZACION
    INTO SBCADENALEGALIZACION;
  CLOSE CUCADENALEGALIZACION;

  DBMS_OUTPUT.put_line('Cadena legalizacion orden principal [' ||
                       SBCADENALEGALIZACION || '] ' ||
                       ' SBDATOSADICIONALES: ' || SBDATOSADICIONALES);

  ---INICIO LEGALIZAR TRABAJO ADICIONAL
  "OPEN".os_legalizeorders(SBCADENALEGALIZACION,
                           nvl('6/04/2017', sysdate),
                           nvl('6/04/2017', sysdate),
                           sysdate,
                           onuErrorCode,
                           osbErrorMessage);
    

  rollback;
  if (onuErrorCode <> 0) then
    "OPEN".ut_trace.trace('ERROR AL LEGALIZAR LA ORDEN [' || ionuOrderId || '] ' ||
                          onuErrorCode || ' - ' || osbErrorMessage,
                          10);
    DBMS_OUTPUT.put_line('ERROR AL LEGALIZAR LA ORDEN [' || ionuOrderId || '] ' ||
                         onuErrorCode || ' - ' || osbErrorMessage);
    IF SBOBSERVACION IS NULL THEN
      SBOBSERVACION := 'ERROR EN EL SERVICIO os_legalizeorders [' ||
                       onuErrorCode || ' - ' || osbErrorMessage || '] ' ||
                       SBCADENALEGALIZACION;
    ELSE
      SBOBSERVACION := SBOBSERVACION || CHR(10) ||
                       'ERROR EN EL SERVICIO os_legalizeorders [' ||
                       onuErrorCode || ' - ' || osbErrorMessage || '] ' ||
                       SBCADENALEGALIZACION;
    END IF;
  
    "OPEN".LDC_BOTRABAJOADICIONAL.PRLOGTRABADIC(NuOrder_Ir,
                                                0,
                                                osbErrorMessage);
    rollback;
  
  end if;
  ---FIN LEGALIZACION TRABAJO ADICIONAL

end;
0
0
