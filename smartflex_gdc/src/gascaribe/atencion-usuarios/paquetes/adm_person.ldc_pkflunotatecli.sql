CREATE OR REPLACE PACKAGE adm_person.LDC_PKFLUNOTATECLI IS
  /***************************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package     : LDC_PKFLUNOTATECLI
  Descripcion : Paquete para validar los contenidos de la Tabla LDC_COMBINXSOLIC.

  Autor     : Daniel Eduardo Valiente Moreno.
  Fecha     : 31-08-2017

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------
  10/07/2024          PAcosta            OSF-2893: Cambio de esquema ADM_PERSON
                                         Retiro marcacion esquema .open objetos de lógica        
  ***************************************************************************/

  --------------------------------------------
  -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
  --------------------------------------------

  --------------------------------------------
  -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
  --------------------------------------------
  FUNCTION fsbVersion RETURN varchar2;

  PROCEDURE PRCONSULTACOMBSOL(inuCodSol    IN mo_packages.package_id%type,
                              onuCodFluNot OUT NUMBER /*LDC_CONFLUNOTATEACL.MEDIO_RESPUESTA%type*/);

  FUNCTION FNUCONSULTACOMBSOL(inuCodSol IN mo_packages.package_id%type)
    RETURN NUMBER;
  --ldc_combinxsolic.flujo_notific%type;

  PROCEDURE PRGENOTFNAC;

  procedure prollenacomeordorcd(idcomentario OR_ORDER_COMMENT.ORDER_COMMENT_ID%type,
                                nuOrder      or_order.order_id%type,
                                sbComentario varchar2);

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
                                nucausal_id         or_order.causal_id%type);

  PROCEDURE PRGENOTINTERACCION(InuOrderId or_order.order_id%type);

