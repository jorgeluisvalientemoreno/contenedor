PL/SQL Developer Test script 3.0
2831
-- Created on 24/08/2023 by JORGE VALIENTE 
declare
  nutt                   number;
  clascausal             number;
  charge_status          open.or_order.charge_status%type;
  dtEXECUTION_FINAL_DATE open.or_order.EXECUTION_FINAL_DATE%type;

  sbAplicaEnt2002688 varchar2(1) := null; --2002688
  isbId              number := 314674950;

  --isbId           VARCHAR2(4000) := '67726981';
  inuCurrent      NUMBER := 1;
  inuTotal        NUMBER := 1;
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(4000);
  salir           NUMBER := 1;

  NuOrder_Ir open.or_order.ORDER_ID%type;

  ---Cursor para obtener el comentario y la direccion
  Cursor CurOrdenActi(NUORDER_ID open.or_order.ORDER_ID%TYPE) is
    select ADDRESS_ID,
           COMMENT_,
           --DAOR_ORDER.FNUGETOPERATING_UNIT_ID(NUORDER_ID, NULL)
           (select oo.operating_unit_id
              from open.or_order oo
             where oo.order_id = NUORDER_ID)
      FROM open.or_order_activity
     where ORDER_ID = NUORDER_ID
       and ROWNUM = 1;

  sBcOMENTARIO      VARCHAR2(2000);
  NuCodDir          number;
  NUUNIDADOPERATIVA NUMBER;

  ---Cursor para obtener la cantidad de actividades configuradas en la orden principal
  Cursor CurcantidadACTIVIDAD(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select count(LR.ACTIVIDAD) cantidadactividades
      FROM open.LDC_OTADICIONAL LR
     where LR.ORDER_ID = NUORDEN;

  nucantidadACTIVIDAD number;

  ---Cursor para obtener cantidad trabajo adcionales generados de la orden principal
  Cursor CurCANTIDADtrabajo(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select count(*) cantidadtabajos
      FROM open.or_related_order oro
     where oro.ORDER_ID = NUORDEN;
  /*select count(*) cantidadtabajos
   FROM LDC_OTADICIONAL LR, or_related_order oro
  where LR.ORDER_ID = NUORDEN
    and lr.order_id = oro.related_order_id
    and lr.actividad in
        (SELECT OOA.Activity_Id
           FROM OPEN.OR_ORDER_ACTIVITY OOA
          WHERE OOA.Activity_Id = lr.actividad
            and ooa.order_id = oro.order_id);*/

  nuCANTIDADtrabajo number;

  ---Cursor para obtener LAS ACTIVIDADES
  Cursor CurACTIVIDAD(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID --, LR.MATERIAL
      FROM open.ldc_otadicional LR
     where LR.ORDER_ID = NUORDEN
     GROUP BY LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID --, LR.MATERIAL
     ORDER BY LR.TASK_TYPE_ID, LR.ACTIVIDAD;

  TEMPCurACTIVIDAD CurACTIVIDAD%ROWTYPE;

  ---Cursor para VALIDAR SI LA ACTIVIDAD YA EXISTE COMO UN TRABAJO ADICIONAL
  --RELACIONADO CON LA ORDEN PRINCIPAL.
  Cursor CurEXISTEACTIVIDAD(NUORDEN    open.or_order.ORDER_ID%TYPE,
                            NUITEMS_ID open.GE_ITEMS.ITEMS_ID%TYPE) is
    select COUNT(LR.ACTIVIDAD) CANTIDAD
      FROM open.LDC_OTADICIONAL LR, open.OR_RELATED_ORDER ORO
     where LR.ORDER_ID = NUORDEN
       AND LR.ACTIVIDAD = NUITEMS_ID
       AND ORO.RELATED_ORDER_ID = LR.ORDER_ID
       and lr.actividad in (SELECT OOA.Activity_Id
                              FROM OPEN.OR_ORDER_ACTIVITY OOA
                             WHERE OOA.Activity_Id = lr.actividad
                               AND ORO.ORDER_ID = OOA.ORDER_ID
                               AND ROWNUM = 1)
     ORDER BY LR.ACTIVIDAD;

  ---Cursor para obtener LOS MATERIALES
  Cursor CurMATERIAL(NUORDEN        open.or_order.ORDER_ID%TYPE,
                     NUTask_Type_Id open.or_order.Task_Type_Id%TYPE,
                     NUACTIVIDAD    open.OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) is
    select LI.MATERIAL, LI.CANTIDAD
      FROM open.LDC_OTADICIONAL LI
     where LI.ORDER_ID = NUORDEN
       AND LI.TASK_TYPE_ID = NUTask_Type_Id
       AND LI.ACTIVIDAD = NUACTIVIDAD
     ORDER BY LI.MATERIAL;

  TEMPCurMATERIAL CurMATERIAL%ROWTYPE;

  --CURSOR PARA GENERAR CADENA QUE SERA TULIZADA PARA LEGALIZAR LA ORDEN
  CURSOR CUCADENALEGALIZACION(NUORDER_ID          OPEN.OR_ORDER.ORDER_ID%TYPE,
                              NUCAUSAL_ID         open.GE_CAUSAL.CAUSAL_ID%TYPE,
                              SBTEXTO             VARCHAR2,
                              SBDATOS             VARCHAR2,
                              TECNICO_UNIDAD      open.LDC_REGTIPOTRAADI.TECNICO_UNIDAD%TYPE,
                              Isbcadenamateriales VARCHAR2,
                              IsbATRIBUTO         VARCHAR2,
                              IsbLECTURAS         VARCHAR2) IS
    SELECT O.ORDER_ID || '|' || NUCAUSAL_ID || '|' || TECNICO_UNIDAD || '|' ||
           SBDATOS || '|' || A.ORDER_ACTIVITY_ID || '>' ||
           decode(nvl((select gc.class_causal_id
                        from open.ge_causal gc
                       where gc.causal_id = NUCAUSAL_ID),
                      0), --nvl(dage_causal.fnugetclass_causal_id(NUCAUSAL_ID, null),0),
                  1,
                  1,
                  0) --|| ';;;;|' || Isbcadenamateriales || '||1277;' ||
           || IsbATRIBUTO || '|' || Isbcadenamateriales || '|' ||
           IsbLECTURAS || '|1277;' || SBTEXTO CADENALEGALIZACION
      FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
     WHERE O.ORDER_ID = A.ORDER_ID
       AND O.ORDER_ID = TO_NUMBER(NUORDER_ID)
          --and a.status = 'R'
       and not exists (select 1
              from open.ct_item_novelty n
             where n.items_id = a.activity_id)
       AND ROWNUM = 1;

  SBCADENALEGALIZACION VARCHAR2(4000);

  ---Cursor para obtener LOS MATERIALES
  Cursor CuOR_ORDER_ACTIVITY(NUORDEN open.or_order.ORDER_ID%TYPE) is
    SELECT OOA.*
      FROM OPEN.OR_ORDER_ACTIVITY OOA
     WHERE OOA.ORDER_ID = NUORDEN
       AND ROWNUM = 1;

  RCCuOR_ORDER_ACTIVITY CuOR_ORDER_ACTIVITY%ROWTYPE;

  --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
  cursor cugrupo(nutask_type_id open.or_task_type.task_type_id%type,
                 NUCAUSAL_ID    open.GE_CAUSAL.CAUSAL_ID%TYPE) is
    select *
      from open.or_tasktype_add_data ottd
     where ottd.task_type_id = nutask_type_id
       and ottd.active = 'Y'
       and (SELECT count(1) cantidad
              FROM DUAL
             WHERE --dage_causal.fnugetclass_causal_id(NUCAUSAL_ID, NULL) 
             (select gc.class_causal_id
                from open.ge_causal gc
               where gc.causal_id = NUCAUSAL_ID) IN (1, 2)
            /*(select column_value
            from table(ldc_boutilities.splitstrings((select l.value_chain from open.ld_parameter l where l.parameter_id='CLASS_CAUSAL_LEGO'),--dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',NULL),
                                                    ',')))*/
            ) = 1
          --/*
          --CASO 200-1932
          --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(NUCAUSAL_ID),
       and (ottd.use_ = decode((select gc.class_causal_id
                                 from open.ge_causal gc
                                where gc.causal_id = NUCAUSAL_ID), --DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(NUCAUSAL_ID),
                               1,
                               'C',
                               2,
                               'I') or ottd.use_ = 'B') --*/
    ;

  cursor cudatoadicional(nuattribute_set_id open.ge_attributes_set.attribute_set_id%type) is
    select *
      from open.ge_attributes b
     where b.attribute_id in
           (select a.attribute_id
              from open.ge_attrib_set_attrib a
             where a.attribute_set_id = nuattribute_set_id);

  RCGRUPO cugrupo%ROWTYPE;

  SBDATOSADICIONALES VARCHAR2(4000);

  ionuOrderId        NUMBER(15);
  inuOrderActivityId number;

  onuValue       open.ge_unit_cost_ite_lis.price%type;
  onuPriceListId open.ge_list_unitary_cost.list_unitary_cost_id%type;
  idtDate        date;
  inuContract    open.ge_list_unitary_cost.contract_id%type;
  inuContractor  open.ge_list_unitary_cost.contractor_id%type;
  inuGeoLocation open.ge_list_unitary_cost.geograp_location_id%type;
  isbType        open.ge_acta.id_tipo_acta%type;
  nuTaskTypeId   open.or_task_type.task_type_id%type;

  nucantidad    number;
  SBOBSERVACION VARCHAR2(4000);
  sbmessageerr  VARCHAR2(4000); --caso: 146

  sbcadenamateriales VARCHAR2(4000);

  -- objetos pata legalizacion de la orden principal
  cursor cuLDC_ORDTIPTRAADI(NUORDER_ID OPEN.OR_ORDER.ORDER_ID%TYPE) is
    select * from open.ldc_otlegalizar lo where lo.order_id = NUORDER_ID;

  tempcuLDC_ORDTIPTRAADI cuLDC_ORDTIPTRAADI%rowtype;
  ---fin legalizacion de la orden principal

  cursor cuusualego is
    select lal.*
      from open.ldc_anexolegaliza lal
     where lal.order_id = isbId;
  /*
  select lu.*
    from ldc_usualego lu
   where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID;
  */

  rfcuusualego cuusualego%rowtype;

  nuControlErrorActividad number := 0;

  --DATO ADICIONAL DESDE LEGO
  cursor cudatoadicionalLEGO(v_order_id     number,
                             v_task_type_id number,
                             v_causal_id    number) is
    select b.name_attribute name_attribute,
           (select lo.value
              from open.ldc_otdalegalizar lo
             where lo.order_id = v_order_id
               and lo.name_attribute =
                   a.attribute_set_id || '_' || b.name_attribute
               and lo.task_type_id = v_task_type_id
               and lo.causal_id = v_causal_id) value
      from open.ge_attributes b, open.ge_attrib_set_attrib a
     where b.attribute_id = a.attribute_id
       and a.attribute_set_id in
           (select ottd.attribute_set_id
              from open.or_tasktype_add_data ottd
             where ottd.task_type_id = v_task_type_id
               and ottd.active = 'Y'
               and (SELECT count(1) cantidad
                      FROM DUAL
                     WHERE --dage_causal.fnugetclass_causal_id(v_causal_id,NULL) 
                     (select gc.class_causal_id
                        from open.ge_causal gc
                       where gc.causal_id = v_causal_id) IN (1, 2)
                    /*(select column_value
                    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',NULL),
                                                            ',')))*/
                    ) = 1
                  --/*
                  --CASO 200-1932
                  --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
               and (ottd.use_ = decode((select gc.class_causal_id
                                         from open.ge_causal gc
                                        where gc.causal_id = v_causal_id), --DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(v_causal_id,null),
                                       1,
                                       'C',
                                       2,
                                       'I') or ottd.use_ = 'B') --*/
            )
     order by a.attribute_set_id, a.attribute_id;
  /*
  select *
    from ldc_otdalegalizar lodl
   where lodl.order_id = inuordenLEGO;
  */

  rfcudatoadicionalLEGO cudatoadicionalLEGO%rowtype;
  ---------------------------------------

  ---Cursor para obtener los items de la orden a gestionar
  Cursor CuItem(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select LOI.ITEM, LOI.CANTIDAD
      FROM open.LDC_OTITEM LOI
     where LOI.ORDER_ID = NUORDEN
     ORDER BY Loi.Item;

  rfCuItem CuItem%ROWTYPE;

  --DATO ADICIONAL DESDE LEGO
  cursor culdc_otadicionalda(v_order_id     number,
                             v_task_type_id number,
                             v_causal_id    number,
                             v_actividad    number,
                             v_mateial      number) is
    select b.name_attribute name_attribute,
           (select lo.value
              from open.ldc_otadicionalda lo
             where lo.order_id = v_order_id
               and lo.name_attribute =
                   a.attribute_set_id || '_' || b.name_attribute
               and lo.task_type_id = v_task_type_id
               and lo.causal_id = v_causal_id
               and lo.actividad = v_actividad
                  --and lo.material = v_mateial
               and rownum = 1) value, /*CA-672*/
           b.attribute_id
      from open.ge_attributes b, open.ge_attrib_set_attrib a
     where b.attribute_id = a.attribute_id
       and a.attribute_set_id in
           (select ottd.attribute_set_id
              from open.or_tasktype_add_data ottd
             where ottd.task_type_id = v_task_type_id
               and ottd.active = 'Y'
               and (SELECT count(1) cantidad
                      FROM DUAL
                     WHERE --dage_causal.fnugetclass_causal_id(v_causal_id, NULL) 
                     (select gc.class_causal_id
                        from open.ge_causal gc
                       where gc.causal_id = v_causal_id) IN (1, 2)
                    /*(select column_value
                    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',NULL),
                                                            ',')))*/
                    ) = 1
                  --/*
                  --CASO 200-1932
                  --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
               and (ottd.use_ = decode(
                                       --DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(v_causal_id, null),
                                       (select gc.class_causal_id
                                          from open.ge_causal gc
                                         where gc.causal_id = v_causal_id),
                                       1,
                                       'C',
                                       2,
                                       'I') or ottd.use_ = 'B') --*/
            )
     order by a.attribute_set_id, a.attribute_id;
  /*
  select *
    from ldc_otdalegalizar lodl
   where lodl.order_id = inuordenLEGO;
  */

  rfculdc_otadicionalda culdc_otadicionalda%rowtype;
  ---------------------------------------
  --Dato Actividad
  ----
  --cursor para identificar los datos actividad de la orden de gestion
  cursor culdc_otdatoactividad(InuActividad number, InuOrden number) is
    select 1 Ubicacion,
           a.component_1_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 1
               and loda.order_id = InuOrden) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 1
               and loda.order_id = InuOrden) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_1_id is not null
       and a.attribute_1_id = b.attribute_id
    union all
    select 2 Ubicacion,
           a.component_2_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 2
               and loda.order_id = InuOrden) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 2
               and loda.order_id = InuOrden) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_2_id is not null
       and a.attribute_2_id = b.attribute_id
    union all
    select 3 Ubicacion,
           a.component_3_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 3
               and loda.order_id = InuOrden) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 3
               and loda.order_id = InuOrden) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_3_id is not null
       and a.attribute_3_id = b.attribute_id
    union all
    select 4 Ubicacion,
           a.component_4_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 4
               and loda.order_id = InuOrden) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.ldc_otdatoactividad loda
             where loda.name_attribute = b.name_attribute || '_' || 4
               and loda.order_id = InuOrden) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_4_id is not null
       and a.attribute_4_id = b.attribute_id
     order by Ubicacion asc;

  rfculdc_otdatoactividad culdc_otdatoactividad%rowtype;

  Cursor CuActividadOrden(NUORDER_ID open.or_order.ORDER_ID%TYPE) is
    select or_order_activity.activity_id Actividad
      FROM open.or_order_activity
     where ORDER_ID = NUORDER_ID
       and or_order_activity.status = 'R'
       and not exists
     (select 1
              from open.ct_item_novelty n
             where n.items_id = or_order_activity.activity_id)
       AND ROWNUM = 1;

  rfCuActividadOrden CuActividadOrden%rowtype;

  sbATRIBUTO   varchar2(4000);
  sbLECTURAS   varchar2(4000);
  sbATRIBUTO_1 varchar2(500);
  sbATRIBUTO_2 varchar2(500);
  sbATRIBUTO_3 varchar2(500);
  sbATRIBUTO_4 varchar2(500);
  sbLECTURAS_1 varchar2(500);
  sbLECTURAS_2 varchar2(500);
  sbLECTURAS_3 varchar2(500);
  sbLECTURAS_4 varchar2(500);

  CURSOR CUEXISTE(IsbATRIBUTO VARCHAR2, IsbParametro VARCHAR2) IS
    SELECT count(1) cantidad
      FROM DUAL
     WHERE IsbATRIBUTO IN
           (SELECT to_number(regexp_substr(IsbParametro, '[^,]+', 1, LEVEL)) AS campo
              FROM dual
            CONNECT BY regexp_substr(IsbParametro, '[^,]+', 1, LEVEL) IS NOT NULL)
    /*(select column_value
    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(IsbParametro,NULL),
                                            ',')))*/
    ;

  nuCUEXISTE number;
  --------------------------------------------------------------------------------
  ------

  ---CASO 200-1528 Nace de un 300 Inicdente
  cursor cuelmesesu(inuorden number) is
    select emss.*
      from open.elmesesu emss
     where emss.emsssesu = (select ooa.product_id
                              from open.Or_Order_Activity ooa
                             where ooa.order_id = inuorden
                               AND ROWNUM = 1)
     order by emss.emssfein desc;

  rfcuelmesesu cuelmesesu%rowtype;
  ----

  --CASO 200-1528
  --Generar Cadena de componentes de la actividad de la OT adicional
  --cursor para identificar los datos actividad de la orden de gestion
  cursor cuLDC_COMPONENTEOTADICIONAL(InuMaterial  number,
                                     InuActividad number,
                                     InuOrden     number) is
    select 1 Ubicacion,
           a.component_1_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 1
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 1
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_1_id is not null
       and a.attribute_1_id = b.attribute_id
    union all
    select 2 Ubicacion,
           a.component_2_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 2
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 2
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_2_id is not null
       and a.attribute_2_id = b.attribute_id
    union all
    select 3 Ubicacion,
           a.component_3_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 3
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 3
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_3_id is not null
       and a.attribute_3_id = b.attribute_id
    union all
    select 4 Ubicacion,
           a.component_4_id COMPONENTE,
           b.name_attribute NOMBRE,
           (select loda.name_attribute_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 4
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_ATRIBUTO,
           (select loda.component_id_value
              from open.LDC_DATOACTIVIDADOTADICIONAL loda
             where loda.name_attribute = b.name_attribute || '_' || 4
               and loda.order_id = InuOrden
               and loda.actividad = InuActividad
            --and loda.material = InuMaterial
            ) VALOR_COMPONENTE
      from open.ge_items_attributes a, open.ge_attributes b
     where a.items_id = InuActividad
       and a.attribute_4_id is not null
       and a.attribute_4_id = b.attribute_id
     order by Ubicacion asc;

  rfcuLDC_COMPONENTEOTADICIONAL cuLDC_COMPONENTEOTADICIONAL%rowtype;
  -----

  --Inicio Caso 200-1580
  ---Cursor para obtener los items con garantias
  CurItemWarranty         sys_refcursor;
  CIW_Item_Warranty_Id    open.GE_ITEM_WARRANTY.Item_Warranty_Id%type;
  CIW_Item_Id             open.GE_ITEM_WARRANTY.Item_Id%type;
  CIW_Element_Id          open.GE_ITEM_WARRANTY.Element_Id%type;
  CIW_Element_Code        open.GE_ITEM_WARRANTY.Element_Code%type;
  CIW_Product_Id          open.GE_ITEM_WARRANTY.Product_Id%type;
  CIW_ORDER_ID            open.GE_ITEM_WARRANTY.ORDER_ID%type;
  CIW_FINAL_WARRANTY_DATE open.GE_ITEM_WARRANTY.FINAL_WARRANTY_DATE%type;
  CIW_IS_ACTIVE           open.GE_ITEM_WARRANTY.IS_ACTIVE%type;
  CIW_ITEM_SERIED_ID      open.GE_ITEM_WARRANTY.ITEM_SERIED_ID%type;
  CIW_SERIE               open.GE_ITEM_WARRANTY.SERIE%type;
  CIW_ITEM                VARCHAR(4000);
  CIW_FLEGALIZACION       open.OR_ORDER.LEGALIZATION_DATE%TYPE;
  CIW_OBSERVACION         VARCHAR(4000);
  CIW_UNIDADOPERATIVA     open.OR_OPERATING_UNIT.NAME%TYPE;
  CIW_PACKAGE_ID          open.OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE;

  --Cursor para retornar un item del tipo de trabajo adicional legalizado
  cursor culdc_otadicional(NUORDEN open.or_order.ORDER_ID%TYPE) is
    select LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID, LR.MATERIAL
      FROM OPEN.ldc_otadicional LR
     where LR.ORDER_ID = NUORDEN
       AND ROWNUM = 1
     GROUP BY LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID, LR.MATERIAL
     ORDER BY LR.TASK_TYPE_ID, LR.ACTIVIDAD;

  rfculdc_otadicional culdc_otadicional%rowtype;

  NuControlGarantia number := 0;
  Sbcharge_status   open.or_order.charge_status%type := '1';
  --Fin Caso 200-1580

  --CASO 200-1679
  --Esta variable manejara la observacion original de la OT registrada en LEGO
  SBOBSERVACIONLEGO open.ldc_otlegalizar.order_comment%type;
  --Esta variable manejara la observacion original de la OT en LEGO sin caracteres especiales
  SBOBSERVACIONOSF open.ldc_otlegalizar.order_comment%type;
  --Parametro para los caracteres especiales a ser reemplazdos en el observacion
  --de la OT registrada en LEGO.
  CURSOR cuParaemtroCadena is
    SELECT (regexp_substr((select l.value_chain
                            from open.ld_parameter l
                           where l.parameter_id = 'CAR_REP_OBS_LEGO'),
                          '[^,]+',
                          1,
                          LEVEL)) column_value
      FROM dual
    CONNECT BY regexp_substr((select l.value_chain
                               from open.ld_parameter l
                              where l.parameter_id = 'CAR_REP_OBS_LEGO'),
                             '[^,]+',
                             1,
                             LEVEL) IS NOT NULL;
  /*     select column_value
  from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAR_REP_OBS_LEGO',
                                                                           NULL),
                                          ','));*/

  rfcuParaemtroCadena cuParaemtroCadena%rowtype;

  --Cursor para establecer que ordenes no tiene estado valido para confirmar
  --por parte de LEGO
  Cursor cuorder IS --(InuOrderID open.or_order.order_id%type) is
    select count(oo.order_id) cantidad --.*--,rowid
      from open.or_order oo
     where oo.order_id = isbId
       and oo.order_status_id IN
           (nvl( --DALD_PARAMETER.fnuGetNumeric_Value('EST_LEG_OT_LEGO',NULL),
                (select l.numeric_value
                   from open.ld_parameter l
                  where l.parameter_id = 'EST_LEG_OT_LEGO'),
                0),
            nvl( --DALD_PARAMETER.fnuGetNumeric_Value('EST_ANU_OT_LEGO', NULL),
                (select l.numeric_value
                   from open.ld_parameter l
                  where l.parameter_id = 'EST_ANU_OT_LEGO'),
                0));
  rfcuorder cuorder%rowtype;
  --CASO 200-1679

  --146
  csbCaso146         varchar2(7) := '0000146';
  sbAplica146        varchar2(1);
  sbInconsGara       varchar2(1);
  sbInconsPadr       varchar2(1);
  sbTitrIncons       open.or_order_activity.comment_%type;
  nuOtGarantia       open.or_order.order_id%type;
  nuExisOtGara       number;
  NuControlGPadre    number := 0;
  SbcharPadre        open.or_order.charge_status%type := '1';
  CurItemWarraPadre  sys_refcursor;
  sbValidaGaraPadre  varchar2(1); --:=nvl((select l.value_chain from open.ld_parameter l where l.parameter_id='VALIDA_GARANTIA_OT_PADRE')/*open.dald_parameter.fsbgetvalue_chain('VALIDA_GARANTIA_OT_PADRE',null)*/,'N');
  sbRegistraAudiGara varchar2(1); --:=nvl((select l.value_chain from open.ld_parameter l where l.parameter_id='REGISTRA_LDC_AUDIT_GARANTIA')/*open.dald_parameter.fsbgetvalue_chain('REGISTRA_LDC_AUDIT_GARANTIA',null)*/,'S');
  -- CA-672
  sbAplica672         VARCHAR2(1);
  nmvadaadusterocada  open.ld_parameter.numeric_value%TYPE; -- := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_USUTER_OCADANO',null),0);
  nmvadaadreppundist  open.ld_parameter.numeric_value%TYPE; -- := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_REPREA_PUNDIST',null),0);
  nmvadaadgdcocadano  open.ld_parameter.numeric_value%TYPE; -- := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_GDC_OCASI_DANO',null),0);
  nmvadaadsicbraugdc  open.ld_parameter.numeric_value%TYPE; -- := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_SINCOB_AUTO_GDC',null),0);
  sbvavldausteracdan  VARCHAR2(2) DEFAULT 'N';
  sbvavldareppundist  VARCHAR2(2) DEFAULT 'N';
  svvavaldagdcocadano VARCHAR2(2) DEFAULT 'N';
  svvavaldasincoaugdc VARCHAR2(2) DEFAULT 'N';
  nmcontaaprob        NUMBER(4);
  sbcorreos           VARCHAR2(4000); -- DEFAULT dald_parameter.fsbgetvalue_chain('PARAM_CORREO_APRRECH_ORDEN',NULL);
  sender              VARCHAR2(1000); -- DEFAULT dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER',NULL);
  sbmensajecue        VARCHAR2(1000);
  sbreqaproba         VARCHAR2(1);
  nmpacoderr          NUMBER;
  sbpamensaerr        VARCHAR2(1000);
  sbAutorizacion      VARCHAR2(1);

  FUNCTION FnuClasificadorCausal(InuCausal number) RETURN number IS
  
    cursor cuClasificadorCausal is
      SELECT count(1) cantidad
        FROM DUAL
       WHERE --dage_causal.fnugetclass_causal_id(InuCausal, NULL) 
       (select gc.class_causal_id
          from open.ge_causal gc
         where gc.causal_id = InuCausal) IN (1, 2)
      /*(select column_value
      from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                               NULL),
                                              ',')))*/
      ;
    rfcuClasificadorCausal cuClasificadorCausal%rowtype;
  
    nuRetornaValor number;
  
  BEGIN
  
    dbms_output.put_line('Inicio LDC_PKGESTIONORDENES.FnuClasificadorCausal');
  
    open cuClasificadorCausal;
    fetch cuClasificadorCausal
      into rfcuClasificadorCausal;
    close cuClasificadorCausal;
  
    nuRetornaValor := nvl(rfcuClasificadorCausal.Cantidad, 0);
  
    dbms_output.put_line('Fin LDC_PKGESTIONORDENES.FnuClasificadorCausal');
    dbms_output.put_line('nuRetornaValor: ' || nuRetornaValor);
  
    return(nuRetornaValor);
  
    /*EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;*/
  END FnuClasificadorCausal;

  FUNCTION FnuExistenciaGarantia(InuTipoTrabajo number, InuCausal number)
    RETURN number IS
  
    cursor cuExistenciaGarantia is
      SELECT count(1) cantidad
        FROM open.LDC_GRUPTITRGARA A
       WHERE A.TASK_TYPE_ID = InuTipoTrabajo;
    --AND A.CAUSAL_ID = InuCausal;
  
    rfcuExistenciaGarantia cuExistenciaGarantia%rowtype;
  
    nuRetornaValor number;
  
  BEGIN
  
    dbms_output.put_line('Inicio LDC_PKGESTIONORDENES.FnuExistenciaGarantia');
  
    open cuExistenciaGarantia;
    fetch cuExistenciaGarantia
      into rfcuExistenciaGarantia;
    close cuExistenciaGarantia;
  
    if nvl(rfcuExistenciaGarantia.Cantidad, 0) > 0 then
      nuRetornaValor := 1;
    else
      nuRetornaValor := 0;
    end if;
    dbms_output.put_line('Fin LDC_PKGESTIONORDENES.FnuExistenciaGarantia');
    dbms_output.put_line('nuRetornaValor: ' || nuRetornaValor);
  
    return(nuRetornaValor);
  
    /*EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;*/
  END FnuExistenciaGarantia;

  PROCEDURE rFrfOrdenesGarantia(InuOrden     number,
                                InuTaskType  number,
                                IdtExcutdate date, --caso:146
                                rfQuery      OUT sys_refcursor /*constants.tyrefcursor*/) as
    csbEnt2002688 open.ldc_versionentrega.nombre_entrega%type := 'OSS_SAC_DSS_2002688_3';
  
    function fblAplicaEntrega(isbEntrega In Varchar2) return boolean is
    
      /*****************************************************************
      PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P.
      
      UNIDAD         : fblAplicaEntrega
      DESCRIPCION    : Funcion usada para verificar si una entrega aplica para la empresa.
      AUTOR          : JVivero (LUDYCOM)
      CASO           : 100-10465
      FECHA          : 08/03/2016
      
      PARAMETROS            DESCRIPCION
      ============      ===================
      isbEntrega        Nombre de la entrega
      
      FECHA             AUTOR                   MODIFICACION
      ==========        =========               ====================
      08/03/2016        JVivero (LUDYCOM)       CreaciOn.
      ******************************************************************/
    
      -- Cursor para consultar si la entrega aplica para la gasera
      Cursor Cu_Aplica Is
        Select a.Aplica
          From open.Ldc_Versionentrega t,
               open.Ldc_Versionempresa e,
               open.Ldc_Versionaplica  a,
               open.Sistema            s
         Where t.Codigo = a.Codigo_Entrega
           And e.Codigo = a.Codigo_Empresa
           And e.Nit = s.Sistnitc
           And t.Nombre_Entrega = isbEntrega;
    
      -- Variables
      sbAplica Ldc_Versionaplica.Aplica%Type;
    
    BEGIN
    
      -- Se abre el cursor para validar si aplica la entrega
      Open Cu_Aplica;
      Fetch Cu_Aplica
        Into sbAplica;
      Close Cu_Aplica;
    
      -- Si aplica la entrega se retorna True, sino aplica se retorna False
      If Nvl(sbAplica, 'N') = 'S' Then
      
        Return True;
      
      Else
      
        Return False;
      
      End If;
    
    END fblAplicaEntrega;
  
  BEGIN
    dbms_output.put_line('---------------------------------------------------------------');
    dbms_output.put_line('Inicio LDC_PKGESTIONORDENES.rFrfOrdenesGarantia');
    if sbAplicaEnt2002688 is null then
      if fblaplicaentrega(csbEnt2002688) then
        sbAplicaEnt2002688 := 'S';
      else
        sbAplicaEnt2002688 := 'N';
      end if;
    end if;
  
    dbms_output.put_line('if sbAplicaEnt2002688[' || sbAplicaEnt2002688 ||
                         '] = ''N'' then');
  
    if sbAplicaEnt2002688 = 'N' then
    
      open rfQuery for
        select a.*,
               (select gi.Description
                  from open.ge_items gi
                 where gi.items_id = A.ITEM_ID
                   AND ROWNUM = 1) ITEM,
               (select oo.LEGALIZATION_DATE
                  from open.or_order oo
                 where oo.order_id = A.ORDER_ID
                   AND ROWNUM = 1) FLEGALIZACION,
               (select ooa.COMMENT_
                  from open.Or_Order_Activity ooa
                 where ooa.order_id = A.ORDER_ID
                   AND ROWNUM = 1) OBSERVACION,
               (SELECT OOU.NAME
                  FROM OPEN.OR_OPERATING_UNIT OOU
                 WHERE OOU.OPERATING_UNIT_ID =
                       (select oo.Operating_Unit_Id
                          from open.or_order oo
                         where oo.order_id = A.ORDER_ID
                           AND ROWNUM = 1)) UNIDADOPERATIVA,
               ooa.package_id
          from open.GE_ITEM_WARRANTY A, open.or_order_activity ooa
         where ooa.order_id = a.order_id
           and a.final_warranty_date >= IdtExcutdate --caso:146
           and a.product_id in
               (select ooa.product_id
                  from open.Or_Order_Activity ooa
                 where ooa.order_id = InuOrden)
           and ooa.task_type_id in
               (select b.task_type_id
                  from open.LDC_GRUPTITRGARA B
                 where b.cod_group_warranty_id in
                       (select b.cod_group_warranty_id
                          from open.LDC_GRUPTITRGARA B
                         where B.TASK_TYPE_ID = InuTaskType
                           and rownum = 1));
    else
      open rfQuery for
        select a.*,
               (select gi.description
                  from open.ge_items gi
                 where gi.items_id = A.ITEM_ID
                   and rownum = 1) ITEM,
               ot.legalization_date FLEGALIZACION,
               (select c.order_comment
                  from open.or_order_comment c
                 where c.order_id = ot.order_id
                   and c.legalize_comment = 'Y'
                   and rownum = 1) OBSERVACION,
               --(SELECT open.daor_operating_unit.fsbgetname(ot.operating_unit_id,null) from dual ) UNIDADOPERATIVA
               (select oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = ot.operating_unit_id) UNIDADOPERATIVA,
               ooa.package_id
          from open.ge_item_warranty  A,
               open.or_order_activity ooa,
               open.or_order          ot
         where ooa.order_id = a.order_id
           and ot.order_id = a.order_id
           and a.final_warranty_date >= IdtExcutdate --caso:146
           and a.product_id in
               (select ooa1.product_id
                  from open.Or_Order_Activity ooa1
                 where ooa1.order_id = InuOrden)
           and ot.task_type_id in
               (select b.task_type_id
                  from open.LDC_GRUPTITRGARA B
                 where b.cod_group_warranty_id in
                       (select b.cod_group_warranty_id
                          from open.LDC_GRUPTITRGARA B
                         where B.TASK_TYPE_ID = InuTaskType
                           and rownum = 1));
    
    end if;
  
    dbms_output.put_line('Fin LDC_PKGESTIONORDENES.rFrfOrdenesGarantia');
    dbms_output.put_line('---------------------------------------------------------------');
  
    /*EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;*/
  END rFrfOrdenesGarantia;

  PROCEDURE PROVALIINTECOTI(inuOrden IN open.or_order.order_id%type,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.
    
      Unidad         : PROVALIINTECOTI
      Descripcion    : Servicio para validar items cotizados
      Ticket          : 200-2404
      Autor          : Elkin Alvarez
      Fecha          : 16/03/2019
    
      Parametros              Descripcion
      ============         ===================
        inuOrden            numero de orden
        onuError            codigo de errror 0-exito -1 - error
        osbError            mensaje de error
    
    
      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========       =========           ====================
      15/03/2019       ELAL               Creacion
    17/06/2019     dsaltarin      200-2688 Se modifica para que no se tenga en cuenta las ordenes adicionales
                      que estan registradas en las formas de cotizacion
     *****************************************************************/
  
    sbDatos VARCHAR2(1); --se almacena resultado de los cursores
  
    sbItems VARCHAR2(4000); --se almacena item con errores
  
    -- se valida si se encuentran configurado el plugin LDC_PRVALIDAITEMCOTIZADO en el tt de la orden
    CURSOR cuValidaPlugin IS
      SELECT 'X'
        FROM open.LDC_PROCEDIMIENTO_OBJ pl, open.or_order o
       WHERE o.order_id = inuOrden
         AND pl.TASK_TYPE_ID = o.task_type_id
         AND pl.PROCEDIMIENTO = 'LDC_PRVALIDAITEMCOTIZADO'
         AND pl.ACTIVO = 'S'
         AND (pl.causal_id IS NULL OR pl.causal_id = o.causal_id)
         AND NOT EXISTS (SELECT 1
                FROM open.or_related_order ore
               WHERE ore.order_id = o.order_id
                 AND ore.RELA_ORDER_TYPE_ID = 13);
  
    --se valida que los items configurados LDCRIAICI se legalicen
    CURSOR cuValiItemConf IS
      SELECT item_cotizado || '-' || i.description items
        FROM open.ldc_itemcotiinte_ldcriaic, open.ge_items i
       WHERE order_id = inuOrden
         AND item_cotizado = i.items_id
         AND NOT EXISTS
       (SELECT ooi.items_id
                FROM open.or_order_items ooi
               WHERE ooi.order_id = inuOrden
                 AND ooi.items_id = item_cotizado
              UNION ALL
              SELECT ooi.items_id
                FROM open.or_order_items ooi, open.or_related_order ore
               WHERE ore.order_id = inuOrden
                 AND ooi.order_id = ore.related_order_id
                 AND ore.RELA_ORDER_TYPE_ID = 13
                 AND ooi.items_id = item_cotizado);
  
    --se valida que items asociado en el parametro COD_ITEMCOTI_LDCRIAIC que se esten legalizando esten configurado en LDCRIAIC
    CURSOR cuvaliitemlenoconf IS
      SELECT ITEMS || '-' || I.DESCRIPTION ITEMS
        FROM (SELECT ooi.order_id orden, ooi.items_id items
                FROM open.or_order_items ooi
               WHERE ooi.order_id = inuOrden
                 AND ooi.items_id IN
                     (SELECT to_number(regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                     '[^,]+',
                                                     1,
                                                     LEVEL)) AS campo
                        FROM dual
                      CONNECT BY regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                               '[^,]+',
                                               1,
                                               LEVEL) IS NOT NULL)
              /*( SELECT to_number(COLUMN_VALUE)
              FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                   NULL),
              
                                                  ',')))*/
              UNION ALL
              SELECT ore.order_id, ooi.items_id
                FROM open.or_order_items ooi, open.or_related_order ore
               WHERE ore.order_id = inuOrden
                 AND ooi.order_id = ore.related_order_id
                 AND ore.RELA_ORDER_TYPE_ID = 13
                 AND ooi.items_id IN
                     (SELECT to_number(regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                     '[^,]+',
                                                     1,
                                                     LEVEL)) AS campo
                        FROM dual
                      CONNECT BY regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                               '[^,]+',
                                               1,
                                               LEVEL) IS NOT NULL)
                    /*( SELECT to_number(COLUMN_VALUE)
                    FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                         NULL),
                    
                                                        ','))
                    
                                                        )*/
                    --200-2688
                 and not exists
               (select null
                        from open.ldc_itemcotiinte_ldcriaic l
                       where l.order_id = ore.related_order_id
                         and l.item_cotizado = ooi.items_id
                      union all
                      select null
                        from open.ldc_itemcoti_ldcriaic l
                       where l.order_id = ore.related_order_id
                         and l.item_cotizado = ooi.items_id)
              --200-2688
              ) da,
             open.ge_items i
       WHERE da.items = i.items_id
         AND NOT EXISTS (SELECT 1
                FROM open.ldc_itemcotiinte_ldcriaic ic
               WHERE ic.order_id = da.orden
                 AND ic.item_cotizado = da.items);
  
    --se valida que los item cotizados configurados y legalizados sean iguales
    CURSOR cuValiValorLega IS
      SELECT items || ' - ' ||
             (select gi.description
                from open.ge_items gi
               where gi.items_id = items) /*dage_items.fsbgetdescription(items,NULL)*/ items,
             totalitemadicional,
             valor_lega
        FROM (select items,
                     sum(totalitemadicional) totalitemadicional,
                     sum(valor_lega) valor_lega
                from (select licl.item_cotizado items,
                             sum(nvl(lial.total, 0)) totalitemadicional,
                             0 valor_lega
                        from open.ldc_itemcotiinte_ldcriaic licl,
                             open.ldc_itemadicinte_ldcriaic lial
                       where licl.order_id = inuorden
                         and lial.codigo = licl.codigo
                       group by licl.item_cotizado
                      UNION all
                      select ooi.items_id items,
                             0 totalitemadicional,
                             sum(nvl(ooi.value, 0)) valor_lega
                        from open.or_order_items ooi
                       where ooi.order_id = inuorden
                            --and exists(select 1 from ldc_itemcotiinte_ldcriaic c where c.order_id=ooi.order_id and c.item_cotizado=ooi.items_id)
                         AND ooi.items_id IN
                             (SELECT to_number(regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                             '[^,]+',
                                                             1,
                                                             LEVEL)) AS campo
                                FROM dual
                              CONNECT BY regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                       '[^,]+',
                                                       1,
                                                       LEVEL) IS NOT NULL)
                      /*( SELECT to_number(COLUMN_VALUE)
                      FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                         NULL),
                      
                                        ',')))*/
                       group by ooi.items_id
                      union all
                      select ooi.items_id items,
                             0 totalitemadicional,
                             sum(nvl(ooi.value, 0)) valor_lega
                        from open.or_order_items   ooi,
                             open.or_related_order ore
                       where ore.order_id = inuOrden
                         AND ore.RELA_ORDER_TYPE_ID = 13
                         AND ooi.order_id = ore.related_order_id
                            --and exists(select 1 from ldc_itemcotiinte_ldcriaic c where c.order_id=ore.order_id and c.item_cotizado=ooi.items_id)
                         AND ooi.items_id IN
                             (SELECT to_number(regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                             '[^,]+',
                                                             1,
                                                             LEVEL)) AS campo
                                FROM dual
                              CONNECT BY regexp_substr('100004717,100004718,100004719,100004720,100004721,100004722,100004723,100004724,100004725,100004726,100004727,100004728,100004729,100004730,100004731,100004732,100004733,100004734,100004735,100004736,100004737,100004738,100004739,100004740,100004741,100004742,100004743,100004744,100004745,100004746,100004747,100004748,100004749,100004750,100004751,100005131,100005130,100005132,100005133,100005134,100005135,100005130,100004898,100004899,100004900,100004901,100004902,100005131,100004897,100004663,100005130,10831,10829,100000681,100010197,100010198,100010200',
                                                       '[^,]+',
                                                       1,
                                                       LEVEL) IS NOT NULL)
                            /*( SELECT to_number(COLUMN_VALUE)
                            FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                               NULL),
                            
                                              ',')))*/
                         and not exists
                       (select null
                                from open.ldc_itemcotiinte_ldcriaic l
                               where l.order_id = ore.related_order_id
                                 and l.item_cotizado = ooi.items_id
                              union all
                              select null
                                from open.ldc_itemcoti_ldcriaic l
                               where l.order_id = ore.related_order_id
                                 and l.item_cotizado = ooi.items_id)
                       group by ooi.items_id)
               group by items)
       WHERE totalitemadicional <> valor_lega;
  
    erDatos EXCEPTION;
  BEGIN
    --se valida que el plugin este configurado
    OPEN cuValidaPlugin;
    FETCH cuValidaPlugin
      INTO sbdatos;
    CLOSE cuValidaPlugin;
  
    -- si no se encuentra configurado se realiza las siguientes validaciones
    IF sbDatos IS NULL THEN
      -- se valida items configurados en LDCRIAICI se legalicen
      FOR reg IN cuValiItemConf LOOP
        IF sbItems IS NULL THEN
          sbItems := reg.items;
        ELSE
          sbItems := substr(sbItems || ',' || reg.items, 1, 3999);
        END IF;
      END LOOP;
    
      IF sbItems IS NOT NULL THEN
        osbError := 'No se han registrado los Items ' || sbItems ||
                    ' los cuales estan asociado a la cotizacion';
        RAISE erDatos;
      END IF;
    
      -- se valida items legalizados y esten el parametro COD_ITEMCOTI_LDCRIAIC se encuentren registrados  en LDCRIAICI
      FOR reg IN cuvaliitemlenoconf LOOP
        IF sbItems IS NULL THEN
          sbItems := reg.items;
        ELSE
          sbItems := substr(sbItems || ',' || reg.items, 1, 3999);
        END IF;
      END LOOP;
    
      IF sbItems IS NOT NULL THEN
        osbError := 'Los Items ' || sbItems ||
                    ' no se encuentran asociado a una cotizacion en LDCRIAICI';
        RAISE erDatos;
      END IF;
    
      FOR reg IN cuValiValorLega LOOP
        IF sbItems IS NULL THEN
          sbItems := 'El valor legalizado [' || reg.valor_lega ||
                     '] del Item[' || reg.items ||
                     '] no coincide con el valor de la cotizacion[' ||
                     reg.totalitemadicional || '].';
        ELSE
          sbItems := substr(sbItems || '|' || 'El valor legalizado [' ||
                            reg.valor_lega || '] del Item[' || reg.items ||
                            '] no coincide con el valor de la cotizacion[' ||
                            reg.totalitemadicional || '].',
                            1,
                            3999);
        END IF;
      
      END LOOP;
    
      IF sbItems IS NOT NULL THEN
        osbError := sbItems;
        RAISE erDatos;
      END IF;
    END IF;
    --se actualiza la orden
    /*UPDATE open.ldc_itemcotiinte_ldcriaic LIL
      SET LIL.ORDER_STATUS_ID = 8
    WHERE LIL.ORDER_ID = inuOrden;*/
  
    onuError := 0;
  EXCEPTION
    WHEN erDatos THEN
      onuError := -1;
    WHEN OTHERS THEN
      onuError := -1;
      osbError := 'Error no controlado en LDC_PKGESTIONORDENES.PROVALIINTECOTI ' ||
                  SQLERRM;
  END PROVALIINTECOTI;

  function fblAplicaEntregaxCaso(isbNumeroCaso In Varchar2) return boolean is
  
    /**************************************************************************
      Autor       : Elkin Alvarez / Horbath
      Fecha       : 2019-02-15
      Ticket      : 200-2431
      Descripcion : retorna si la aplica o no la entrega por caso
    
      Parametros Entrada
      isbNumeroCaso numero de caso
    
      Valor de salida
        retorna 0 si espera pago o 1 sino espera
     sbErrorMessage mensaje de error.
    
      nuError  codigo del error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  
    --se valida aplicacion de entrega
    CURSOR cuAplicaEntrega IS
      Select a.Aplica
        From open.Ldc_Versionentrega t,
             open.Ldc_Versionempresa e,
             open.Ldc_Versionaplica  a,
             open.Sistema            s
       Where t.Codigo = a.Codigo_Entrega
         And e.Codigo = a.Codigo_Empresa
         And e.Nit = s.Sistnitc
         And T.Codigo =
             (SELECT max(t1.codigo)
                FROM Ldc_Versionentrega t1
               WHERE T1.Codigo_Caso like '%' || isbNumeroCaso || '%');
  
    -- Variables
    sbAplica Ldc_Versionaplica.Aplica%Type;
  
  BEGIN
  
    -- Se abre el cursor para validar si aplica la entrega
    Open cuAplicaEntrega;
    Fetch cuAplicaEntrega
      Into sbAplica;
    Close cuAplicaEntrega;
  
    -- Si aplica la entrega se retorna True, sino aplica se retorna False
    If Nvl(sbAplica, 'N') = 'S' Then
      Return True;
    Else
      Return false;
    End If;
  exception
    when others then
      return false;
  END fblAplicaEntregaxCaso;

  FUNCTION LDCPRBLOPORVAL(inuOrder open.or_order.order_id%type) RETURN number is
  
    /**************************************************************************
      Proceso     : LDCPRBLOPORVAL
      Autor       :  Horbath
      Fecha       : 03-06-2020
      Ticket      : 146
      Descripcion : funcion para permitir la modificacion de la orden en lego,
          dependiendo la cusal de legalizacion de la orden validacion de garantia.
    
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  
    sberror  varchar2(3000);
    nuStatus number;
    nuCausal number;
    codeval  number;
  
    nuGarInc   open.or_order.causal_id%type := 3679; --dald_parameter.fnuGetNumeric_Value('CAUSAL_GARANTIA_INCORRECTA');
    nuGarCor   open.or_order.causal_id%type := 3678; --dald_parameter.fnuGetNumeric_Value('CAUSAL_GARANTIA_CORRECTA');
    nuTtrabajo open.or_order.task_type_id%type := 11128; --dald_parameter.fnuGetNumeric_Value('TITRVALIDAGARANTIA');
  
    cursor CURVALG(ORDEN NUMBER) is
      select order_status_id, causal_id
        from open.or_related_order r, open.or_order o
       where r.RELATED_ORDER_ID = o.order_id
         and r.order_id = ORDEN
         and o.TASK_TYPE_ID = nuTtrabajo
         and CREATED_DATE =
             (select max(CREATED_DATE)
                from open.or_related_order r, open.or_order o
               where r.RELATED_ORDER_ID = o.order_id
                 and r.order_id = ORDEN
                 and o.TASK_TYPE_ID = nuTtrabajo);
  
  begin
    dbms_output.put_line('Empieza LDCPRBLOPORVAL');
    dbms_output.put_line('LDCPRBLOPORVAL-inuOrder -->' || inuOrder);
    if (fblAplicaEntregaxCaso('0000146')) then
      OPEN CURVALG(inuOrder);
      FETCH CURVALG
        INTO nuStatus, nuCausal;
      CLOSE CURVALG;
      dbms_output.put_line('LDCPRBLOPORVAL-nuStatus -->' || nuStatus);
      dbms_output.put_line('LDCPRBLOPORVAL-nuCausal -->' || nuCausal);
      if nuStatus is null and nuCausal is null then
      
        codeval := 0;
      
      else
      
        if nuStatus = 8 then
        
          if nuCausal = nuGarInc then
          
            codeval := 0;
          
          ELSIF nuCausal = nuGarCor then
          
            codeval := 2;
          
          end if;
        
        else
        
          codeval := 1;
        
        end if;
      
      end if;
      dbms_output.put_line('Termina LDCPRBLOPORVAL');
      return(codeval);
    else
      return 0;
    end if;
  exception
    when others then
      return(0); --codeval:=0;
  end LDCPRBLOPORVAL;

  ---fin declare
  -----------------------------------------------------------------------

BEGIN

  select nvl(l.value_chain, 'N')
    into sbValidaGaraPadre
    from open.ld_parameter l
   where l.parameter_id = 'VALIDA_GARANTIA_OT_PADRE';

  begin
    select nvl(l.value_chain, 'S')
      into sbRegistraAudiGara
      from open.ld_parameter l
     where l.parameter_id = 'REGISTRA_LDC_AUDIT_GARANTIA';
  exception
    when others then
      sbRegistraAudiGara := 'S';
  end;

  --nmvadaadusterocada   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_USUTER_OCADANO',null),0);
  select l.numeric_value
    into nmvadaadusterocada
    from open.ld_parameter l
   where l.parameter_id = 'PARAM_DATADIC_USUTER_OCADANO';
  --nmvadaadreppundist   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_REPREA_PUNDIST',null),0);
  select l.numeric_value
    into nmvadaadreppundist
    from open.ld_parameter l
   where l.parameter_id = 'PARAM_DATADIC_REPREA_PUNDIST';
  --nmvadaadgdcocadano   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_GDC_OCASI_DANO',null),0);
  select l.numeric_value
    into nmvadaadgdcocadano
    from open.ld_parameter l
   where l.parameter_id = 'PARAM_DATADIC_GDC_OCASI_DANO';
  --nmvadaadsicbraugdc   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_SINCOB_AUTO_GDC',null),0);
  select l.numeric_value
    into nmvadaadsicbraugdc
    from open.ld_parameter l
   where l.parameter_id = 'PARAM_DATADIC_SINCOB_AUTO_GDC';

  --sbcorreos            VARCHAR2(4000) DEFAULT dald_parameter.fsbgetvalue_chain('PARAM_CORREO_APRRECH_ORDEN',NULL);
  select l.value_chain
    into sbcorreos
    from open.ld_parameter l
   where l.parameter_id = 'PARAM_CORREO_APRRECH_ORDEN';
  --sender               VARCHAR2(1000) DEFAULT dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER',NULL);
  select l.value_chain
    into sender
    from open.ld_parameter l
   where l.parameter_id = 'LDC_SMTP_SENDER';

  --caso 200-1679
  open cuorder;
  fetch cuorder
    into rfcuorder;
  close cuorder;

  --146
  if (fblAplicaEntregaxCaso('0000146')) then
    sbAplica146  := 'S';
    sbTitrIncons := null;
    sbInconsPadr := 'N';
    nuExisOtGara := LDCPRBLOPORVAL(isbId);
  else
    sbAplica146 := 'N';
  end if;
  --146
  if (fblAplicaEntregaxCaso('0000672')) then
    sbAplica672  := 'S';
    sbTitrIncons := null;
    sbInconsPadr := 'N';
  else
    sbAplica672 := 'N';
  end if;

  dbms_output.put_line('Antes sbAplica146: ' || sbAplica146);

  if sbAplica672 = 'S' and sbAplica146 = 'S' then
    dbms_output.put_line('Entregas 176 y 672 activas simulteanmente, apagar una de las 2');
    /*update open.ldc_otlegalizar lol
      set  lol.mensaje_legalizado = 'Entregas 176 y 672 activas simulteanmente, apagar una de las 2'
    where lol.order_id = isbId;*/
    --Commit;
    return;
  end if;

  if nvl(rfcuorder.cantidad, 0) = 0 then
    --caso 200-1679
  
    open cuusualego;
    fetch cuusualego
      into rfcuusualego;
    close cuusualego;
  
    dbms_output.put_line('INICIO LDC_PKGESTIONORDENES.PrConfirmarOrden');
  
    NuOrder_Ir := isbId;
  
    SBOBSERVACION := NULL;
  
    --------------------------------------------------------------------
    ---proceso de legalizacion de orden principal
    open cuLDC_ORDTIPTRAADI(NuOrder_Ir);
    fetch cuLDC_ORDTIPTRAADI
      into tempcuLDC_ORDTIPTRAADI;
    if cuLDC_ORDTIPTRAADI%notfound then
      onuErrorCode    := -1;
      osbErrorMessage := 'La orden [' || NuOrder_Ir ||
                         '] principal tiene inconvenientes en la configuracion de la forma LEGO';
      dbms_output.put_line(osbErrorMessage);
      close cuLDC_ORDTIPTRAADI;
      --raise ex.CONTROLLED_ERROR;
    else
    
      dbms_output.put_line('Paso 1 sbAplica146: ' || sbAplica146);
    
      if sbAplica146 = 'S' and nuExisOtGara = 1 then
        onuErrorCode := -1;
        if tempcuLDC_ORDTIPTRAADI.Mensaje_Legalizado like
           '%En proceso de validacion de garantias%' then
          osbErrorMessage := tempcuLDC_ORDTIPTRAADI.Mensaje_Legalizado;
        else
          osbErrorMessage := 'En proceso de validacion de garantias';
        end if;
      else
      
        --nuTaskTypeId := (select oo.Task_Type_Id from open.or_order oo where oo.order_id= NuOrder_Ir) ;-- daor_order.fnugetTask_Type_Id(NuOrder_Ir,0);
        select oo.Task_Type_Id
          into nuTaskTypeId
          from open.or_order oo
         where oo.order_id = NuOrder_Ir;
        IF tempcuLDC_ORDTIPTRAADI.task_type_id <> nuTaskTypeId THEN
          tempcuLDC_ORDTIPTRAADI.task_type_id := nuTaskTypeId;
          --update open.ldc_otlegalizar set task_type_id = nuTaskTypeId where order_id = NuOrder_Ir;
          dbms_output.put_line('update open.ldc_otlegalizar set task_type_id = nuTaskTypeId where order_id = NuOrder_Ir');
        END IF;
      
        --Inicio CASO 200-1679
        SBOBSERVACIONLEGO := tempcuLDC_ORDTIPTRAADI.Order_Comment;
        --Ciclo para reemplazar lso caracteres especiales por espacios
        --para poder legalizar la OT en LEGO
        SBOBSERVACIONOSF := SBOBSERVACIONLEGO;
        FOR rfcuParaemtroCadena in cuParaemtroCadena loop
          SBOBSERVACIONOSF := replace(SBOBSERVACIONOSF,
                                      rfcuParaemtroCadena.Column_Value,
                                      ' ');
        END LOOP;
        --Fin CASO 200-1679
      
        --cadena datos adicionales
        SBDATOSADICIONALES := NULL;
      
        select oo.task_type_id
          into nutt
          from open.or_order oo
         where oo.order_id = NuOrder_Ir;
      
        dbms_output.put_line('(NuOrder_Ir[' || NuOrder_Ir ||
                             '],daor_order.fnugettask_type_id(NuOrder_Ir,null)[' || nutt ||
                             '],tempcuLDC_ORDTIPTRAADI.Causal_Id[' ||
                             tempcuLDC_ORDTIPTRAADI.Causal_Id || ']) loop');
      
        for rfcudatoadicionalLEGO in cudatoadicionalLEGO(NuOrder_Ir,
                                                         nutt, --daor_order.fnugettask_type_id(NuOrder_Ir,null),
                                                         tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
          IF SBDATOSADICIONALES IS NULL THEN
            SBDATOSADICIONALES := rfcudatoadicionalLEGO.NAME_ATTRIBUTE || '=' ||
                                  rfcudatoadicionalLEGO.Value;
          ELSE
            SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                  rfcudatoadicionalLEGO.NAME_ATTRIBUTE || '=' ||
                                  rfcudatoadicionalLEGO.Value;
          END IF;
        end loop;
      
        if SBDATOSADICIONALES is null then
          select oo.task_type_id
            into nutt
            from open.or_order oo
           where oo.order_id = NuOrder_Ir;
          for rc in cugrupo( /*daor_order.fnugettask_type_id(NuOrder_Ir, null)*/nutt,
                            tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
            dbms_output.put_line('Grupo de dato adicional [' ||
                                 rc.attribute_set_id ||
                                 '] asociado al tipo de trabajo [' ||
                                 rc.task_type_id || ']');
            dbms_output.put_line('Grupo de dato adicional [' ||
                                 rc.attribute_set_id ||
                                 '] asociado al tipo de trabajo [' ||
                                 rc.task_type_id || ']');
          
            for rcdato in cudatoadicional(rc.attribute_set_id) loop
              IF SBDATOSADICIONALES IS NULL THEN
                SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
              ELSE
                SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                      RCDATO.NAME_ATTRIBUTE || '=';
              END IF;
              dbms_output.put_line('Dato adicional[' ||
                                   rcdato.name_attribute || ']');
              dbms_output.put_line('Dato adicional[' ||
                                   rcdato.name_attribute || ']');
            end loop;
          end loop;
        
        end if; --if SBDATOSADICIONALES is null then
        --fin cadena datos adicionales
      
        ---Inicio de cadena para item de orden a gestionar
        sbcadenamateriales := null;
        FOR rfCuItem IN CuItem(NuOrder_Ir) LOOP
        
          if sbcadenamateriales is null then
            sbcadenamateriales := rfCuItem.Item || '>' || rfCuItem.Cantidad || '>Y';
          else
            sbcadenamateriales := sbcadenamateriales || ';' ||
                                  rfCuItem.Item || '>' || rfCuItem.Cantidad || '>Y';
          end if;
        
        END LOOP;
        ---Fin de cadena para item de orden a gestionar
      
        ---Cursor para armar cadena componentes actividad de la orden gestionada en LEGO
        --Dato Actividad
      
        if FnuClasificadorCausal(tempcuLDC_ORDTIPTRAADI.Causal_Id) = 0 then
        
          sbATRIBUTO := ';;;;';
          sbLECTURAS := null;
        
        else
        
          open CuActividadOrden(NuOrder_Ir);
          fetch CuActividadOrden
            into rfCuActividadOrden;
          close CuActividadOrden;
        
          dbms_output.put_line('Actividad [' ||
                               rfCuActividadOrden.Actividad || ']');
          dbms_output.put_line('Actividad [' ||
                               rfCuActividadOrden.Actividad || ']');
        
          for rfculdc_otdatoactividad in culdc_otdatoactividad(rfCuActividadOrden.Actividad,
                                                               NuOrder_Ir) loop
          
            dbms_output.put_line('Nombre Atributo [' ||
                                 rfculdc_otdatoactividad.nombre || ']');
          
            if rfculdc_otdatoactividad.componente = 2 then
              if sbATRIBUTO_1 is null then
                if rfculdc_otdatoactividad.valor_atributo is not null then
                  sbATRIBUTO_1 := ';' || rfculdc_otdatoactividad.nombre || '>' ||
                                  rfculdc_otdatoactividad.valor_atributo || '>>';
                
                  open CUEXISTE(rfculdc_otdatoactividad.nombre,
                                'COD_ATR_RET_LEGO');
                  fetch CUEXISTE
                    into nuCUEXISTE;
                  close CUEXISTE;
                
                  if nuCUEXISTE > 0 then
                    sbLECTURAS_1 := rfculdc_otdatoactividad.valor_atributo ||
                                    ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                 0) || '=R===';
                  else
                    sbLECTURAS_1 := rfculdc_otdatoactividad.valor_atributo ||
                                    ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                 0) || '=I===';
                  end if;
                end if;
              elsif sbATRIBUTO_2 is null then
                if rfculdc_otdatoactividad.valor_atributo is not null then
                  sbATRIBUTO_2 := ';' || rfculdc_otdatoactividad.nombre || '>' ||
                                  rfculdc_otdatoactividad.valor_atributo || '>>';
                
                  open CUEXISTE(rfculdc_otdatoactividad.nombre,
                                'COD_ATR_RET_LEGO');
                  fetch CUEXISTE
                    into nuCUEXISTE;
                  close CUEXISTE;
                
                  if nuCUEXISTE > 0 then
                    sbLECTURAS_2 := rfculdc_otdatoactividad.valor_atributo ||
                                    ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                 0) || '=R===';
                  else
                    sbLECTURAS_2 := '<' ||
                                    rfculdc_otdatoactividad.valor_atributo ||
                                    ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                 0) || '=I===';
                  end if;
                end if;
              end if;
              ----CASO 200-1528 IDETNFIICACION DE OTROS COMPONENTES
              --INICIO
            else
              if rfculdc_otdatoactividad.componente = 9 then
                if sbATRIBUTO_1 is null then
                  if rfculdc_otdatoactividad.valor_atributo is not null then
                    open cuelmesesu(NuOrder_Ir);
                    fetch cuelmesesu
                      into rfcuelmesesu;
                    close cuelmesesu;
                    sbATRIBUTO_1 := ';LECTURA>' ||
                                    rfculdc_otdatoactividad.valor_atributo || '>>';
                  
                    sbLECTURAS_1 := rfcuelmesesu.emsscoem || ';1=' ||
                                    nvl(rfculdc_otdatoactividad.valor_componente,
                                        0) || '=T===';
                  end if;
                elsif sbATRIBUTO_2 is null then
                  if rfculdc_otdatoactividad.valor_atributo is not null then
                    open cuelmesesu(NuOrder_Ir);
                    fetch cuelmesesu
                      into rfcuelmesesu;
                    close cuelmesesu;
                  
                    sbATRIBUTO_2 := ';LECTURA>' ||
                                    rfculdc_otdatoactividad.valor_atributo || '>>';
                  
                    sbLECTURAS_2 := rfcuelmesesu.emsscoem || ';1=' ||
                                    nvl(rfculdc_otdatoactividad.valor_componente,
                                        0) || '=T===';
                  end if;
                end if;
              end if;
              --FIN
              ----
            end if;
          end loop;
          if sbATRIBUTO_1 is null then
            sbATRIBUTO_1 := ';';
          end if;
          if sbATRIBUTO_2 is null then
            sbATRIBUTO_2 := ';';
          end if;
          sbATRIBUTO_3 := ';';
          sbATRIBUTO_4 := ';';
        
          sbATRIBUTO := sbATRIBUTO_1 || sbATRIBUTO_2 || sbATRIBUTO_3 ||
                        sbATRIBUTO_4;
          sbLECTURAS := sbLECTURAS_1 || sbLECTURAS_2 || sbLECTURAS_3 ||
                        sbLECTURAS_4;
        
        end if;
      
        dbms_output.put_line('Dato ATRIBUTOS [' || sbATRIBUTO || ']');
        dbms_output.put_line('Dato LECTURAS [' || sbLECTURAS || ']');
      
        --Fin Dato Actividad----------------------------------------
        -------------------------------------------------------------
      
        --cadena legalizacion de orden prinipal
        SBCADENALEGALIZACION := NULL;
        dbms_output.put_line('CUCADENALEGALIZACION(NuOrder_Ir[' ||
                             NuOrder_Ir || '],
                                  tempcuLDC_ORDTIPTRAADI.Causal_Id[' ||
                             tempcuLDC_ORDTIPTRAADI.Causal_Id || '],
                                  nvl(SBOBSERVACIONOSF, '''')[' ||
                             SBOBSERVACIONOSF || '],
                                  SBDATOSADICIONALES[' ||
                             SBDATOSADICIONALES || '],
                                  rfcuusualego.tecnico_unidad[' ||
                             rfcuusualego.tecnico_unidad || '],
                                  sbcadenamateriales[' ||
                             sbcadenamateriales || '],
                                  sbATRIBUTO[' ||
                             sbATRIBUTO || '],
                                  sbLECTURAS[' ||
                             sbLECTURAS || '])');
        OPEN CUCADENALEGALIZACION(NuOrder_Ir,
                                  tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                  --'-Legalizacion por forma LEGO-' ||
                                  --nvl(tempcuLDC_ORDTIPTRAADI.Order_Comment,''),
                                  nvl(SBOBSERVACIONOSF, ''),
                                  SBDATOSADICIONALES,
                                  rfcuusualego.tecnico_unidad, --tempcuLDC_ORDTIPTRAADI.Tecnico_Unidad,
                                  sbcadenamateriales,
                                  sbATRIBUTO,
                                  sbLECTURAS);
        --null);
        FETCH CUCADENALEGALIZACION
          INTO SBCADENALEGALIZACION;
        CLOSE CUCADENALEGALIZACION;
        --fin cadena legalizacion de orden prinipal
      
        dbms_output.put_line('Cadena legalizacion orden principal [' ||
                             SBCADENALEGALIZACION || '] ');
        dbms_output.put_line('Cadena legalizacion orden principal [' ||
                             SBCADENALEGALIZACION || '] ');
      
        ---INICIO LEGALIZAR TRABAJO ADICIONAL
      
        /*api_legalizeorders(SBCADENALEGALIZACION,
        nvl(tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
            sysdate),
        nvl(tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
            sysdate),
        sysdate,
        onuErrorCode,
        osbErrorMessage);*/
      
        onuErrorCode := 0;
        if onuErrorCode = 0 then
          select gc.class_causal_id
            into clascausal
            from open.ge_causal gc
           where gc.causal_id = tempcuLDC_ORDTIPTRAADI.Causal_Id;
          dbms_output.put_line('Paso 2 sbAplica146: ' || sbAplica146);
          if (sbAplica146 = 'S' and sbValidaGaraPadre = 'S' and /*open.dage_causal.fnugetclass_causal_id(tempcuLDC_ORDTIPTRAADI.Causal_Id, null )*/
             clascausal = 1 and nuExisOtGara != 2) then
          
            NuControlGPadre := 0;
            select oo.charge_status
              into charge_status
              from open.or_order oo
             where oo.order_id = NuOrder_Ir;
            SbcharPadre := nvl(charge_status, --daor_order.fsbgetcharge_status(NuOrder_Ir,null),
                               '0');
            dbms_output.put_line('rFrfOrdenesGarantia NuControlGPad' ||
                                 NuControlGPadre);
            dbms_output.put_line('rFrfOrdenesGarantia Sbcharge_status' ||
                                 SbcharPadre);
            sbInconsPadr := 'N';
          
            select oo.EXECUTION_FINAL_DATE
              into dtEXECUTION_FINAL_DATE
              from open.or_order oo
             where oo.order_id = NuOrder_Ir;
            if FnuExistenciaGarantia(nuTaskTypeId,
                                     tempcuLDC_ORDTIPTRAADI.Causal_Id) = 1 then
              rFrfOrdenesGarantia(NuOrder_Ir,
                                  nuTaskTypeId,
                                  dtEXECUTION_FINAL_DATE, --daor_order.FDTGETEXECUTION_FINAL_DATE(NuOrder_Ir),
                                  CurItemWarraPadre);
              Loop
                FETCH CurItemWarraPadre
                  INTO CIW_Item_Warranty_Id,
                       CIW_Item_Id,
                       CIW_Element_Id,
                       CIW_Element_Code,
                       CIW_Product_Id,
                       CIW_ORDER_ID,
                       CIW_FINAL_WARRANTY_DATE,
                       CIW_IS_ACTIVE,
                       CIW_ITEM_SERIED_ID,
                       CIW_SERIE,
                       CIW_ITEM,
                       CIW_FLEGALIZACION,
                       CIW_OBSERVACION,
                       CIW_UNIDADOPERATIVA,
                       CIW_PACKAGE_ID;
              
                EXIT WHEN CurItemWarraPadre%NOTFOUND;
                IF (CIW_ORDER_ID <> NuOrder_Ir) THEN
                
                  NuControlGPadre := 1;
                  --if nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) = 3 then
                  dbms_output.put_line('rFrfOrdenesGarantia CIW_ORDER_ID:' ||
                                       CIW_ORDER_ID);
                  if SbcharPadre = '3' then
                    dbms_output.put_line('rFrfOrdenesGarantia SbcharPade = 3');
                    if sbRegistraAudiGara = 'S' then
                      dbms_output.put_line('if sbRegistraAudiGara = ''S'' then');
                      /*insert into open.LDC_AUDIT_GARANTIA
                      values
                        (CIW_ORDER_ID, --CIW_Item_Warranty_Id,
                         CIW_Item_Id,
                         NuOrder_Ir, --NuOrder_Ir,
                         rfCuActividadOrden.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                         rfcuusualego.tecnico_unidad,
                         open.daor_order.fnugetoperating_unit_id(ionuOrderId, null));
                         sbInconsPadr :='S';*/
                    end if;
                  end if;
                END IF;
              END LOOP;
            
              --if NuControlGarantia = 0 and nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) <> 3 then
              if NuControlGPadre = 0 and SbcharPadre <> '3' then
              
                if sbRegistraAudiGara = 'S' then
                  dbms_output.put_line('if sbRegistraAudiGara = ''S'' then');
                  /*insert into LDC_AUDIT_GARANTIA
                  values
                    (NULL, --CIW_Item_Warranty_Id,
                     NULL,
                     NuOrder_Ir, --482 se deja la orden padre
                     rfCuActividadOrden.Actividad , --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                     rfcuusualego.tecnico_unidad,
                     open.daor_order.fnugetoperating_unit_id(NuOrder_Ir, null));*/
                end if;
                sbInconsPadr := 'S';
              end if;
            
            end if;
          end if;
        end if;
      
        /*
        OS_LEGALIZEORDERALLACTIVITIES(NuOrder_Ir,
                                      tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                      rfcuusualego.tecnico_unidad,
                                      tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
                                      tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
                                      tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                      SYSDATE,
                                      onuErrorCode,
                                      osbErrorMessage);
        */
        ---FIN LEGALIZACION TRABAJO ADICIONAL
      end if; --if sbAplica146='S' and nuExisOtGara = 2 then
    end if;
    close cuLDC_ORDTIPTRAADI;
  
    dbms_output.put_line('onuErrorCode[' || onuErrorCode || ']');
    dbms_output.put_line('onuErrorCode[' || onuErrorCode || ']');
  
    ---fin proceso para legalizar orden principal
    -----------------------------------------------------------------------
  
    if onuErrorCode = 0 then
      OPEN CurOrdenActi(NuOrder_Ir);
      FETCH CurOrdenActi
        INTO NuCodDir, sbCOMENTARIO, NUUNIDADOPERATIVA;
      close CurOrdenActi;
    
      --Ciclo para crear actividades para trabajos adicionales
      FOR TEMPCurACTIVIDAD IN CurACTIVIDAD(NuOrder_Ir) LOOP
      
        --No permitir seguri creando trabajos adicionales si al menos uno tubo un error
        if (nuControlErrorActividad = 0) then
        
          nucantidad := 0;
        
          OPEN CurEXISTEACTIVIDAD(NuOrder_Ir, TEMPCurACTIVIDAD.Actividad);
          FETCH CurEXISTEACTIVIDAD
            INTO nucantidad;
          CLOSE CurEXISTEACTIVIDAD;
        
          IF nucantidad = 0 THEN
          
            /*
            dbms_output.put_line('**********************************************');
            dbms_output.put_line('**********************************************',
                           10);
            dbms_output.put_line('ORDEN ORIGINAL --> ' || NuOrder_Ir);
            dbms_output.put_line('ORDEN ORIGINAL --> ' || NuOrder_Ir);
            dbms_output.put_line('ACTIVIDAD --> ' ||
                                 TEMPCurACTIVIDAD.Actividad);
            dbms_output.put_line('ACTIVIDAD --> ' || TEMPCurACTIVIDAD.Actividad,
                           10);
            dbms_output.put_line('**********************************************');
            dbms_output.put_line('**********************************************',
                           10);
              */
          
            --se inicializa la variable para que genere la orden pro cada activdad para el trabajo adicional
            ionuOrderId        := null;
            inuOrderActivityId := null;
          
            --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
            --Incio OSF-630
            OPEN CuOR_ORDER_ACTIVITY(NuOrder_Ir);
            FETCH CuOR_ORDER_ACTIVITY
              INTO RCCuOR_ORDER_ACTIVITY;
            CLOSE CuOR_ORDER_ACTIVITY;
            dbms_output.put_line('or_boorderactivities.CreateActivity(TEMPCurACTIVIDAD.Actividad[' ||
                                 TEMPCurACTIVIDAD.Actividad || '],
                                                  RCCuOR_ORDER_ACTIVITY.Package_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Package_Id || '],
                                                  RCCuOR_ORDER_ACTIVITY.Motive_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Motive_Id || '],
                                                  RCCuOR_ORDER_ACTIVITY.Component_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Component_Id || '],
                                                  null,
                                                  NuCodDir[' ||
                                 NuCodDir || '],
                                                  null,
                                                  RCCuOR_ORDER_ACTIVITY.Subscriber_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Subscriber_Id || '],
                                                  RCCuOR_ORDER_ACTIVITY.Subscription_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Subscription_Id || '],
                                                  RCCuOR_ORDER_ACTIVITY.Product_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Product_Id || '],
                                                  RCCuOR_ORDER_ACTIVITY.Operating_Sector_Id[' ||
                                 RCCuOR_ORDER_ACTIVITY.Operating_Sector_Id || '],
                                                  null,
                                                  null,
                                                  null,
                                                  nvl(SBOBSERVACIONOSF[' ||
                                 SBOBSERVACIONOSF ||
                                 '], ''),
                                                  null,
                                                  null,
                                                  ionuOrderId,
                                                  inuOrderActivityId,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  0,
                                                  null,
                                                  null,
                                                  null,
                                                  null)');
            --Fin OSF-630
            ionuOrderId := 307265740;
            IF NVL(ionuOrderId, 0) > 0 THEN
            
              ---ACTUALIZAR DATOS DE OR_ORDER_ACTIVITY
            
              /* UPDATE OR_ORDER_ACTIVITY OOA
                SET OOA.PACKAGE_ID      = RCCuOR_ORDER_ACTIVITY.Package_Id,
                    OOA.MOTIVE_ID       = RCCuOR_ORDER_ACTIVITY.Motive_Id,
                    OOA.SUBSCRIBER_ID   = RCCuOR_ORDER_ACTIVITY.Subscriber_Id,
                    OOA.SUBSCRIPTION_ID = RCCuOR_ORDER_ACTIVITY.Subscription_Id,
                    OOA.PRODUCT_ID      = RCCuOR_ORDER_ACTIVITY.Product_Id
              WHERE OOA.ORDER_ID = ionuOrderId;*/
            
              ---OR_ORDER_ACTIVITY
            
              dbms_output.put_line('ORDEN GENERADA --> ' || ionuOrderId);
            
              ---INICIO RELACIONAR MATERIALES CON LA ORDEN ADICIONAL
              sbcadenamateriales := null;
              FOR TEMPCurMATERIAL IN CurMATERIAL(NuOrder_Ir,
                                                 TEMPCurACTIVIDAD.Task_Type_Id,
                                                 TEMPCurACTIVIDAD.Actividad) LOOP
              
                if sbcadenamateriales is null then
                  sbcadenamateriales := TEMPCurMATERIAL.Material || '>' ||
                                        TEMPCurMATERIAL.Cantidad || '>Y';
                else
                  sbcadenamateriales := sbcadenamateriales || ';' ||
                                        TEMPCurMATERIAL.Material || '>' ||
                                        TEMPCurMATERIAL.Cantidad || '>Y';
                end if;
              
              END LOOP;
              ------FIN RELACIONAR MATERIALES CON LA ORDEN ADICIONAL
            
              -------INICIO RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL
              dbms_output.put_line('OS_RELATED_ORDER(NuOrder_Ir,
                                 ionuOrderId,
                                 onuErrorCode,
                                 osbErrorMessage)');
            
              onuErrorCode := 0;
              IF onuErrorCode = 0 THEN
                ---- ASIGNAR LA ORDEN A LA UNIDAD OPERATIVA
                dbms_output.put_line('os_assign_order(ionuOrderId,
                                  NUUNIDADOPERATIVA,
                                  sysdate,
                                  sysdate,
                                  onuerrorcode,
                                  osberrormessage)');
                onuErrorCode := 0;
                IF onuErrorCode = 0 THEN
                
                  --CADENA DE LEGALIZAICION ORDEN
                  --cadena datos adicionales de ordenes adicionales
                
                  --cadena datos adicionales
                  SBDATOSADICIONALES := NULL;
                  if sbAplica672 = 'S' then
                    sbvavldausteracdan  := 'N';
                    sbvavldareppundist  := 'N';
                    svvavaldagdcocadano := 'N';
                    svvavaldasincoaugdc := 'N';
                  end if;
                  for rfculdc_otadicionalda in culdc_otadicionalda(NuOrder_Ir,
                                                                   TEMPCurACTIVIDAD.Task_Type_Id,
                                                                   TEMPCurACTIVIDAD.Causal_Id,
                                                                   TEMPCurACTIVIDAD.Actividad,
                                                                   --TEMPCurACTIVIDAD.Material
                                                                   0) loop
                  
                    -- Inicio -- CA-672
                    if sbAplica672 = 'S' then
                      IF rfculdc_otadicionalda.attribute_id =
                         nmvadaadusterocada THEN
                        sbvavldausteracdan          := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                        sbvavldausteracdan          := TRIM(sbvavldausteracdan);
                        rfculdc_otadicionalda.Value := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                      ELSIF rfculdc_otadicionalda.attribute_id =
                            nmvadaadreppundist THEN
                        sbvavldareppundist          := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                        sbvavldareppundist          := TRIM(sbvavldareppundist);
                        rfculdc_otadicionalda.Value := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                      ELSIF rfculdc_otadicionalda.attribute_id =
                            nmvadaadgdcocadano THEN
                        svvavaldagdcocadano         := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                        svvavaldagdcocadano         := TRIM(svvavaldagdcocadano);
                        rfculdc_otadicionalda.Value := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                      ELSIF rfculdc_otadicionalda.attribute_id =
                            nmvadaadsicbraugdc THEN
                        svvavaldasincoaugdc         := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                        svvavaldasincoaugdc         := TRIM(svvavaldasincoaugdc);
                        rfculdc_otadicionalda.Value := nvl(rfculdc_otadicionalda.Value,
                                                           'N');
                      END IF;
                    end if;
                  
                    -- tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                    --IF rfculdc_otadicionalda.Value is not null then
                    IF SBDATOSADICIONALES IS NULL THEN
                      SBDATOSADICIONALES := rfculdc_otadicionalda.NAME_ATTRIBUTE || '=' ||
                                            rfculdc_otadicionalda.Value;
                    ELSE
                      SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                            rfculdc_otadicionalda.NAME_ATTRIBUTE || '=' ||
                                            rfculdc_otadicionalda.Value;
                    END IF;
                    --end if;
                  end loop;
                
                  --SBDATOSADICIONALES := NULL;
                  if SBDATOSADICIONALES is null then
                    for rc in cugrupo(TEMPCurACTIVIDAD.Task_Type_Id,
                                      TEMPCurACTIVIDAD.Causal_Id) loop
                      -- tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                      dbms_output.put_line('Grupo de dato adicional [' ||
                                           rc.attribute_set_id ||
                                           '] asociado al tipo de trabajo [' ||
                                           rc.task_type_id || ']');
                      dbms_output.put_line('Grupo de dato adicional [' ||
                                           rc.attribute_set_id ||
                                           '] asociado al tipo de trabajo [' ||
                                           rc.task_type_id || ']');
                    
                      for rcdato in cudatoadicional(rc.attribute_set_id) loop
                        IF SBDATOSADICIONALES IS NULL THEN
                          SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
                        ELSE
                          SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                                RCDATO.NAME_ATTRIBUTE || '=';
                        END IF;
                        dbms_output.put_line('Dato adicional[' ||
                                             rcdato.name_attribute || ']');
                        dbms_output.put_line('Dato adicional[' ||
                                             rcdato.name_attribute || ']');
                      end loop;
                    end loop;
                  end if; --if SBDATOSADICIONALES is null then
                  --fin cadena datos adicionales
                
                  dbms_output.put_line('DATOS ADICIONALES[' ||
                                       SBDATOSADICIONALES || ']');
                  dbms_output.put_line('DATOS ADICIONALES[' ||
                                       SBDATOSADICIONALES || ']');
                
                  SBCADENALEGALIZACION := NULL;
                
                  --dbms_output.put_line('Causal OT Adicional [' || TEMPCurACTIVIDAD.Causal_Id || ']');
                  --dbms_output.put_line('Causal OT Adicional [' || TEMPCurACTIVIDAD.Causal_Id || ']',10);
                
                  --dbms_output.put_line('Causal OT Adicional FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id)[' || FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) || ']');
                  --dbms_output.put_line('Causal OT Adicional FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id)[' || FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) || ']',10);
                
                  if FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) = 0 then
                  
                    sbATRIBUTO := ';;;;';
                    sbLECTURAS := null;
                  
                  else
                  
                    sbATRIBUTO_1 := null;
                    sbATRIBUTO_2 := null;
                    sbATRIBUTO_3 := null;
                    sbATRIBUTO_4 := null;
                  
                    sbLECTURAS_1 := null;
                    sbLECTURAS_2 := null;
                    sbLECTURAS_3 := null;
                    sbLECTURAS_4 := null;
                  
                    --CASO 200-1528
                    --Inicio Proceso de generacion de cadena para componentes de actividad de la OT adicional
                    ---Cursor para armar cadena componentes actividad de la orden gestionada en LEGO
                    --Dato Actividad
                    /*dbms_output.put_line('Actividad OT Adicional[' ||
                                         TEMPCurACTIVIDAD.Actividad || ']');
                    dbms_output.put_line('Actividad OT Adicional[' ||
                                   TEMPCurACTIVIDAD.Actividad || ']',
                                   10);
                    dbms_output.put_line('Material OT Adicional[' ||
                                         TEMPCurACTIVIDAD.Material || ']');
                    dbms_output.put_line('Material OT Adicional[' ||
                                   TEMPCurACTIVIDAD.Material || ']',
                                   10);*/
                    dbms_output.put_line('Orden Padre[' || NuOrder_Ir || ']');
                    dbms_output.put_line('Orden Padre[' || NuOrder_Ir || ']');
                  
                    for rfcuLDC_COMPONENTEOTADICIONAL in cuLDC_COMPONENTEOTADICIONAL(0, --TEMPCurACTIVIDAD.Material,
                                                                                     TEMPCurACTIVIDAD.Actividad,
                                                                                     NuOrder_Ir) loop
                    
                      dbms_output.put_line('Nombre Atributo [' ||
                                           rfcuLDC_COMPONENTEOTADICIONAL.nombre || ']');
                    
                      if rfcuLDC_COMPONENTEOTADICIONAL.componente = 2 then
                        if sbATRIBUTO_1 is null then
                          if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                            sbATRIBUTO_1 := ';' ||
                                            rfcuLDC_COMPONENTEOTADICIONAL.nombre || '>' ||
                                            rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';
                          
                            open CUEXISTE(rfcuLDC_COMPONENTEOTADICIONAL.nombre,
                                          'COD_ATR_RET_LEGO');
                            fetch CUEXISTE
                              into nuCUEXISTE;
                            close CUEXISTE;
                          
                            if nuCUEXISTE > 0 then
                              sbLECTURAS_1 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=R===';
                            else
                              sbLECTURAS_1 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=I===';
                            end if;
                          end if;
                        elsif sbATRIBUTO_2 is null then
                          if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                            sbATRIBUTO_2 := ';' ||
                                            rfcuLDC_COMPONENTEOTADICIONAL.nombre || '>' ||
                                            rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';
                          
                            open CUEXISTE(rfcuLDC_COMPONENTEOTADICIONAL.nombre,
                                          'COD_ATR_RET_LEGO');
                            fetch CUEXISTE
                              into nuCUEXISTE;
                            close CUEXISTE;
                          
                            if nuCUEXISTE > 0 then
                              sbLECTURAS_2 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=R===';
                            else
                              sbLECTURAS_2 := '<' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=I===';
                            end if;
                          end if;
                        end if;
                        ----CASO 200-1528 IDETNFIICACION DE OTROS COMPONENTES
                        --INICIO
                      else
                        if rfcuLDC_COMPONENTEOTADICIONAL.componente = 9 then
                          if sbATRIBUTO_1 is null then
                            if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                              open cuelmesesu(NuOrder_Ir);
                              fetch cuelmesesu
                                into rfcuelmesesu;
                              close cuelmesesu;
                              sbATRIBUTO_1 := ';LECTURA>' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';
                            
                              sbLECTURAS_1 := rfcuelmesesu.emsscoem ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=T===';
                            end if;
                          elsif sbATRIBUTO_2 is null then
                            if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                              open cuelmesesu(NuOrder_Ir);
                              fetch cuelmesesu
                                into rfcuelmesesu;
                              close cuelmesesu;
                            
                              sbATRIBUTO_2 := ';LECTURA>' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';
                            
                              sbLECTURAS_2 := rfcuelmesesu.emsscoem ||
                                              ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                           0) || '=T===';
                            end if;
                          end if;
                        end if;
                        --FIN
                        ----
                      end if;
                    end loop;
                  
                    if sbATRIBUTO_1 is null then
                      sbATRIBUTO_1 := ';';
                    end if;
                    if sbATRIBUTO_2 is null then
                      sbATRIBUTO_2 := ';';
                    end if;
                    sbATRIBUTO_3 := ';';
                    sbATRIBUTO_4 := ';';
                  
                    sbATRIBUTO := sbATRIBUTO_1 || sbATRIBUTO_2 ||
                                  sbATRIBUTO_3 || sbATRIBUTO_4;
                    sbLECTURAS := sbLECTURAS_1 || sbLECTURAS_2 ||
                                  sbLECTURAS_3 || sbLECTURAS_4;
                  end if;
                  dbms_output.put_line('Dato ATRIBUTOS [' || sbATRIBUTO || ']');
                  dbms_output.put_line('Dato ATRIBUTOS [' || sbATRIBUTO || ']');
                  dbms_output.put_line('Dato LECTURAS [' || sbLECTURAS || ']');
                  dbms_output.put_line('Dato LECTURAS [' || sbLECTURAS || ']');
                
                  --Fin Dato Actividad----------------------------------------
                  -----------------------------------------------------------------------------
                
                  OPEN CUCADENALEGALIZACION(ionuOrderId,
                                            TEMPCurACTIVIDAD.Causal_Id, --tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                            --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                            nvl(SBOBSERVACIONOSF, ''),
                                            SBDATOSADICIONALES,
                                            rfcuusualego.tecnico_unidad,
                                            sbcadenamateriales,
                                            sbATRIBUTO,
                                            sbLECTURAS);
                  FETCH CUCADENALEGALIZACION
                    INTO SBCADENALEGALIZACION;
                  CLOSE CUCADENALEGALIZACION;
                  --FIN CADENA LEGALIZACION ORDEN
                  dbms_output.put_line('CADENA LEGALIZACION[' ||
                                       SBCADENALEGALIZACION || ']');
                  dbms_output.put_line('CADENA LEGALIZACION[' ||
                                       SBCADENALEGALIZACION || ']');
                
                  --relacionar orden con tecnico y unidad de trabajo
                  dbms_output.put_line('insert into ldc_asig_ot_tecn
                      (unidad_operativa, tecnico_unidad, orden)
                    values
                      (NUUNIDADOPERATIVA,
                       OPEN.GE_BOPERSONAL.FNUGETPERSONID,
                       ionuOrderId)');
                  --fin relacion
                
                  --se realiza un proceso COMMIT antes de realizar el
                  --proceso de legalizacion de orden adcional
                  /*--CASO 200-1369*/
                  --commit;
                
                  --fin commit;
                
                  ---INICIO LEGALIZAR TRABAJO ADICIONAL
                  dbms_output.put_line('api_legalizeorders(SBCADENALEGALIZACION,
                                      nvl(tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
                                          sysdate),
                                      nvl(tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
                                          sysdate),
                                      sysdate,
                                      onuErrorCode,
                                      osbErrorMessage)');
                
                  --if (onuErrorCode = 0) then
                  --  commit;
                  --else
                  if (onuErrorCode <> 0) then
                    nuControlErrorActividad := 1;
                  
                    dbms_output.put_line('ERROR AL LEGALIZAR LA ORDEN [' ||
                                         ionuOrderId || '] ' ||
                                         onuErrorCode || ' - ' ||
                                         osbErrorMessage);
                    dbms_output.put_line('ERROR AL LEGALIZAR LA ORDEN [' ||
                                         ionuOrderId || '] ' ||
                                         onuErrorCode || ' - ' ||
                                         osbErrorMessage);
                  
                    SBOBSERVACION := 'Error al utilizar el servicio api_legalizeorders [' ||
                                     onuErrorCode || ' - ' ||
                                     osbErrorMessage || ']';
                  
                    --reversar el proceso de legalizaion de orden adicional
                    rollback;
                  
                    begin
                      dbms_output.put_line('update ldc_otlegalizar lol
                           set lol.legalizado         = ''N'',
                               lol.mensaje_legalizado = SBOBSERVACION
                         where lol.order_id = NuOrder_Ir');
                      --commit;
                    end;
                  
                    --Caso 200-1580 - Insercion en tabla auditoria
                  else
                    --CAUSAL: TEMPCurACTIVIDAD.Causal_Id
                    --TIPO DE TRABAJO: TEMPCurACTIVIDAD.Task_Type_Id
                    --
                    --otgarantia
                    --itemgarantia
                    --otlegalizada: NuOrder_Ir
                    --itemlegalizado: TEMPCurACTIVIDAD.Material
                    --usuario: (p)rfcuusualego.tecnico_unidad
                    --unidadoperativa: NUUNIDADOPERATIVA
                  
                    /*
                    open culdc_otadicional(NuOrder_Ir);
                    fetch culdc_otadicional into rfculdc_otadicional;
                    close culdc_otadicional;
                    */
                  
                    NuControlGarantia := 0;
                    --Sbcharge_status   := nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),'0');
                    select oo.charge_status
                      into Sbcharge_status
                      from open.or_order oo
                     where oo.order_id = ionuOrderId;
                    dbms_output.put_line('rFrfOrdenesGarantia NuControlGarantia' ||
                                         NuControlGarantia);
                    dbms_output.put_line('rFrfOrdenesGarantia Sbcharge_status' ||
                                         Sbcharge_status);
                    sbInconsGara   := 'N';
                    sbAutorizacion := 'N';
                  
                    select gc.class_causal_id
                      into clascausal
                      from open.ge_causal gc
                     where gc.causal_id = TEMPCurACTIVIDAD.Causal_Id;
                  
                    dbms_output.put_line('if (FnuExistenciaGarantia(TEMPCurACTIVIDAD.Task_Type_Id,
                                               TEMPCurACTIVIDAD.Causal_Id)[' ||
                                         FnuExistenciaGarantia(TEMPCurACTIVIDAD.Task_Type_Id,
                                                               TEMPCurACTIVIDAD.Causal_Id) ||
                                         '] = 1  and open.dage_causal.fnugetclass_causal_id(TEMPCurACTIVIDAD.Causal_Id, null) [' ||
                                         clascausal ||
                                         '] = 1) and
                      ((nuExisOtGara[' ||
                                         nuExisOtGara ||
                                         '] != 2 and sbAplica146[' ||
                                         sbAplica146 ||
                                         '] = ''S'') or sbAplica146[' ||
                                         sbAplica146 || '] = ''N'')  then');
                  
                    if (FnuExistenciaGarantia(TEMPCurACTIVIDAD.Task_Type_Id,
                                              TEMPCurACTIVIDAD.Causal_Id) = 1 and /*open.dage_causal.fnugetclass_causal_id(TEMPCurACTIVIDAD.Causal_Id, null)*/
                       clascausal = 1) and
                       ((nuExisOtGara != 2 and sbAplica146 = 'S') or
                       sbAplica146 = 'N') then
                    
                      select oo.EXECUTION_FINAL_DATE
                        into dtEXECUTION_FINAL_DATE
                        from open.or_order oo
                       where oo.order_id = NuOrder_Ir;
                    
                      dtEXECUTION_FINAL_DATE := to_date('30/10/2023 11:00:00',
                                                        'DD/MM/YYYY HH24:MI:SS');
                    
                      dbms_output.put_line('Orden [' || NuOrder_Ir ||
                                           '] EXECUTION_FINAL_DATE [' ||
                                           dtEXECUTION_FINAL_DATE || ']');
                      dbms_output.put_line('rFrfOrdenesGarantia(NuOrder_Ir[' ||
                                           NuOrder_Ir || '],
                                          TEMPCurACTIVIDAD.Task_Type_Id[' ||
                                           TEMPCurACTIVIDAD.Task_Type_Id || '],
                                          dtEXECUTION_FINAL_DATE[' ||
                                           dtEXECUTION_FINAL_DATE || '],
                                          CurItemWarranty)');
                    
                      rFrfOrdenesGarantia(NuOrder_Ir,
                                          TEMPCurACTIVIDAD.Task_Type_Id,
                                          dtEXECUTION_FINAL_DATE, --daor_order.FDTGETEXECUTION_FINAL_DATE(NuOrder_Ir),
                                          CurItemWarranty);
                      Loop
                        FETCH CurItemWarranty
                          INTO CIW_Item_Warranty_Id,
                               CIW_Item_Id,
                               CIW_Element_Id,
                               CIW_Element_Code,
                               CIW_Product_Id,
                               CIW_ORDER_ID,
                               CIW_FINAL_WARRANTY_DATE,
                               CIW_IS_ACTIVE,
                               CIW_ITEM_SERIED_ID,
                               CIW_SERIE,
                               CIW_ITEM,
                               CIW_FLEGALIZACION,
                               CIW_OBSERVACION,
                               CIW_UNIDADOPERATIVA,
                               CIW_PACKAGE_ID;
                      
                        EXIT WHEN CurItemWarranty%NOTFOUND;
                      
                        salir := 0; --caso: 146
                        dbms_output.put_line('IF (CIW_ORDER_ID[' ||
                                             CIW_ORDER_ID ||
                                             '] <> ionuOrderId[' ||
                                             ionuOrderId ||
                                             '] and RCCuOR_ORDER_ACTIVITY.Package_Id[' ||
                                             RCCuOR_ORDER_ACTIVITY.Package_Id ||
                                             '] != CIW_PACKAGE_ID[' ||
                                             CIW_PACKAGE_ID || ']) THEN');
                        IF (CIW_ORDER_ID <> ionuOrderId and RCCuOR_ORDER_ACTIVITY.Package_Id !=
                           CIW_PACKAGE_ID) THEN
                          dbms_output.put_line('Paso Garantia Sbcharge_status: ' ||
                                               Sbcharge_status ||
                                               ' - NuControlGarantia: ' ||
                                               NuControlGarantia);
                          NuControlGarantia := 1;
                          --if nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) = 3 then
                          dbms_output.put_line('rFrfOrdenesGarantia CIW_ORDER_ID:' ||
                                               CIW_ORDER_ID);
                          if Sbcharge_status = '3' then
                            dbms_output.put_line('rFrfOrdenesGarantia Sbcharge_status = 3');
                            if sbRegistraAudiGara = 'S' then
                              dbms_output.put_line('insert into LDC_AUDIT_GARANTIA
                                values
                                  (CIW_ORDER_ID, --CIW_Item_Warranty_Id,
                                   CIW_Item_Id,
                                   ionuOrderId, --NuOrder_Ir,
                                   TEMPCurACTIVIDAD.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                                   rfcuusualego.tecnico_unidad,
                                   NUUNIDADOPERATIVA)');
                            end if;
                            -- Inicio: 146
                            dbms_output.put_line('Paso 3 sbAplica146: ' ||
                                                 sbAplica146);
                            if (sbAplica146 = 'S' or
                               (sbAplica672 = 'S' and
                               sbvavldausteracdan = 'N' and
                               sbvavldareppundist = 'N')) then
                              sbInconsGara := 'S';
                            end if;
                            -- Fin: 146
                          end if;
                        END IF;
                      END LOOP;
                    
                      --if NuControlGarantia = 0 and nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) <> 3 then
                       dbms_output.put_line('if NuControlGarantia['|| NuControlGarantia ||'] = 0 and Sbcharge_status[' || Sbcharge_status || '] <> ''3'' then');
                      if NuControlGarantia = 0 and Sbcharge_status <> '3' then
                                                dbms_output.put_line('sbRegistraAudiGara: ' || sbRegistraAudiGara);

                        if sbRegistraAudiGara = 'S' then
                          dbms_output.put_line('insert into LDC_AUDIT_GARANTIA
                            values
                              (NULL, --CIW_Item_Warranty_Id,
                               NULL,
                               ionuOrderId, --NuOrder_Ir,
                               TEMPCurACTIVIDAD.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                               rfcuusualego.tecnico_unidad,
                               NUUNIDADOPERATIVA)');
                        end if;
                        -- Inicio: 146
                        dbms_output.put_line('Paso 4 sbAplica146: ' ||
                                             sbAplica146);
                        if (sbAplica146 = 'S' or (sbAplica672 = 'S' and
                           svvavaldagdcocadano = 'N' and
                           svvavaldasincoaugdc = 'N')) then
                          sbInconsGara := 'S';
                        end if;
                        if sbAplica672 = 'S' and (svvavaldagdcocadano = 'S' OR
                           svvavaldasincoaugdc = 'S') then
                          sbAutorizacion := 'S';
                        else
                          sbAutorizacion := 'N';
                        end if;
                        -- Fin: 146
                      end if;
                    
                    end if;
                    --Inicio 146
                    dbms_output.put_line('Paso 5 sbAplica146: ' ||
                                         sbAplica146);
                    if ((sbAplica146 = 'S' or sbAplica672 = 'S') and
                       sbInconsGara = 'S') then
                      if sbTitrIncons is null then
                        sbTitrIncons := 'Inconsistencias en Garantias tipos de trabajo Adicionales : ' ||
                                        TEMPCurACTIVIDAD.TASK_TYPE_ID;
                      else
                        sbTitrIncons := sbTitrIncons || ', ' ||
                                        TEMPCurACTIVIDAD.TASK_TYPE_ID;
                      end if;
                    end if;
                  
                    if sbAplica672 = 'S' and sbInconsGara = 'N' and
                       sbAutorizacion = 'S' then
                      --Se valida si esta pendiente alguna aprobacion
                      SELECT COUNT(1)
                        INTO nmcontaaprob
                        FROM open.ldc_otscobleg h
                       WHERE h.nro_orden = NuOrder_Ir
                         and h.tipo_trab_adic =
                             tempcuractividad.task_type_id
                         AND h.estado = 'APROBADA';
                      IF nmcontaaprob = 0 THEN
                        --se valida si ya hay una solicitud registrada
                        --si hay no debe volver a registrar
                        --sino hay debe registrar
                        SELECT COUNT(1)
                          INTO nmcontaaprob
                          FROM open.ldc_otscobleg h
                         WHERE h.nro_orden = NuOrder_Ir
                           and h.tipo_trab_adic =
                               tempcuractividad.task_type_id
                           AND h.estado = 'PENDIENTE APROBACION';
                        nmpacoderr := 0;
                        IF nmcontaaprob = 0 THEN
                        
                          dbms_output.put_line('ldc_pkgotssincobsingar.ldc_prccrearegaproleg(
                                                                            NuOrder_Ir
                                                                           ,tempcuractividad.task_type_id
                                                                           ,svvavaldagdcocadano
                                                                           ,svvavaldasincoaugdc
                                                                           ,nmpacoderr
                                                                           ,sbpamensaerr
                                                                           )');
                          IF nmpacoderr = 0 THEN
                            sbmensajecue := 'Orden : ' ||
                                            to_char(NuOrder_Ir) ||
                                            ' pendiente de aprobacion para que el contratista proceda a legalizarla.';
                            --ldc_email.mail(sender, sbcorreos, 'Orden pendiente de aprobacion', sbmensajecue);
                            dbms_output.put_line(sbmensajecue);
                          ELSE
                            sbTitrIncons := 'Inconsistencias tipos de trabajo Adicionales : ' ||
                                            tempcuractividad.task_type_id || ' ' ||
                                            sbpamensaerr;
                          END IF;
                        End if;
                        if nmpacoderr = 0 then
                          if sbTitrIncons is null then
                            sbTitrIncons := 'Inconsistencias en Garantias tipos de trabajo Adicionales : ' ||
                                            TEMPCurACTIVIDAD.TASK_TYPE_ID ||
                                            ' Pendiente aprobacion';
                          else
                            sbTitrIncons := sbTitrIncons || ', ' ||
                                            TEMPCurACTIVIDAD.TASK_TYPE_ID ||
                                            ' Pendiente aprobacion';
                          end if;
                        end if;
                      
                        ---
                      end if;
                    
                    end if;
                  
                    --Fin 146
                    --Fin Caso 200-1580
                  end if;
                  ---FIN LEGALIZACION TRABAJO ADICIONAL
                
                ELSE
                
                  nuControlErrorActividad := 1;
                
                  /*
                  dbms_output.put_line('ERROR AL ASIGNAR LA ORDEN [' ||
                                       ionuOrderId ||
                                       '] A LA UNIDAD OPERATIVA [' ||
                                       NUUNIDADOPERATIVA || '] ' ||
                                       onuErrorCode || ' - ' ||
                                       osbErrorMessage);
                  DBMS_OUTPUT.put_line('ERROR AL ASIGNAR LA ORDEN [' ||
                                       ionuOrderId ||
                                       '] A LA UNIDAD OPERATIVA [' ||
                                       NUUNIDADOPERATIVA || '] ' ||
                                       onuErrorCode || ' - ' ||
                                       osbErrorMessage);
                  */
                
                  SBOBSERVACION := 'Error en el servicio os_assign_order al asignar la nueva orden a la unidad [' ||
                                   NUUNIDADOPERATIVA || '] - [' ||
                                   onuErrorCode || ' - ' || osbErrorMessage || ']';
                
                  rollback;
                
                  begin
                    DBMS_OUTPUT.put_line('update open.ldc_otlegalizar lol
                         set lol.legalizado         = ''N'',
                             lol.mensaje_legalizado = SBOBSERVACION
                       where lol.order_id = NuOrder_Ir)');
                    --commit;
                  end;
                
                END IF;
                ----FIN ASIGNACION ORDEN
              ELSE
              
                nuControlErrorActividad := 1;
              
                /*
                dbms_output.put_line('ERROR AL RELACIONAR LA ORDEN [' ||
                                     ionuOrderId ||
                                     '] A LA ORDEN ORIGINAL [' ||
                                     NuOrder_Ir || '] ' || onuErrorCode ||
                                     ' - ' || osbErrorMessage);
                dbms_output.put_line('ERROR AL RELACIONAR LA ORDEN [' ||
                               ionuOrderId || '] A LA ORDEN ORIGINAL [' ||
                               NuOrder_Ir || '] ' || onuErrorCode || ' - ' ||
                               osbErrorMessage,
                               10);
                  */
              
                SBOBSERVACION := 'ERROR AL RELACIONAR LA ORDEN [' ||
                                 ionuOrderId || '] A LA ORDEN ORIGINAL [' ||
                                 NuOrder_Ir ||
                                 '] Utilizando el servicio OS_RELATED_ORDER';
                rollback;
              
                begin
                  DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
                       set lol.legalizado         = ''N'',
                           lol.mensaje_legalizado = SBOBSERVACION
                     where lol.order_id = NuOrder_Ir');
                  --commit;
                end;
              
              END IF;
              --FIN RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL*/
            
              /*--CASO 200-1369*/
              --commit;
            
            ELSE
              --IF onuErrorCode = 0 THEN de la creacion de orden con OS_CREATEORDERACTIVITIES
            
              --Inicio OSF-630
              DBMS_OUTPUT.put_line('errors.GETERROR(onuErrorCode, osbErrorMessage)');
              --Fin OSF-630
            
              nuControlErrorActividad := 1;
            
              dbms_output.put_line('ERROR AL GENERAR EL TRABAJO ADICIONAL CON LA ACTIVIDAD [' ||
                                   TEMPCurACTIVIDAD.Actividad || '] ' ||
                                   onuErrorCode || ' - ' ||
                                   osbErrorMessage);
              dbms_output.put_line('ERROR AL GENERAR EL TRABAJO ADICIONAL CON LA ACTIVIDAD [' ||
                                   TEMPCurACTIVIDAD.Actividad || '] ' ||
                                   onuErrorCode || ' - ' ||
                                   osbErrorMessage);
            
              SBOBSERVACION := 'ERROR AL GENERAR EL TRABAJO ADICIONAL CON EL SERIVICIO OS_CREATEORDERACTIVITIES CON LA ACTIVIDAD [' ||
                               TEMPCurACTIVIDAD.Actividad || '] ' ||
                               onuErrorCode || ' - ' || osbErrorMessage || ']';
              rollback;
            
              begin
                DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
                     set lol.legalizado         = ''N'',
                         lol.mensaje_legalizado = SBOBSERVACION
                   where lol.order_id = NuOrder_Ir');
                --commit;
              end;
            
            END IF;
            /*
            ELSE
              IF SBOBSERVACION IS NULL THEN
                SBOBSERVACION := 'LA ACTIVIDAD [' || TEMPCurACTIVIDAD.Actividad ||
                                 '] YA TIENE TIPO DE TRABAJO ADICIONAL RELACIONADA CON LA ORDEN [' ||
                                 NuOrder_Ir || ']';
              ELSE
                SBOBSERVACION := SBOBSERVACION || CHR(10) || ' LA ACTIVIDAD [' ||
                                 TEMPCurACTIVIDAD.Actividad ||
                                 '] YA TIENE TIPO DE TRABAJO ADICIONAL RELACIONADA CON LA ORDEN [' ||
                                 NuOrder_Ir || ']';
              END IF;
            */
          END IF; --FIN DE VALIDACION DE EXISTENCIA TRABAJO ADICIONAL
        END IF; --      if (nuControlErrorActividad = 0) then
      END LOOP;
    
      --INICIO CA 200-2404
      IF fblAplicaEntregaxcaso('200-2404') AND nuControlErrorActividad = 0 THEN
      
        PROVALIINTECOTI(NuOrder_Ir, onuErrorCode, osbErrorMessage);
      
        IF onuErrorCode <> 0 THEN
          SBOBSERVACION           := osbErrorMessage;
          nuControlErrorActividad := 1;
          rollback;
        
          begin
            DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
               set lol.legalizado         = ''N'',
                   lol.mensaje_legalizado = SBOBSERVACION
              where lol.order_id = NuOrder_Ir');
            --commit;
          end;
        END IF;
      END IF;
      --FIN CA 200-2404
    
      --146
      dbms_output.put_line('Paso 5 sbAplica146: ' || sbAplica146);
      if (sbAplica146 = 'S' and
         (sbTitrIncons is not null or sbInconsPadr = 'S') and
         nuControlErrorActividad = 0) then
        --482 se valida que no haya error para generar la ot de validacion
        rollback;
        if sbInconsPadr = 'S' then
          sbTitrIncons := 'Inconsistencias en la orden padre titr ' ||
                          nuTaskTypeId || '.' || sbTitrIncons;
        end if;
        nuControlErrorActividad := 1;
        DBMS_OUTPUT.put_line('LDC_PKGVALGA.PRCRORVAL(NuOrder_Ir,sbTitrIncons, sbmessageerr, nuOtGarantia)');
        if sbmessageerr is not null then
          DBMS_OUTPUT.put_line('update ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
                     set lol.legalizado         = ''N'',
                       lol.mensaje_legalizado = ''Error al intentar crear la orden de validacion '' || sbmessageerr
                   where lol.order_id = NuOrder_Ir');
          --commit;
        else
          DBMS_OUTPUT.put_line('update ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
                     set lol.legalizado         = ''N'',
                       lol.mensaje_legalizado = ''En proceso de validacion de garantias, se ha generado la orden #['' || nuOtGarantia ||'']''
                   where lol.order_id = NuOrder_Ir');
          --commit;
        end if;
      
      end if;
    
      if (sbAplica672 = 'S' and
         (sbTitrIncons is not null or sbInconsPadr = 'S')) then
        rollback;
        if sbInconsPadr = 'S' then
          sbTitrIncons := 'Inconsistencias en la orden padre titr ' ||
                          nuTaskTypeId || '.' || sbTitrIncons;
        end if;
        nuControlErrorActividad := 1;
        DBMS_OUTPUT.put_line('UPDATE ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
             SET lol.legalizado         = ''N''
                ,lol.mensaje_legalizado = ''Error : '' || sbTitrIncons
           WHERE lol.order_id = nuorder_ir');
        --COMMIT;
      end if;
      --146
      --if SBOBSERVACION is not null then
      if nuControlErrorActividad = 0 then
        DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
             set lol.legalizado = ''S'', lol.mensaje_legalizado = null
           where lol.order_id = NuOrder_Ir');
        dbms_output.put_line('ACTUALIZA ORDEN CON S');
        --commit;
      
        --CASO 200-1679
        --Actualizar la observacion retornando los caracteres especiales
        --a la observacion de la OT registrada en LEGO
        DBMS_OUTPUT.put_line('update open.or_order_comment ooa
             set ooa.ORDER_COMMENT = SBOBSERVACIONLEGO
           where ooa.ORDER_ID = NuOrder_Ir
           and ooa.LEGALIZE_COMMENT = ''Y''');
        --Commit;
        --Fin CASO 200-1679
      
      end if;
    
    else
    
      SBOBSERVACION := 'ERROR EN EL SERVICIO api_legalizeorders [' ||
                       onuErrorCode || ' - ' || osbErrorMessage || ']';
    
      rollback;
    
      begin
        DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
             set lol.legalizado         = ''N'',
                 lol.mensaje_legalizado = SBOBSERVACION
           where lol.order_id = NuOrder_Ir');
        --commit;
      end;
    
      --commit;
    
    end if;
  
    --CASO 200-1679
    --FIN CURSOR cuorder
  ELSE
    --Actualizar la observacion retornando los caracteres especiales
    --a la observacion de la OT registrada en LEGO
    DBMS_OUTPUT.put_line('update ldc_otlegalizar lol
         set lol.legalizado = ''S'', lol.mensaje_legalizado = null
       where lol.order_id = isbId');
    Commit;
  END IF;
  --CASO 200-1679

  dbms_output.put_line('FIN LDC_PKGESTIONORDENES.PrConfirmarOrden');
  --ROLLBACK;

end;
0
0
