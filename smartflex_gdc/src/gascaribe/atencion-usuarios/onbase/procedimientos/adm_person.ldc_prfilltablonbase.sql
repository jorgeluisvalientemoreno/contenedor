CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRFILLTABLONBASE IS

  /*******************************************************************************
   Metodo:       LDC_PRFILLTABLONBASE
   Descripcion:  Procedimiento se encarga de hacer el llenado en las tablas
         LDC_COMEORDORCD y LDC_ORDEELDORCD Caso 252

   Autor:        Olsoftware/Miguel Ballesteros
   Fecha:        07/01/2020

   Historia de Modificaciones
   FECHA        AUTOR                       DESCRIPCION
   07/01/2020   Horbath                     caso: 377
   06/06/2022   Jorge Valiente              * Retirar la validacion del FLAG para que realice el registro de DATA en al entidad
                                            LDC_ORDEELDORCD definida para consultar por ONBASE
                                            * Cambio de c?digo de versi?n del 0000377 a la nueva versi?n OSF-327
   06/06/2022   Jorge Valiente              OSF-398: * Filtrar ordenes solo en este 0 o 5 con fecha de creacion dl sistema
                                                     * No permitir repetir regitros en la entidad LDC_ORDEELDORCD
  *******************************************************************************/

  onuCodFluNot NUMBER;

  RegCategoria LDC_CONFLUNOTATEACL.CATECODI%type;
  RegContrato  mo_motive.subscription_id%type;
  TempFlujo    NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

  ingresoTupla boolean;
  nuError      number;
  sbError      VARCHAR2(4000);
  nuCaso       varchar2(30) := 'OSF-327';--'0000703';--
  nuparano     NUMBER;
  nuparmes     NUMBER;
  nutsess      NUMBER;
  sbparuser    VARCHAR2(4000);

  --Caso Activo
  csbEntrega2002013 CONSTANT VARCHAR2(100) := 'CRM_SVC_DVM_2002013_2';
  --

  cursor cuDataLDCCFNAC(INUPACKAGE_TYPE_ID NUMBER,
                        INUCAUSAL_TYPE_ID  NUMBER,
                        INUCATECODI        NUMBER,
                        INUTASK_TYPE_ID    NUMBER,
                        INUCAUSAL_ID       NUMBER,
                        InuMEDIO_RECEPCION NUMBER) is
    select LDC_CFNAC.MEDIO_RESPUESTA, ldc_cfnac.flagjob
      from LDC_CONFLUNOTATEACL LDC_CFNAC
     WHERE LDC_CFNAC.PACKAGE_TYPE_ID = INUPACKAGE_TYPE_ID
       AND LDC_CFNAC.CAUSAL_TYPE_ID = INUCAUSAL_TYPE_ID
       AND LDC_CFNAC.CATECODI = INUCATECODI
       AND LDC_CFNAC.TASK_TYPE_ID = INUTASK_TYPE_ID
       AND LDC_CFNAC.CAUSAL_ID = INUCAUSAL_ID
       AND LDC_CFNAC.MEDIO_RECEPCION = InuMEDIO_RECEPCION;

  RFcuDataLDCCFNAC cuDataLDCCFNAC%rowtype;
  --TICKET 252 LJLB --se agrega nuevos campos para llenar tabla LDC_ORDEELDORCD
  cursor cuDataOrden(Inuorden                 or_order.order_id%type,
                     InuPAR_TIPO_SERVICIO_GAS number) is
    select oo.order_id orden,
           OOA.PRODUCT_ID producto,
           OOA.SUBSCRIPTION_ID contrato,
           mp.package_id Solicitud,
           mp.package_type_id tipo_solicitud,
           mm.causal_id causal_registro,
           (select s.sesucate
              from open.servsusc s
             where s.sesususc = mm.subscription_id
               and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
               and rownum = 1) categoria,
           (select s.SESUSUCA
              from open.servsusc s
             where s.sesususc = mm.subscription_id
               and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
               and rownum = 1) subcategoria,
           oo.task_type_id tipo_trabajo,
           oo.causal_id causal_legaliza,
           --ge.is_write medio_recepcion,
           MP.RECEPTION_TYPE_ID medio_recepcion,
           ooa.address_id codigo_direccion,
           mp.cust_care_reques_num interaccion,
           OPEN.daab_address.fnugetgeograp_location_id(ooa.address_id, NULL) codigo_localidad,
           OPEN.dage_geogra_location.fsbgetdescription(OPEN.daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                   NULL),
                                                       NULL) descripcion_localidad,
           mp.subscriber_id codigo_cliente,
           OPEN.dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                      NULL) || ' ' ||
           open.dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id, NULL) nombre_cliente,
           mp.contact_id contacto,
           OPEN.dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
           OPEN.daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
           OPEN.dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
           OPEN.dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
           mp.comment_ observacion,
           OPEN.daps_package_type.fsbgetdescription(mp.package_type_id,
                                                    null) desc_tipo_solicitud,
           oo.legalization_date fecha_legalizacion,
           OPEN.dage_subscriber.fsbgetsubscriber_name(mp.contact_id,
                                                      NULL) || ' ' ||
           open.dage_subscriber.fsbgetsubs_last_name(mp.contact_id, NULL) NOMBRE_SOLICITANTE
      from mo_packages mp,
           mo_motive   mm,
           --   GE_RECEPTION_TYPE GE,
           or_order          oo,
           or_order_activity ooa
     where oo.order_id = Inuorden
       and ooa.order_id = oo.order_id
       and mp.package_id = ooa.package_id
       and mp.package_id = mm.package_id;
  --and MP.RECEPTION_TYPE_ID = GE.RECEPTION_TYPE_ID;

  rfcuDataOrden cuDataOrden%rowtype;

  nuOrderId        or_order.order_id%type;
  nuMedioRespuesta number;

  nuCOD_FLU_RES_TEL       number := 0;
  nuCOD_FLU_RES_CAR       number := 0;
  nuPAR_TIPO_SERVICIO_GAS number := 0;
  nuACT_OT_FLU_RES_TEL    number;
  nuACT_OT_FLU_RES_CAR    number;

  cursor culd_parameternumber(sbparameter_id ld_parameter.parameter_id%type) is
    select lp.numeric_value
      from open.ld_parameter lp
     where lp.parameter_id = sbparameter_id;

  rfculd_parameternumber culd_parameternumber%rowtype;

  onuErrorCode    number;
  osbErrorMessage varchar2(4000);

  NuCodDir    number;
  ionuOrderId number;

  --INICIO CA 252
  -- Cursor que obtiene la informacion para llenar la tabla LDC_COMEORDORCD
  CURSOR CUGETDATCOMEORDORCD(nuOrden number) IS -- CASO 377: SE MODIFICA LA CADENA DEL CMAPO COMENTARIO
    SELECT oc.ORDER_COMMENT_ID idcomentario,
           oc.order_id         ORDEN,
           'Solicitud[' || mp.package_id || ' - ' ||
             daps_package_type.fsbgetdescription(mp.package_type_id) ||
             '] - Causal Registro [' ||
             nvl(daCC_CAUSAL.fsbgetdescription(mm.causal_id, null), '') ||
             '] - Comentario[' || mp.comment_ || ']  - Tipo Trabajo[' ||
             daor_task_type.fsbgetdescription(oo.task_type_id) ||
             '] - Causal Legalizacion [' ||
             nvl(dage_causal.Fsbgetdescription(oo.causal_id, null), '') ||
             '] - Comentario[' || oc.order_comment|| ']' comentario
      FROM open.OR_ORDER_COMMENT oc,
			open.MO_PACKAGES           mp,
            open.OR_ORDER_ACTIVITY     ooa,
            open.OR_ORDER              oo,
			open.mo_motive             mm
     where oc.order_id = nuOrden
	 and oc.ORDER_ID = oo.order_id
	 and mp.package_id = ooa.package_id
	 and ooa.ORDER_ID = oo.order_id
	 and mm.package_id = mp.package_id
       and (select count(lo.orden_id)
              from LDC_COMEORDORCD lo
             where lo.orden_id = oc.order_id) = 0;

  --FIN CA 252

  --CASO 377
  cursor cuDataLDCCFNACTODOS(INUPACKAGE_TYPE_ID NUMBER,
                             INUCAUSAL_TYPE_ID  NUMBER,
                             INUCATECODI        NUMBER,
                             INUTASK_TYPE_ID    NUMBER,
                             INUCAUSAL_ID       NUMBER,
                             InuMEDIO_RECEPCION NUMBER) is
    select t.MEDIO_RESPUESTA, t.FLAGJOB
      from LDC_CONFLUNOTATEACL t
     WHERE T.PACKAGE_TYPE_ID = INUPACKAGE_TYPE_ID
       and TASK_TYPE_ID = INUTASK_TYPE_ID
       AND nvl(CAUSAL_TYPE_ID, -1) =
           decode(nvl(CAUSAL_TYPE_ID, -1), -1, -1, INUCAUSAL_TYPE_ID)
       and nvl(CATECODI, -1) =
           decode(nvl(CATECODI, -1), -1, -1, INUCATECODI)
       and nvl(CAUSAL_ID, -1) =
           decode(nvl(CAUSAL_ID, -1), -1, -1, INUCAUSAL_ID)
       and nvl(MEDIO_RECEPCION, -1) =
           decode(nvl(MEDIO_RECEPCION, -1), -1, -1, InuMEDIO_RECEPCION);

  cursor CUSOLOTINTERACCION(Inuinteraccion           mo_packages.cust_care_reques_num%type,
                            InuPAR_TIPO_SERVICIO_GAS number) is
    select oo.order_id orden,
           OOA.PRODUCT_ID producto,
           OOA.SUBSCRIPTION_ID contrato,
           mp.package_id Solicitud,
           mp.package_type_id tipo_solicitud,
           mm.causal_id causal_registro,
           (select s.sesucate
              from open.servsusc s
             where s.sesususc = mm.subscription_id
               and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
               and rownum = 1) categoria,
           (select s.SESUSUCA
              from open.servsusc s
             where s.sesususc = mm.subscription_id
               and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
               and rownum = 1) subcategoria,
           oo.task_type_id tipo_trabajo,
           oo.causal_id causal_legaliza,
           --ge.is_write medio_recepcion,
           MP.RECEPTION_TYPE_ID medio_recepcion,
           ooa.address_id codigo_direccion,
           mp.cust_care_reques_num interaccion,
           OPEN.daab_address.fnugetgeograp_location_id(ooa.address_id, NULL) codigo_localidad,
           OPEN.dage_geogra_location.fsbgetdescription(OPEN.daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                   NULL),
                                                       NULL) descripcion_localidad,
           mp.subscriber_id codigo_cliente,
           OPEN.dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                      NULL) || ' ' ||
           open.dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id, NULL) nombre_cliente,
           mp.contact_id contacto,
           OPEN.dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
           OPEN.daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
           OPEN.dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
           OPEN.dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
           mp.comment_ observacion,
           OPEN.daps_package_type.fsbgetdescription(mp.package_type_id,
                                                    null) desc_tipo_solicitud,
           oo.legalization_date fecha_legalizacion,
           OPEN.dage_subscriber.fsbgetsubscriber_name(mp.contact_id,
                                                      NULL) || ' ' ||
           open.dage_subscriber.fsbgetsubs_last_name(mp.contact_id, NULL) NOMBRE_SOLICITANTE
      from mo_packages mp,
           mo_motive   mm,
           --   GE_RECEPTION_TYPE GE,
           or_order          oo,
           or_order_activity ooa
     where ooa.order_id = oo.order_id
       and mp.package_id = ooa.package_id
       and mp.package_id = mm.package_id
       and mp.cust_care_reques_num = Inuinteraccion
       and (select count(lo.orden_id)
              from LDC_ORDEELDORCD lo
             where lo.orden_id = oo.order_id) = 0;

  rfCUSOLOTINTERACCION CUSOLOTINTERACCION%rowtype;
  --Inicio 377

  cursor cu_orden is
    select o.order_id
      from LDC_CONFLUNOTATEACL lc,
           or_order            o,
           or_order_activity   a,
           mo_packages         mp
     where o.order_id = a.order_id
       and a.package_id = mp.package_id
       and lc.task_type_id = o.task_type_id
       and lc.package_type_id = mp.package_type_id
       and o.order_status_id in (0,5)
       and trunc(o.created_date) = trunc(sysdate)    
       and (select count(z.orden_id) from LDC_ORDEELDORCD z where z.orden_id = o.order_id) = 0
       --and o.order_status_id = 8
       --and trunc(o.legalization_date) = trunc(sysdate)
       ;  ---trunc(sysdate - 560); --

  rfcu_orden cu_orden%rowtype;

  procedure prollenacomeordorcd(idcomentario OR_ORDER_COMMENT.ORDER_COMMENT_ID%type,
                                nuOrder      or_order.order_id%type,
                                sbComentario varchar2) is
    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function  :    prollenacomeordorcd
      Descripcion :  inserta en la tabla LDC_COMEORDORCD

      Parametros  :
            idcomentario          id del comentario
        nuOrder               numero de orden
        sbComentario          comentario

      Autor    :  Luis Javier Lopez Barrios
      Fecha    :  04-03-2020

      Historia de modificaciones
      Autor    Fecha         Descripcion
    *****************************************************************/
  begin

    insert into LDC_COMEORDORCD
      (COMEORDOR_ID, ORDEN_ID, COMENT_ID, COMENTARIO, ESTADO)
    VALUES
      (SEQ_LDC_COMEORDORCD.NEXTVAL,
       nuOrder,
       idcomentario,
       sbComentario,
       'P');
    commit;

  exception
    when others then
      ERRORS.SETERROR;
      RAISE ex.controlled_error;

  end;

  procedure prollenaordeeldorcd(nuOrder             or_order.order_id%type,
                                nuContrato          NUMBER,
                                nuProducto          number,
                                nucategoria         number,
                                nusubcategoria      number,
                                dtFechaCrea         date,
                                dtFechaAsig         date,
                                nuOperating_unit    or_operating_unit.operating_unit_id%type,
                                sbNameUnit          varchar2,
                                nuCausal            ge_causal.causal_id%type,
                                nuPackage_id        mo_packages.package_id%type,
                                nuLocalidad         ge_geogra_location.geograp_location_id%type,
                                sbDescLocal         varchar2,
                                nuCliente           mo_packages.subscriber_id%type,
                                sbNameClien         varchar2,
                                nuContacto          mo_packages.contact_id%type,
                                sbNameContacto      varchar2,
                                sbDireccion         varchar2,
                                sbTelefono          varchar2,
                                sbEmail             varchar2,
                                nuInteraccion       mo_packages.CUST_CARE_REQUES_NUM%type,
                                sbObservacion       varchar2,
                                nutiposolicitud     mo_packages.package_type_id%type,
                                sbdesctiposol       ps_package_type.description%type,
                                dtlegalization_date or_order.legalization_date%type,
                                nucausal_id         or_order.causal_id%type,
                                sbNOMBRE_SOLICITANTE  varchar2) is

    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function  :    prollenaordeeldorcd
      Descripcion :  inserta en la tabla LDC_ORDEELDORCD

      Parametros  :
            nuOrder               numero de orden
        nuContrato            numero de contrato
        nuProducto            numero de producto
        nucategoria           categoria
        nusubcategoria        subcategoria
        dtFechaCrea           fecha de creacion
        dtFechaAsig           fecha de asignacion
        nuOperating_unit      unidad operativa
        sbNameUnit            nombre de la unidad
        nuCausal              causal de registro
        nuPackage_id          solicitud
        nuLocalidad           localidad
        sbDescLocal           descripcion de localidad
        nuCliente             cliente
        sbNameClien           nombre del cliente
        nuContacto            contacto
        sbNameContacto        nombre del contacto
        sbDireccion           direccion
        sbTelefono            telefono
        sbEmail               email
        nuInteraccion         interaccion
        sbObservacion         obseravcion

      Autor    :  Luis Javier Lopez Barrios
      Fecha    :  04-03-2020

      Historia de modificaciones
      Autor    Fecha         Descripcion
      HORBATH  26/05/2020    CASO 377: Se agregaron 2 nuevos parametros de entrada:
                                       nutiposolicitud  mo_packages.package_type_id%type,
                                       sbdesctiposol    ps_package_type.description%type.
	  HORBATH  05/02/2021    CASO 377: Se modifico el cursor CUGETDATCOMEORDORCD para cambiar el formato de comentario
    *****************************************************************/
  begin

    insert into LDC_ORDEELDORCD
      (ORDEELDOR_ID,
       ORDEN_ID,
       PRODUCTO,
       CONTRATO,
       CATEGORIA,
       SUBCATEGORIA,
       FECHA_CREACION,
       FECHA_ASIGNACION,
       UNIDAD_OPERATIVA,
       NOMBRE_UNIDAD,
       CAUSAL_REGISTRO,
       NUMERO_SOLICITUD,
       CODIGO_LOCALIDAD,
       DESCRIPCION_LOCALIDAD,
       CODIGO_CLIENTE,
       NOMBRE_CLIENTE,
       CONTACTO,
       NOMBRE_CONTACTO,
       DIRECCION,
       TELEFONO,
       EMAIL,
       INTERACCION,
       OBSERVACION,
       ESTADO,
       package_type_id,
       description_package_type_id,
       fecha_legalizacion,
       causal_legalizacion,
       NOMBRE_SOLICITANTE)
    VALUES
      (SEQ_LDC_ORDEELDORCD.NEXTVAL,
       nuOrder,
       nuContrato,
       nuProducto,
       nucategoria,
       nusubcategoria,
       dtFechaCrea,
       dtFechaAsig,
       nuOperating_unit,
       sbNameUnit,
       nuCausal,
       nuPackage_id,
       nuLocalidad,
       sbDescLocal,
       nuCliente,
       sbNameClien,
       nuContacto,
       sbNameContacto,
       sbDireccion,
       sbTelefono,
       sbEmail,
       nuInteraccion,
       sbObservacion,
       'P',
       nutiposolicitud,
       sbdesctiposol,
       dtlegalization_date,
       nucausal_id,
       sbNOMBRE_SOLICITANTE);

    commit;

  exception
    when others then
      ERRORS.SETERROR;
      RAISE ex.controlled_error;
  end;

