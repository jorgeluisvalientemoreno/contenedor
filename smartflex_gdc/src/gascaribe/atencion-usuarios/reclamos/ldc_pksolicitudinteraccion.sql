create or replace PACKAGE LDC_PKSOLICITUDINTERACCION is

  TYPE tyRefCursor IS REF CURSOR;

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRGENOTLLARESPQRVER
  Descripcion    : Servicio para generar OT de llamada respuesta PQR Verbal
  Autor          : Jorge Valiente
  Fecha          : 19/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  ******************************************************************/

  PROCEDURE LDC_PRGENOTLLARESPQRVER;

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRADMORDSOLINT
  Descripcion    : Servicio para administrar Ordenes de solcitud de interaccion
  Autor          : Jorge Valiente
  Fecha          : 20/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  ******************************************************************/

  PROCEDURE LDC_PRADMORDSOLINT;

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRJOBADMORDSOLINT
  Descripcion    : Servicio JOB para administrar Ordenes de solcitud de interaccion
  Autor          : Jorge Valiente
  Fecha          : 20/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  ******************************************************************/

  PROCEDURE LDC_PRJOBADMORDSOLINT;

  FUNCTION FN_VALIDAR_SOLICITUD_ORDEN
  (
    nuSolicitud IN mo_packages.package_id%type
  )
  RETURN NUMBER;

  PROCEDURE PR_ASIGNACIONORDEN
  (
    nuOrderId                    IN OR_ORDER.ORDER_ID%TYPE,
    nuCOD_CAU_GEN_OT_CER_SOL_INT IN ld_parameter.numeric_value%type
   );

 /*****************************************************************
 Propiedad intelectual de GDC - EFIGAS (c).
 
 Unidad         : PrlegalizaOrden
 Descripcion    : Servicio para legalizar orden con el API llamado api_legalizeorders
 Autor          : Jorge Valiente
 Fecha          : 07/07/2023
 CASO           : OSF-1188
 
 Parametros              Descripcion
 ============         ===================
 
 Fecha             Autor                Modificacion
 =========       =========             ====================
 ******************************************************************/
 Procedure PrlegalizaOrden(InuOrden              IN number,
                           InuTipoTrabajo        IN number,
                           InuCausalLegalizacion IN number,
                           nuerrorcode           OUT number,
                           sbERROR               OUT varchar2);

