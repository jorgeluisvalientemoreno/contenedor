CREATE OR REPLACE PACKAGE LDC_IMPESTADOCUENTA IS

  /*****************************************************************
    Unidad      :   LDC_IMPESTADOCUENTA
    Descripcion   :   Paquete que contiene la logica para el proceso LDCIEC
                    Impresion masiva de duplicados
    ============        ===================

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20/01/2014      agordillo           Creacion
    06/03/2015      Agordillo           Modificacion Incidente.143734
	22-11-2016      Sandra Muñoz        CA 200-326. Modificación GenerateFactDuplicado
	5/11/2019		Miguel Ballesteros  CA 68. Modificacion de la funcion frfConsultaSolicitud
    06-Sep-2023     felipe.valencia     OSF-1388 Se modifica para cambiar el api os_legalizeorders
                                        a api_legalizeorders
                                        Se elimina aplica entrega OSS_OL_0000068_4
										Se elimina aplica entrega BSS_FAC_NCZ_200326_10
										Se elimina aplica entrega x caso 0000805
    **************************************************************/

  CSBVERSION            CONSTANT VARCHAR2(40) := 'OSF-1388';

  globalsesion NUMBER;

  /*Funcion que devuelve la version del pkg*/
  FUNCTION FSBVERSION RETURN VARCHAR2;

  FUNCTION frfConsultaSolicitud RETURN Constants.tyRefCursor;

  PROCEDURE ProcessSolicitud(isbPk        IN VARCHAR2,
                             inuCurrent   IN NUMBER,
                             inuTotal     IN NUMBER,
                             onuErrorCode OUT ge_error_log.message_id%TYPE,
                             osbErrorMess OUT ge_error_log.description%TYPE);

  FUNCTION fsbGetNombreCliente(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2;

  FUNCTION fnuFechaLimPago(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2;

  FUNCTION fnuGetSaldoPendiente(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2;

  FUNCTION fnuGetUltimaFact(inuContrato IN suscripc.susccodi%TYPE)
    RETURN NUMBER;

  FUNCTION fnuEdConfexmeEC(INUSUBSCRIPTION IN FACTURA.FACTSUSC%TYPE)
    RETURN NUMBER;

  PROCEDURE InsertDuplicadoclob(inufactcodi IN factura.factcodi%TYPE,
                                inuContrato IN suscripc.susccodi%TYPE,
                                inuCurrent  IN NUMBER,
                                inuTotal    IN NUMBER);

  PROCEDURE GenerateFactDuplicado(inuContrato     IN suscripc.susccodi%TYPE,
                                  inuFactura      IN factura.factcodi%TYPE,
                                  onuErrorCode    OUT NUMBER,
                                  osbErrorMessage OUT VARCHAR2);

  PROCEDURE LegOrdenDuplicado(inuOrden        IN or_order.order_id%TYPE,
                              onuErrorCode    OUT NUMBER,
                              osbErrorMessage OUT VARCHAR2);

  --cambio 7430
  /*****************************************************************
  Unidad      :   fsbGetDepartamento
  Descripcion :   Permite obtener el nombre del departamento asociado a la direccion de al orden
  Parametros          Descripcion
  ============        ===================
  inuContrato         codigo de la direcccion
  inutipodato         codigo del tipo de dato a retonar
                             0 --> Codigo
                             1 --> Nombre


  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  12/05/2015      Jorge Valiente           Creacion
  **************************************************************/
  FUNCTION fsbGetDepartamento(inuaddress_id IN or_order_activity.address_id%TYPE,
                              inutipodato   NUMBER) RETURN VARCHAR2;

  /*****************************************************************
  Unidad      :   fsbGetLocalidad
  Descripcion :   Permite obtener el nombre de la localidad asociado a la direccion de al orden
  Parametros          Descripcion
  ============        ===================
  inuContrato         codigo de la direcccion
  inutipodato         codigo del tipo de dato a retonar
                             0 --> Codigo
                             1 --> Nombre


  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  12/05/2015      Jorge Valiente           Creacion
  **************************************************************/
  FUNCTION fsbGetLocalidad(inuaddress_id IN or_order_activity.address_id%TYPE,
                           inutipodato   NUMBER) RETURN VARCHAR2;
  --fin cambio 7430

END LDC_IMPESTADOCUENTA;

/
CREATE OR REPLACE PACKAGE BODY LDC_IMPESTADOCUENTA IS

  /* Mensaje que indica que falta un parametro requerido */
  cnuNULL_ATTRIBUTE CONSTANT ge_message.message_id%TYPE := 2126;
  CNUNO_CONFEXME    CONSTANT NUMBER := 13162;

  TYPE tbSolicitud IS TABLE OF LDC_SOL_DUPLICADO_TMP%ROWTYPE INDEX BY BINARY_INTEGER;

  gtbDatos tbSolicitud;

  /*Funcion que devuelve la version del pkg*/
  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    RETURN CSBVERSION;
  END FSBVERSION;

  /*****************************************************************
  Unidad      :   frfConsultaSolicitud
  Descripcion   :   Consulta las solicitudes de duplicado que se encuentran registradas,
                  en el rango de fechas diligenciados en la forma LDCIEC
  Parametros          Descripcion
  ============        ===================

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  12/06/2015      Jorge Valiente      Cambio 7430: Adicion de nuevos campos para identificar el
                                                   DEPARTEMNTO y LOCALIDAD en el resultado de la consulta
  15/04/2019      Daniel Valiente     Se modifico la rutina de insercion de datos por medio de un BulkCollect
                                      Se unifico el proceso al momento de registrar en las tablas TMP y PL

  06/09/2023      felipe.valencia     Se elimina aplica entrega OSS_OL_0000068_4
  **************************************************************/

  FUNCTION frfConsultaSolicitud RETURN Constants.tyRefCursor IS

    sbREQUEST_DATE   ge_boInstanceControl.stysbValue;
    sbATTENTION_DATE ge_boInstanceControl.stysbValue;
    --cambio 7430
    sbCUCODEPA ge_boInstanceControl.stysbValue;
    sbCUCOLOCA ge_boInstanceControl.stysbValue;
    ---fin cambio 7430

    /* Cursor referenciado con datos de la consulta */
    rfResult constants.tyRefCursor;

    /* Atributos de la consulta */
    sbAttributes ge_boutilities.styStatement;
    /* Tablas de la consulta */
    sbFrom ge_boutilities.styStatement;
    /* Criterios de consulta */
    sbWhere ge_boutilities.styStatement;
    /* Consulta de ?rdenes */
    sbSql ge_boutilities.styStatement;

    nuTipoTrabajo   or_task_type.task_type_id%TYPE;
    nuTipoSolicitud ps_package_type.package_type_id%TYPE := 100212;
    nuEstSolicitud  NUMBER := 13;

    onuError          number;
    osbErrorMessage   varchar2(2000);

    nuDatos NUMBER;
    nuIndex NUMBER;


    --Caso 200-2439 danval 15-04-19 variables para nuevos procesos
    orfRegistros pkConstante.tyRefCursor;
    TYPE Registros_TYPE IS TABLE OF LDC_SOL_DUPLICADO_TMP%ROWTYPE;
    itab          Registros_TYPE;
    i             number;
    sbAttributes1 ge_boutilities.styStatement;
    sbSql1        ge_boutilities.styStatement;
    ---
  BEGIN

    IF globalsesion IS NULL THEN
      globalsesion := userenv('SESSIONID');
    END IF;

    -------------------- CASO 68 ---------------------------------
    nuTipoTrabajo :=  DALD_PARAMETER.fsbGetValue_Chain('COD_TT_DUPLICADO', NULL);
    --------------------------------------------------------------


    ut_trace.trace('[INICIO] LDC_IMPESTADOCUENTA.frfConsultaSolicitud', 10);
    /*'15/04/2018 00:00:00';*/
    sbREQUEST_DATE := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                            'REQUEST_DATE');
    /*'15/04/2019 00:00:00';*/
    sbATTENTION_DATE := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                              'ATTENTION_DATE');

    --cambio 7430
    --variable que permitira contener el codigo del DEPARTAMENTO
    /*'-1';*/
    sbCUCODEPA := ge_boInstanceControl.fsbGetFieldValue('CUENCOBR',
                                                        'CUCODEPA');
    --variable que permitira contener el codigo del LOCALIDAD
    sbCUCOLOCA := ge_boInstanceControl.fsbGetFieldValue('CUENCOBR',
                                                        'CUCOLOCA');
    --fin cambio 7430

    ------------------------------------------------
    -- User code
    ------------------------------------------------

    IF (sbATTENTION_DATE < sbREQUEST_DATE) THEN
      pkg_error.setErrorMessage(2691,
                      'La Fecha Final no puede ser menor a la fecha Inicial');
      RAISE pkg_error.CONTROLLED_ERROR;
    END IF;

    /* Atributos de la consulta */
    ge_boutilities.AddAttribute(' or_order_activity.subscription_id ',
                                '"Numero_Contrato"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' dage_subscriber.fsbgetidentification(pktblsuscripc.fnugetsuscclie(or_order_activity.subscription_id))',
                                '"Identificacion"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetNombreCliente(or_order_activity.subscription_id) ',
                                '"Nombre_Cliente"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' mo_packages.package_id',
                                '"Solicitud_Duplicado"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' mo_packages.request_date',
                                '"Fecha_Solicitud"',
                                sbAttributes);
    -------------------- CASO 68 ---------------------------------
    ge_boutilities.AddAttribute(' or_order_activity.order_id',
                                '"Orden_de_Trabajo"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' or_order.order_status_id ',
                                '"Estado_de_Orden"',
                                sbAttributes);
    -- se agrega el campo direccion --
    ge_boutilities.AddAttribute(' daab_address.fsbgetaddress(or_order_activity.address_id, null) ',
                                '"Direccion"',
                                sbAttributes);
    --------------------------------------------------------------
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fnuGetSaldoPendiente(or_order_activity.subscription_id) ',
                                '"Saldo_Pendiente_Contrato"',
                                sbAttributes);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fnuFechaLimPago(or_order_activity.subscription_id) ',
                                '"Fecha_Limite_Pago"',
                                sbAttributes);
    ----cambio 7430
    --colcado para obtener el DEPARTAMENTO
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetDepartamento(or_order_activity.address_id,0) || '' - '' || LDC_IMPESTADOCUENTA.fsbGetDepartamento(or_order_activity.address_id,1) ',
                                '"Departamento"',
                                sbAttributes);
    --colcado para obtener el LOCALIDAD
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetLocalidad(or_order_activity.address_id,0) || '' - '' || LDC_IMPESTADOCUENTA.fsbGetLocalidad(or_order_activity.address_id,1) ',
                                '"Localidad"',
                                sbAttributes);
    ----fin cambio 7430

    --Caso 200-2439 danval 15-04-19 atributos consulta del bulkcollect
    /* Atributos de la consulta */
    ge_boutilities.AddAttribute(' or_order_activity.subscription_id ',
                                '"contrato"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' dage_subscriber.fsbgetidentification(pktblsuscripc.fnugetsuscclie(or_order_activity.subscription_id))',
                                '"identificacion"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetNombreCliente(or_order_activity.subscription_id) ',
                                '"nombre"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' mo_packages.package_id',
                                '"solicitud"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' mo_packages.request_date',
                                '"fecha_solicitud"',
                                sbAttributes1);
    -------------------- CASO 68 ---------------------------------
    ge_boutilities.AddAttribute(' or_order_activity.order_id',
                                '"orden"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' or_order.order_status_id ',
                                '"estado_orden"',
                                sbAttributes1);
    -- se agrega el campo direccion --
    ge_boutilities.AddAttribute('daab_address.fsbgetaddress(or_order_activity.address_id, null) ',
                                '"Direccion"',
                                sbAttributes1);
    ---------------------------------------------------------------
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fnuGetSaldoPendiente(or_order_activity.subscription_id) ',
                                '"saldo_pendiente"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fnuFechaLimPago(or_order_activity.subscription_id) ',
                                '"limited_pago"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetDepartamento(or_order_activity.address_id,0) || '' - '' || LDC_IMPESTADOCUENTA.fsbGetDepartamento(or_order_activity.address_id,1) ',
                                '"departamento"',
                                sbAttributes1);
    ge_boutilities.AddAttribute(' LDC_IMPESTADOCUENTA.fsbGetLocalidad(or_order_activity.address_id,0) || '' - '' || LDC_IMPESTADOCUENTA.fsbGetLocalidad(or_order_activity.address_id,1) ',
                                '"localidad"',
                                sbAttributes1);
    ---

    sbFrom := 'mo_packages, or_order_activity, or_order';

    -------------------- CASO 68 ---------------------------------

    sbWhere := 'where package_type_id=' || nuTipoSolicitud ||
  ' and motive_status_id=' || nuEstSolicitud ||
  ' and mo_packages.package_id = or_order_activity.package_id
    and or_order_activity.task_type_id in (' || nuTipoTrabajo ||
                                          ')
    and or_order_activity.order_id = or_order.order_id
    and or_order.order_status_id=5
    and trunc(mo_packages.request_date) between ''' ||
              to_date(sbREQUEST_DATE, 'dd/mm/yyyy hh24:mi:ss') || '''' ||
              ' and ''' ||
              to_date(sbATTENTION_DATE, 'dd/mm/yyyy hh24:mi:ss') || '''';

    --------------------------------------------------------------
    ---cambio 7430
    ---logica que permitira validar si selecciono un departamento de forma especifica.
    IF sbCUCODEPA <> '-1' THEN
      sbWhere := sbWhere ||
                 ' and LDC_IMPESTADOCUENTA.fsbGetDepartamento(or_order_activity.address_id,0) = ' ||
                 to_number(sbCUCODEPA);
      IF sbCUCOLOCA <> '-1' THEN
        sbWhere := sbWhere ||
                   ' and LDC_IMPESTADOCUENTA.fsbGetLocalidad(or_order_activity.address_id,0) = ' ||
                   to_number(sbCUCOLOCA);
      END IF;
    END IF;
    ---fin cambio 7430

    -- Se agrega el paquete para eliminar las solicitudes duplicadas [caso 68]
    LDC_PKANULSOLICDUPLI.LDC_SEARCHSOLIREPET(nuTipoSolicitud,
                                              nuEstSolicitud,
                                              sbREQUEST_DATE,
                                              sbATTENTION_DATE,
                                              nuTipoTrabajo   );


    sbSql := ' SELECT ' || chr(10) || sbAttributes || chr(10) || ' FROM ' ||
             sbFrom || chr(10) || sbWhere;
    --caso 200-2439 danval 15-04-19 select bulk Collect
    sbSql1 := ' SELECT ' || chr(10) || sbAttributes1 || chr(10) || ' FROM ' ||
              sbFrom || chr(10) || sbWhere;
    ---

    ut_trace.trace('sbSql:[' || sbSql || ']', 10);

    DELETE LDC_SOL_DUPLICADO_TMP;

    --Caso 200-2439 danval 15-04-19 Se modifica logica para que el bulck collect lo haga de a 10 registro y no en una sola coleccion
    OPEN orfRegistros FOR sbSql1;
    LOOP
      FETCH orfRegistros BULK COLLECT
        INTO itab limit 10;
      i := itab.FIRST;
      while (i is not null) loop
        if itab.EXISTS(i) then
          -------------------- CASO 68 ---------------------------------

         ut_trace.trace('INSERT INTO LDC_SOL_DUPLICADO_TMP values (' || itab(i).
                        contrato || ',''' || itab(i).identificacion ||
                        ''',''' || itab(i).nombre || ''',' || itab(i)
                       .solicitud || ',''' || itab(i).fecha_solicitud ||
                        ''',' || itab(i).orden || ',' || itab(i)
                       .estado_orden || ',''' || itab(i).direccion ||
                       ''',' || itab(i).saldo_pendiente ||',''' ||
                       itab(i).limited_pago || ''',''' || itab(i)
                       .departamento || ''',''' || itab(i).localidad ||
                        ''')',
                         10);


          EXECUTE IMMEDIATE 'INSERT INTO LDC_SOL_DUPLICADO_TMP values (' || itab(i).
                            contrato || ',''' || itab(i).identificacion ||
                            ''',''' || itab(i).nombre || ''',' || itab(i)
                           .solicitud || ',''' || itab(i).fecha_solicitud ||
                            ''',' || itab(i).orden || ',' || itab(i)
                           .estado_orden || ',''' || itab(i).direccion ||
                           ''',' || itab(i).saldo_pendiente ||',''' ||
                           itab(i).limited_pago || ''',''' || itab(i)
                           .departamento || ''',''' || itab(i).localidad ||
                            ''')';


          ---
          nuIndex := itab(i).contrato;
          gtbDatos(nuIndex).contrato := itab(i).contrato;
          gtbDatos(nuIndex).identificacion := itab(i).identificacion;
          gtbDatos(nuIndex).nombre := itab(i).nombre;
          gtbDatos(nuIndex).solicitud := itab(i).solicitud;
          gtbDatos(nuIndex).fecha_solicitud := itab(i).fecha_solicitud;
          gtbDatos(nuIndex).orden := itab(i).orden;
          gtbDatos(nuIndex).estado_orden := itab(i).estado_orden;
          gtbDatos(nuIndex).direccion := itab(i).direccion;
          gtbDatos(nuIndex).saldo_pendiente := itab(i).saldo_pendiente;
          gtbDatos(nuIndex).limited_pago := itab(i).limited_pago;
          ---------------------------------------------------------------------------
        end if;
        i := itab.NEXT(i);
      end loop;
      EXIT WHEN orfRegistros%NOTFOUND;
    end loop;
    CLOSE orfRegistros;

    OPEN rfResult FOR sbSql /*sbSql1*/;

    ut_trace.trace('[FIN] LDC_IMPESTADOCUENTA.frfConsultaSolicitud', 10);

    RETURN rfResult;
  END frfConsultaSolicitud;

  /*****************************************************************
  Unidad      :   ProcessSolicitud
  Descripcion   :
  Parametros          Descripcion
  ============        ===================

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  PROCEDURE ProcessSolicitud(isbPk        IN VARCHAR2,
                             inuCurrent   IN NUMBER,
                             inuTotal     IN NUMBER,
                             onuErrorCode OUT ge_error_log.message_id%TYPE,
                             osbErrorMess OUT ge_error_log.description%TYPE) AS

    nuFactura factura.factcodi%TYPE;
  BEGIN
    ut_trace.trace('[Inicia] LDC_IMPESTADOCUENTA.ProcessSolicitud Datos Entrada',
                   10);
    ut_trace.trace(' Datos Entrada' || isbPk || ' inuCurrent ' ||
                   inuCurrent || ' inuTotal ' || inuTotal,
                   10);

    nuFactura := LDC_IMPESTADOCUENTA.fnuGetUltimaFact(isbPk);

    IF (nuFactura != 0) THEN
      LDC_IMPESTADOCUENTA.InsertDuplicadoclob(nuFactura,
                                              isbPk,
                                              inuCurrent,
                                              inuTotal);
    END IF;

    ut_trace.trace('[FIN] LDC_IMPESTADOCUENTA.ProcessSolicitud', 10);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END ProcessSolicitud;

  /*****************************************************************
  Unidad      :   fsbGetNombreCliente
  Descripcion   :   Permite consultar el nombre del cliente dado el contrato
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  FUNCTION fsbGetNombreCliente(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2 IS
    sbNombre VARCHAR2(250);
  BEGIN

    SELECT REPLACE(subscriber_name, '&', '') || ' ' ||
           REPLACE(subs_last_name, '&', '')
      INTO sbNombre
      FROM suscripc, ge_subscriber
     WHERE susccodi = inuContrato
       AND suscclie = subscriber_id;

    if sbNombre is null then
      sbnombre := '';
    end if;

    RETURN sbNombre;

  EXCEPTION
    WHEN no_data_found THEN
      sbNombre := ' ';
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fsbGetNombreCliente;

  /*****************************************************************
  Unidad      :   fnuFechaLimPago
  Descripcion   :   Permite consultar la fecha de limited de pago de la ultima
                  factura del cliente, dado el contrato
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  FUNCTION fnuFechaLimPago(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2 IS
    sbFecha      VARCHAR2(250);
    nuUltimaFact NUMBER := 0;
  BEGIN

    BEGIN

      SELECT num_factura
        INTO nuUltimaFact
        FROM (SELECT factcodi num_factura
                FROM factura
               WHERE factsusc = inuContrato --and factprog=6
               ORDER BY factfege DESC)
       WHERE rownum = 1;

    EXCEPTION
      WHEN no_data_found THEN
        nuUltimaFact := 0;
    END;

    IF (nuUltimaFact != 0) THEN

      BEGIN
        SELECT to_char(cucofeve, 'DD/MM/YYYY')
          INTO sbFecha
          FROM cuencobr
         WHERE cucofact = nuUltimaFact
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          sbFecha := ' ';
      END;

    END IF;

    if sbFecha is null then
      sbFecha := '01/01/2001';
    end if;

    RETURN sbFecha;

  EXCEPTION
    WHEN no_data_found THEN
      sbFecha := ' ';
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fnuFechaLimPago;

  /*****************************************************************
  Unidad      :   fnuGetSaldoPendiente
  Descripcion   :   Permite consulta el saldo pendiente del contrato
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  FUNCTION fnuGetSaldoPendiente(inuContrato IN suscripc.susccodi%TYPE)
    RETURN VARCHAR2 IS
    nuSaldoPendiente NUMBER;
  BEGIN

    SELECT (SUM(CUCOSACU) - SUM(CUCOVARE) - SUM(CUCOVRAP))
      INTO nuSaldoPendiente
      FROM servsusc, cuencobr
     WHERE sesususc = inuContrato
       AND cuconuse = sesunuse
       AND cucosacu > 0;

    if nuSaldoPendiente is null then
      nuSaldoPendiente := 0;
    end if;

    RETURN nuSaldoPendiente;
  EXCEPTION
    WHEN no_data_found THEN
      nuSaldoPendiente := ' ';
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fnuGetSaldoPendiente;

  /*****************************************************************
  Unidad      :   fnuGetUltimaFact
  Descripcion   :   Obtiene la ultima factura generada para el contrato
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  FUNCTION fnuGetUltimaFact(inuContrato IN suscripc.susccodi%TYPE)
    RETURN NUMBER IS
    nuFactura factura.factcodi%TYPE;
  BEGIN

    SELECT num_factura
      INTO nuFactura
      FROM (SELECT factcodi num_factura
              FROM factura
             WHERE factsusc = inuContrato --and factprog=6
             ORDER BY factfege DESC)
     WHERE rownum = 1;

    if nuFactura is null then
      nuFactura := 0;
    end if;

    RETURN nuFactura;

  EXCEPTION
    WHEN no_data_found THEN
      nuFactura := 0;
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fnuGetUltimaFact;

  /*****************************************************************
  Unidad      :   InsertDuplicadoclob
  Descripcion   :   Inserta el duplicado en la tabla temporar para realizar la impresion a pdf
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  PROCEDURE InsertDuplicadoclob(inufactcodi IN factura.factcodi%TYPE,
                                inuContrato IN suscripc.susccodi%TYPE,
                                inuCurrent  IN NUMBER,
                                inuTotal    IN NUMBER) IS

    rctempclob      Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
    nuExecutableId  sa_executable.executable_id%TYPE;
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
    nuOrden         NUMBER;

  BEGIN

    ut_trace.trace('Inicia InsertDuplicadoclob ', 10);

    BEGIN

      rctempclob := NULL;

      /*Insertar el clob en la entidad ld_temp_clob_fact*/
      ut_trace.trace('-- PASO 1.Insertar el clob en la entidad ld_temp_clob_fact Factura:' ||
                     inufactcodi,
                     10);
      rctempclob.temp_clob_fact_id := LD_BOSequence.Fnuseqld_temp_clob_fact;
      rctempclob.template_id       := to_char(inufactcodi);
      rctempclob.package_id        := gtbDatos(inuContrato).solicitud;

      /*Capturar la sesion de usuario*/
      IF globalsesion IS NULL THEN
        globalsesion := userenv('SESSIONID');
      END IF;

      ut_trace.trace('-- PASO 2.globalsesion = ' || globalsesion, 10);
      rctempclob.sesion := globalsesion;

      /*Insertar registro en entidad ld_temp_clob_fact*/
      ut_trace.trace('Datos: template_id' || rctempclob.TEMPLATE_ID ||
                     ' sesion' || rctempclob.SESION,
                     10);

      BEGIN
        -- paulaag
        Dald_Temp_Clob_Fact.insRecord(rctempclob);
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          onuErrorCode    := ld_boconstans.cnuGeneric_Error;
          osbErrorMessage := '-Error insertando la factura [' ||
                             inufactcodi ||
                             '] en la entidad ld_temp_clob_fact_1';
          ROLLBACK;
      END;

      -- Genera el duplicado
      GenerateFactDuplicado(inuContrato,
                            inufactcodi,
                            onuErrorCode,
                            osbErrorMessage);

      -- Si termino de procesar los datos, llama al proceso de impresion
      IF inuCurrent = inuTotal THEN
        COMMIT;

        ut_trace.trace('-- PASO 7.Componente .net ', 10);
        --Obtener ejecutable del .net sa_executable
        nuExecutableId := sa_boexecutable.fnuGetExecutableIdbyName(Ld_Boconstans.csbGen_Sale_Duplicate,
                                                                   FALSE);

        --Setear componente .net
        Ld_Bosubsidy.SetEventPrint(nuExecutableId);

        --Realizar el llamado a la aplicacion que se encarga de generar los duplicados de factura
        Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbGen_Sale_Duplicate);

      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
        osbErrorMessage := 'Error insertando la factura [' || inufactcodi ||
                           '] en la entidad ld_temp_clob_fact';
        ROLLBACK;
    END;

    <<error>>
    NULL;

    ut_trace.trace('-- FIN InsertDuplicadoclob', 10);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END InsertDuplicadoclob;

  /*****************************************************************
  Unidad      :   GenerateFactDuplicado
  Descripcion   :   Genera el duplicado de la factura, haciendo el llamado al los
                  procesos de extracion
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  06/03/2015      agordillo           Modificacion Incidente.143734
                                      Se modifica el cursor cuTemp_Clob, se le agrega el parametro de entrada
                                      inuFact para que se consulte solamente la factura que se esta procesando.
  22-11-2016      Sandra Muñoz        CA 200-326. Se modifica temporalmente el segmento de rangos para poder ser visualizado en los duplicados
  **************************************************************/
  PROCEDURE GenerateFactDuplicado(inuContrato     IN suscripc.susccodi%TYPE,
                                  inuFactura      IN factura.factcodi%TYPE,
                                  onuErrorCode    OUT NUMBER,
                                  osbErrorMessage OUT VARCHAR2) IS

    CURSOR cuTemp_Clob(inusession NUMBER, inuFact NUMBER) IS -- Agordillo Incidente.143734
      SELECT l.package_id,
             l.temp_clob_fact_id,
             l.template_id,
             l.docudocu,
             l.sesion
        FROM ld_temp_clob_fact l
       WHERE l.sesion = inusession -- Agordillo Incidente.143734
         AND l.template_id = inuFact;

    nuParamConfexme ld_parameter.numeric_value%TYPE;
    --  nuPackType              mo_packages.package_type_id%type;
    nuConfexme     ed_confexme.coemcodi%TYPE;
    rcExtMixConf   ed_confexme%ROWTYPE;
    nuFormatCode   ed_formato.formcodi%TYPE;
    nuFactura      cuencobr.cucofact%TYPE;
    nubilldocument ld_parameter.parameter_id%TYPE;
    clfactclob     CLOB;
    rctempclob     Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
    --   nuindex                 number;

    RCFACTURA FACTURA%ROWTYPE;
    ONUCOUPON NUMBER;

    nuOrden           or_order.order_id%TYPE;
    nuStaOrden        or_order.order_status_id%TYPE;
    nuDatos           NUMBER;
    rcLD_Cupon_Causal daLD_Cupon_Causal.styLD_Cupon_Causal;
    nuModificado      NUMBER;

  BEGIN

    ut_trace.trace('-- PASO 5.1.Inicio LDC_IMPESTADOCUENTA.GenerateFactDuplicado globalsesion ' ||
                   globalsesion,
                   10);

    -- Obtiene el ED_CONFEXME del contrato
    nuParamConfexme := LDC_IMPESTADOCUENTA.fnuEdConfexmeEC(inuContrato);

    ut_trace.trace('-- PASO 5.3 CONFEXME = ' || nuParamConfexme, 10);

    FOR rcTemp_Clob IN cuTemp_Clob(globalsesion, inuFactura) LOOP

      --  Obtiene el ed_confexme pra la extraccion y mezcla
      IF (nuParamConfexme IS NOT NULL) THEN
        -- Asocia el confexme obtenido del parametro  -- ed_confexme
        nuConfexme := nuParamConfexme;
        -- Obtiene nombre de plantilla
        rcExtMixConf                  := pktblED_ConfExme.frcGetRecord(nuConfexme);
        ld_bosubsidy.globalsbTemplate := rcExtMixConf.coempadi;
        ut_trace.trace('-- PASO 5.7 rcExtMixConf.coempadi = ' ||
                       rcExtMixConf.coempadi,
                       10);

        IF (rcExtMixConf.coempadi IS NULL) THEN
          ut_trace.trace('-- PASO 5.8 rcExtMixConf.coempadi IS null', 10);
          onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
          osbErrorMessage := 'Error al buscar el template para realizar la mezcla a partir del identificador: ' ||
                             nuConfexme || ', de la tabla ED_ConfExme';
          GOTO error;
        END IF;

        --  Obtiene el ID del formato a partir del identificador  ed_confexme  ed_document
        nuFormatCode := pkBOInsertMgr.GetCodeFormato(rcExtMixConf.coempada);
        ut_trace.trace('-- PASO 5.9 nuFormatCode:' || nuFormatCode, 10);
      ELSE
        ut_trace.trace('-- PASO 5.10 error al buscar el template para realizar la mezcla',
                       10);
        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
        osbErrorMessage := 'Error al buscar el template para realizar la mezcla';
        GOTO error;
      END IF;

      -- Obtener la factura asociada a la solicitud
      nuFactura := to_number(rcTemp_Clob.template_id); --rcTemp_Clob.temp_clob_fact_id;   ld_temp_clob_fact
      ut_trace.trace('-- PASO 5.11 Factura recuperada ' || nuFactura, 10);

      IF nuFactura IS NOT NULL THEN

        -- Obtener el tipo de documento de la factura
        nubilldocument := pktblfactura.fnuGetFACTCONS(nuFactura, NULL); -- factura
        ut_trace.trace('-- PASO 5.12 nubilldocument=' || nubilldocument ||
                       ' nuFormatCode ' || nuFormatCode || ' nuFactura ' ||
                       nuFactura,
                       10);
        -- Se borra la variable
        clfactclob := NULL;

        --  Genera los datos de la factura
        RCFACTURA := PKTBLFACTURA.FRCGETRECORD(inuFactura,
                                               PKCONSTANTE.NOCACHE);
        PKBOPRINTINGPROCESS.PROCESSBYBILL(RCFACTURA,
                                          PKCONSTANTE.NO,
                                          PKBILLCONST.CSBTOKEN_FACTURA,
                                          nuFormatCode,
                                          ONUCOUPON,
                                          clfactclob);

        ut_trace.trace('clfactclob - original' || to_char(clfactclob), 10);

          -- Modifica el xml para generar el bloque LDC_RANGOS_2
          nuModificado := LDC_DUPLICADO_MESES_ANT.fnuModificaED_Document(inufactura => inuFactura,
                                                                         iclxml     => clfactclob);

        ut_trace.trace('clfactclob - ' || to_char(clfactclob), 10);

        -- nuindex := LD_BOSequence.Fnuseqld_temp_clob_fact;
        ut_trace.trace('-- PASO 5.16 Insertar el clob en la entidad ld_temp_clob_fact = ' ||
                       globalsesion,
                       10);

        -- Actualiza el clob en la entidad ld_temp_clob_fact
        rctempclob.temp_clob_fact_id := rcTemp_Clob.temp_clob_fact_id;
        rctempclob.sesion            := globalsesion;
        rctempclob.docudocu          := clfactclob;
        rctempclob.template_id       := rcTemp_Clob.template_id; --paulaag
        rctempclob.package_id        := rcTemp_Clob.package_id; --paulaag
        -- Actualiza registro en entidad ld_temp_clob_fact
        Dald_Temp_Clob_Fact.updRecord(rctempclob);

        ut_trace.trace('-- PASO 5.17 Actualizo registro en Dald_Temp_Clob_Fact con data:' ||
                       'rctempclob.temp_clob_fact_id =>' ||
                       rctempclob.temp_clob_fact_id ||
                       'rctempclob.sesion =>' || rctempclob.sesion ||
                       'rctempclob.template_id=>' ||
                       rctempclob.template_id || 'rctempclob.package_id=>' ||
                       rctempclob.package_id,
                       10);

        IF (clfactclob IS NOT NULL) THEN
          ut_trace.trace('Empieza a Legalizar... contrato ' || inuContrato ||
                         ' Num Datos del proceso ' || gtbDatos.count,
                         10);

          nuOrden := gtbDatos(inuContrato).orden;

          ut_trace.trace('Empieza a Legalizar la orden de trabajo ' ||
                         nuOrden,
                         10);

          LDC_IMPESTADOCUENTA.LegOrdenDuplicado(nuOrden,
                                                onuErrorCode,
                                                osbErrorMessage);

          nuStaOrden := pkg_bcordenes.fnuObtieneEstado(nuOrden);


          IF (onuErrorCode > 0) THEN
            ut_trace.trace('Error en la legalizacion de la orden ' ||
                           onuErrorCode,
                           10);
          END IF;

          IF (nuStaOrden = 8) THEN
            -- Insert sobre la tabla LD_Cupon_Causal
            ut_trace.trace('Insertando LD_Cupon_Causal, para el cobro del duplicado',
                           10);
            rcLD_Cupon_Causal.cuponume   := ONUCOUPON;
            rcLD_Cupon_Causal.causal_id  := 120; --glCausal_Cupon_id;
            rcLD_Cupon_Causal.package_id := gtbDatos(inuContrato).solicitud;
            DALD_CUPON_CAUSAL.insRecord(rcLD_Cupon_Causal);

          END IF;

        END IF;

      ELSE
        ut_trace.trace('-- PASO 5.18 no se ha obtenido una factura desde el Proceso de Batch',
                       10);
        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
        osbErrorMessage := '[Error] no se ha obtenido una factura desde el Proceso de Batch';
        GOTO error;
      END IF;

      --Fin obtener CLOB de la solicitud procesada
      <<error>>
      NULL;

    END LOOP;

    ut_trace.trace('-- PASO 5.19 Fin LDC_IMPESTADOCUENTA.GenerateFactDuplicado',
                   10);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END GenerateFactDuplicado;

  /*****************************************************************
  Unidad      :   fnuEdConfexmeEC
  Descripcion   :   Obtiene el ed_confexme del contrato
                  procesos de extracion
  Parametros          Descripcion
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  FUNCTION fnuEdConfexmeEC(INUSUBSCRIPTION IN FACTURA.FACTSUSC%TYPE)
    RETURN NUMBER --ED_CONFEXME%ROWTYPE
   IS
    NUCONFEXID ED_CONFEXME.COEMCODI%TYPE;
    RCCONFEXME ED_CONFEXME%ROWTYPE;
    NUCOMPANY  SISTEMA.SISTCODI%TYPE;
  BEGIN
    UT_TRACE.TRACE('INICIA LDC_IMPESTADOCUENTA.fnuEdConfexmeEC', 16);
    -- Consulta el ed_confexme del contrato
    NUCONFEXID := PKTBLSUSCRIPC.FNUGETSUSCCOEM(INUSUBSCRIPTION);

    -- Si no lo encuentra en el formato se consulta en la tabla sistema
    IF (NUCONFEXID IS NULL) THEN
      NUCOMPANY  := SA_BOSYSTEM.FNUGETUSERCOMPANYID;
      NUCONFEXID := PKTBLSISTEMA.FNUGETSISTCOEM(NUCOMPANY);
    END IF;

    IF (NUCONFEXID IS NOT NULL) THEN
      RCCONFEXME := PKTBLED_CONFEXME.FRCGETRECORD(NUCONFEXID);
    ELSE

	  pkg_error.setErrorMessage(CNUNO_CONFEXME,'El atributo no puede ser nulo');

      RAISE LOGIN_DENIED;
    END IF;
    UT_TRACE.TRACE('LDC_IMPESTADOCUENTA.fnuEdConfexmeEC ', 16);

    RETURN RCCONFEXME.COEMCODI;

  EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR pkg_error.CONTROLLED_ERROR THEN
      UT_TRACE.TRACE('Error (LOGIN_DENIED) LDC_IMPESTADOCUENTA.fnuEdConfexmeEC ',
                     17);
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      UT_TRACE.TRACE('Error (OTHERS) LDC_IMPESTADOCUENTA.fnuEdConfexmeEC ',
                     17);
      RAISE pkg_error.CONTROLLED_ERROR;
  END fnuEdConfexmeEC;

  /*****************************************************************
  Unidad      :   LegOrdenDuplicado
  Descripcion   :   Permite legalizar una orden de duplicado
  ============        ===================
  inuContrato         Contrato del Cliente

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  20/01/2014      agordillo           Creacion
  **************************************************************/
  PROCEDURE LegOrdenDuplicado(inuOrden        IN or_order.order_id%TYPE,
                              onuErrorCode    OUT NUMBER,
                              osbErrorMessage OUT VARCHAR2) AS
    nuCausalLeg      NUMBER;
    nuPersonaLeg     NUMBER;
    sbObservacion    VARCHAR2(2000);
    ISBDATAORDER     VARCHAR2(2000);
    SBINCONSISTENCIA VARCHAR2(1000);

    idtExeInitialDate DATE := SYSDATE;
    idtExeFinalDate   DATE := SYSDATE;
    idtChangeDate     DATE := SYSDATE;
    --  onuErrorCode        NUMBER;
    --  osbErrorMessage     VARCHAR2(4000);
    nuOperatingUnit NUMBER;
    nuPersonOp      NUMBER;
  BEGIN

    ut_trace.trace('Inicia LDC_IMPESTADOCUENTA.LegOrdenDuplicado', 10);

    -- Se obtiene la unidad operativa de la orden
    nuOperatingUnit := pkg_bcordenes.fnuObtieneUnidadOperativa(inuOrden);

    IF (nuOperatingUnit IS NOT NULL) THEN
      nuPersonOp := daor_operating_unit.fnugetperson_in_charge(nuOperatingUnit);
    END IF;

    -- Causal de legalizacion
    nuCausalLeg := dald_parameter.fnuGetNumeric_Value('COD_CAU_LEG_SOL_DUPLICADO');
    -- Persona para legalizar la orden
    nuPersonaLeg := nuPersonOp; --dald_parameter.fnuGetNumeric_Value('COD_USER_LEG_SOL_DUPLICADO');

    sbObservacion := dald_parameter.fsbGetValue_Chain('OBS_ORDEN_SOL_DUPLICADO') || ' ' ||
                     SYSDATE;

    ISBDATAORDER := inuOrden || '|' || nuCausalLeg || '|' || nuPersonaLeg || '||' ||
                    ldc_bcfinanceot.fnuGetActivityId(inuOrden) || '>' || 0 /*FALLO*/
                    ||
                    ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;' ||
                    sbObservacion;

    ut_trace.trace('Datos ' || ISBDATAORDER, 10);

    api_legalizeorders(ISBDATAORDER,
                      idtExeInitialDate,
                      idtExeFinalDate,
                      idtChangeDate,
                      onuErrorCode,
                      osbErrorMessage);

    IF onuErrorCode <> 0 THEN
      SBINCONSISTENCIA := ' Error en la legalizacion del duplicado de la Factura ';
      UT_TRACE.TRACE(SBINCONSISTENCIA, 17);
    END IF;

    ut_trace.trace('Fin LDC_IMPESTADOCUENTA.LegOrdenDuplicado', 10);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END LegOrdenDuplicado;

  --cambio 7430
  /*****************************************************************
  Unidad      :   fsbGetDepartamento
  Descripcion :   Permite obtener el nombre del departamento asociado a la direccion de al orden
  Parametros          Descripcion
  ============        ===================
  inuContrato         codigo de la direcccion
  inutipodato         codigo del tipo de dato a retonar
                             0 --> Codigo
                             1 --> Nombre

  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  12/05/2015      Jorge Valiente           Creacion
  **************************************************************/
  FUNCTION fsbGetDepartamento(inuaddress_id IN or_order_activity.address_id%TYPE,
                              inutipodato   NUMBER) RETURN VARCHAR2 IS
    sbNombre VARCHAR2(4000);
  BEGIN

    IF inutipodato = 0 THEN
      SELECT DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(daab_address.fnugetgeograp_location_id(inuaddress_id,
                                                                                                            NULL),
                                                                NULL)
        INTO sbNombre
        FROM dual;
    END IF;
    IF inutipodato = 1 THEN
      SELECT DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(daab_address.fnugetgeograp_location_id(inuaddress_id,
                                                                                                                                                        NULL),
                                                                                                            NULL),
                                                         NULL)
        INTO sbNombre
        FROM dual;
    END IF;

    if sbNombre is null then
      sbnombre := '';
    end if;

    RETURN sbNombre;

  EXCEPTION
    WHEN no_data_found THEN
      sbNombre := ' ';
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fsbGetDepartamento;

  /*****************************************************************
  Unidad      :   fsbGetLocalidad
  Descripcion :   Permite obtener el nombre de la localidad asociado a la direccion de al orden
  Parametros          Descripcion
  ============        ===================
  inuContrato         codigo de la direcccion
  inutipodato         codigo del tipo de dato a retonar
                             0 --> Codigo
                             1 --> Nombre


  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ============    =================== ====================
  12/05/2015      Jorge Valiente           Creacion
  **************************************************************/
  FUNCTION fsbGetLocalidad(inuaddress_id IN or_order_activity.address_id%TYPE,
                           inutipodato   NUMBER) RETURN VARCHAR2 IS
    sbNombre VARCHAR2(4000);
  BEGIN

    IF inutipodato = 0 THEN
      SELECT daab_address.fnugetgeograp_location_id(inuaddress_id,
                                                         NULL)
        INTO sbNombre
        FROM dual;
    END IF;
    IF inutipodato = 1 THEN
      SELECT DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(daab_address.fnugetgeograp_location_id(inuaddress_id,
                                                                                                     NULL),
                                                         NULL)
        INTO sbNombre
        FROM dual;
    END IF;

    if sbNombre is null then
      sbnombre := '';
    end if;

    RETURN sbNombre;

  EXCEPTION
    WHEN no_data_found THEN
      sbNombre := ' ';
    WHEN pkg_error.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      pkg_error.Seterror;
      RAISE pkg_error.CONTROLLED_ERROR;
  END fsbGetLocalidad;
  --fin cambio 7430

END LDC_IMPESTADOCUENTA;
/
GRANT EXECUTE on LDC_IMPESTADOCUENTA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_IMPESTADOCUENTA to REXEOPEN;
GRANT EXECUTE on LDC_IMPESTADOCUENTA to REXEINNOVA;
GRANT EXECUTE on LDC_IMPESTADOCUENTA to PERSONALIZACIONES;
/