BEGIN


  IF  fblAplicaEntregaxCaso(nuCaso) THEN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'LDC_PRFILLTABLONBASE',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

    for rfcu_orden in cu_orden loop

      nuOrderId := rfcu_orden.order_id; --30178971; --

      open culd_parameternumber('PAR_TIPO_SERVICIO_GAS');
      fetch culd_parameternumber
        into rfculd_parameternumber;
      if culd_parameternumber%found then
        if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
          nuPAR_TIPO_SERVICIO_GAS := rfculd_parameternumber.numeric_value;
        end if;
      end if;
      close culd_parameternumber;

      open cuDataOrden(nuOrderId, nuPAR_TIPO_SERVICIO_GAS);
      fetch cuDataOrden
        into rfcuDataOrden;
      if cuDataOrden%found then
        if rfcuDataOrden.Solicitud is not null then
          ---Inicio Proceso Generacion OT Flujo
          --/*
          ingresoTupla := false;

          --INICIO CONFICURACION CON CAUSAL DE REGISTRO ESPECIFICA
          OPEN cuDataLDCCFNAC(rfcuDataOrden.Tipo_Solicitud,
                              rfcuDataOrden.Causal_Registro,
                              rfcuDataOrden.Categoria,
                              rfcuDataOrden.Tipo_Trabajo,
                              rfcuDataOrden.Causal_Legaliza,
                              rfcuDataOrden.Medio_Recepcion);
          FETCH cuDataLDCCFNAC
            INTO RFcuDataLDCCFNAC;
          IF cuDataLDCCFNAC%FOUND THEN
            IF NVL(TO_NUMBER(RFcuDataLDCCFNAC.Medio_Respuesta), 0) > 0 THEN
              ingresoTupla     := TRUE;
              nuMedioRespuesta := TO_NUMBER(RFcuDataLDCCFNAC.Medio_Respuesta);
              NuCodDir         := rfcuDataOrden.Codigo_Direccion;
            END IF;
          END IF;
          CLOSE cuDataLDCCFNAC;
          --FIN CONFICURACION CON CAUSAL DE REGISTRO ESPECIFICA -------------------

          --INICIO CONFICURACION CON CAUSAL DE REGISTRO ESPECIFICA
          IF (ingresoTupla = false) THEN
            --OPEN cuDataLDCCFNAC
            open cuDataLDCCFNACTODOS(rfcuDataOrden.Tipo_Solicitud,
                                     rfcuDataOrden.Causal_Registro, -- -1,
                                     rfcuDataOrden.Categoria,
                                     rfcuDataOrden.Tipo_Trabajo,
                                     rfcuDataOrden.Causal_Legaliza,
                                     rfcuDataOrden.Medio_Recepcion);
            --FETCH cuDataLDCCFNAC
            FETCH cuDataLDCCFNACTODOS
              INTO RFcuDataLDCCFNAC;
            --IF cuDataLDCCFNAC%FOUND THEN
            IF cuDataLDCCFNACTODOS%FOUND THEN
              IF NVL(TO_NUMBER(RFcuDataLDCCFNAC.Medio_Respuesta), 0) > 0 THEN
                ingresoTupla     := TRUE;
                nuMedioRespuesta := TO_NUMBER(RFcuDataLDCCFNAC.Medio_Respuesta);
                NuCodDir         := rfcuDataOrden.Codigo_Direccion;
              END IF;
            END IF;
            --CLOSE cuDataLDCCFNAC;
            CLOSE cuDataLDCCFNACTODOS;
          end if;
          --FIN CONFICURACION CON CAUSAL DE REGISTRO ESPECIFICA -------------------

          --/*
          --Valido si no encontro configuraciones
          IF (ingresoTupla = false) THEN

            ut_trace.trace('*********NO EXISTE CONFIGURACION Orden[' ||
                           nuOrderId || ']-TipoSolicitud[' ||
                           rfcuDataOrden.Tipo_Solicitud ||
                           ']-CausalRegistro[' ||
                           rfcuDataOrden.Causal_Registro || ']-Categoria[' ||
                           rfcuDataOrden.Categoria || ']-TipoTrabajo[' ||
                           rfcuDataOrden.Tipo_Trabajo ||
                           ']-CausalLegaliza[' ||
                           rfcuDataOrden.Causal_Legaliza ||
                           ']-MedioRecepcion[' ||
                           rfcuDataOrden.Medio_Recepcion || ']',
                           10);

            --/*
            --DBMS_OUTPUT.put_line('NO ENCONTRO COMBINACIONES');
            --Error no hay ninguna configuraci?n para ese tipo de Solicitud
            INSERT INTO LDC_INCONSISFLUJO
            VALUES
              (rfcuDataOrden.Solicitud,
               'NO EXISTE CONFIGURACION TipoSolicitud[' ||
               rfcuDataOrden.Tipo_Solicitud || ']-CausalRegistro[' ||
               rfcuDataOrden.Causal_Registro || ']-Categoria[' ||
               rfcuDataOrden.Categoria || ']-TipoTrabajo[' ||
               rfcuDataOrden.Tipo_Trabajo || ']-CausalLegaliza[' ||
               rfcuDataOrden.Causal_Legaliza || ']-MedioRecepcion[' ||
               rfcuDataOrden.Medio_Recepcion || ']',
               sysdate);
            --COMMIT;
            --*/

          ELSE

            --Parametro Flujo Respuesta Telefonico
            open culd_parameternumber('COD_FLU_RES_TEL');
            fetch culd_parameternumber
              into rfculd_parameternumber;
            if culd_parameternumber%found then
              if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
                nuCOD_FLU_RES_TEL := rfculd_parameternumber.numeric_value;
              end if;
            end if;
            close culd_parameternumber;

            --Parametro Flujo Respuesta Carta
            open culd_parameternumber('COD_FLU_RES_CAR');
            fetch culd_parameternumber
              into rfculd_parameternumber;
            if culd_parameternumber%found then
              if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
                nuCOD_FLU_RES_CAR := rfculd_parameternumber.numeric_value;
              end if;
            end if;
            close culd_parameternumber;

            --Actividad OT Flujo Respuesta Telefonico
            open culd_parameternumber('ACT_OT_FLU_RES_TEL');
            fetch culd_parameternumber
              into rfculd_parameternumber;
            if culd_parameternumber%found then
              if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
                nuACT_OT_FLU_RES_TEL := rfculd_parameternumber.numeric_value;
              end if;
            end if;
            close culd_parameternumber;

            --Actividad OT Flujo Respuesta Carta
            open culd_parameternumber('ACT_OT_FLU_RES_CAR');
            fetch culd_parameternumber
              into rfculd_parameternumber;
            if culd_parameternumber%found then
              if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
                nuACT_OT_FLU_RES_CAR := rfculd_parameternumber.numeric_value;
              end if;
            end if;
            close culd_parameternumber;

            if nuCOD_FLU_RES_TEL is null or nuCOD_FLU_RES_CAR is null or
               nuACT_OT_FLU_RES_TEL is null or nuACT_OT_FLU_RES_CAR is null then

              if nuCOD_FLU_RES_TEL is null then
                INSERT INTO LDC_INCONSISFLUJO
                VALUES
                  (rfcuDataOrden.Solicitud,
                   'El paraemtro COD_FLU_RES_TEL NO tiene valor',
                   sysdate);
              end if;

              if nuCOD_FLU_RES_CAR is null then
                INSERT INTO LDC_INCONSISFLUJO
                VALUES
                  (rfcuDataOrden.Solicitud,
                   'El paraemtro COD_FLU_RES_CAR NO tiene valor',
                   sysdate);
              end if;

              if nuACT_OT_FLU_RES_TEL is null then
                INSERT INTO LDC_INCONSISFLUJO
                VALUES
                  (rfcuDataOrden.Solicitud,
                   'El paraemtro ACT_OT_FLU_RES_TEL NO tiene valor',
                   sysdate);
              end if;

              if nuACT_OT_FLU_RES_CAR is null then
                INSERT INTO LDC_INCONSISFLUJO
                VALUES
                  (rfcuDataOrden.Solicitud,
                   'El paraemtro ACT_OT_FLU_RES_CAR NO tiene valor',
                   sysdate);
              end if;

            else

              --IF RFcuDataLDCCFNAC.FLAGJOB = 'Y' THEN
                --LDC_PKFLUNOTATECLI.
                prollenaordeeldorcd(nuOrderId,
                                    rfcuDataOrden.producto,
                                    rfcuDataOrden.contrato,
                                    rfcuDataOrden.categoria,
                                    rfcuDataOrden.subcategoria,
                                    sysdate,
                                    null,
                                    null,
                                    null,
                                    rfcuDataOrden.causal_registro,
                                    rfcuDataOrden.solicitud,
                                    rfcuDataOrden.codigo_localidad,
                                    rfcuDataOrden.descripcion_localidad,
                                    rfcuDataOrden.codigo_cliente,
                                    rfcuDataOrden.nombre_cliente,
                                    rfcuDataOrden.contacto,
                                    rfcuDataOrden.nombre_contacto,
                                    rfcuDataOrden.direccion,
                                    rfcuDataOrden.telefono,
                                    rfcuDataOrden.email,
                                    rfcuDataOrden.interaccion,
                                    rfcuDataOrden.observacion,
                                    rfcuDataOrden.Tipo_Solicitud,
                                    rfcuDataOrden.Desc_Tipo_Solicitud,
                                    rfcuDataOrden.Fecha_Legalizacion,
                                    rfcuDataOrden.Causal_Legaliza,
                                    rfcuDataOrden.NOMBRE_SOLICITANTE);

                --Se llena comentarios
                FOR reg IN CUGETDATCOMEORDORCD(nuOrderId) LOOP
                  --LDC_PKFLUNOTATECLI.
                  prollenacomeordorcd(reg.idcomentario,
                                      reg.ORDEN,
                                      reg.comentario);
                END LOOP;

                ut_trace.trace('FLUJO DE RESPUESTA CARTA - EXISTE CONFIGURACION Orden[' ||
                               nuOrderId || ']-TipoSolicitud[' ||
                               rfcuDataOrden.Tipo_Solicitud ||
                               ']-CausalRegistro[' ||
                               rfcuDataOrden.Causal_Registro ||
                               ']-Categoria[' || rfcuDataOrden.Categoria ||
                               ']-TipoTrabajo[' ||
                               rfcuDataOrden.Tipo_Trabajo ||
                               ']-CausalLegaliza[' ||
                               rfcuDataOrden.Causal_Legaliza ||
                               ']-MedioRecepcion[' ||
                               rfcuDataOrden.Medio_Recepcion ||
                               ']-OrdenGenerada[' || ionuOrderId ||
                               ']-Iteraccion[' ||
                               rfcuDataOrden.Interaccion || ']',
                               10);

                --CASO 377
                --Identificar todas las solicitudes asociada a la interaccion de la orden generada para respuesta tipo carta
                for rfCUSOLOTINTERACCION in CUSOLOTINTERACCION(rfcuDataOrden.Interaccion,
                                                               nuPAR_TIPO_SERVICIO_GAS) loop

                  --LDC_PKFLUNOTATECLI.
                  prollenaordeeldorcd(rfCUSOLOTINTERACCION.Orden,
                                      rfCUSOLOTINTERACCION.producto,
                                      rfCUSOLOTINTERACCION.contrato,
                                      rfCUSOLOTINTERACCION.categoria,
                                      rfCUSOLOTINTERACCION.subcategoria,
                                      sysdate,
                                      null,
                                      null,
                                      null,
                                      rfCUSOLOTINTERACCION.causal_registro,
                                      rfCUSOLOTINTERACCION.solicitud,
                                      rfCUSOLOTINTERACCION.codigo_localidad,
                                      rfCUSOLOTINTERACCION.descripcion_localidad,
                                      rfCUSOLOTINTERACCION.codigo_cliente,
                                      rfCUSOLOTINTERACCION.nombre_cliente,
                                      rfCUSOLOTINTERACCION.contacto,
                                      rfCUSOLOTINTERACCION.nombre_contacto,
                                      rfCUSOLOTINTERACCION.direccion,
                                      rfCUSOLOTINTERACCION.telefono,
                                      rfCUSOLOTINTERACCION.email,
                                      rfCUSOLOTINTERACCION.interaccion,
                                      rfCUSOLOTINTERACCION.observacion,
                                      rfCUSOLOTINTERACCION.Tipo_Solicitud,
                                      rfCUSOLOTINTERACCION.Desc_Tipo_Solicitud,
                                      rfCUSOLOTINTERACCION.Fecha_Legalizacion,
                                      rfCUSOLOTINTERACCION.Causal_Legaliza,
                                      rfCUSOLOTINTERACCION.NOMBRE_SOLICITANTE);

                  --Se llena comentarios de las ordenes con el comentario de su respectiva solicitud
                  FOR reg IN CUGETDATCOMEORDORCD(rfCUSOLOTINTERACCION.Orden) LOOP
                    --LDC_PKFLUNOTATECLI.
                    prollenacomeordorcd(reg.idcomentario,
                                        reg.ORDEN,
                                        reg.comentario||
                                        ' - ' || rfCUSOLOTINTERACCION.observacion  );
                  END LOOP;

                end loop;
                --FIn CASO 377

              --END IF;

            END IF;

          end if;
          ---Fin Proceso generacion OT Flujo--------------------------------------

        end if;
      end if;
      close cuDataOrden;

      commit;

      ut_trace.trace('Finaliza LDC_PRFILLTABLONBASE', 10);
      Ldc_proactualizaestaprog(nutsess,
                               sbError,
                               'LDC_PRFILLTABLONBASE',
                               'Ok');
    end loop;
  END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    Errors.GETERROR(nuError, sbError);
    Ldc_proactualizaestaprog(nutsess,
                             sbError,
                             'LDC_PRFILLTABLONBASE',
                             'ERROR');
    raise;

  when OTHERS then
    Errors.setError;
    Errors.GETERROR(NUERROR, sbError);
    Ldc_proactualizaestaprog(nutsess,
                             sbError,
                             'LDC_PRFILLTABLONBASE',
                             'ERROR');
    raise ex.CONTROLLED_ERROR;

END LDC_PRFILLTABLONBASE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRFILLTABLONBASE', 'ADM_PERSON');
END;
/