End ldc_pksolicitudinteraccion;
/
create or replace PACKAGE BODY LDC_PKSOLICITUDINTERACCION AS

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRGENOTLLARESPQRVER
  Descripcion    : Servicio para generar OT de llamada respuesta PQR Verbal
  Autor          : Jorge Valiente
  Fecha          : 19/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  05-Abril-2017  Jorge Valiente        Caso 200-1204: Cambio de la asginacion del observacion a la nueva
                                                       orden creada por inconvnenientes con la uniion de
                                                       muchas observaciones en una sola.
  10-abril-2021  Lguillen         cambio 728 : se requiere controlar la cantidad de caracteres a la hora de legalizar
                                 el cual contiene el cursor CUCOMENTARIOS y se deber¿¿ extraer del comentario
                                 de la solicitud y de la orden una porci¿¿n para que este sea mas corto
                                 y no se presente el error el cual deja la solicitud en estado de espera
  12/08/2022     EDMLAR          OSF-444: Se modifia la logica para cuando los dias de legalizacion son iguales al
                                 al parametro-1, queda funcionando cuando los dias de legalizacion son mayor igual
                                 al parametro-1 y menor igual alpara metro-3, se elimina lo que se hacia cuando los 
                                 dias eran igual al parametro-3 
  25-11-2022     Jorge Valiente        OSF-703: * Adicion de logica relacionada a la validacion de cantidad de solicitudes ascoiadas
                                                a una interaccion con medio de recepcion asociadas definidos en el paraemtro COD_MED_REC_SOL_ASO_SOL_INT.
                                                con el fin de establecer si se debe o no generar la OT de TT 10810
                                                * Se actuliza la consulta del cursor cuOTsinlegalizar agregando a la validacion del estado de orden, el estado 12 - Anulada
  06-06-2023     Jorge Valiente        OSF-1188: * Nuevo servicio para establecer el medio de recepcion de la solicitud con el parametro MEDIO_RECEPCION_EXCLUYE_LLAMADA_RESPUESTA_PQR_VERBAL
                                                 para generar OT 12579 - ELABOR.DOC.RTA-CON DIR.                                                  

  ******************************************************************/

  PROCEDURE LDC_PRGENOTLLARESPQRVER is

    --variables
    nuorden               number;
    sbcomentario          varchar2(4000);
    nuOrderId             number := null;
    nuOrderActivityId     number := null;
    nuMotive              number := null;
    product_id            number := null;
    suscription_id        number := null;
    nuCOD_ACT_ASO_SOL_INT number;
  sbEntrega varchar2(30):= 'FNB_OL_0000728_1';
    nuSolicitud or_order_activity.package_id%type;
    nuOperatingUnit or_operating_unit.operating_unit_id%type;

    nuOrderActIdLega    or_order_activity.order_activity_id%type;
    nuPackageTypeId     mo_packages.package_type_id%type;

    sbERROR varchar2(4000) := NULL;

    --cursor
    --cursor para identificar la solicitud definida por un medio de recpcion configurado
    cursor cusolmediorecepcion(inupackage_id number) is
      select count(mp.package_id) cantidad
        from open.MO_PACKAGES mp
       where mp.package_id = inupackage_id
         and mp.RECEPTION_TYPE_ID IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_MED_REC_SOL_ASO_SOL_INT',
                                                                                         NULL),

                                                        ',')));

    rfcusolmediorecepcion cusolmediorecepcion%rowtype;

    --cursor para obtener los datos de la orden legalizada
    cursor cuorderactivity(inuorder_id number) is
      select ooa.*
        from open.or_order_activity ooa
       where ooa.order_id = inuorder_id;

    rfcuorderactivity cuorderactivity%rowtype;

    --cursor para obtener los datos de la solciitud de interaccion asociada a la solicitud de la orden legalizada
    cursor cuSolicitudInteraccion(inupackage_id number) is
      select mp.*
        from open.MO_PACKAGES mp
       where mp.TAG_NAME = 'P_INTERACCION_268'
         and mp.MOTIVE_STATUS_ID = 13
         and mp.CUST_CARE_REQUES_NUM =
             damo_packages.fsbgetcust_care_reques_num(inupackage_id, null);

    rfcuSolicitudInteraccion cuSolicitudInteraccion%rowtype;

    --cursor para obtener los datos de la solciitud de interaccion asociada a la solicitud de la orden legalizada
    cursor cuOTSolicitudInteraccion(inupackage_id number) is
      select count(ooa.order_id) cantidad
        from or_order_activity ooa, or_order oo
       where ooa.package_id = inupackage_id
         and ooa.order_id = oo.order_id
         and oo.order_status_id in (0, 5)
         and oo.task_type_id =
             dald_parameter.fnuGetNumeric_Value('COD_TIP_TRA_ASO_SOL_INT',
                                                NULL);

    rfcuOTSolicitudInteraccion cuOTSolicitudInteraccion%rowtype;

    --Cursor para identificar las solicitudes y ?rdenes que est?n relacionados con el
    --NUEVO PLUG_IN relacionados con la solicitud de interacci?n.

  -- inicio del cambio 728 si la entrega aplica se debe tener encuenta uqe los comentarios de la orden
  -- y de la solicitud tendran una cantidad limitada de caracteres de lo contrario el proceso
  --se ejecutar¿¿ con normalida para ellos se implementaria l cursor cucomentarios_2. el cucomentarios
  --permanece igual


    cursor cucomentarios_2(inupackage_id number) is
      select 'Solicitud[' || SUBSTR(mp.package_id,1,1000) || ' - ' ||
         daps_package_type.fsbgetdescription(mp.package_type_id) ||
         '] - Causal Registro [' ||
         nvl(daCC_CAUSAL.fsbgetdescription(mm.causal_id, null), '') ||
         '] - Comentario[' || mp.comment_ || ']  - Tipo Trabajo[' ||
         daor_task_type.fsbgetdescription(oo.task_type_id) ||
         '] - Causal Legalizacion [' ||
         nvl(dage_causal.Fsbgetdescription(oo.causal_id, null), '') ||
         '] - Comentario[' || (select SUBSTR(ooc.order_comment,1,1600)
                     from or_order_comment ooc
                    where ooc.order_id = oo.order_id
                      and rownum = 1) || ']' ComentarioOT
      from open.MO_PACKAGES           mp,
         open.OR_ORDER_ACTIVITY     ooa,
         open.OR_ORDER              oo,
         open.LDC_PROCEDIMIENTO_OBJ lpo,
         open.mo_motive             mm
       where mp.CUST_CARE_REQUES_NUM =
         open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                 null)
       and mp.package_id <> inupackage_id
       and mp.package_id = ooa.package_id
       and ooa.ORDER_ID = oo.order_id
       and oo.TASK_TYPE_ID = lpo.task_type_id
       and lpo.procedimiento =
         'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER'
       and lpo.activo = 'S'
       and mm.package_id = mp.package_id;

    cursor cucomentarios(inupackage_id number) is
      select 'Solicitud[' || mp.package_id || ' - ' ||
         daps_package_type.fsbgetdescription(mp.package_type_id) ||
         '] - Causal Registro [' ||
         nvl(daCC_CAUSAL.fsbgetdescription(mm.causal_id, null), '') ||
         '] - Comentario[' || mp.comment_ || ']  - Tipo Trabajo[' ||
         daor_task_type.fsbgetdescription(oo.task_type_id) ||
         '] - Causal Legalizacion [' ||
         nvl(dage_causal.Fsbgetdescription(oo.causal_id, null), '') ||
         '] - Comentario[' || (select ooc.order_comment
                     from or_order_comment ooc
                    where ooc.order_id = oo.order_id
                      and rownum = 1) || ']' ComentarioOT
      from open.MO_PACKAGES           mp,
         open.OR_ORDER_ACTIVITY     ooa,
         open.OR_ORDER              oo,
         open.LDC_PROCEDIMIENTO_OBJ lpo,
         open.mo_motive             mm
       where mp.CUST_CARE_REQUES_NUM =
         open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                 null)
       and mp.package_id <> inupackage_id
       and mp.package_id = ooa.package_id
       and ooa.ORDER_ID = oo.order_id
       and oo.TASK_TYPE_ID = lpo.task_type_id
       and lpo.procedimiento =
         'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER'
       and lpo.activo = 'S'
       and mm.package_id = mp.package_id;

   -- Fin Cambio 728


    /*select 'Solicitud[[' || mp.package_id || ' - ' ||
          daps_package_type.fsbgetdescription(mp.package_type_id) ||
          '] - Comentario[' || mp.comment_ || ']  - Orden[[' ||
          oo.order_id || '] - Comentario[' || ooa.comment_ || ']' ComentarioOT
     from open.MO_PACKAGES           mp,
          open.OR_ORDER_ACTIVITY     ooa,
          open.OR_ORDER              oo,
          open.LDC_PROCEDIMIENTO_OBJ lpo
    where mp.CUST_CARE_REQUES_NUM =
          open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                                        null)
      and mp.package_id <> inupackage_id
      and mp.package_id = ooa.package_id
      and ooa.ORDER_ID = oo.order_id
      and oo.TASK_TYPE_ID = lpo.task_type_id
      and lpo.procedimiento =
          'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER'
      and lpo.activo = 'S';*/

    rfcucomentarios cucomentarios%rowtype;

    --cursor cantidad de ordenes sin legalizar relacionadas con el nuevo servicio
    cursor cuOTsinlegalizar(inupackage_id number, inuorder_id number) is
      select count(oo.order_id) cantidadsinlegalizar
        from open.MO_PACKAGES           mp,
             open.OR_ORDER_ACTIVITY     ooa,
             open.OR_ORDER              oo,
             open.LDC_PROCEDIMIENTO_OBJ lpo
       where mp.CUST_CARE_REQUES_NUM =
             open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                                           null)
         and mp.package_id <> inupackage_id
         and mp.package_id = ooa.package_id
         and ooa.ORDER_ID = oo.order_id
         and oo.order_id <> inuorder_id
         and oo.order_status_id not in (8,12) --<> 8 OSF-703 se incluye estado diferente a 12
         and oo.TASK_TYPE_ID = lpo.task_type_id
         and lpo.procedimiento =
             'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER'
         and lpo.activo = 'S';

    rfcuOTsinlegalizar cuOTsinlegalizar%rowtype;

    nuCOD_CAU_GEN_OT_CER_SOL_INT open.ld_parameter.numeric_value%type := open.
                                                                         dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_CER_SOL_INT',
                                                                                                            null);

    nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 open.ld_parameter.numeric_value%type := open.
                                                                           dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_3',
                                                                                                              null);

    ---variables CASO 200-1204
    nuErrorCode  number;
    sbErrorMesse varchar2(4000);
    ------------------------

    ---Inicio OSF-703
    ---Cursor para estabelcer la cantidad de solicitudes asociada a la interaccion que tenga configurado en el parametro COD_MED_REC_SOL_ASO_SOL_INT
    --para pedmtir o no la generacion de la OT de TT 10810.
    
    sbCODMEDRECSOLASOSOLINT ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('COD_MED_REC_SOL_ASO_SOL_INT',NULL);
    
    cursor CuCantidadSol(inupackage_id number) is
      select count(mp.package_id) cantidad
              from open.MO_PACKAGES mp
             where mp.cust_care_reques_num = damo_packages.fsbgetcust_care_reques_num(inupackage_id, null)
             and mp.package_id <> to_number(damo_packages.fsbgetcust_care_reques_num(inupackage_id, null))
               and mp.RECEPTION_TYPE_ID IN
                   (SELECT to_number(regexp_substr(sbCODMEDRECSOLASOSOLINT, '[^,]+', 1, LEVEL))
                      FROM dual
                    CONNECT BY regexp_substr(sbCODMEDRECSOLASOSOLINT, '[^,]+', 1, LEVEL) IS NOT NULL);        
    nuCuCantidadSol number;
    ---Fin OSF-703

    ---Inicio OSF-1188
    nuMedioRecepcionSolicitud  open.mo_packages.reception_type_id%type;
    sbMedioRecepcionParametro  varchar2(4000);
    nuActividadOT         number;
    nuCOD_CAU_GEN_OT_SOL_INT   open.ld_parameter.numeric_value%type;    
    cursor cuMedioRecepcion (InuMedioRecepcionSolicitud open.mo_packages.reception_type_id%type, IsbMedioRecepcionParametro open.ld_parameter.value_chain%type) is    
    SELECT COUNT(1)              
              FROM (SELECT to_number(regexp_substr(IsbMedioRecepcionParametro,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS MedioRecepcion
                      FROM dual
                    CONNECT BY regexp_substr(IsbMedioRecepcionParametro, '[^,]+', 1, LEVEL) IS NOT NULL)
             WHERE MedioRecepcion = InuMedioRecepcionSolicitud;
    nuExiste number :=0;
    
    ---Fin OSF-1188

  BEGIN

    ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER',
                   10);

    ut_trace.trace('**********Valor parametro nuCOD_CAU_GEN_OT_CER_SOL_INT [' ||
                   nuCOD_CAU_GEN_OT_CER_SOL_INT || ']',
                   10);

    if nvl(nuCOD_CAU_GEN_OT_CER_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro nuCOD_CAU_GEN_OT_CER_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    ut_trace.trace('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3 [' ||
                   nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 || ']',
                   10);

    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_3, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('*****Numero de la Orden a legalizar [' || nuorden || ']',
                   10);
    ut_trace.trace('*****Causal legalizacion [' ||
                   open.daor_order.fnugetcausal_id(nuorden) || ']',
                   10);
    ut_trace.trace('*****Estado Orden [' ||
                   open.daor_order.fnugetorder_status_id(nuorden) || ']',
                   10);
    ut_trace.trace('*****Fecha legalizacion [' ||
                   open.daor_order.fdtgetlegalization_date(nuorden) || ']',
                   10);

    --cursor para obtener los datos de la orden legalizada

    open cuorderactivity(nuorden);
    fetch cuorderactivity
      into rfcuorderactivity;


    if cuorderactivity%found then
      ut_trace.trace('**********Solicitud [' ||
                     rfcuorderactivity.package_id || ']',
                     10);
      --cursor para identificar la solicitud definida por un medio de recpcion configurado

      open cusolmediorecepcion(rfcuorderactivity.package_id);
      fetch cusolmediorecepcion
        into rfcusolmediorecepcion;

      if cusolmediorecepcion%found then

         ut_trace.trace('***************Cantidad para determinar si la solciitud tiene medio de recepcion definido en el parametro COD_MED_REC_SOL_ASO_SOL_INT [' || rfcusolmediorecepcion.cantidad || ']', 10);          
         ---Inicio OSF-703
         if rfcusolmediorecepcion.cantidad = 0 then
          open CuCantidadSol(rfcuorderactivity.package_id);
          fetch CuCantidadSol into nuCuCantidadSol;
          close CuCantidadSol;
          ut_trace.trace('***************Cantidad de solicitudes asociada a la interacccion con medio de recpccion en el parametro COD_MED_REC_SOL_ASO_SOL_INT [' || nuCuCantidadSol || '] en al interaccion', 10);          
         else
           nuCuCantidadSol := rfcusolmediorecepcion.cantidad;
         end if;

         --Fin OSF-703

        --if rfcusolmediorecepcion.cantidad > 0 then        
        ut_trace.trace('***************if nuCuCantidadSol['|| nuCuCantidadSol ||'] > 0', 10);          
        if nuCuCantidadSol > 0 then         
          --cursor para obtener los datos de la solciitud de interaccion asociada a la solicitud de la orden legalizada

          open cuSolicitudInteraccion(rfcuorderactivity.package_id);
          fetch cuSolicitudInteraccion
            into rfcuSolicitudInteraccion;

          if cuSolicitudInteraccion%found then
            ut_trace.trace('***************Solicitud Interaccion [' ||
                           rfcuSolicitudInteraccion.Package_Id || ']',
                           10);
            --cursor para obtener los datos de la solciitud de interaccion asociada a la solicitud de la orden legalizada

            open cuOTSolicitudInteraccion(rfcuorderactivity.package_id);
            fetch cuOTSolicitudInteraccion
              into rfcuOTSolicitudInteraccion;

            if cuOTSolicitudInteraccion%found then
              ut_trace.trace('***************Cantidad de ordenes asociadas a Solcitud de Interaccion [' ||
                             rfcuOTSolicitudInteraccion.Cantidad || ']',
                             10);
              --valida si la cantidad de ciertas ordenes existentes permiten crear una nueva
              if nvl(rfcuOTSolicitudInteraccion.Cantidad, 0) = 0 then

                --inicializa datos para la observacion de la nueva orden
                sbcomentario := null;
                /*Comentariado por el CASO 200-2104
                para ser ubicado despues de la creacion de las observaciones en la tabal OR_ORDER_COMMENT
                y poder manejar todas las observaciones de diferenstes ordenes y solicitudes
                for rfcucomentarios in cucomentarios(rfcuSolicitudInteraccion.Package_Id) loop
                  sbcomentario := sbcomentario || chr(13) ||
                                  rfcucomentarios.comentarioot;

                end loop;
                ut_trace.trace('***************Comentario [' ||
                               sbcomentario || ']',
                               10);
                --*/

                --incia proceso de creacion de nueva orden
                nuOrderId             := null;
                nuOrderActivityId     := null;
                nuMotive              := mo_bopackages.fnuGetInitialMotive(rfcuSolicitudInteraccion.Package_Id);
                product_id            := mo_bomotive.fnugetproductid(nuMotive);
                suscription_id        := mo_bomotive.fnugetsubscription(nuMotive);
                nuCOD_ACT_ASO_SOL_INT := open.
                                         dald_parameter.fnuGetNumeric_Value('COD_ACT_LLRPQRV_ASO_SOL_INT',
                                                                            null);
                if nvl(nuCOD_ACT_ASO_SOL_INT, 0) = 0 then
                  sbERROR := 'Dato no valido en el parametro COD_ACT_LLRPQRV_ASO_SOL_INT';
                  RAISE ex.CONTROLLED_ERROR;
                end if;

                open cuOTsinlegalizar(rfcuSolicitudInteraccion.Package_Id,
                                      nuorden);
                fetch cuOTsinlegalizar
                  into rfcuOTsinlegalizar;

                if cuOTsinlegalizar%found then
                  if rfcuOTsinlegalizar.Cantidadsinlegalizar = 0 then
                    ut_trace.trace('***************Cantidad Sin legalizar [' ||
                                   rfcuOTsinlegalizar.Cantidadsinlegalizar || ']',
                                   10);

                    -- Antes de crear la orden, se valida que el tipo de dolicitud no est¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿ en el par¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿metro PACKAGES_COMUSR
                    if nvl(instr(dald_parameter.fsbGetValue_Chain('PACKAGES_COMUSR'),
                          damo_packages.fnugetpackage_type_id(rfcuorderactivity.Package_Id,0)), 0) = 0 then


                         --Inicio OSF-1188
                        ut_trace.trace('Inicio - Logica OSF-1188', 10);                        
                        sbMedioRecepcionParametro := pkg_parametros.fsbGetValorCadena('MEDIO_RECEPCION_EXCLUYE_LLAMADA_RESPUESTA_PQR_VERBAL');
                        ut_trace.trace('sbMedioRecepcionParametro: '|| sbMedioRecepcionParametro, 15);                        
                        nuMedioRecepcionSolicitud := personalizaciones.ldc_bcConsGenerales.fsbValorColumna('OPEN.MO_PACKAGES','reception_type_id','package_id',rfcuorderactivity.package_id);
                        ut_trace.trace('Solicitud: '|| rfcuorderactivity.package_id || ' - nuMedioRecepcionSolicitud: '|| nuMedioRecepcionSolicitud, 15);                        
                        ut_trace.trace('nuCOD_CAU_GEN_OT_SOL_INT: '|| nuCOD_CAU_GEN_OT_SOL_INT, 15);                        
                        open cuMedioRecepcion(nuMedioRecepcionSolicitud, sbMedioRecepcionParametro);
                        fetch cuMedioRecepcion into nuExiste;
                        close cuMedioRecepcion;
                        ut_trace.trace('nuExiste: '|| nuExiste, 15);
                        --Valida si existe el medio de recpecion en el parametro no generar la OT 10810 sino la OT 12579. como solicito el funcional 
                        --Jhonny Escandon para tipo de solicitud con medio de recepcion 43 - Chat
                        ut_trace.trace('nuCOD_ACT_ASO_SOL_INT: '|| nuCOD_ACT_ASO_SOL_INT, 15);
                        if nuExiste = 1 then
                          
                          nuActividadOT := pkg_parametros.fnuGetValorNumerico('ACTIVIDAD_ELABORA_DOCUMENTO_RESPUESTA_CON_DIRECCION');
                          nuCOD_ACT_ASO_SOL_INT := nuActividadOT;
                          ut_trace.trace('ACTIVIDAD_ELABORA_DOCUMENTO_RESPUESTA_CON_DIRECCION: '|| nuCOD_ACT_ASO_SOL_INT, 15);

                        end if;                        
                        ut_trace.trace('Fin - Logica OSF-1188', 10);                        
                        --Fin OSF-1188

                        or_boorderactivities.CreateActivity(nuCOD_ACT_ASO_SOL_INT,
                                                            rfcuSolicitudInteraccion.Package_Id,
                                                            nuMotive,
                                                            null,
                                                            null,
                                                            rfcuSolicitudInteraccion.Address_Id,
                                                            null,
                                                            null,
                                                            suscription_id,
                                                            product_id,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            sbcomentario,
                                                            null,
                                                            null,
                                                            nuOrderId,
                                                            nuOrderActivityId,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null);

                        ut_trace.trace('Se creo la orden[' || nuOrderId ||
                                       '] - Codigo Actiivdad[' ||
                                       nuOrderActivityId || ']',
                                       10);

                        sbcomentario := null;
                        --/*CASO 200-2104
                        --asignacion de comentarios de diferentes ordenes a la nueva orden generada
            -- INICIO DEL CAMBIO 728 , Si la entrega aplica usara el cursor cucomentarios_2
            --el cual corta  los comentarios de la solicitud y de la orden para evitar el error de exceder el numero del cursor

            IF fblaplicaentrega(sbEntrega) THEN
              for rfcucomentarios in cucomentarios_2(rfcuSolicitudInteraccion.Package_Id) loop
                OS_ADDORDERCOMMENT(nuOrderId,
                         3,
                         SUBSTR(rfcucomentarios.comentarioot,
                            1,
                            1900),
                         nuErrorCode,
                         sbErrorMesse);
              end loop;

              nuSolicitud := daor_order_activity.fnugetpackage_id(nuOrderActivityId,0);

              ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.FN_VALIDAR_SOLICITUD_ORDEN, solicitud '|| nuSolicitud, 10);

            else
              for rfcucomentarios in cucomentarios(rfcuSolicitudInteraccion.Package_Id) loop
                OS_ADDORDERCOMMENT(nuOrderId,
                         3,
                         SUBSTR(rfcucomentarios.comentarioot,
                            1,
                            1900),
                         nuErrorCode,
                         sbErrorMesse);
              end loop;

              nuSolicitud := daor_order_activity.fnugetpackage_id(nuOrderActivityId,0);

              ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.FN_VALIDAR_SOLICITUD_ORDEN, solicitud '|| nuSolicitud, 10);

            END IF;
                        -- FIN DEL CAMBIO 728

            IF LDC_PKSOLICITUDINTERACCION.FN_VALIDAR_SOLICITUD_ORDEN(nuSolicitud) = 1 THEN

                            -- Se obtiene la unidad de trabajo para poderla asignar
                            ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.PR_ASIGNACIONORDEN', 10);

                            ut_trace.trace('Orden '||nuOrderId, 10);

                            ut_trace.trace('nuCOD_CAU_GEN_OT_CER_SOL_INT '||nuCOD_CAU_GEN_OT_CER_SOL_INT, 10);
                            
                            ut_trace.trace('nuExiste [' || nuExiste || ']',10);

                            ---Valida con la variable nuExiste si la orden generada fue mediante la logica del OSF-1188 
                            --no debe ser atendida de forma inmediata
                            if nuExiste = 0 then

                               LDC_PKSOLICITUDINTERACCION.PR_ASIGNACIONORDEN(nuOrderId, nuCOD_CAU_GEN_OT_CER_SOL_INT);
                               
                            End if;

                            ut_trace.trace('FIN LDC_PKSOLICITUDINTERACCION.PR_ASIGNACIONORDEN', 10);

                        END IF;

                        --*/

                        --la orden creada necera cerrada si tiempo de gesti?n de notificaci?n ya ha expirado
                        /*
                        if round(sysdate -
                                 damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id,
                                                                  null)) >
                           nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
                        --*/

                        ut_trace.trace('*****************Dias de habiles round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(' ||
                                       open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id) || ',' ||
                                       SYSDATE || '),0) [' ||
                                       round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id),
                                                                                        SYSDATE),
                                             0) || ']',
                                       10);

                        if round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id),
                                                                            SYSDATE),
                                 0) > nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then

                          --cerrar la orden identificada por el JOB
                          BEGIN
                            update or_order oo
                               set oo.assigned_date     = sysdate,
                                   oo.legalization_date = sysdate,
                                   oo.order_status_id   = 8,
                                   oo.causal_id         = nuCOD_CAU_GEN_OT_CER_SOL_INT
                            --oo.operating_unit_id = nvl(NUOPERATING_UNIT_ID, 1886),
                             where oo.order_id = nuOrderId;

                            update or_order_activity ooa
                               set ooa.status = 'F'
                             where ooa.order_id = nuOrderId
                               and ooa.product_id = product_id;
                          end;

                        end if;
                    end if;
                  else
                    ut_trace.trace('***************Cantidad Sin legalizar [' ||
                                   rfcuOTsinlegalizar.Cantidadsinlegalizar || ']',
                                   10);
                  end if;
                end if;
                close cuOTsinlegalizar;
              end if;
            end if;
            close cuOTSolicitudInteraccion;
          end if;
          close cuSolicitudInteraccion;
        end if;
      end if;
      close cusolmediorecepcion;
    end if;
    close cuorderactivity;

    ut_trace.trace('FIN LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER',
                   10);

    --RAISE ex.CONTROLLED_ERROR;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      if sbERROR is null then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER');
      else
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         sbERROR);
      end if;
    when OTHERS then
      rollback;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER');

  END LDC_PRGENOTLLARESPQRVER;

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRADMORDSOLINT
  Descripcion    : Servicio para administrar Ordenes de solcitud de interaccion
  Autor          : Jorge Valiente
  Fecha          : 20/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  02/01/2023    Jorge Valiente          CASO OSF-711: Se modifico el cursor CUCOMENTARIOS y retirando 
                                                      la condición de ROWNUM sea igual a 1 y que solo agregue comentarios 
                                                      que no sean definidos en la legalización (and legalize_comment = 'N').
  ******************************************************************/

  PROCEDURE LDC_PRADMORDSOLINT is

    --variables
    nuorden                        number;
    nuClasCausal                   number;
    nuCOD_CAU_GEN_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCOD_CAU_CER_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCOD_CAU_REG_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 open.ld_parameter.numeric_value%type;

    sbcomentario                varchar2(4000);
    nuOrderId                   number := null;
    nuOrderActivityId           number := null;
    nuMotive                    number := null;
    product_id                  number := null;
    suscription_id              number := null;
    nuCOD_ACT_EDRCD_ASO_SOL_INT number;
    nuCOD_ACT_ASO_SOL_INT       number;

    sbERROR varchar2(4000) := NULL;

    --cursor
    --cursor permitir? obtener datos de la orden legalizada.
    cursor cuorderactivity(inuorder_id number) is
      select ooa.*
        from open.or_order_activity ooa
       where ooa.order_id = inuorder_id;

    rfcuorderactivity cuorderactivity%rowtype;

    --cursor para comparar dato numerio si existe en paremtro tipo dato cadena
    cursor cuexistedanudaca(inudato number, isbdato varchar2) is
      select count(1) cantidad
        from dual
       where inudato IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(isbdato, ',')));

    rfcuexistedanudaca cuexistedanudaca%rowtype;

    --cursor para obtener el comentario de la 1ra orde 10810 generada por el PLUGIN
    cursor cucomnetario(inusolicitud number) is
      select ooa.order_id orden, ooa.comment_ commentario
        from or_order_activity ooa
       where ooa.task_type_id = nvl(dald_parameter.fnuGetNumeric_Value('COD_TIP_TRA_ASO_SOL_INT',
                                                                       NULL),
                                    0)
         and ooa.package_id = inusolicitud
         and rownum = 1
       order by ooa.order_id;

  --TICKET 200-1329 LJLB -- se consultan comentarios de las ordenes 10810
    CURSOR cucomentarios IS
    select *
    from(SELECT ORDER_COMMENT comentarioot
    FROM open.or_order_comment
    WHERE  order_id = nuorden
    and legalize_comment = 'N'
    order by ORDER_COMMENT_ID asc);
    --where rownum = 1; OSF-711

    rfcucomnetario cucomnetario%rowtype;
    nuerrorcode number;

  BEGIN

    ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.LDC_PRADMORDSOLINT',
                   10);

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('*****Numero de la Orden a legalizar [' || nuorden || ']',
                   10);
    ut_trace.trace('*****Causal legalizacion [' ||
                   open.daor_order.fnugetcausal_id(nuorden) || ']',
                   10);
    nuClasCausal := open. dage_causal.fnugetclass_causal_id(open.daor_order.fnugetcausal_id(nuorden),
                                                            null);
    ut_trace.trace('*****Clasificador Causal legalizacion [' ||
                   nuClasCausal || ']',
                   10);
    ut_trace.trace('*****Estado Orden [' ||
                   open.daor_order.fnugetorder_status_id(nuorden) || ']',
                   10);
    ut_trace.trace('*****Fecha legalizacion [' ||
                   open.daor_order.fdtgetlegalization_date(nuorden) || ']',
                   10);

    --paremtro de causal para generar orden 12579
    nuCOD_CAU_GEN_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_SOL_INT',
                                                                        null);

    ut_trace.trace('**********Valor parametro COD_CAU_GEN_OT_SOL_INT [' ||
                   nuCOD_CAU_GEN_OT_SOL_INT || ']',
                   10);

    if nvl(nuCOD_CAU_GEN_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_GEN_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    --parametro de causal para cerrar de forma automatica la orden y solicitud
    nuCOD_CAU_CER_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_CER_OT_SOL_INT',
                                                                        null);

    ut_trace.trace('**********Valor parametro COD_CAU_CER_OT_SOL_INT [' ||
                   nuCOD_CAU_CER_OT_SOL_INT || ']',
                   10);

    if nvl(nuCOD_CAU_CER_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_CER_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    --parametro de causal para regenerar orden 10810
    nuCOD_CAU_REG_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_REG_OT_SOL_INT',
                                                                        null);

    ut_trace.trace('**********Valor parametro COD_CAU_REG_OT_SOL_INT [' ||
                   nuCOD_CAU_REG_OT_SOL_INT || ']',
                   10);

    if nvl(nuCOD_CAU_REG_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_REG_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_1',
                                                                              null);

    ut_trace.trace('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1 [' ||
                   nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 || ']',
                   10);

    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_1, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    /*
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_2',
                                                                              null);
    ut_trace.trace('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2 [' ||
                   nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 || ']',
                   10);

    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_2, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2';
      RAISE ex.CONTROLLED_ERROR;
    end if;

    nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_3',
                                                                              null);
    --

    ut_trace.trace('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3 [' ||
                   nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 || ']',
                   10);

    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_3, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3';
      RAISE ex.CONTROLLED_ERROR;
    end if;
    --*/

    if nvl(nuClasCausal, 0) = 2 then

      --cursor permitir? obtener datos de la orden legalizada.
      open cuorderactivity(nuorden);
      fetch cuorderactivity
        into rfcuorderactivity;
      close cuorderactivity;

      --Por configuracion de OSF y funcionalidad del la causal 3524
      --se coloca el comentario todo el codigo que se encarga de crear
      --la OT 12759
      --TICKET 200-1329 LJLB -- se habilita logica para que la orden 12759 se cree por plugin
      --logica para crear orden 12579 elaborar carta con direcci?n
      ut_trace.trace('********************Causal legalizacion  [' ||
                     open.daor_order.fnugetcausal_id(nuorden) || ']',
                     10);
      ut_trace.trace('********************Causal Parametro  [' ||
                     nuCOD_CAU_GEN_OT_SOL_INT || ']',
                     10);
      open cuexistedanudaca(open.daor_order.fnugetcausal_id(nuorden),
                            nuCOD_CAU_GEN_OT_SOL_INT);
      fetch cuexistedanudaca
        into rfcuexistedanudaca;

      ut_trace.trace('***************rfcuexistedanudaca.cantidad [' ||
                     rfcuexistedanudaca.cantidad || ']',
                     10);

      if cuexistedanudaca%found then

        if rfcuexistedanudaca.cantidad > 0 then

          ut_trace.trace('***************sysdate [' || sysdate || '] -
               open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id)[' ||
                         open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id) || ']',
                         10);

          ut_trace.trace('***************Dias de diferencia round(sysdate -
               open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id),
               0) [' ||
                         round(sysdate -
                               open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id),
                               0) || ']',
                         10);

          if round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id),
                                                              SYSDATE),
                   0) <= nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 then

            ut_trace.trace('********************Causal legalizacion  [' ||
                           open.daor_order.fnugetcausal_id(nuorden) || ']',
                           10);
            ut_trace.trace('********************Causal Parametro  [' ||
                           nuCOD_CAU_GEN_OT_SOL_INT || ']',
                           10);

            --incia proceso de creacion de nueva orden
            nuOrderId                   := null;
            nuOrderActivityId           := null;
            nuMotive                    := mo_bopackages.fnuGetInitialMotive(rfcuorderactivity.Package_Id);
            product_id                  := mo_bomotive.fnugetproductid(nuMotive);
            suscription_id              := mo_bomotive.fnugetsubscription(nuMotive);
            sbcomentario                := 'Orden generada de la legalizacion de la orden ' ||
                                           nuorden;
            nuCOD_ACT_EDRCD_ASO_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_ACT_EDRCD_ASO_SOL_INT',
                                                                                   null);

            if nvl(nuCOD_ACT_EDRCD_ASO_SOL_INT, 0) = 0 then
              sbERROR := 'Dato no valido en el parametro COD_ACT_EDRCD_ASO_SOL_INT';
              RAISE ex.CONTROLLED_ERROR;
            end if;

            or_boorderactivities.CreateActivity(nuCOD_ACT_EDRCD_ASO_SOL_INT,
                                                rfcuorderactivity.Package_Id,
                                                nuMotive,
                                                null,
                                                null,
                                                rfcuorderactivity.Address_Id,
                                                null,
                                                null,
                                                suscription_id,
                                                product_id,
                                                null,
                                                null,
                                                null,
                                                null,
                                                sbcomentario,
                                                null,
                                                null,
                                                nuOrderId,
                                                nuOrderActivityId,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null);

            ut_trace.trace('Se creo la orden[' || nuOrderId ||
                           '] - Codigo Actiivdad[' || nuOrderActivityId || ']',
                           10);

             --TICKET 200 1329 LJLB -- asignacion de comentarios de diferentes ordenes a la nueva orden generada
          FOR rfcucomentarios IN cucomentarios LOOP
            os_addordercomment(nuOrderId,
                               3,
                               substr(rfcucomentarios.comentarioot,
                                      1,
                                      1900),
                               nuerrorcode,
                               sbERROR);
            IF nuerrorcode <> 0 THEN
                RAISE ex.CONTROLLED_ERROR;
            END IF;
          END LOOP;

          end if;
        end if;
      end if;
      close cuexistedanudaca;
      --*/

      --Inicio validar otras causales
      --validar si la causal genera cierre automatico de orden y solciitud de interaccion
      ut_trace.trace('********************Causal legalizacion  [' ||
                     open.daor_order.fnugetcausal_id(nuorden) || ']',
                     10);
      ut_trace.trace('********************Causal Parametro  [' ||
                     nuCOD_CAU_CER_OT_SOL_INT || ']',
                     10);

      open cuexistedanudaca(open.daor_order.fnugetcausal_id(nuorden),
                            nuCOD_CAU_CER_OT_SOL_INT);
      fetch cuexistedanudaca
        into rfcuexistedanudaca;

      ut_trace.trace('***************Cantidad [' ||
                     rfcuexistedanudaca.cantidad || ']',
                     10);

      if cuexistedanudaca%found then
        if rfcuexistedanudaca.cantidad > 0 then
          ut_trace.trace('***************Cierre automatico OT [' ||
                         nuorden || '] y Solcitud [' ||
                         rfcuorderactivity.package_id || ']',
                         10);

          --Incio atender la solicitud de suspension de RP
          begin
            update mo_packages mp
               set mp.motive_status_id = 14, mp.attention_date = sysdate
             where mp.package_id = rfcuorderactivity.package_id;

            update mo_motive mm
               set mm.attention_date = sysdate, mm.motive_status_id = 11
             where mm.package_id = rfcuorderactivity.package_id;
          end;
          --Fin atender la solicitud de suspension de RP
        end if;
      end if;
      close cuexistedanudaca;

      --validar si la causal permite regenerear la orden 10810
      ut_trace.trace('********************Causal legalizacion  [' ||
                     open.daor_order.fnugetcausal_id(nuorden) || ']',
                     10);
      ut_trace.trace('********************Causal Parametro  [' ||
                     nuCOD_CAU_REG_OT_SOL_INT || ']',
                     10);
      open cuexistedanudaca(open.daor_order.fnugetcausal_id(nuorden),
                            nuCOD_CAU_REG_OT_SOL_INT);
      fetch cuexistedanudaca
        into rfcuexistedanudaca;

      ut_trace.trace('***************rfcuexistedanudaca.cantidad [' ||
                     rfcuexistedanudaca.cantidad || ']',
                     10);

      if cuexistedanudaca%found then
        if rfcuexistedanudaca.cantidad > 0 then
          --incia proceso de regenerar orden 10810
          nuOrderId             := null;
          nuOrderActivityId     := null;
          nuMotive              := mo_bopackages.fnuGetInitialMotive(rfcuorderactivity.Package_Id);
          product_id            := mo_bomotive.fnugetproductid(nuMotive);
          suscription_id        := mo_bomotive.fnugetsubscription(nuMotive);
          sbcomentario          := 'Orden regenerada de la legalizacion de la orden ' ||
                                   nuorden;
          nuCOD_ACT_ASO_SOL_INT := open.
                                   dald_parameter.fnuGetNumeric_Value('COD_ACT_LLRPQRV_ASO_SOL_INT',
                                                                      null);
          if nvl(nuCOD_ACT_ASO_SOL_INT, 0) = 0 then
            sbERROR := 'Dato no valido en el parametro COD_ACT_LLRPQRV_ASO_SOL_INT';
            RAISE ex.CONTROLLED_ERROR;
          end if;

          open cucomnetario(rfcuorderactivity.Package_Id);
          fetch cucomnetario
            into rfcucomnetario;
          if cucomnetario%found then
            sbcomentario := rfcucomnetario.commentario;
          end if;
          close cucomnetario;

          ut_trace.trace('***************Comentario de 1ra orden 10810 [' ||
                         sbcomentario || ']',
                         10);

          or_boorderactivities.CreateActivity(nuCOD_ACT_ASO_SOL_INT,
                                              rfcuorderactivity.Package_Id,
                                              nuMotive,
                                              null,
                                              null,
                                              rfcuorderactivity.Address_Id,
                                              null,
                                              null,
                                              suscription_id,
                                              product_id,
                                              null,
                                              null,
                                              null,
                                              null,
                                              sbcomentario,
                                              null,
                                              null,
                                              nuOrderId,
                                              nuOrderActivityId,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null);

          ut_trace.trace('Se regenero la orden[' || nuOrderId ||
                         '] - Codigo Actiivdad[' || nuOrderActivityId || ']',
                         10);

         --TICKET 200 1329 LJLB -- asignacion de comentarios de diferentes ordenes a la nueva orden generada
          FOR rfcucomentarios IN cucomentarios LOOP
            os_addordercomment(nuOrderId,
                               3,
                               substr(rfcucomentarios.comentarioot,
                                      1,
                                      1900),
                               nuerrorcode,
                               sbERROR);
            IF nuerrorcode <> 0 THEN
                RAISE ex.CONTROLLED_ERROR;
            END IF;
          END LOOP;

        end if;
      end if;
      close cuexistedanudaca;

      --Fin validar otras causales

    elsif nvl(nuClasCausal, 0) = 1 then

      --cursor permitir? obtener datos de la orden legalizada.
      open cuorderactivity(nuorden);
      fetch cuorderactivity
        into rfcuorderactivity;
      close cuorderactivity;
      ut_trace.trace('**********Atender la solicitud [' ||
                     rfcuorderactivity.package_id || ']',
                     10);

      --Incio atender la solicitud de suspension de RP
      begin
        update mo_packages mp
           set mp.motive_status_id = 14, mp.attention_date = sysdate
         where mp.package_id = rfcuorderactivity.package_id;

        update mo_motive mm
           set mm.attention_date = sysdate, mm.motive_status_id = 11
         where mm.package_id = rfcuorderactivity.package_id;
      end;
      --Fin atender la solicitud de suspension de RP
    elsif nvl(nuClasCausal, 0) = 0 then
      sbERROR := 'La causal de legalizacion [' ||
                 open.daor_order.fnugetcausal_id(nuorden) ||
                 '] no es de EXITO ni de FALLO';
      --RAISE ex.CONTROLLED_ERROR;
    end if;

    ut_trace.trace('FIN LDC_PKSOLICITUDINTERACCION.LDC_PRADMORDSOLINT', 10);

    --RAISE ex.CONTROLLED_ERROR;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      if sbERROR is null then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRADMORDSOLINT');
      else
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         sbERROR);
      end if;
    when OTHERS then
      rollback;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRADMORDSOLINT');

  END LDC_PRADMORDSOLINT;

  /*****************************************************************
  Propiedad intelectual de GDC - EFIGAS (c).

  Unidad         : LDC_PRJOBADMORDSOLINT
  Descripcion    : Servicio JOB para administrar Ordenes de solcitud de interaccion
  Autor          : Jorge Valiente
  Fecha          : 20/01/2017
  CASO           : 200-982

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  06/06/2023    Jorge Valiente          CASO OSF-1188: Agregar signo = para estabelcer dias iguales a los configurasdos en el parametro nuCAN_DIA_VAL_ACT_EN_SOL_INT_3
                                                       Lagelazicon de orden mediante el nuevo API llamado api_legalizeorders
  ******************************************************************/

  PROCEDURE LDC_PRJOBADMORDSOLINT is

    --variables
    nuorden                        number;
    nuClasCausal                   number;
    nuCOD_CAU_GEN_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCOD_CAU_CER_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCOD_CAU_REG_OT_SOL_INT       open.ld_parameter.numeric_value%type;
    nuCOD_CAU_GEN_OT_CER_SOL_INT   open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 open.ld_parameter.numeric_value%type;
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 open.ld_parameter.numeric_value%type;

    sbcomentario                varchar2(4000);
    nuOrderId                   number := null;
    nuOrderActivityId           number := null;
    nuMotive                    number := null;
    product_id                  number := null;
    suscription_id              number := null;
    nuCOD_ACT_EDRCD_ASO_SOL_INT number;
    nuCOD_ACT_ASO_SOL_INT       number;

    sbERROR varchar2(4000) := NULL;

    nuCantDias number := null;

    --cursor
    --cursor permitir? obtener datos de la orden legalizada.
    cursor cuorder is
      select oo.task_type_id tipo_trabajo,
             oo.order_id     orden,
             ooa.package_id  Solicitud
        from open.or_order oo, open.or_order_activity ooa
       where oo.order_status_id in (0, 5)
         and oo.task_type_id =
             dald_parameter.fnuGetNumeric_Value('COD_TIP_TRA_ASO_SOL_INT',
                                                NULL)
         and oo.order_id = ooa.order_id;

    rfcuorder cuorder%rowtype;

    --cursor permitir? obtener datos de la orden legalizada.
    cursor cuorderactivity(inuorder_id number) is
      select ooa.*
        from open.or_order_activity ooa
       where ooa.order_id = inuorder_id;

    rfcuorderactivity cuorderactivity%rowtype;

    --cursor permitir? obtener datos de la orden legalizada.
    cursor cuSolicitudPLUGIN(inupackage_id number) is
      select ooa.*
        from open.MO_PACKAGES           mp,
             open.OR_ORDER_ACTIVITY     ooa,
             open.OR_ORDER              oo,
             open.LDC_PROCEDIMIENTO_OBJ lpo
       where mp.CUST_CARE_REQUES_NUM =
             open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                                           null)
         and mp.package_id <> inupackage_id
         and mp.package_id = ooa.package_id
         and ooa.ORDER_ID = oo.order_id
         and oo.TASK_TYPE_ID = lpo.task_type_id
         and lpo.procedimiento =
             'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER';
    --and lpo.activo = 'S';

    rfcuSolicitudPLUGIN cuSolicitudPLUGIN%rowtype;

    --cursor para comparar dato numerio si existe en paremtro tipo dato cadena
    cursor cuexistedanudaca(inudato number, isbdato varchar2) is
      select count(1) cantidad
        from dual
       where inudato IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(isbdato, ',')));

    rfcuexistedanudaca cuexistedanudaca%rowtype;
    --TICKET 200-1329 LJLB -- se consultan comentarios de las ordenes 10810
    CURSOR cucomentarios IS
    select *
    from(SELECT ORDER_COMMENT comentarioot
    FROM open.or_order_comment
    WHERE  order_id = nuorden
    order by ORDER_COMMENT_ID asc)
    where rownum = 1;


    nuerrorcode number;  --TICKET 200-1329 LJLB -- se almacena codigo de error

  BEGIN

    dbms_output.put_line('INICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');

    for rfcuorder in cuorder loop

      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden := rfcuorder.orden;
      dbms_output.put_line('*****Numero de la Orden a legalizar [' ||
                           nuorden || ']');

      --paremtro de causal para cerrar la OT 10810 y generar orden 12579
      nuCOD_CAU_GEN_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_SOL_INT',
                                                                          null);

      dbms_output.put_line('**********Valor parametro COD_CAU_GEN_OT_SOL_INT [' ||
                           nuCOD_CAU_GEN_OT_SOL_INT || ']');

      if nvl(nuCOD_CAU_GEN_OT_SOL_INT, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro COD_CAU_GEN_OT_SOL_INT';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      --parametro de causal para cerrar de forma automatica la orden y solicitud
      nuCOD_CAU_CER_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_CER_OT_SOL_INT',
                                                                          null);

      dbms_output.put_line('**********Valor parametro COD_CAU_CER_OT_SOL_INT [' ||
                           nuCOD_CAU_CER_OT_SOL_INT || ']');

      if nvl(nuCOD_CAU_CER_OT_SOL_INT, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro COD_CAU_CER_OT_SOL_INT';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      --parametro de causal para cerrar de forma automatica la orden y solicitud
      nuCOD_CAU_REG_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_REG_OT_SOL_INT',
                                                                          null);

      dbms_output.put_line('**********Valor parametro COD_CAU_REG_OT_SOL_INT [' ||
                           nuCOD_CAU_REG_OT_SOL_INT || ']');

      if nvl(nuCOD_CAU_REG_OT_SOL_INT, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro COD_CAU_REG_OT_SOL_INT';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      --parametro de causal para cerrar de forma automatica la orden y solicitud
      nuCOD_CAU_GEN_OT_CER_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_CER_SOL_INT',
                                                                              null);

      dbms_output.put_line('**********Valor parametro COD_CAU_GEN_OT_CER_SOL_INT [' ||
                           nuCOD_CAU_GEN_OT_CER_SOL_INT || ']');

      if nvl(nuCOD_CAU_GEN_OT_CER_SOL_INT, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro COD_CAU_GEN_OT_CER_SOL_INT';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_1',
                                                                                null);

      dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1 [' ||
                           nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 || ']');

      if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_1, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_2',
                                                                                null);
      dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2 [' ||
                           nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 || ']');

      if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_2, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_3',
                                                                                null);

      dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3 [' ||
                           nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 || ']');

      if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_3, 0) = 0 then
        sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3';
        RAISE ex.CONTROLLED_ERROR;
      end if;

      --if nvl(nuClasCausal, 0) = 2 then

      --cursor permitir? obtener datos de la orden legalizada.
      open cuorderactivity(nuorden);
      fetch cuorderactivity
        into rfcuorderactivity;
      close cuorderactivity;

      open cuSolicitudPLUGIN(rfcuorderactivity.package_id);
      fetch cuSolicitudPLUGIN
        into rfcuSolicitudPLUGIN;
      close cuSolicitudPLUGIN;

      dbms_output.put_line('***************Solcitiud [' ||
                           rfcuSolicitudPLUGIN.package_id || ']');
      dbms_output.put_line('***************Solcitiud de Interaccion [' ||
                           rfcuorderactivity.package_id || ']');
      dbms_output.put_line('***************sysdate [' || sysdate || '] -
               open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id)[' ||
                           open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                                 null) || ']');

      /*
      nuCantDias := round(sysdate -
                          open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                          0);
      --*/

      dbms_output.put_line('***************Dias de diferencia [' ||
                           round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                                                                                  null),
                                                                            SYSDATE),
                                 0) || ']');

      --if nuCantDias <= nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 then
      /*
      if round(sysdate -
               open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
               0) <= nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 then
        --*/
      --/*
      if open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                               null) is not null then
        -- OSF-444
        if round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                                                               SYSDATE),
                    0) >= nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then

          /*
          elsif round(sysdate -
                      open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                      0) > nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
          --*/
          dbms_output.put_line('***************nuCAN_DIA_VAL_ACT_EN_SOL_INT_3');

          --Inicio OSF-1188
          PrlegalizaOrden(nuorden,rfcuorder.tipo_trabajo,nuCOD_CAU_GEN_OT_CER_SOL_INT,nuerrorcode,sbERROR);
          if nuerrorcode = 0 then
            commit;
          else
            rollback;
          end if;
          --Fin OSF-1188

        elsif round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                                                                  null)-1,
                                                            SYSDATE),
                 0) Between nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 and nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
          --*/

          dbms_output.put_line('***************nuCAN_DIA_VAL_ACT_EN_SOL_INT_1');

          --incia proceso de creacion de nueva orden
          nuOrderId                   := null;
          nuOrderActivityId           := null;
          nuMotive                    := mo_bopackages.fnuGetInitialMotive(rfcuorderactivity.Package_Id);
          product_id                  := mo_bomotive.fnugetproductid(nuMotive);
          suscription_id              := mo_bomotive.fnugetsubscription(nuMotive);
          sbcomentario                := 'Orden generada al cerrar la orden ' ||
                                         nuorden;
          nuCOD_ACT_EDRCD_ASO_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_ACT_EDRCD_ASO_SOL_INT',
                                                                                 null);

          if nvl(nuCOD_ACT_EDRCD_ASO_SOL_INT, 0) = 0 then
            sbERROR := 'Dato no valido en el parametro COD_ACT_EDRCD_ASO_SOL_INT';
            RAISE ex.CONTROLLED_ERROR;
          end if;

          or_boorderactivities.CreateActivity(nuCOD_ACT_EDRCD_ASO_SOL_INT,
                                              rfcuorderactivity.Package_Id,
                                              nuMotive,
                                              null,
                                              null,
                                              rfcuorderactivity.Address_Id,
                                              null,
                                              null,
                                              suscription_id,
                                              product_id,
                                              null,
                                              null,
                                              null,
                                              null,
                                              sbcomentario,
                                              null,
                                              null,
                                              nuOrderId,
                                              nuOrderActivityId,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null,
                                              null);

          dbms_output.put_line('Se creo la orden[' || nuOrderId ||
                               '] - Codigo Actiivdad[' ||
                               nuOrderActivityId || ']');

         --TICKET 200 1329 LJLB -- asignacion de comentarios de diferentes ordenes a la nueva orden generada
          FOR rfcucomentarios IN cucomentarios LOOP
            os_addordercomment(nuOrderId,
                               3,
                               substr(rfcucomentarios.comentarioot,
                                      1,
                                      1900),
                               nuerrorcode,
                               sbERROR);
            IF nuerrorcode <> 0 THEN
                RAISE ex.CONTROLLED_ERROR;
            END IF;

          END LOOP;

          --Inicio OSF-1188
          PrlegalizaOrden(nuorden,rfcuorder.tipo_trabajo,nuCOD_CAU_CER_OT_SOL_INT,nuerrorcode,sbERROR);
          if nuerrorcode = 0 then
            commit;
          else
            rollback;
          end if;
          --Fin OSF-1188

        end if;

      end if; --if nvl(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,null)) <> 0 then

    end loop;

    dbms_output.put_line('FIN LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');

    --RAISE ex.CONTROLLED_ERROR;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      if sbERROR is null then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');
      else
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         sbERROR);
      end if;
    when OTHERS then
      rollback;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');

  END LDC_PRJOBADMORDSOLINT;


  PROCEDURE PR_ASIGNACIONORDEN
  (
    nuOrderId                    IN OR_ORDER.ORDER_ID%TYPE,
    nuCOD_CAU_GEN_OT_CER_SOL_INT IN ld_parameter.numeric_value%type
   ) is

  BEGIN

    ut_trace.trace('Sentencias actualizar, orden '|| nuOrderId || ' nuCOD_CAU_GEN_OT_CER_SOL_INT '|| nuCOD_CAU_GEN_OT_CER_SOL_INT, 10);
    update or_order oo
    set oo.legalization_date = ut_date.fdtsysdate,
    oo.order_status_id   = 8,
    oo.causal_id         = nuCOD_CAU_GEN_OT_CER_SOL_INT
    where oo.order_id = nuOrderId;

    ut_trace.trace('Fin primera sentencia actualizar', 10);

    ut_trace.trace('Inicio segunda sentencia actualizar', 10);

    update or_order_activity ooa
    set ooa.status = 'F'
    where ooa.order_id = nuOrderId;

    ut_trace.trace('Fin segunda sentencia actualizar', 10);


  EXCEPTION
    WHEN OTHERS THEN
        rollback;
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.PR_ASIGNACIONORDEN');

  END PR_ASIGNACIONORDEN;

  FUNCTION FN_VALIDAR_SOLICITUD_ORDEN
  (
    nuSolicitud     IN  mo_packages.package_id%type
  )
  RETURN NUMBER
  IS

      nuTiposTrabajos   NUMBER;
      nuPackageId       mo_packages_asso.package_id%type;

      cursor cuSolicitudes(nuSolicitud mo_packages.package_id%type) is
      select package_id
      from mo_packages_asso
      where mo_packages_asso.package_id_asso = nuSolicitud;

  BEGIN
       ut_trace.trace('INICIO FN_VALIDAR_SOLICITUD_ORDEN, primer cursor explicito', 10);

       nuTiposTrabajos := 0;
       select count(1)
       into nuTiposTrabajos
       from or_order, or_order_activity, mo_packages
       where or_order.order_id = or_order_activity.order_id
       and mo_packages.package_id = or_order_activity.package_id
       and or_order_activity.package_id = nuSolicitud
       and or_order_activity.task_type_id IN ((SELECT TO_NUMBER(COLUMN_VALUE)
                                               FROM TABLE
                                               (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('TRABS_COMUSR',NULL),','))));

       ut_trace.trace('FIN FN_VALIDAR_SOLICITUD_ORDEN, primer cursor explicito valor ' || nuTiposTrabajos, 10);

       IF nuTiposTrabajos > 0 THEN
            RETURN 1;
       END IF;

      ut_trace.trace('abrir FN_VALIDAR_SOLICITUD_ORDEN, cursor cuSolicitudes', 10);

      open cuSolicitudes (nuSolicitud);
      fetch cuSolicitudes
      into nuPackageId;
      close cuSolicitudes;

      ut_trace.trace('cerrar FN_VALIDAR_SOLICITUD_ORDEN, primer cursor cuSolicitudes, valor '|| nuPackageId, 10);

      ut_trace.trace('INICIO FN_VALIDAR_SOLICITUD_ORDEN, segundo cursor explicito', 10);

      select count(1)
      into nuTiposTrabajos
      from or_order, or_order_activity, mo_packages
      where or_order.order_id = or_order_activity.order_id
      and mo_packages.package_id = or_order_activity.package_id
      and or_order_activity.package_id IN (select mo_packages_asso.package_id_asso
                                            from mo_packages_asso
                                            where mo_packages_asso.package_id = nuPackageId)
      and or_order_activity.task_type_id IN ((SELECT TO_NUMBER(COLUMN_VALUE)
                                              FROM TABLE
                                              (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('TRABS_COMUSR',NULL),','))));

      ut_trace.trace('FIN FN_VALIDAR_SOLICITUD_ORDEN, segundo cursor explicito, valor ' || nuTiposTrabajos, 10);


      IF nuTiposTrabajos > 0 THEN

            RETURN 1;

       END IF;

    RETURN 0;

  EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
  END FN_VALIDAR_SOLICITUD_ORDEN;


 /*****************************************************************
 Propiedad intelectual de GDC - EFIGAS (c).
 
 Unidad         : PrlegalizaOrden
 Descripcion    : Servicio para legalizar orden con el API llamado api_legalizeorders
 Autor          : Jorge Valiente
 Fecha          : 07/07/2023
 CASO           : OSF-1188
 
 Parametros              Descripcion
 ============         ===================
 
 Fecha             Autor                Modificacion
 =========       =========             ====================
 ******************************************************************/
 Procedure PrlegalizaOrden(InuOrden              IN number,
                           InuTipoTrabajo        IN number,
                           InuCausalLegalizacion IN number,
                           nuerrorcode           OUT number,
                           sbERROR               OUT varchar2) IS
 
   CADENALEGALIZACION varchar2(4000) := null;
 
   cursor cudatoadicional is
     select b.name_attribute name_attribute, null value
       from ge_attributes b, ge_attrib_set_attrib a
      where b.attribute_id = a.attribute_id
        and a.attribute_set_id in
            (select ottd.attribute_set_id
               from or_tasktype_add_data ottd
              where ottd.task_type_id = InuTipoTrabajo
                and ottd.active = 'Y'
                and (SELECT count(1) cantidad
                       FROM DUAL
                      WHERE dage_causal.fnugetclass_causal_id(InuCausalLegalizacion,
                                                              NULL) IN
                            (select column_value
                               from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                        NULL),
                                                                       ',')))) = 1
                   --/*
                   --CASO 200-1932
                   --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
                and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(InuCausalLegalizacion,
                                                                          null),
                                        1,
                                        'C',
                                        2,
                                        'I') or ottd.use_ = 'B') --*/
             )
      order by a.attribute_set_id, a.attribute_id;
 
   rfcudatoadicional cudatoadicional%rowtype;
 
   SBDATOSADICIONALES VARCHAR2(4000);
 
 BEGIN
   ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.fsbcadenalegalizada',
                  10);
 
   -- Llama el API de lagalizacion de Ordenes
 
   ---Inicio Datos Adicionales--------------------
   --cadena datos adicionales
   SBDATOSADICIONALES := ';;;;';
 
   for rfcudatoadicional in cudatoadicional loop
     IF SBDATOSADICIONALES IS NULL THEN
       SBDATOSADICIONALES := rfcudatoadicional.NAME_ATTRIBUTE || '=' ||
                             rfcudatoadicional.Value;
     ELSE
       SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                             rfcudatoadicional.NAME_ATTRIBUTE || '=' ||
                             rfcudatoadicional.Value;
     END IF;
   end loop;
   dbms_output.put_line('SBDATOSADICIONALES  => ' || SBDATOSADICIONALES);
   --fin cadena datos adicionales   
 
   ---Fin Datos Adicionales-----------------------------  
 
   dbms_output.put_line('inuorderid  => ' || InuOrden);
   dbms_output.put_line('inucausalid => ' || InuCausalLegalizacion);
   dbms_output.put_line('inupersonid => ' || ge_bopersonal.fnuGetPersonId);
   dbms_output.put_line('idtchangedate => null');
   dbms_output.put_line('***************************PASO 2.2');
   SELECT (InuOrden || '|' || InuCausalLegalizacion || '|' ||
          ge_bopersonal.fnuGetPersonId || '|' || NULL || '|' ||
          A.ORDER_ACTIVITY_ID || '>' ||
          decode(nvl(dage_causal.fnugetclass_causal_id(InuCausalLegalizacion,
                                                        null),
                      0),
                  1,
                  1,
                  0) || ';;;;' || '|' || NULL || '|' || NULL || '|1277;' ||
          'Legalizacion desde JOB - LDC_PRJOBADMORDSOLINT')
     INTO CADENALEGALIZACION
     FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
    WHERE O.ORDER_ID = A.ORDER_ID
      AND O.ORDER_ID = InuOrden
      and a.status = 'R'
      and not exists (select 1
             from open.ct_item_novelty n
            where n.items_id = a.activity_id)
      AND ROWNUM = 1;
 
   dbms_output.put_line('CADENALEGALIZACION => ' || CADENALEGALIZACION);
 
   api_legalizeorders(CADENALEGALIZACION,
                      sysdate,
                      sysdate,
                      sysdate,
                      nuerrorcode,
                      sbERROR);
 
   dbms_output.put_line('onuerrorcode => ' || nuerrorcode);
   dbms_output.put_line('osberrormessage => ' || sbERROR);
 
   ut_trace.trace('FIN LDC_PKSOLICITUDINTERACCION.fsbcadenalegalizada', 10);
 
 EXCEPTION
   WHEN OTHERS THEN
     rollback;
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                      'Error al lealizar la cadena [' ||
                                      CADENALEGALIZACION || ']');
     pkg_error.getError(nuerrorcode, sbERROR);
   
 end PrlegalizaOrden;

END LDC_PKSOLICITUDINTERACCION;
/