END LDC_PKFLUNOTATECLI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKFLUNOTATECLI IS
  /***************************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package     : LDC_PKFLUNOTATECLI
  Descripcion : Paquete para validar los contenidos de la Tabla LDC_CONFLUNOTATEACL.

  Autor     : Daniel Eduardo Valiente Moreno.
  Fecha     : 31-08-2017

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------

  ***************************************************************************/

  --------------------------------------------
  -- Constantes VERSION DEL PAQUETE
  --------------------------------------------
  csbVERSION constant varchar2(10) := 'CA2002013';

  --------------------------------------------
  -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
  --------------------------------------------

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    return csbVERSION;
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    PRCONSULTACOMBSOL
  Descripcion :  Consulta de las Solicitud y validacion de su configuracion en LDC_CONFLUNOTATEACL

  Parametros  :          Descripcion
  inuCodSol              Id de la Solicitud
  onuCodFluNot           Valor del Flujo para la Configuracion hallada

  Autor    :  Daniel Eduardo Valiente Moreno
  Fecha    :  31-08-2018

  Historia de modificaciones
  Autor    Fecha       Descripcion

  *****************************************************************/

  PROCEDURE PRCONSULTACOMBSOL(inuCodSol    IN mo_packages.package_id%type,
                              onuCodFluNot OUT NUMBER /*LDC_CONFLUNOTATEACL.MEDIO_RESPUESTA%type*/) As

    RegCategoria LDC_CONFLUNOTATEACL.CATECODI%type;
    RegContrato  mo_motive.subscription_id%type;
    TempFlujo    NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

    CURSOR cuDatos1 IS
      SELECT M.SUBSCRIPTION_ID  CONTRATO,
             CS.CATECODI        CATEGORIA,
             CS.MEDIO_RESPUESTA FLUJO
        FROM MO_PACKAGES       MP,
             OR_ORDER_ACTIVITY OA,
             OR_ORDER          O,
             MO_MOTIVE         M,
             --   GE_RECEPTION_TYPE   GE,
             LDC_CONFLUNOTATEACL CS
      --CONDICIONES BASE
       WHERE MP.CUST_CARE_REQUES_NUM = inuCodSol
         AND M.PACKAGE_ID = MP.PACKAGE_ID
         AND OA.PACKAGE_ID = MP.PACKAGE_ID
         AND O.ORDER_ID = OA.ORDER_ID
         AND MP.RECEPTION_TYPE_ID = CS.MEDIO_RECEPCION
         AND M.SUBSCRIPTION_ID IS NOT NULL
            --CONDICIONES LDC_CONFLUNOTATEACL
         AND CS.PACKAGE_TYPE_ID = MP.PACKAGE_TYPE_ID
         AND CS.CAUSAL_TYPE_ID = M.CAUSAL_ID
         AND CS.TASK_TYPE_ID = O.TASK_TYPE_ID
         AND CS.CAUSAL_ID = O.CAUSAL_ID
      --    AND CS.MEDIO_RECEPCION = GE.IS_WRITE
       GROUP BY M.SUBSCRIPTION_ID, CS.CATECODI; --, CS.MEDIO_RESPUESTA);--.FLUJO_NOTIFIC;

    CURSOR cuDatos2(NContrato  suscripc.susccodi%type,
                    NCategoria LDC_CONFLUNOTATEACL.CATECODI%type) IS
      SELECT COUNT(*)
        FROM SUSCRIPC S, PR_PRODUCT P
       WHERE S.SUSCCODI IN (NContrato) --CONTRATO
         AND S.SUSCCODI = P.SUBSCRIPTION_ID
         AND P.CATEGORY_ID IN (NCategoria) --CATEGORIA
         AND P.PRODUCT_TYPE_ID = NVL(DALD_PARAMETER.fnuGetNumeric_Value('PAR_TIPO_SERVICIO_GAS',
                                                                             NULL),
                                     0);

    ingresoTupla boolean;
    Cnt_cuDatos2 NUMBER;

    --Caso Activo
    csbEntrega2002013 CONSTANT VARCHAR2(100) := '200-2013';
    --

  BEGIN

    --DBMS_OUTPUT.put_line('INICIO PROCESO DE BUSQUEDA EN PRCONSULTACOMBSOL');
    --Valido que la solicitud no vaya nula
    IF inuCodSol IS NOT NULL THEN

      --DBMS_OUTPUT.put_line('VALIDAR ENTREGA');
      IF fblAplicaEntregaxcaso(csbEntrega2002013) THEN

        ingresoTupla := false;
        onuCodFluNot := 0;
        TempFlujo    := 0;

        --DBMS_OUTPUT.put_line('BUSQUEDA DE COMBINACIONES');
        FOR tupla in cuDatos1 LOOP

          ingresoTupla := true;
          RegCategoria := tupla.categoria;
          RegContrato  := tupla.contrato;
          TempFlujo    := tupla.flujo;
          --DBMS_OUTPUT.put_line('CATEGORIA ' || RegCategoria);
          --DBMS_OUTPUT.put_line('CONTRATO ' || RegContrato);
          --DBMS_OUTPUT.put_line('FLUJO ' || TempFlujo);
          ut_trace.trace('CATEGORIA ' || RegCategoria || 'CONTRATO ' ||
                         RegContrato || 'FLUJO ' || TempFlujo,
                         10);
          --DBMS_OUTPUT.put_line('SE VALIDAN LAS CATEGORIAS');
          OPEN cuDatos2(RegContrato, RegCategoria);
          FETCH cuDatos2
            INTO Cnt_cuDatos2;
          IF cuDatos2%NOTFOUND THEN
            Cnt_cuDatos2 := 0;
          END IF;
          ut_trace.trace('Cnt_cuDatos2[' || Cnt_cuDatos2 || ']', 10);
          --DBMS_OUTPUT.put_line('REGISTROS ' || Cnt_cuDatos2);
          IF (Cnt_cuDatos2 > 0) THEN
            --DBMS_OUTPUT.put_line('SE HALLO UN FLUJO VALIDO');
            onuCodFluNot := TempFlujo;
          END IF;

        END LOOP;

        --Valido si no encontro configuraciones
        IF (ingresoTupla = false) THEN

          --DBMS_OUTPUT.put_line('NO ENCONTRO COMBINACIONES');
          --Error no hay ninguna configuraci?n para ese tipo de Solicitud
          INSERT INTO LDC_INCONSISFLUJO
          VALUES
            (inuCodSol,
             'No existe ninguna configuraci?n para este tipo de Solicitud en la tabla LDC_CONFLUNOTATEACL',
             sysdate);
          --COMMIT;

        ELSE

          --Valido si no hay configuraciones para la categoria de la orden
          IF (onuCodFluNot = 0) THEN

            --DBMS_OUTPUT.put_line('NO ENCONTRO CATEGORIAS');
            INSERT INTO LDC_INCONSISFLUJO
            VALUES
              (inuCodSol,
               'La Categoria asociada al contrato no se halla configurada en la tabla LDC_CONFLUNOTATEACL para el Tipo de Solicitud, Causal de Registro, Tipo de Trabajo, Causal de Legalizacion y Medio de Recepci?n',
               sysdate);
            --COMMIT;

          END IF;

        END IF;

      ELSE

        --DBMS_OUTPUT.put_line('ENTREGA NO APLICADA');
        onuCodFluNot := 99;

      END IF;

    ELSE

      --Si la Solicitud esta Nula se envia el valor generico para que continue el proceso
      onuCodFluNot := 99;

    END IF;
    ut_trace.trace('onuCodFluNot[' || onuCodFluNot || ']', 10);

    /*INSERT INTO LDC_INCONSISFLUJO
    VALUES
      (inuCodSol,
       'onuCodFluNot[' || onuCodFluNot || ']',
       sysdate);
       ----commit;*/

  END PRCONSULTACOMBSOL;

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
                                nucausal_id         or_order.causal_id%type) is

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
       causal_legalizacion)
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
       nucausal_id);

  exception
    when others then
      ERRORS.SETERROR;
      RAISE ex.controlled_error;
  end;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    FNUCONSULTACOMBSOL
  Descripcion :  Devuelve la variable de Salida de PRCONSULTACOMBSOL

  Parametros  :          Descripcion
  inuCodSol              Id de la Solicitud

  Retorno     :
  onuCodFluNot           Valor del parametro de Salida

  Autor    :  Daniel Eduardo Valiente Moreno
  Fecha    :  03-09-2018

  Historia de modificaciones
  Autor    Fecha       Descripcion

  *****************************************************************/

  FUNCTION FNUCONSULTACOMBSOL(inuCodSol IN mo_packages.package_id%type)
    RETURN NUMBER Is
    --RETURN LDC_CONFLUNOTATEACL.flujo_notific%type Is

    onuCodFluNot NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

  BEGIN

    --
    /*INSERT INTO LDC_INCONSISFLUJO
    VALUES
      (inuCodSol,
       'INICIO DE VERIFICACION',
       sysdate);*/
    --COMMIT;
    --
    onuCodFluNot := 0;
    PRCONSULTACOMBSOL(inuCodSol, onuCodFluNot);
    --
    /*INSERT INTO LDC_INCONSISFLUJO
    VALUES
      (inuCodSol,
       'onuCodFluNot[' || onuCodFluNot || ']',
       sysdate);*/
    --COMMIT;
    --
    RETURN onuCodFluNot;

  END FNUCONSULTACOMBSOL;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    PRCONSULTACOMBSOL
  Descripcion :  Generar OT 10810 o 12579 con base a la configuracion establecida
                 en la forma LDCCFNAC

  Parametros  :          Descripcion

  Autor    :  Daniel Eduardo Valiente Moreno
  Fecha    :  31-08-2018

  Historia de modificaciones
  Autor              Fecha         Descripcion
  LJLB               28/02/2020   CA 252 se agrega insert a la tabla LDC_COMEORDORCD y LDC_ORDEELDORCD
  HORTBATH           26/05/2020   CA 377: * Se agrega nuevo cursor llamado cuDataLDCCFNACTODOS con la consulta
                                  a la entidad LDC_CONFLUNOTATEACL para establecer que las b?squedas
                                  con relaci?n a la matriz de la forma LDCCFNAC y establecer una b?squeda
                                  para todos no CUSOLOTINTERACCIONser? con el valor -1 sino cuando el campo tenga un valor NULL.
                                  * Crear un nuevo cursor llamado .
                                  Este cursor permitir? obtener todas las solicitudes y sus ?rdenes asociadas
                                  a la interacci?n que g?nero la nueva orden y las ordenes de estas solicitudes
                                  no est? ya registrada en la entidad LDC_ORDEELDORCD
   Jorge Valiente   06/06/2022    * Utilizar el cursor CUGETDATCOMEORDORCD para estabelcer el comentario de la orden
                                    crear por la configuracion de la MATRIZ DE COMBINACIONES - LDCCFNAC
  *****************************************************************/

  PROCEDURE PRGENOTFNAC AS

    onuCodFluNot NUMBER;

    RegCategoria LDC_CONFLUNOTATEACL.CATECODI%type;
    RegContrato  mo_motive.subscription_id%type;
    TempFlujo    NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

    ingresoTupla boolean;

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
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) categoria,
             (select s.SESUSUCA
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) subcategoria,
             oo.task_type_id tipo_trabajo,
             oo.causal_id causal_legaliza,
             --ge.is_write medio_recepcion,
             MP.RECEPTION_TYPE_ID medio_recepcion,
             ooa.address_id codigo_direccion,
             mp.cust_care_reques_num interaccion,
             daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                         NULL) codigo_localidad,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                     NULL),
                                                         NULL) descripcion_localidad,
             mp.subscriber_id codigo_cliente,
             dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                        NULL) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id,
                                                       NULL) nombre_cliente,
             mp.contact_id contacto,
             dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
             daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
             dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
             dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
             mp.comment_ observacion,
             daps_package_type.fsbgetdescription(mp.package_type_id,
                                                      null) desc_tipo_solicitud
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
    nuvalact                number;

    cursor culd_parameternumber(sbparameter_id ld_parameter.parameter_id%type) is
      select lp.numeric_value
        from ld_parameter lp
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
     FROM OR_ORDER_COMMENT oc,
			MO_PACKAGES           mp,
            OR_ORDER_ACTIVITY     ooa,
            OR_ORDER              oo,
			mo_motive             mm
     where oc.order_id = nuOrden
	 and oc.ORDER_ID = oo.order_id
	 and mp.package_id = ooa.package_id
	 and ooa.ORDER_ID = oo.order_id
	 and mm.package_id = mp.package_id;

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
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) categoria,
             (select s.SESUSUCA
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) subcategoria,
             oo.task_type_id tipo_trabajo,
             oo.causal_id causal_legaliza,
             --ge.is_write medio_recepcion,
             MP.RECEPTION_TYPE_ID medio_recepcion,
             ooa.address_id codigo_direccion,
             mp.cust_care_reques_num interaccion,
             daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                         NULL) codigo_localidad,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                     NULL),
                                                         NULL) descripcion_localidad,
             mp.subscriber_id codigo_cliente,
             dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                        NULL) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id,
                                                       NULL) nombre_cliente,
             mp.contact_id contacto,
             dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
             daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
             dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
             dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
             mp.comment_ observacion,
             daps_package_type.fsbgetdescription(mp.package_type_id,
                                                      null) desc_tipo_solicitud,
             oo.legalization_date fecha_legalizacion
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

    CURSOR cuValActEscr(iteracion number, actividad number) IS
      select count(*)
        from or_order_activity a, or_order o
       where o.order_id = a.order_id
         and o.order_status_id in (0, 5)
         and a.package_id = iteracion --105995046
         and a.activity_id = actividad;

    /*select count(*)
     from mo_packages mp, or_order_activity a, or_order o
    where o.order_id = a.order_id
      and mp.package_id = a.package_id
      and o.order_status_id in (0, 5)
      and mp.cust_care_reques_num = iteracion --105995046
      and a.activity_id = actividad;*/

    CURSOR cuOrdver(iteracion number, actividad number) IS
      select o.order_id, o.order_status_id
        from or_order_activity a, or_order o
       where o.order_id = a.order_id
         and o.order_status_id in (0, 5)
         and a.package_id = iteracion --105995046
         and a.activity_id = actividad;

    /*select o.order_id, o.order_status_id
     from mo_packages mp, or_order_activity a, or_order o
    where o.order_id = a.order_id
      and mp.package_id = a.package_id
      and o.order_status_id in (0, 5)
      and mp.cust_care_reques_num = iteracion --105995046
      and a.activity_id = actividad;*/

    rfcuOrdver cuOrdver%rowtype;

    --Inicio 377

    nuOrdenAct  or_order_activity.order_activity_id%type;
    sbMensaje   varchar2(4000);
    nuMensaje   number;

    ---OSF-327-------------------
    sbComentarioOrden or_order_activity.comment_%type;
    rfCUGETDATCOMEORDORCD CUGETDATCOMEORDORCD%rowtype;
    -------------------------------------------------

  BEGIN

    ut_trace.trace('INICIO LDC_PKFLUNOTATECLI.PRGENOTFNAC', 10);

    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder(); --30178971; --

    ---OSF-327.---------------
    --Obtener el comentario a utilizar en la orden generada
    open CUGETDATCOMEORDORCD(nuOrderId);
    fetch CUGETDATCOMEORDORCD into rfCUGETDATCOMEORDORCD;
    if CUGETDATCOMEORDORCD%found then
      if rfCUGETDATCOMEORDORCD.comentario is not null then
        sbComentarioOrden := rfCUGETDATCOMEORDORCD.comentario;
      end if;
    end if;
    close CUGETDATCOMEORDORCD;
    --------------------------------------------------------

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

        /*
        dbms_output.put_line('Orden[' || nuOrderId || ']-TipoTrabajo[' ||
                             rfcuDataOrden.Tipo_Trabajo ||
                             ']-CausalLegalizacion[' ||
                             rfcuDataOrden.Causal_Legaliza ||
                             ']-TipoSolicitud[' ||
                             rfcuDataOrden.Tipo_Solicitud ||
                             ']-CausalRegistro[' ||
                             rfcuDataOrden.Causal_Registro ||
                             ']-MedioRecepcion[' ||
                             rfcuDataOrden.Medio_Recepcion || ']');
        --*/

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

          /*
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           '*********NO EXISTE CONFIGURACION Orden[' ||
                                           nuOrderId || ']-TipoSolicitud[' ||
                                           rfcuDataOrden.Tipo_Solicitud ||
                                           ']-CausalRegistro[' ||
                                           rfcuDataOrden.Causal_Registro ||
                                           ']-Categoria[' ||
                                           rfcuDataOrden.Categoria ||
                                           ']-TipoTrabajo[' ||
                                           rfcuDataOrden.Tipo_Trabajo ||
                                           ']-CausalLegaliza[' ||
                                           rfcuDataOrden.Causal_Legaliza ||
                                           ']-MedioRecepcion[' ||
                                           rfcuDataOrden.Medio_Recepcion || ']');
          raise ex.CONTROLLED_ERROR;
          --*/
          ut_trace.trace('*********NO EXISTE CONFIGURACION Orden[' ||
                         nuOrderId || ']-TipoSolicitud[' ||
                         rfcuDataOrden.Tipo_Solicitud ||
                         ']-CausalRegistro[' ||
                         rfcuDataOrden.Causal_Registro || ']-Categoria[' ||
                         rfcuDataOrden.Categoria || ']-TipoTrabajo[' ||
                         rfcuDataOrden.Tipo_Trabajo || ']-CausalLegaliza[' ||
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

            if nuMedioRespuesta = nuCOD_FLU_RES_TEL then

              OPEN cuValActEscr(rfcuDataOrden.Interaccion,
                                nuACT_OT_FLU_RES_CAR);
              FETCH cuValActEscr
                INTO nuvalact;
              CLOSE cuValActEscr;
              if nuvalact = 0 or nuvalact is null then
                -----------------------------------------------------------------------------------------------------
                --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
                /*OS_CREATEORDERACTIVITIES(nuACT_OT_FLU_RES_TEL,
                                         NuCodDir,
                                         sysdate,
                                         --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                         'Generacion OT para FLUJO DE RESPUESTA TELEFONICO',
                                         0,
                                         ionuOrderId,
                                         onuErrorCode,
                                         osbErrorMessage);*/

             ionuOrderId := null;
             nuOrdenAct := null;
             onuErrorCode  := null;
             osbErrorMessage  := null;

             or_boorderactivities.createactivity(inuitemsid         => nuACT_OT_FLU_RES_TEL,
                  inupackageid        => rfcuDataOrden.Interaccion,
                  inumotiveid         => null,
                  inucomponentid      => NULL,
                  inuinstanceid       => NULL,
                  inuaddressid        => NuCodDir,
                  inuelementid        => NULL,
                  inusubscriberid     => null,
                  inusubscriptionid   => rfcuDataOrden.contrato,
                  inuproductid        => null,
                  inuopersectorid     => NULL,
                  inuoperunitid       => NULL,
                  idtexecestimdate    => NULL,
                  inuprocessid        => NULL,
                  isbcomment          => sbComentarioOrden,--'Generacion OT para FLUJO DE RESPUESTA TELEFONICO',
                  iblprocessorder     => FALSE,
                  inupriorityid       => NULL,
                  ionuorderid         => ionuOrderId,
                  ionuorderactivityid => nuOrdenAct,
                  inuordertemplateid  => NULL,
                  isbcompensate       => NULL,
                  inuconsecutive      => NULL,
                  inurouteid          => NULL,
                  inurouteconsecutive => NULL,
                  inulegalizetrytimes => 0,
                  isbtagname          => NULL,
                  iblisacttogroup     => FALSE,
                  inurefvalue         => 0);

                IF nvl(ionuOrderId , -1) = -1 then
                  Errors.Geterror(onuErrorCode, osbErrorMessage);
                end if;

                IF onuErrorCode = 0 THEN

                 /* update Or_Order_Activity ooa
                     set ooa.package_id = rfcuDataOrden.Interaccion
                   where ooa.order_id = ionuOrderId;*/

                  prollenaordeeldorcd(ionuOrderId,
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
                                      null,
                                      null);
                  --Se llena comentarios
                  FOR reg IN CUGETDATCOMEORDORCD(ionuOrderId) LOOP
                    prollenacomeordorcd(reg.idcomentario,
                                        reg.ORDEN,
                                        reg.comentario);
                  END LOOP;

                  /*


                    ut_trace.trace('FLUJO DE RESPUESTA TELEFONICO - EXISTE CONFIGURACION Orden[' ||
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

                  else

                    INSERT INTO LDC_INCONSISFLUJO
                    VALUES
                      (rfcuDataOrden.Solicitud,
                       'Error al generar la OT con el servicio OS_CREATEORDERACTIVITIES y la actividad[' ||
                       nuACT_OT_FLU_RES_TEL || '] - [' || osbErrorMessage || ']',
                       sysdate);

                    /*
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     'ERROR - FLUJO DE RESPUESTA TELEFONICO - CodigoError[' ||
                                                     onuErrorCode ||
                                                     ']-MensajeError[' ||
                                                     osbErrorMessage || ']');
                    raise ex.CONTROLLED_ERROR;
                    --*/

                end if;
                --------------------------------------------------------------------------------------------
              end if;

            else
              if nuMedioRespuesta = nuCOD_FLU_RES_CAR then

                --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
                /*OS_CREATEORDERACTIVITIES(nuACT_OT_FLU_RES_CAR,
                                         NuCodDir,
                                         sysdate,
                                         --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                         'Generacion OT para FLUJO DE RESPUESTA CARTA',
                                         0,
                                         ionuOrderId,
                                         onuErrorCode,
                                         osbErrorMessage);*/
             ionuOrderId := null;
             nuOrdenAct := null;
             onuErrorCode  := null;
             osbErrorMessage  := null;

             or_boorderactivities.createactivity(inuitemsid         => nuACT_OT_FLU_RES_CAR,
                  inupackageid        => rfcuDataOrden.Interaccion,
                  inumotiveid         => null,
                  inucomponentid      => NULL,
                  inuinstanceid       => NULL,
                  inuaddressid        => NuCodDir,
                  inuelementid        => NULL,
                  inusubscriberid     => null,
                  inusubscriptionid   => rfcuDataOrden.contrato,
                  inuproductid        => null,
                  inuopersectorid     => NULL,
                  inuoperunitid       => NULL,
                  idtexecestimdate    => NULL,
                  inuprocessid        => NULL,
                  isbcomment          => sbComentarioOrden,--'Generacion OT para FLUJO DE RESPUESTA CARTA',
                  iblprocessorder     => FALSE,
                  inupriorityid       => NULL,
                  ionuorderid         => ionuOrderId,
                  ionuorderactivityid => nuOrdenAct,
                  inuordertemplateid  => NULL,
                  isbcompensate       => NULL,
                  inuconsecutive      => NULL,
                  inurouteid          => NULL,
                  inurouteconsecutive => NULL,
                  inulegalizetrytimes => 0,
                  isbtagname          => NULL,
                  iblisacttogroup     => FALSE,
                  inurefvalue         => 0);

                IF nvl(ionuOrderId , -1) = -1 then
                  Errors.Geterror(onuErrorCode, osbErrorMessage);
                end if;
                IF onuErrorCode = 0 THEN

                  /*update Or_Order_Activity ooa
                     set ooa.package_id = rfcuDataOrden.Interaccion
                   where ooa.order_id = ionuOrderId;*/

                  IF RFcuDataLDCCFNAC.FLAGJOB = 'N' THEN
                    prollenaordeeldorcd(ionuOrderId,
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
                                        null,
                                        null);

                    --Se llena comentarios
                    FOR reg IN CUGETDATCOMEORDORCD(ionuOrderId) LOOP
                      prollenacomeordorcd(reg.idcomentario,
                                          reg.ORDEN,
                                          reg.comentario);
                    END LOOP;

                    ut_trace.trace('FLUJO DE RESPUESTA CARTA - EXISTE CONFIGURACION Orden[' ||
                                   nuOrderId || ']-TipoSolicitud[' ||
                                   rfcuDataOrden.Tipo_Solicitud ||
                                   ']-CausalRegistro[' ||
                                   rfcuDataOrden.Causal_Registro ||
                                   ']-Categoria[' ||
                                   rfcuDataOrden.Categoria ||
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
                                          rfCUSOLOTINTERACCION.Causal_Legaliza);

                      --Se llena comentarios de las ordenes con el comentario de su respectiva solicitud
                      FOR reg IN CUGETDATCOMEORDORCD(rfCUSOLOTINTERACCION.Orden) LOOP
                        prollenacomeordorcd(reg.idcomentario,
                                            reg.ORDEN,
                                            reg.comentario||
                                            ' - ' || rfCUSOLOTINTERACCION.observacion );
                      END LOOP;

                    end loop;
                    --FIn CASO 377

                  END IF;

                else

                  INSERT INTO LDC_INCONSISFLUJO
                  VALUES
                    (rfcuDataOrden.Solicitud,
                     'Error al generar la OT con el servicio OS_CREATEORDERACTIVITIES y la actividad[' ||
                     nuACT_OT_FLU_RES_CAR || '] - [' || osbErrorMessage || ']',
                     sysdate);

                  /*
                  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                   'ERROR - FLUJO DE RESPUESTA CARTA - CodigoError[' ||
                                                   onuErrorCode ||
                                                   ']-MensajeError[' ||
                                                   osbErrorMessage || ']');
                  raise ex.CONTROLLED_ERROR;
                  --*/

                end if;

                -----
                FOR rfcuOrdver IN cuOrdver(rfcuDataOrden.Interaccion,
                                           nuACT_OT_FLU_RES_TEL) LOOP

                  BEGIN
                    Or_BOAnullOrder.AnullOrderWithOutVal(rfcuOrdver.order_id,
                                                         SYSDATE);
                  EXCEPTION
                    WHEN OTHERS THEN
                      ut_trace.trace('Error al anular la orden ' ||
                                     rfcuOrdver.order_id || ' error: ' ||
                                     SQLERRM,
                                     10);
                  END;
                END LOOP;
                -----
              end if; --nuMedioRespuesta = nuCOD_FLU_RES_CAR

            end if;

          END IF;

        end if;
        ---Fin Proceso generacion OT Flujo--------------------------------------

      end if;
    end if;
    close cuDataOrden;

    ut_trace.trace('FIN LDC_PKFLUNOTATECLI.PRGENOTFNAC', 10);

    --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'PASO FINAL');
    --raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PRGENOTFNAC;

  --Serivicio adicional solciitado por la funcional Liliana Cabarcas
  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    PRGENOTINTERACCION
  Descripcion :  Generar OT 10810 o 12579 con base a la configuracion establecida
                 en la forma LDCCFNAC con relacion a que la orden de la solicitud
                 generada configurada en esta forma no este legalizada y la causal
                 de legalizacion en la configuracion sea NULL

  Parametros  :          Descripcion

  Autor    :  GDC
  Fecha    :  24-07-2020

  Historia de modificaciones
  Autor            Fecha         Descripcion
  Jorge Valiente   06/06/2022    * Creacion del cursor cuComentarioOrden para estabelcer el comentario de la orden
                                  crear por la configuracion de la MATRIZ DE COMBINACIONES - LDCCFNAC

  *****************************************************************/

  PROCEDURE PRGENOTINTERACCION(InuOrderId or_order.order_id%type) AS

    onuCodFluNot NUMBER;

    RegCategoria LDC_CONFLUNOTATEACL.CATECODI%type;
    RegContrato  mo_motive.subscription_id%type;
    TempFlujo    NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

    ingresoTupla boolean;

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
         AND LDC_CFNAC.CAUSAL_ID IS NULL --= INUCAUSAL_ID
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
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) categoria,
             (select s.SESUSUCA
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) subcategoria,
             oo.task_type_id tipo_trabajo,
             oo.causal_id causal_legaliza,
             --ge.is_write medio_recepcion,
             MP.RECEPTION_TYPE_ID medio_recepcion,
             ooa.address_id codigo_direccion,
             mp.cust_care_reques_num interaccion,
             daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                         NULL) codigo_localidad,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                     NULL),
                                                         NULL) descripcion_localidad,
             mp.subscriber_id codigo_cliente,
             dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                        NULL) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id,
                                                       NULL) nombre_cliente,
             mp.contact_id contacto,
             dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
             daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
             dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
             dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
             mp.comment_ observacion,
             daps_package_type.fsbgetdescription(mp.package_type_id,
                                                      null) desc_tipo_solicitud
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
    nuvalact                number;
    nucanotver              number;

    cursor culd_parameternumber(sbparameter_id ld_parameter.parameter_id%type) is
      select lp.numeric_value
        from ld_parameter lp
       where lp.parameter_id = sbparameter_id;

    rfculd_parameternumber culd_parameternumber%rowtype;

    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

    NuCodDir    number;
    ionuOrderId number;

    nuOrdenAct  or_order_activity.order_activity_id%type;
    sbMensaje   varchar2(4000);
    nuMensaje   number;

    --INICIO CA 252
    -- Cursor que obtiene la informacion para llenar la tabla LDC_COMEORDORCD
    CURSOR CUGETDATCOMEORDORCD(nuOrden number) IS
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
     FROM OR_ORDER_COMMENT oc,
			MO_PACKAGES           mp,
            OR_ORDER_ACTIVITY     ooa,
            OR_ORDER              oo,
			mo_motive             mm
     where oc.order_id = nuOrden
	 and oc.ORDER_ID = oo.order_id
	 and mp.package_id = ooa.package_id
	 and ooa.ORDER_ID = oo.order_id
	 and mm.package_id = mp.package_id;

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
         and CAUSAL_ID is null
            /*and nvl(CAUSAL_ID, -1) =
            decode(nvl(CAUSAL_ID, -1), -1, -1, INUCAUSAL_ID)*/
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
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) categoria,
             (select s.SESUSUCA
                from servsusc s
               where s.sesususc = mm.subscription_id
                 and s.sesuserv = InuPAR_TIPO_SERVICIO_GAS
                 and rownum = 1) subcategoria,
             oo.task_type_id tipo_trabajo,
             oo.causal_id causal_legaliza,
             --ge.is_write medio_recepcion,
             MP.RECEPTION_TYPE_ID medio_recepcion,
             ooa.address_id codigo_direccion,
             mp.cust_care_reques_num interaccion,
             daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                         NULL) codigo_localidad,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(ooa.address_id,
                                                                                                     NULL),
                                                         NULL) descripcion_localidad,
             mp.subscriber_id codigo_cliente,
             dage_subscriber.fsbgetsubscriber_name(mp.subscriber_id,
                                                        NULL) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(mp.subscriber_id,
                                                       NULL) nombre_cliente,
             mp.contact_id contacto,
             dage_person.fsbgetname_(mp.contact_id, NULL) nombre_contacto,
             daab_address.fsbgetaddress_parsed(ooa.address_id, NULL) direccion,
             dage_subscriber.fsbgetphone(mp.subscriber_id, NULL) telefono,
             dage_subscriber.fsbgete_mail(mp.subscriber_id, NULL) email,
             mp.comment_ observacion,
             daps_package_type.fsbgetdescription(mp.package_type_id,
                                                      null) desc_tipo_solicitud,
             oo.legalization_date fecha_legalizacion
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

    CURSOR cuValActEscr(iteracion number, actividad number) IS
      select count(*)
        from or_order_activity a, or_order o
       where o.order_id = a.order_id
         --and o.order_status_id in (0, 5)
         and a.package_id = iteracion --105995046
         and a.activity_id = actividad;

    /*select count(*)
     from mo_packages mp, or_order_activity a, or_order o
    where o.order_id = a.order_id
      and mp.package_id = a.package_id
      and o.order_status_id in (0, 5)
      and mp.cust_care_reques_num = iteracion --105995046
      and a.activity_id = actividad;*/

    CURSOR cuOrdver(iteracion number, actividad number) IS
      select o.order_id, o.order_status_id
        from or_order_activity a, or_order o
       where o.order_id = a.order_id
         and o.order_status_id in (0, 5)
         and a.package_id = iteracion --105995046
         and a.activity_id = actividad;

    /*select o.order_id, o.order_status_id
     from mo_packages mp, or_order_activity a, or_order o
    where o.order_id = a.order_id
      and mp.package_id = a.package_id
      and o.order_status_id in (0, 5)
      and mp.cust_care_reques_num = iteracion --105995046
      and a.activity_id = actividad;*/

    rfcuOrdver cuOrdver%rowtype;

    --Inicio 377

    ---OSF-327-------------------
    cursor cuComentarioOrden(nuOrden number) IS
      SELECT 'Solicitud[' || mp.package_id || ' - ' ||
           daps_package_type.fsbgetdescription(mp.package_type_id) ||
           '] - Causal Registro [' ||
           nvl(daCC_CAUSAL.fsbgetdescription(mm.causal_id, null), '') ||
           '] - Comentario[' || mp.comment_ || ']' comentario
      FROM MO_PACKAGES       mp,
           OR_ORDER_ACTIVITY ooa,
           OR_ORDER          oo,
           mo_motive         mm
      where oo.order_id = nuOrden
       and mp.package_id = ooa.package_id
       and ooa.ORDER_ID = oo.order_id
       and mm.package_id = mp.package_id;

    sbComentarioOrden or_order_activity.comment_%type;
    -------------------------------------------------

  BEGIN

    ut_trace.trace('INICIO LDC_PKFLUNOTATECLI.PRGENOTINTERACCION', 10);

    nuOrderId := InuOrderId; --or_bolegalizeorder.fnuGetCurrentOrder(); --30178971; --

    --Carga el tipo de servicio gas
    open culd_parameternumber('PAR_TIPO_SERVICIO_GAS');
    fetch culd_parameternumber
      into rfculd_parameternumber;
    if culd_parameternumber%found then
      if nvl(rfculd_parameternumber.numeric_value, 0) > 0 then
        nuPAR_TIPO_SERVICIO_GAS := rfculd_parameternumber.numeric_value;
      end if;
    end if;
    close culd_parameternumber;

    ---OSF-327.---------------
    --Obtener el comentario a utilizar en la orden generada
    open cuComentarioOrden(nuOrderId);
    fetch cuComentarioOrden into sbComentarioOrden;
    close cuComentarioOrden;
    --------------------------------------------------------

    open cuDataOrden(nuOrderId, nuPAR_TIPO_SERVICIO_GAS);
    fetch cuDataOrden
      into rfcuDataOrden;
    if cuDataOrden%found then
      if rfcuDataOrden.Solicitud is not null then

        /*
        dbms_output.put_line('Orden[' || nuOrderId || ']-TipoTrabajo[' ||
                             rfcuDataOrden.Tipo_Trabajo ||
                             ']-CausalLegalizacion[' ||
                             rfcuDataOrden.Causal_Legaliza ||
                             ']-TipoSolicitud[' ||
                             rfcuDataOrden.Tipo_Solicitud ||
                             ']-CausalRegistro[' ||
                             rfcuDataOrden.Causal_Registro ||
                             ']-MedioRecepcion[' ||
                             rfcuDataOrden.Medio_Recepcion || ']');
        --*/

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

          /*
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           '*********NO EXISTE CONFIGURACION Orden[' ||
                                           nuOrderId || ']-TipoSolicitud[' ||
                                           rfcuDataOrden.Tipo_Solicitud ||
                                           ']-CausalRegistro[' ||
                                           rfcuDataOrden.Causal_Registro ||
                                           ']-Categoria[' ||
                                           rfcuDataOrden.Categoria ||
                                           ']-TipoTrabajo[' ||
                                           rfcuDataOrden.Tipo_Trabajo ||
                                           ']-CausalLegaliza[' ||
                                           rfcuDataOrden.Causal_Legaliza ||
                                           ']-MedioRecepcion[' ||
                                           rfcuDataOrden.Medio_Recepcion || ']');
          raise ex.CONTROLLED_ERROR;
          --*/
          ut_trace.trace('*********NO EXISTE CONFIGURACION Orden[' ||
                         nuOrderId || ']-TipoSolicitud[' ||
                         rfcuDataOrden.Tipo_Solicitud ||
                         ']-CausalRegistro[' ||
                         rfcuDataOrden.Causal_Registro || ']-Categoria[' ||
                         rfcuDataOrden.Categoria || ']-TipoTrabajo[' ||
                         rfcuDataOrden.Tipo_Trabajo || ']-CausalLegaliza[' ||
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

            if nuMedioRespuesta = nuCOD_FLU_RES_TEL then

              OPEN cuValActEscr(rfcuDataOrden.Interaccion,
                                nuACT_OT_FLU_RES_CAR);
              FETCH cuValActEscr
                INTO nuvalact;
              CLOSE cuValActEscr;

              OPEN cuValActEscr(rfcuDataOrden.Interaccion,
                                nuACT_OT_FLU_RES_TEL);
              FETCH cuValActEscr
                INTO nucanotver;
              CLOSE cuValActEscr;

              if (nuvalact = 0 or nuvalact is null) and nucanotver = 0 then
                -----------------------------------------------------------------------------------------------------
                --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
                --dsaltarin se corrige el api de generacion de otr
                /*OS_CREATEORDERACTIVITIES(nuACT_OT_FLU_RES_TEL,
                                         NuCodDir,
                                         sysdate,
                                         --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                         'Generacion OT para FLUJO DE RESPUESTA TELEFONICO',
                                         0,
                                         ionuOrderId,
                                         onuErrorCode,
                                         osbErrorMessage);
                */
             ionuOrderId := null;
             nuOrdenAct := null;
             onuErrorCode  := null;
             osbErrorMessage  := null;

             or_boorderactivities.createactivity(inuitemsid         => nuACT_OT_FLU_RES_TEL,
                  inupackageid        => rfcuDataOrden.Interaccion,
                  inumotiveid         => null,
                  inucomponentid      => NULL,
                  inuinstanceid       => NULL,
                  inuaddressid        => NuCodDir,
                  inuelementid        => NULL,
                  inusubscriberid     => null,
                  inusubscriptionid   => rfcuDataOrden.contrato,
                  inuproductid        => null,
                  inuopersectorid     => NULL,
                  inuoperunitid       => NULL,
                  idtexecestimdate    => NULL,
                  inuprocessid        => NULL,
                  isbcomment          => sbComentarioOrden, --'Generacion OT para FLUJO DE RESPUESTA TELEFONICO',
                  iblprocessorder     => FALSE,
                  inupriorityid       => NULL,
                  ionuorderid         => ionuOrderId,
                  ionuorderactivityid => nuOrdenAct,
                  inuordertemplateid  => NULL,
                  isbcompensate       => NULL,
                  inuconsecutive      => NULL,
                  inurouteid          => NULL,
                  inurouteconsecutive => NULL,
                  inulegalizetrytimes => 0,
                  isbtagname          => NULL,
                  iblisacttogroup     => FALSE,
                  inurefvalue         => 0);

                IF nvl(ionuOrderId , -1) = -1 then
                  Errors.Geterror(onuErrorCode, osbErrorMessage);
                end if;
                IF onuErrorCode = 0 THEN

                  /*update Or_Order_Activity ooa
                     set ooa.package_id = rfcuDataOrden.Interaccion
                   where ooa.order_id = ionuOrderId;*/

                  prollenaordeeldorcd(ionuOrderId,
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
                                      null,
                                      null);
                  --Se llena comentarios
                  FOR reg IN CUGETDATCOMEORDORCD(ionuOrderId) LOOP
                    prollenacomeordorcd(reg.idcomentario,
                                        reg.ORDEN,
                                        reg.comentario);
                  END LOOP;

                  /*


                    ut_trace.trace('FLUJO DE RESPUESTA TELEFONICO - EXISTE CONFIGURACION Orden[' ||
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

                  else

                    INSERT INTO LDC_INCONSISFLUJO
                    VALUES
                      (rfcuDataOrden.Solicitud,
                       'Error al generar la OT con el servicio OS_CREATEORDERACTIVITIES y la actividad[' ||
                       nuACT_OT_FLU_RES_TEL || '] - [' || osbErrorMessage || ']',
                       sysdate);

                    /*
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     'ERROR - FLUJO DE RESPUESTA TELEFONICO - CodigoError[' ||
                                                     onuErrorCode ||
                                                     ']-MensajeError[' ||
                                                     osbErrorMessage || ']');
                    raise ex.CONTROLLED_ERROR;
                    --*/

                end if;
                --------------------------------------------------------------------------------------------
              end if;

            else
              OPEN cuValActEscr(rfcuDataOrden.Interaccion,
                                nuACT_OT_FLU_RES_CAR);
              FETCH cuValActEscr
                INTO nuvalact;
              CLOSE cuValActEscr;
              if nuMedioRespuesta = nuCOD_FLU_RES_CAR and nuvalact = 0 then

                --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
                /*OS_CREATEORDERACTIVITIES(nuACT_OT_FLU_RES_CAR,
                                         NuCodDir,
                                         sysdate,
                                         --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                         'Generacion OT para FLUJO DE RESPUESTA CARTA',
                                         0,
                                         ionuOrderId,
                                         onuErrorCode,
                                         osbErrorMessage);*/

             ionuOrderId := null;
             nuOrdenAct := null;
             onuErrorCode  := null;
             osbErrorMessage  := null;

             or_boorderactivities.createactivity(inuitemsid         => nuACT_OT_FLU_RES_CAR,
                  inupackageid        => rfcuDataOrden.Interaccion,
                  inumotiveid         => null,
                  inucomponentid      => NULL,
                  inuinstanceid       => NULL,
                  inuaddressid        => NuCodDir,
                  inuelementid        => NULL,
                  inusubscriberid     => null,
                  inusubscriptionid   => rfcuDataOrden.contrato,
                  inuproductid        => null,
                  inuopersectorid     => NULL,
                  inuoperunitid       => NULL,
                  idtexecestimdate    => NULL,
                  inuprocessid        => NULL,
                  isbcomment          => sbComentarioOrden, --'Generacion OT para FLUJO DE RESPUESTA CARTA',
                  iblprocessorder     => FALSE,
                  inupriorityid       => NULL,
                  ionuorderid         => ionuOrderId,
                  ionuorderactivityid => nuOrdenAct,
                  inuordertemplateid  => NULL,
                  isbcompensate       => NULL,
                  inuconsecutive      => NULL,
                  inurouteid          => NULL,
                  inurouteconsecutive => NULL,
                  inulegalizetrytimes => 0,
                  isbtagname          => NULL,
                  iblisacttogroup     => FALSE,
                  inurefvalue         => 0);

                IF nvl(ionuOrderId , -1) = -1 then
                  Errors.Geterror(onuErrorCode, osbErrorMessage);
                end if;

                IF onuErrorCode = 0 THEN

                  /*update Or_Order_Activity ooa
                     set ooa.package_id = rfcuDataOrden.Interaccion
                   where ooa.order_id = ionuOrderId;*/

                  IF RFcuDataLDCCFNAC.FLAGJOB = 'N' THEN
                    prollenaordeeldorcd(ionuOrderId,
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
                                        null,
                                        null);

                    --Se llena comentarios
                    FOR reg IN CUGETDATCOMEORDORCD(ionuOrderId) LOOP
                      prollenacomeordorcd(reg.idcomentario,
                                          reg.ORDEN,
                                          reg.comentario);
                    END LOOP;

                    ut_trace.trace('FLUJO DE RESPUESTA CARTA - EXISTE CONFIGURACION Orden[' ||
                                   nuOrderId || ']-TipoSolicitud[' ||
                                   rfcuDataOrden.Tipo_Solicitud ||
                                   ']-CausalRegistro[' ||
                                   rfcuDataOrden.Causal_Registro ||
                                   ']-Categoria[' ||
                                   rfcuDataOrden.Categoria ||
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
                                          rfCUSOLOTINTERACCION.Causal_Legaliza);

                      --Se llena comentarios de las ordenes con el comentario de su respectiva solicitud
                      FOR reg IN CUGETDATCOMEORDORCD(rfCUSOLOTINTERACCION.Orden) LOOP
                        prollenacomeordorcd(reg.idcomentario,
                                            reg.ORDEN,
                                            reg.comentario ||
                                            ' - ' ||rfCUSOLOTINTERACCION.observacion  );
                      END LOOP;

                    end loop;
                    --FIn CASO 377

                  END IF;

                else

                  INSERT INTO LDC_INCONSISFLUJO
                  VALUES
                    (rfcuDataOrden.Solicitud,
                     'Error al generar la OT con el servicio OS_CREATEORDERACTIVITIES y la actividad[' ||
                     nuACT_OT_FLU_RES_CAR || '] - [' || osbErrorMessage || ']',
                     sysdate);

                  /*
                  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                   'ERROR - FLUJO DE RESPUESTA CARTA - CodigoError[' ||
                                                   onuErrorCode ||
                                                   ']-MensajeError[' ||
                                                   osbErrorMessage || ']');
                  raise ex.CONTROLLED_ERROR;
                  --*/

                end if;

                -----
                FOR rfcuOrdver IN cuOrdver(rfcuDataOrden.Interaccion,
                                           nuACT_OT_FLU_RES_TEL) LOOP

                  BEGIN
                    Or_BOAnullOrder.AnullOrderWithOutVal(rfcuOrdver.order_id,
                                                         SYSDATE);
                  EXCEPTION
                    WHEN OTHERS THEN
                      ut_trace.trace('Error al anular la orden ' ||
                                     rfcuOrdver.order_id || ' error: ' ||
                                     SQLERRM,
                                     10);
                  END;
                END LOOP;
                -----
              end if; --nuMedioRespuesta = nuCOD_FLU_RES_CAR

            end if;

          END IF;

        end if;
        ---Fin Proceso generacion OT Flujo--------------------------------------

      end if;
    end if;
    close cuDataOrden;

    ut_trace.trace('FIN LDC_PKFLUNOTATECLI.PRGENOTINTERACCION', 10);

    --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'PASO FINAL');
    --raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PRGENOTINTERACCION;
  ----------------------------------------------------------------------------

END LDC_PKFLUNOTATECLI;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKFLUNOTATECLI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKFLUNOTATECLI', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_PKFLUNOTATECLI para reportes
GRANT EXECUTE ON adm_person.LDC_PKFLUNOTATECLI TO rexereportes;
/