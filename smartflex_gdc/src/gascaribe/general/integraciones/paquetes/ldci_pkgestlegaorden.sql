create or replace PACKAGE LDCI_PKGESTLEGAORDEN AS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKGESTLEGAORDEN
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I015
     DESCRIPCION: Paquete de integracion de ordenes de lectura

    Historia de Modificaciones
    Autor                                  Fecha        Descripcion
    carlosvl<carlos.virgen@olsoftware.com> 07-02-2014   #NC-87252: Manejo del numero de registros por lote mediante un parametro del sistema

    JESUS VIVERO (LUDYCOM)                 19-01-2015   #20150119: jesusv: - Se agrega procesos de registro de logs y inicializacion de cursor de xistencia de orden
                                                                           - Se agregan campos de control de fechas y procesamiento

    JESUS VIVERO (LUDYCOM)                 30-01-2015   #20150130: jesusv: Se corrige cursor de ordenes notificadas en XML para asegurar actualizar el estado de las que pasaron por XML a PI

    JESUS VIVERO (LUDYCOM)                 12-02-2015   #20150212: jesusv: Se corrige error de sincronizacion y control para Jobs de Anulacion y Legalizacion de ordenes

    AAcuna                                 10-04-2017   #Ca200-1200: Se modifica dependiendo el sistema si cambia la fecha de cambio de estado o no
    Eduardo Aguera                         28/12/2017   200-1583 Se crea procedimiento proLegalizaOrdenesSistema para independizar la legalizacion por sistemas. Cambio de legalizacion de
                                                        ordenes de trabajo de sincrono a asincrono para el sistema SIGELEC.

    horbath                                28/12/2018   200-2254 se modifica el procedimiento proLegalizaOrdenesSistema para darle trato especial a las ordenes
                                                        tt 12457 para que cambie tipo de trabajo, causal y actividad del or_order_activity que vengan por las pda

    horbath                                06/04/2019   200-2466 se modifica el procedimiento proLegalizaOrdenesSistema para darle trato especial a las legaciones
                                                        de combinacion que vengan configurados en la tabla LDCCONFCTSUSPA por la forma LDCCFCTSA
                                                        
    Miguel Ballesteros(OLSOFTWARE)         14/01/2020   250 - Se modifica la cadena de legalizacion de la variable SARTA para tener en cuenta el valor de la cantidad por el tipo de causal

    Lubin Pineda                            15/05/2024  OSF-2603: Se ajusta NOTIFICARPROCESOORDENES y se hace
                                                        pública para prueba por medio de tester
  */

  procedure PROSETFILEAT(inuActivity     in NUMBER,
                         isbFileName     in VARCHAR2,
                         isbObservation  in VARCHAR2,
                         icbFileSrc      in CLOB,
                         onuErrorCode    Out NUMBER,
                         osbErrorMessage Out VARCHAR2);

  procedure PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId   In NUMBER,
                                          inuGeograLocationId  In NUMBER,
                                          inuConsCycleId       In NUMBER,
                                          Inuoperatingsectorid In NUMBER,
                                          inuRouteId           In NUMBER,
                                          Idtinitialdate       In Date,
                                          Idtfinaldata         In Date,
                                          Inutasktypeid        In Number,
                                          inuOrderStatusId     In NUMBER,
                                          Onuerrorcode         Out Number,
                                          Osberrormsg          Out Varchar2);

  function fdtValidaSystem(istSystem     ldci_ordenesalegalizar.system%type,
                           idtChangeDate ldci_ordenesalegalizar.changedate%type,
                           osbMensaje    OUT VARCHAR2) RETURN DATE;

  procedure PROLEGALIZARORDEN(ISBDATAORDER  in varchar2,
                              IDTINITDATE   in date,
                              IDTFINALDATE  in date,
                              IDTCHANGEDATE in date,
                              Resultado     out Number,
                              Msj           out Varchar2);

  procedure proLegalizaOrdenes;

  procedure proLegalizaOrdenesSistema(isbSistema ldci_ordenesalegalizar.system%type);

  procedure proNotificaOrdenesLegalizadas;

  procedure PROCESOORDENES;

  /*
  * NC:        Validacion si una orden esta o no
  *            legalizada, retorna 0 si no esta legalizada
  *            retorna 1 si esta legalizada, y -1 si termino errores
  * FECHA:     15-01-2013
  *
  * Autor:     Hector Fabio Dominguez
  *
  */

  function fnuValidaOrdLega(isbIdOrden IN VARCHAR2,
                            osbMensaje OUT VARCHAR2) RETURN NUMBER;

  procedure proInsLoteOrdenesALegalizar(iclXMLOrdenes in CLOB);

  procedure proLegalizaOrdenesRelecturas(isbSistema ldci_ordenesalegalizar.system%type);

  procedure proLegalizaOrdenesSistemaCiclo(isbSistema ldci_ordenesalegalizar.system%type,
                                           isbCicl    number);

  procedure proActualizaEstado(inuOrden       in ldci_ordenesalegalizar.order_id%type,
                               inuMessageCode in ldci_ordenesalegalizar.messagecode%type,
                               isbMessageText in ldci_ordenesalegalizar.messagetext%type,
                               isbstate       in ldci_ordenesalegalizar.state%type);
  PROCEDURE procLegalizaActivity(inuorden        in or_order.order_id%type,
                                 inuopera        in or_order.operating_unit_id%type,
                                 inucausal       in or_order.causal_id%type,
                                 sbcomment       in or_order_activity.comment_%type,
                                 onuErrorCode    in out NUMBER,
                                 osbErrorMessage in out VARCHAR2);

  PROCEDURE procInstArtefac(nuORDER_ACTIVITY_ID or_activ_appliance.order_activity_id%type,
                            nuAPPLIANCE_ID      or_activ_appliance.appliance_id%type,
                            nuAMOUNT            or_activ_appliance.amount%type,
                            onuErrorCode        in out NUMBER,
                            osbErrorMessage     in out VARCHAR2);

  PROCEDURE procInstDefect(NUORDER_ACTIVITY_ID or_activ_defect.order_activity_id%type,
                           NUDEFECT_ID         or_activ_defect.defect_id%type,
                           onuErrorCode        in out NUMBER,
                           osbErrorMessage     in out VARCHAR2);
                           
    procedure NOTIFICARPROCESOORDENES(nuestaproc in LDCI_ESTAPROC.PROCCODI%type);
                           
END LDCI_PKGESTLEGAORDEN;
/

create or replace Package Body LDCI_PKGESTLEGAORDEN As

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

  -- Carga variables globales
  sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
  sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
  sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
  sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
  sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
  sbProtocol     LDCI_CARASEWE.CASEVALO%type;
  sbHost         LDCI_CARASEWE.CASEVALO%type;
  sbPuerto       LDCI_CARASEWE.CASEVALO%type;
  sbPrefijoLDC   LDCI_CARASEWE.CASEVALO%type;
  sbDefiSewe     LDCI_DEFISEWE.DESECODI%type;

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKGESTLEGAORDEN
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I015
     DESCRIPCION: Paquete de integracion de ordenes de lectura

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

  procedure proCreaLogIntegra(iclInfoXml     in Clob,
                              isbComentarios In Varchar2,
                              inuRegistros   In Number,
                              onuSecuencia   In Out Number) As
    --#20150119: jesusv: se agregan procesos de registro de logs

    /*
       PROPIEDAD INTELECTUAL DE GASES DE GASES DEL CARIBE
       FUNCION    : LDCI_PKGESTLEGAORDEN.proCreaLogIntegra
       AUTOR      : Jesus Vivero
       FECHA      : 19-01-2015
       RICEF      :
       DESCRIPCION: Proceso para registrar en log de integraciones

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    PRAGMA AUTONOMOUS_TRANSACTION;

    sbInsertaLog Ldci_Carasewe.Casevalo%Type;
    nuSecuencia  Number;

  Begin

    -- Se valida si se registra log
    Select Nvl(Casevalo, 'N')
      Into sbInsertaLog
      From Ldci_Carasewe
     Where Casecodi = 'LOG_INSERT_LEGA_ORDEN'
       And Casedese = 'WS_SISURE';

    If Nvl(sbInsertaLog, 'N') = 'S' Then

      -- Se busca el consecutivo de secuencia
      Select Ldci_Seq_Logs_Integraciones.Nextval
        Into nuSecuencia
        From Dual;

      -- Se inserta el registro del log
      Insert Into Ldci_Logs_Integraciones
        (Secuencia, Fecha, Info_Xml, Comentarios, Cantidad_Registros)
      Values
        (nuSecuencia, Sysdate, iclInfoXml, isbComentarios, inuRegistros);

      Commit;

      onuSecuencia := nuSecuencia;

    End If;

  Exception
    When Others Then
      Null;
  End proCreaLogIntegra;

  procedure proActuLogIntegra(inuSecuencia   In Number,
                              isbComentarios In Varchar2,
                              inuRegistros   In Number) As
    --#20150119: jesusv: se agregan procesos de actualizacion de logs

    /*
       PROPIEDAD INTELECTUAL DE GASES DE GASES DEL CARIBE
       FUNCION    : LDCI_PKGESTLEGAORDEN.proActuLogIntegra
       AUTOR      : Jesus Vivero
       FECHA      : 19-01-2015
       RICEF      :
       DESCRIPCION: Proceso para actualizar en log de integraciones

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    PRAGMA AUTONOMOUS_TRANSACTION;

    sbInsertaLog Ldci_Carasewe.Casevalo%Type;
    nuSecuencia  Number;

  Begin

    -- Se valida si se registra log
    Select Nvl(Casevalo, 'N')
      Into sbInsertaLog
      From Ldci_Carasewe
     Where Casecodi = 'LOG_INSERT_LEGA_ORDEN'
       And Casedese = 'WS_SISURE';

    If Nvl(sbInsertaLog, 'N') = 'S' Then

      -- Se actualiza el registro del log
      Update Ldci_Logs_Integraciones
         Set Comentarios        = SubStr(Comentarios || '|' ||
                                         isbComentarios,
                                         1,
                                         4000),
             Cantidad_Registros = inuRegistros
       Where Secuencia = inuSecuencia;

      Commit;

    End If;

  Exception
    When Others Then
      Null;
  End proActuLogIntegra;

  procedure proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%type) as
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       Procedimiento : LDCI_PKGESTLEGAORDEN.proCargaVarGlobal
       AUTOR      : OLSoftware / Carlos E. Virgen
       FECHA      : 25/02/2012
       RICEF      : REQ007-I062
       DESCRIPCION: Limpia y carga las variables globales

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    onuErrorCode    ge_error_log.Error_log_id%TYPE;
    osbErrorMessage ge_error_log.description%TYPE;
    errorPara01 EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada

  begin
    LDCI_PKGESTLEGAORDEN.sbInputMsgType := null;
    LDCI_PKGESTLEGAORDEN.sbNameSpace    := null;
    LDCI_PKGESTLEGAORDEN.sbUrlWS        := null;
    LDCI_PKGESTLEGAORDEN.sbUrlDesti     := null;
    LDCI_PKGESTLEGAORDEN.sbSoapActi     := null;
    LDCI_PKGESTLEGAORDEN.sbProtocol     := null;
    LDCI_PKGESTLEGAORDEN.sbHost         := null;
    LDCI_PKGESTLEGAORDEN.sbPuerto       := null;
    LDCI_PKGESTLEGAORDEN.sbPrefijoLDC   := null;
    LDCI_PKGESTLEGAORDEN.sbDefiSewe     := null;

    LDCI_PKGESTLEGAORDEN.sbDefiSewe := isbCASECODI;
    -- carga los parametos de la interfaz
    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'INPUT_MESSAGE_TYPE',
                                       LDCI_PKGESTLEGAORDEN.sbInputMsgType,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'NAMESPACE',
                                       LDCI_PKGESTLEGAORDEN.sbNameSpace,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'WSURL',
                                       LDCI_PKGESTLEGAORDEN.sbUrlWS,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'SOAPACTION',
                                       LDCI_PKGESTLEGAORDEN.sbSoapActi,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'PROTOCOLO',
                                       LDCI_PKGESTLEGAORDEN.sbProtocol,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'PUERTO',
                                       LDCI_PKGESTLEGAORDEN.sbPuerto,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI,
                                       'HOST',
                                       LDCI_PKGESTLEGAORDEN.sbHost,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      Raise Errorpara01;
    end if;

    /*LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PREFIJO_LDC', LDCI_PKGESTLEGAORDEN.sbPrefijoLDC, osbErrorMessage);
    if(osbErrorMessage != '0') then
         Raise Errorpara01;
    end if; */

    LDCI_PKGESTLEGAORDEN.Sburldesti := Lower(LDCI_PKGESTLEGAORDEN.Sbprotocol) ||
                                           '://' ||
                                           LDCI_PKGESTLEGAORDEN.Sbhost || ':' ||
                                           LDCI_PKGESTLEGAORDEN.Sbpuerto || '/' ||
                                           LDCI_PKGESTLEGAORDEN.Sburlws;
    LDCI_PKGESTLEGAORDEN.sbUrlDesti := trim(LDCI_PKGESTLEGAORDEN.sbUrlDesti);

  exception
    When Errorpara01 then
      Errors.seterror(-1,
                      'ERROR: [LDCI_PKGESTLEGAORDEN.proCargaVarGlobal]: Cargando el parametro :' ||
                      osbErrorMessage);
      commit; --rollback;
    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end proCargaVarGlobal;

  function fnuValidaOrdLega(isbIdOrden IN VARCHAR2,
                            osbMensaje OUT VARCHAR2) RETURN NUMBER IS

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega
       AUTOR      : Hector Dominguez
       FECHA      : 18-12-2013
       RICEF      : I015
       DESCRIPCION: Funcion para validar si una orden esta legalizada
                    retorna -1 si termino con error y osbmensaje con la descripcion
                    retorna 0 si no esta legalizada osbmensaje OK
                    retorna 1 si esta legazliada y osbmensaje OK
       NC:          Validacion si una orden es legalizada

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    /*
    * Valirable de control
    * 0= no legalizada 1= legalizada
    */
    nuOrdenLega NUMBER;
    /*
    * Cursor     : cuConsultaOrden
    * Descripcion: Cursor encargado de validar si la orden
    *              fue legalizada
    */

    CURSOR cuConsultaOrden IS
      SELECT COUNT(*)
        FROM OR_ORDER
       WHERE ORDER_STATUS_ID = 8
         AND ORDER_ID = TO_NUMBER(isbIdOrden);

  BEGIN
    osbMensaje := 'OK';
    /*
    * Se ejecuta la consulta de validacion
    */
    OPEN cuConsultaOrden;
    FETCH cuConsultaOrden
      INTO nuOrdenLega;
    CLOSE cuConsultaOrden;

    RETURN nuOrdenLega;

  EXCEPTION
    WHEN OTHERS THEN
      osbMensaje := 'Error consultando la orden ' ||
                    DBMS_UTILITY.format_error_backtrace;
      RETURN - 1;

  END fnuValidaOrdLega;

  function fdtValidaSystem(istSystem     ldci_ordenesalegalizar.system%type,
                           idtChangeDate ldci_ordenesalegalizar.changedate%type,
                           osbMensaje    OUT VARCHAR2) RETURN DATE IS

    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKGESTLEGAORDEN.fdtValidaSystem
     * Tiquete : Ca 200-1200
     * Autor   : JM/AAcuna
     * Fecha   : 11/04/2013
     * Descripcion : Valida si el sistema ingresado esta dentro del parametro para cambiar la fecha de estado a nulo
     *
     *
     *
     * Autor                     Fecha         Descripcion
     * AAcuna                    10-04-2017    Ca 200-1200: Creacion de la funcion
    **/

    dtChangeDate date;
    dato         number;

  BEGIN

    Select COUNT(*)
      into dato
      From Table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDCI_VALCAMBIOEST'),
                                              ','))
     Where COLUMN_VALUE Like '%' || istSystem || '%';

    if (dato > 0) then

      dtChangeDate := null;

    else

      dtChangeDate := idtChangeDate;

    end if;

    RETURN dtChangeDate;

  EXCEPTION
    WHEN OTHERS THEN
      osbMensaje := 'Error consultando la orden ' ||
                    DBMS_UTILITY.format_error_backtrace;
      RETURN null;

  END fdtValidaSystem;

  Procedure ENVIARORDENES As

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.ENVIARORDENES
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    sbErrMens   varchar2(2000);
    sbNameSpace LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS     LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti  LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi  LDCI_CARASEWE.CASEVALO%type;
    sbProtocol  LDCI_CARASEWE.CASEVALO%type;
    sbHost      LDCI_CARASEWE.CASEVALO%type;
    sbPuerto    LDCI_CARASEWE.CASEVALO%type;
    Sbmens      Varchar2(4000);

    --Variables mensajes SOAP
    L_Payload clob;

    l_response CLOB;
    qryCtx     DBMS_XMLGEN.ctxHandle;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  Begin
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'NAMESPACE',
                                       sbNameSpace,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'WSURL',
                                       sbUrlWS,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'SOAPACTION',
                                       sbSoapActi,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PROTOCOLO',
                                       sbProtocol,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PUERTO',
                                       sbPuerto,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'HOST',
                                       sbHost,
                                       sbMens);
    if (sbMens != '0') then
      Raise Errorpara01;
    end if;

    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' ||
                  Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    -- Genera el mensaje XML
    Qryctx := Dbms_Xmlgen.Newcontext('Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",
    Address_Id as "idDireccion", Address as "direccion", Geogra_Location_Id as "idLocalidad",
    Neighborthood as "idBarrio", Oper_Sector_Id as "idSectorOper", Route_Id as "idRuta",
    Consecutive as "consPredio",Priority as "prioridad", to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",
    to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso", to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",
    to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec", to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",
    daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",
    Cursor (Select Order_Activity_Id as "idActividadOrden" ,Consecutive as "consecut",
            Activity_Id as "idActividad", Address_Id as "idDireccion",
            Address as "direccion", Subscriber_Name as "nombreSusc", Product_Id as "idProducto",
            Service_Number as "numServicio", Meter as "medidor", Product_Status_Id as "idEstadoProd",
            Subscription_Id as "idSuscripcion",Category_Id as "idCategoria", Subcategory_Id as "idSubcateg",
            Cons_Cycle_Id as "idCicloCons", Cons_Period_Id as "idPeriodoCons", Bill_Cycle_Id as "idCicloFact",
            Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",
            Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",
            Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",
            Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",
            to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",
            Observation_B as "observLec2", Observation_C as "observLec3"
            From LDCI_ACTIVIDADORDEN Act, Perifact Per
                      Where Ord.Order_Id = Act.Order_Id And
                      Act.Bill_Period_Id = per.PEFACODI) As actividades
      From LDCI_ORDEN Ord where rownum <= 30000');
    --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      RAISE excepNoProcesoRegi;
    end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET', '<ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>', '</ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>', '<orden>');
    L_Payload := Replace(L_Payload, '</ROW>', '</orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>', '<actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>', '</actividades>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');
    L_Payload := '<urn:NotificarOrdenesLectura>' || L_Payload ||
                 '</urn:NotificarOrdenesLectura>';
    L_Payload := Replace(L_Payload, '&', '');
    L_Payload := Replace(L_Payload, '?', 'N');
    L_Payload := Replace(L_Payload, '?', 'n');
    L_Payload := Trim(L_Payload);

    --insert into LDCI_PAYLOADS (id, interfaz, Payload, Fecha_Creacion) VALUES (LDCI_SEQPAYLOAD.NEXTVAL, 'ORDENES', L_Payload, CURRENT_DATE);
    --Dbms_Output.Put_Line(L_Payload);
    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

    --Insert Into Payloadtest (Id, Data, Estructura, Fecha ) Values (Ldc_Seq_Payloadtest.Nextval, L_Payload, 'ENVIO ORDENES', Current_Date);
    --Commit;
    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                      sbUrlDesti,
                                                      sbSoapActi,
                                                      sbNameSpace);

    Dbms_Output.Put_Line('Response: ' || l_response);
    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then
      Dbms_Output.Put_Line(L_Response);

      Raise Excepnoprocesosoap;
    end if;

    --sbErrMens := '0';

  Exception
    When Errorpara01 then
      sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: Error en carga de parametros: ' ||
                   sbMens;

    WHEN excepNoProcesoRegi THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
      sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' ||
                   DBMS_UTILITY.format_error_backtrace;

    WHEN excepNoProcesoSOAP THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
      Sberrmens := 'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.' ||
                   Dbms_Utility.Format_Error_Backtrace;
  end ENVIARORDENES;

  Procedure ENVIARORDENESTRANSAC(idTransac in number,
                                 lote      in number,
                                 cantLotes in number) As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.ENVIARORDENESTRANSAC
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    sbErrMens   varchar2(2000);
    sbNameSpace LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS     LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti  LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi  LDCI_CARASEWE.CASEVALO%type;
    sbProtocol  LDCI_CARASEWE.CASEVALO%type;
    sbHost      LDCI_CARASEWE.CASEVALO%type;
    sbPuerto    LDCI_CARASEWE.CASEVALO%type;
    Sbmens      Varchar2(4000);

    --Variables mensajes SOAP
    L_Payload    clob;
    sbXmlTransac VARCHAR2(200);

    l_response CLOB;
    qryCtx     DBMS_XMLGEN.ctxHandle;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  Begin
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'NAMESPACE',
                                       sbNameSpace,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'WSURL',
                                       sbUrlWS,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'SOAPACTION',
                                       sbSoapActi,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PROTOCOLO',
                                       sbProtocol,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PUERTO',
                                       sbPuerto,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'HOST',
                                       sbHost,
                                       sbMens);
    if (sbMens != '0') then
      Raise Errorpara01;
    end if;

    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' ||
                  Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    -- Genera el mensaje XML
    Qryctx := Dbms_Xmlgen.Newcontext('Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",
    Address_Id as "idDireccion", Address as "direccion", Geogra_Location_Id as "idLocalidad",
    Neighborthood as "idBarrio", Oper_Sector_Id as "idSectorOper", Route_Id as "idRuta",
    Consecutive as "consPredio",Priority as "prioridad", to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",
    to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso", to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",
    to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec", to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",
    daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",
    Cursor (Select Order_Activity_Id as "idActividadOrden" ,Consecutive as "consecut",
            Activity_Id as "idActividad", Address_Id as "idDireccion",
            Address as "direccion", Subscriber_Name as "nombreSusc", Product_Id as "idProducto",
            Service_Number as "numServicio", Meter as "medidor", Product_Status_Id as "idEstadoProd",
            Subscription_Id as "idSuscripcion",Category_Id as "idCategoria", Subcategory_Id as "idSubcateg",
            Cons_Cycle_Id as "idCicloCons", Cons_Period_Id as "idPeriodoCons", Bill_Cycle_Id as "idCicloFact",
            Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",
            Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",
            Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",
            Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",
            to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",
            Observation_B as "observLec2", Observation_C as "observLec3"
            From LDCI_ACTIVIDADORDEN Act, Perifact Per
                      Where Ord.Order_Id = Act.Order_Id And
                      Act.Bill_Period_Id = per.PEFACODI(+)) As actividades
From LDCI_ORDEN Ord where rownum <= 30000');
    --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      RAISE excepNoProcesoRegi;
    end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET', '<ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>', '</ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>', '<orden>');
    L_Payload := Replace(L_Payload, '</ROW>', '</orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>', '<actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>', '</actividades>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');

    sbXmlTransac := '<transaccion>
            <transaccion>' || idTransac ||
                    '</transaccion>
            <lote>' || lote || '</lote>
         </transaccion>';

    L_Payload := '<urn:NotificarOrdenesLectura>' || sbXmlTransac ||
                 L_Payload || '</urn:NotificarOrdenesLectura>';
    L_Payload := Replace(L_Payload, '&', '');
    L_Payload := Replace(L_Payload, '?', 'N');
    L_Payload := Replace(L_Payload, '?', 'n');
    L_Payload := Trim(L_Payload);

    --insert into LDCI_PAYLOADS (id, interfaz, Payload, Fecha_Creacion) VALUES (LDCI_SEQPAYLOAD.NEXTVAL, 'ORDENES', L_Payload, CURRENT_DATE);
    --Dbms_Output.Put_Line(L_Payload);
    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

    --Insert Into Payloadtest (Id, Data, Estructura, Fecha ) Values (Ldc_Seq_Payloadtest.Nextval, L_Payload, 'ENVIO ORDENES', Current_Date);
    --Commit;

    Dbms_Output.Put_Line('Enviando :' ||
                         to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));
    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                      sbUrlDesti,
                                                      sbSoapActi,
                                                      sbNameSpace);

    Dbms_Output.Put_Line('Response: ' || l_response || ' ' ||
                         to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));
    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then
      Dbms_Output.Put_Line(L_Response);
      Raise Excepnoprocesosoap;
    end if;

    --sbErrMens := '0';

  Exception
    When Errorpara01 then
      Dbms_Output.Put_Line(Sbmens);
    WHEN excepNoProcesoRegi THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
      sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' ||
                   DBMS_UTILITY.format_error_backtrace;
      Dbms_Output.Put_Line(sbErrMens);

    WHEN excepNoProcesoSOAP THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
      Sberrmens := 'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.' ||
                   Dbms_Utility.Format_Error_Backtrace;
      Dbms_Output.Put_Line(Sberrmens);
  end ENVIARORDENESTRANSAC;

  Procedure CONFIRMARORDENES(idTransac in number,
                             cantLotes in number,
                             cantOrds  in number,
                             cantActs  in number) As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.CONFIRMARORDENES
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    sbErrMens   varchar2(2000);
    sbNameSpace LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS     LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti  LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi  LDCI_CARASEWE.CASEVALO%type;
    sbProtocol  LDCI_CARASEWE.CASEVALO%type;
    sbHost      LDCI_CARASEWE.CASEVALO%type;
    sbPuerto    LDCI_CARASEWE.CASEVALO%type;
    Sbmens      Varchar2(4000);

    --Variables mensajes SOAP
    L_Payload    clob;
    sbXmlTransac VARCHAR2(200);

    l_response CLOB;
    qryCtx     DBMS_XMLGEN.ctxHandle;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  Begin
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'NAMESPACE',
                                       sbNameSpace,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'WSURL',
                                       sbUrlWS,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'SOAPACTION',
                                       sbSoapActi,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PROTOCOLO',
                                       sbProtocol,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PUERTO',
                                       sbPuerto,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'HOST',
                                       sbHost,
                                       sbMens);
    if (sbMens != '0') then
      Raise Errorpara01;
    end if;

    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' ||
                  Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    sbXmlTransac := '<idTransaccion>' || idTransac ||
                    '</idTransaccion>
            <cantidadLotes>' || cantLotes ||
                    '</cantidadLotes>
            <cantidadOrdenes>' || cantOrds ||
                    '</cantidadOrdenes>
            <cantidadActs>' || cantActs ||
                    '</cantidadActs>';

    L_Payload := '<urn:ConfirmaTransacOrdRequest>' || sbXmlTransac ||
                 '</urn:ConfirmaTransacOrdRequest>';

    L_Payload := Trim(L_Payload);

    --insert into LDCI_PAYLOADS (id, interfaz, Payload, Fecha_Creacion) VALUES (LDCI_SEQPAYLOAD.NEXTVAL, 'ORDENES', L_Payload, CURRENT_DATE);
    --Dbms_Output.Put_Line(L_Payload);
    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

    --Insert Into Payloadtest (Id, Data, Estructura, Fecha ) Values (Ldc_Seq_Payloadtest.Nextval, L_Payload, 'ENVIO ORDENES', Current_Date);
    --Commit;
    Dbms_Output.Put_Line('Enviando :' ||
                         to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));
    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                      sbUrlDesti,
                                                      sbSoapActi,
                                                      sbNameSpace);

    Dbms_Output.Put_Line('Response: ' || l_response || ' ' ||
                         to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));
    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then
      Dbms_Output.Put_Line(L_Response);

      Raise Excepnoprocesosoap;
    end if;

    --sbErrMens := '0';

  Exception
    When Errorpara01 then
      Dbms_Output.Put_Line(Sbmens);
    WHEN excepNoProcesoRegi THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
      sbErrMens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros' ||
                   DBMS_UTILITY.format_error_backtrace;
      Dbms_Output.Put_Line(sbErrMens);

    WHEN excepNoProcesoSOAP THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
      Sberrmens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.' ||
                   Dbms_Utility.Format_Error_Backtrace;
      Dbms_Output.Put_Line(Sberrmens);
  end CONFIRMARORDENES;

  Procedure CANCELARORDENES(idTransac in number, lote in number) As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.CANCELARORDENES
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    sbErrMens   varchar2(2000);
    sbNameSpace LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS     LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti  LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi  LDCI_CARASEWE.CASEVALO%type;
    sbProtocol  LDCI_CARASEWE.CASEVALO%type;
    sbHost      LDCI_CARASEWE.CASEVALO%type;
    sbPuerto    LDCI_CARASEWE.CASEVALO%type;
    Sbmens      Varchar2(4000);

    --Variables mensajes SOAP
    L_Payload    clob;
    sbXmlTransac VARCHAR2(200);

    l_response CLOB;
    qryCtx     DBMS_XMLGEN.ctxHandle;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  Begin
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'NAMESPACE',
                                       sbNameSpace,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'WSURL',
                                       sbUrlWS,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'SOAPACTION',
                                       sbSoapActi,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PROTOCOLO',
                                       sbProtocol,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'PUERTO',
                                       sbPuerto,
                                       sbMens);
    if (sbMens != '0') then
      RAISE errorPara01;
    end if; --if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'HOST',
                                       sbHost,
                                       sbMens);
    if (sbMens != '0') then
      Raise Errorpara01;
    end if;

    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' ||
                  Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    /*
    sbXmlTransac := '<transaccion>' || idTransac ||'</transaccion>
            <lote>' || lote || '</lote>';*/

    sbXmlTransac := '<transaccion>' || idTransac || '</transaccion>';

    L_Payload := '<urn:CancelaTransacOrdRequest>' || sbXmlTransac ||
                 '</urn:CancelaTransacOrdRequest>';

    L_Payload := Trim(L_Payload);

    --insert into LDCI_PAYLOADS (id, interfaz, Payload, Fecha_Creacion) VALUES (LDCI_SEQPAYLOAD.NEXTVAL, 'ORDENES', L_Payload, CURRENT_DATE);
    --Dbms_Output.Put_Line(L_Payload);
    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

    --Insert Into Payloadtest (Id, Data, Estructura, Fecha ) Values (Ldc_Seq_Payloadtest.Nextval, L_Payload, 'ENVIO ORDENES', Current_Date);
    --Commit;
    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                      sbUrlDesti,
                                                      sbSoapActi,
                                                      sbNameSpace);

    Dbms_Output.Put_Line('Response: ' || l_response);
    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then
      Dbms_Output.Put_Line(L_Response);

      Raise Excepnoprocesosoap;
    end if;

    --sbErrMens := '0';

  Exception
    When Errorpara01 then
      Dbms_Output.Put_Line(Sbmens);
    WHEN excepNoProcesoRegi THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
      sbErrMens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros' ||
                   DBMS_UTILITY.format_error_backtrace;
      Dbms_Output.Put_Line(sbErrMens);

    WHEN excepNoProcesoSOAP THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
      Sberrmens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.' ||
                   Dbms_Utility.Format_Error_Backtrace;
      Dbms_Output.Put_Line(Sberrmens);
  end CANCELARORDENES;

  PROCEDURE NOTIFICARPROCESAMIENTO(INUPROCODI   IN LDCI_ESTAPROC.PROCCODI%TYPE,
                                   Onuerrorcode Out Number,
                                   Osberrormsg  Out Varchar2) AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.NOTIFICARPROCESAMIENTO
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    CURSOR CUESTAPROC IS
      SELECT * FROM LDCI_ESTAPROC WHERE PROCCODI = INUPROCODI;
    RECCUESTAPROC LDCI_ESTAPROC%ROWTYPE;

    CURSOR CUPERSON(SBUSER GE_PERSON.USER_ID%TYPE) IS
      SELECT * FROM GE_PERSON WHERE user_id = SBUSER;
    RECCUPERSON GE_PERSON%ROWTYPE;

    CURSOR CUMENSAJES IS
      SELECT * FROM LDCI_MESAPROC WHERE MESAPROC = INUPROCODI;
    RECCUMENSAJES LDCI_ESTAPROC%ROWTYPE;

  BEGIN
    OPEN CUESTAPROC;
    FETCH CUESTAPROC
      INTO RECCUESTAPROC;
    /*BUSCAR EL CORREO ELECTRONICO DEL USUARIO*/

    /*BUSCAR MENSAJES*/

    /*CONCATENAR MENSAJES*/

    /*ENVIAR CORREO LECTRONICO*/

  END NOTIFICARPROCESAMIENTO;

  Procedure PROCESOACTIVIDADESORDEN(Orden          In LDCI_ACTIVIDADORDEN.Order_Id%Type,
                                    cantAtcs       out number,
                                    nuTransac      in number,
                                    OnuFLAFPROCESO in out number) As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.PROCESOACTIVIDADESORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    TYPE refRegistros is REF CURSOR;
    Resultado    Number(18) := -1;
    Msj          Varchar2(200) := '';
    Recregistros Refregistros;
    reg          LDCI_ACTIVIDADORDEN%Rowtype;

    Nuorder_Activity_Id Ldci_Actividadorden.Order_Activity_Id%Type;
    Nuconsecutive       Ldci_Actividadorden.Consecutive%Type;
    Nuactivity_Id       Ldci_Actividadorden.Activity_Id%Type;
    Nuaddress_Id        Ldci_Actividadorden.Address_Id%Type;
    Sbaddress           Ldci_Actividadorden.Address%Type;
    Sbsubscriber_Name   Ldci_Actividadorden.Subscriber_Name%Type;
    Nuproduct_Id        Ldci_Actividadorden.Product_Id%Type;
    Sbservice_Number    Ldci_Actividadorden.Service_Number%Type;
    Sbmeter             Ldci_Actividadorden.Meter%Type;
    Nuproduct_Status_Id Ldci_Actividadorden.Product_Status_Id%Type;
    Nusubscription_Id   Ldci_Actividadorden.Subscription_Id%Type;
    Nucategory_Id       Ldci_Actividadorden.Category_Id%Type;
    Nusubcategory_Id    Ldci_Actividadorden.Subcategory_Id%Type;
    Nucons_Cycle_Id     Ldci_Actividadorden.Cons_Cycle_Id%Type;
    Nucons_Period_Id    Ldci_Actividadorden.Cons_Period_Id%Type;
    Nubill_Cycle_Id     Ldci_Actividadorden.Bill_Cycle_Id%Type;
    Nubill_Period_Id    Ldci_Actividadorden.Bill_Period_Id%Type;
    Nuparent_Product_Id Ldci_Actividadorden.Parent_Product_Id%Type;
    Sbparent_Address_Id Ldci_Actividadorden.Parent_Address_Id%Type;
    Sbparent_Address    Ldci_Actividadorden.Parent_Address%Type;
    Sbcausal            Ldci_Actividadorden.Causal%Type;
    Nucons_Type_Id      Ldci_Actividadorden.Cons_Type_Id%Type;
    Numeter_Location    Ldci_Actividadorden.Meter_Location%Type;
    Nudigit_Quantity    Ldci_Actividadorden.Digit_Quantity%Type;
    Nulimit             Ldci_Actividadorden.Limit%Type;
    Sbretry             Ldci_Actividadorden.Retry%Type;
    Nuaverage           Ldci_Actividadorden.Average%Type;
    Nulast_Read         Ldci_Actividadorden.Last_Read%Type;
    Dtlast_Read_Date    Ldci_Actividadorden.Last_Read_Date%Type;
    Nuobservation_A     Ldci_Actividadorden.Observation_A%Type;
    Nuobservation_B     Ldci_Actividadorden.Observation_B%Type;
    NUObservation_C     Ldci_Actividadorden.Observation_C%TYPE;

    nuMesacodi   LDCI_MESAPROC.MESACODI%TYPE;
    nuFlagValida Number := 0;

  Begin

    cantAtcs := 0;
    /* CARGAR ACTIVIDADES DE LA ORDEN */
    OS_GETORDERACTIVITIES(Orden, Recregistros, Resultado, Msj);

    --evaluar el resultado antes de recorrer el cursor
    If Resultado = 0 Then
      Loop
        Fetch Recregistros
          Into Nuorder_Activity_Id,
               Nuconsecutive,
               Nuactivity_Id,
               Nuaddress_Id,
               Sbaddress,
               Sbsubscriber_Name,
               Nuproduct_Id,
               Sbservice_Number,
               Sbmeter,
               Nuproduct_Status_Id,
               Nusubscription_Id,
               Nucategory_Id,
               Nusubcategory_Id,
               Nucons_Cycle_Id,
               Nucons_Period_Id,
               Nubill_Cycle_Id,
               Nubill_Period_Id,
               Nuparent_Product_Id,
               Sbparent_Address_Id,
               Sbparent_Address,
               Sbcausal,
               Nucons_Type_Id,
               Numeter_Location,
               Nudigit_Quantity,
               Nulimit,
               Sbretry,
               Nuaverage,
               Nulast_Read,
               Dtlast_Read_Date,
               NUObservation_A,
               NUObservation_B,
               NUObservation_C;
        EXIT WHEN Recregistros%notfound;
        cantAtcs := cantAtcs + 1;

        LDCI_PKVALIDASIGELEC.PROVALIDAACTIVIDAD(Orden,
                                                Nuorder_Activity_Id,
                                                Nuconsecutive,
                                                Nuactivity_Id,
                                                Nuaddress_Id,
                                                Sbaddress,
                                                Sbsubscriber_Name,
                                                Nuproduct_Id,
                                                Sbservice_Number,
                                                Sbmeter,
                                                Nuproduct_Status_Id,
                                                Nusubscription_Id,
                                                Nucategory_Id,
                                                Nusubcategory_Id,
                                                Nucons_Cycle_Id,
                                                Nucons_Period_Id,
                                                Nubill_Cycle_Id,
                                                Nubill_Period_Id,
                                                Nuparent_Product_Id,
                                                Sbparent_Address_Id,
                                                Sbparent_Address,
                                                Sbcausal,
                                                Nucons_Type_Id,
                                                Numeter_Location,
                                                Nudigit_Quantity,
                                                Nulimit,
                                                Sbretry,
                                                Nuaverage,
                                                Nulast_Read,
                                                Dtlast_Read_Date,
                                                Nuobservation_A,
                                                Nuobservation_B,
                                                NUObservation_C,
                                                nuTransac,
                                                nuFlagValida);

        IF nuFlagValida = 0 THEN
          /* PERSISTIR ACTIVIDADES */
          insert into LDCI_ACTIVIDADORDEN
            (ORDER_ID,
             ORDER_ACTIVITY_ID,
             CONSECUTIVE,
             ACTIVITY_ID,
             ADDRESS_ID,
             ADDRESS,
             SUBSCRIBER_NAME,
             PRODUCT_ID,
             SERVICE_NUMBER,
             METER,
             PRODUCT_STATUS_ID,
             SUBSCRIPTION_ID,
             CATEGORY_ID,
             SUBCATEGORY_ID,
             CONS_CYCLE_ID,
             CONS_PERIOD_ID,
             BILL_CYCLE_ID,
             BILL_PERIOD_ID,
             PARENT_PRODUCT_ID,
             PARENT_ADDRESS_ID,
             PARENT_ADDRESS,
             CAUSAL,
             CONS_TYPE_ID,
             METER_LOCATION,
             Digit_Quantity,
             Limit,
             Retry,
             Average,
             Last_Read,
             Last_Read_Date,
             Observation_A,
             Observation_B,
             Observation_C)
          Values
            (Orden,
             Nuorder_Activity_Id,
             Nuconsecutive,
             Nuactivity_Id,
             Nuaddress_Id,
             Sbaddress,
             Sbsubscriber_Name,
             Nuproduct_Id,
             Sbservice_Number,
             Sbmeter,
             Nuproduct_Status_Id,
             Nusubscription_Id,
             Nucategory_Id,
             Nusubcategory_Id,
             Nucons_Cycle_Id,
             Nucons_Period_Id,
             Nubill_Cycle_Id,
             Nubill_Period_Id,
             Nuparent_Product_Id,
             Sbparent_Address_Id,
             Sbparent_Address,
             Sbcausal,
             Nucons_Type_Id,
             Numeter_Location,
             Nudigit_Quantity,
             Nulimit,
             Sbretry,
             Nuaverage,
             Nulast_Read,
             Dtlast_Read_Date,
             NUObservation_A,
             NUObservation_B,
             NUObservation_C);

        else
          OnuFLAFPROCESO := 1;
          exit;
        END IF; -- IF nuFlagValida = 0 THEN
      End Loop; -- Loop
    Else
      /*CREAR MENSAJE DE ERROR*/
      LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                    Msj,
                                    'E',
                                    CURRENT_DATE,
                                    nuMesacodi,
                                    Resultado,
                                    Msj);
    end if; -- If Resultado = 0 Then
    Close Recregistros;
  Exception
    When Others Then
      /*CREAR MENSAJE DE ERROR*/
      OnuFLAFPROCESO := 1;
      LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                    'ERROR: ' || SQLERRM || '. TRACE:' ||
                                    DBMS_UTILITY.format_error_backtrace,
                                    'E',
                                    CURRENT_DATE,
                                    nuMesacodi,
                                    Resultado,
                                    Msj);
  End PROCESOACTIVIDADESORDEN;

  PROCEDURE PROPROCESARRORDEN(nuTransac              IN LDCI_ORDEN.TRANSAC_ID%TYPE,
                              Nuorder_Id             IN LDCI_ORDEN.Order_Id%TYPE,
                              Nutask_Type_Id         IN LDCI_ORDEN.Task_Type_Id%TYPE,
                              Nuorder_Status_Id      IN LDCI_ORDEN.Address_Id%TYPE,
                              Nuaddress_Id           IN LDCI_ORDEN.Address_Id%TYPE,
                              Sbaddress              IN LDCI_ORDEN.Address%TYPE,
                              Nugeogra_Location_Id   IN LDCI_ORDEN.Geogra_Location_Id%TYPE,
                              Nuneighborthood        IN LDCI_ORDEN.Neighborthood%TYPE,
                              Nuoper_Sector_Id       IN LDCI_ORDEN.Oper_Sector_Id%TYPE,
                              Nuroute_Id             IN LDCI_ORDEN.Route_Id%TYPE,
                              Nuconsecutive          IN LDCI_ORDEN.Consecutive%TYPE,
                              Nupriority             IN LDCI_ORDEN.Priority%TYPE,
                              Dtassigned_Date        IN LDCI_ORDEN.Assigned_Date%TYPE,
                              Dtarrange_Hour         IN LDCI_ORDEN.Arrange_Hour%TYPE,
                              Dtcreated_Date         IN LDCI_ORDEN.Created_Date%TYPE,
                              Dtexec_Estimate_Date   IN LDCI_ORDEN.Exec_Estimate_Date%TYPE,
                              dtMax_Date_To_Legalize IN LDCI_ORDEN.Max_Date_To_Legalize%TYPE,
                              OnuFLAFPROCESO         IN Out Number) AS

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.PROPROCESARRORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

  BEGIN
    /*
      VALIDAR DATOS DE LA ORDEN
    */

    /*
       PERSISTIR ERRORES DE VALIDACION DE LA ORDEN
    */

    null;
  EXCEPTION
    WHEN OTHERS THEN
      OnuFLAFPROCESO := 1;
  END PROPROCESARRORDEN;

  PROCEDURE PROGENERARPAYLOADSORDENES(nuTransac    in NUMBER,
                                      nuLote       in number,
                                      nuLotes      in number,
                                      Onuerrorcode Out Number,
                                      Osberrormsg  Out Varchar2) AS

    sbErrMens varchar2(2000);
    Sbmens    Varchar2(4000);

    nuMesacodi LDCI_MESAENVWS.MESACODI%TYPE;

    --Variables mensajes SOAP
    L_Payload    clob;
    sbXmlTransac VARCHAR2(500);

    qryCtx DBMS_XMLGEN.ctxHandle;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

    --#NC-INTERNA: Conteo de cantidad de ordenes
    -- conteo de ordenes por lote
    cursor cuContordenes is
      SELECT COUNT(ORD.ORDER_ID) ORDENES
        FROM LDCI_ORDEN ORD
       WHERE ORD.LOTE = nuLote;

    -- conteo de actividades por lote
    cursor cuContAvtividades is
      SELECT COUNT(ACT.ACTIVITY_ID) ACTIVIDADES
        FROM LDCI_ORDEN ORD, LDCI_ACTIVIDADORDEN ACT
       WHERE ORD.ORDER_ID = ACT.ORDER_ID
         AND ORD.LOTE = nuLote;

    nuCantOrds number := 0;
    nuCantActs number := 0;
  Begin

    --#NC-INTERNA: Conteo de cantidad de ordenes
    open cuContordenes;
    fetch cuContordenes
      into nuCantOrds;
    close cuContordenes;

    open cuContAvtividades;
    fetch cuContAvtividades
      into nuCantActs;
    close cuContAvtividades;

    -- Genera el mensaje XML
    Qryctx := Dbms_Xmlgen.Newcontext('Select Ord.Order_Id as "idOrden",
                                                                Task_Type_Id as "idTipoTrab",
                                                                                                   Order_Status_Id  as "idEstado",
                                                         Address_Id as "idDireccion",
                                                                                                   Address as "direccion",
                                                                                                   Geogra_Location_Id as "idLocalidad",
                                                         Neighborthood as "idBarrio",
                                                                                                   Oper_Sector_Id as "idSectorOper",
                                                                                                   Route_Id as "idRuta",
                                                         Consecutive as "consPredio",
                                                                                                   Priority as "prioridad",
                                                                                                    to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",
                                                         to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso",
                                                                                                    to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",
                                                         to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec",
                                                                                                    to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",
                                                         daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",
                                                                                                    Cursor (Select Order_Activity_Id as "idActividadOrden",
                                                                                                                   Consecutive as "consecut",
                                                                                                                          Activity_Id as "idActividad",
                                                                                                                              Address_Id as "idDireccion",
                                                                                                                          Address as "direccion",
                                                                                                                              Subscriber_Name as "nombreSusc",
                                                                                                                              Product_Id as "idProducto",
                                                                                                                          Service_Number as "numServicio",
                                                                                                                              Meter as "medidor",
                                                                                                                              Product_Status_Id as "idEstadoProd",
                                                                                                                          Subscription_Id as "idSuscripcion",
                                                                                                                              Category_Id as "idCategoria",
                                                                                                                              Subcategory_Id as "idSubcateg",
                                                                                                                          Cons_Cycle_Id as "idCicloCons",
                                                                                                                              Cons_Period_Id as "idPeriodoCons",
                                                                                                                              Bill_Cycle_Id as "idCicloFact",
                                                                                                                    Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",
                                                                                                                    Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",
                                                                                                                    Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",
                                                                                                                    Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",
                                                                                                                    to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",
                                                                                                                    Observation_B as "observLec2", Observation_C as "observLec3"
                                                                                                                From LDCI_ACTIVIDADORDEN Act, Perifact Per
                                                                                                                                    Where Ord.Order_Id = Act.Order_Id And
                                                                                                                                    Act.Bill_Period_Id = per.PEFACODI(+)) As actividades
From LDCI_ORDEN Ord where Ord.LOTE = ' ||
                                     nuLote);
    --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      RAISE excepNoProcesoRegi;
    end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET', '<ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>', '</ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>', '<orden>');
    L_Payload := Replace(L_Payload, '</ROW>', '</orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>', '<actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>', '</actividades>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');

    sbXmlTransac := '<transaccion>
            <proceso>' || nuTransac ||
                    '</proceso>
            <lote>' || nuLote ||
                    '</lote>
            <cantidadLotes>' || nuLotes ||
                    '</cantidadLotes>
            <cantOrdenes>' || nuCantOrds ||
                    '</cantOrdenes>
            <cantActividades>' || nuCantActs ||
                    '</cantActividades>
         </transaccion>';

    L_Payload := '<urn:NotificarOrdenesLectura>' || sbXmlTransac ||
                 L_Payload || '</urn:NotificarOrdenesLectura>';
    --  L_Payload := Replace(L_Payload, '&',  '');
    -- L_Payload := Replace(L_Payload, '?',  'N');
    -- L_Payload := Replace(L_Payload, '?',  'n');
    L_Payload := Trim(L_Payload);
    --Dbms_Output.Put_Line('PROGENERARPAYLOADSORDENES.[1230] L_Payload: ' || chr(13) || L_Payload);
    --insert into LDCI_PAYLOADS (id, interfaz, Payload, Fecha_Creacion) VALUES (LDCI_SEQPAYLOAD.NEXTVAL, 'ORDENES', L_Payload, CURRENT_DATE);

    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   'WS_ENVIO_ORDENES',
                                   -1,
                                   nuTransac,
                                   null,
                                   L_Payload,
                                   nuLote,
                                   nuLotes,
                                   nuMesacodi,
                                   Onuerrorcode,
                                   sbErrMens);
  Exception
    WHEN excepNoProcesoRegi THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
      sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' ||
                   DBMS_UTILITY.format_error_backtrace;
      Dbms_Output.Put_Line(sbErrMens);
    WHEN OTHERS THEN
      --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
      Sberrmens := 'ERROR ALMACENANDO PAYLOAD. ' || SQLERRM || '. ' ||
                   Dbms_Utility.Format_Error_Backtrace;
      Dbms_Output.Put_Line(Sberrmens);
  END PROGENERARPAYLOADSORDENES;

    procedure NOTIFICARPROCESOORDENES(nuestaproc in LDCI_ESTAPROC.PROCCODI%type) AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.NOTIFICARPROCESOORDENES
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'NOTIFICARPROCESOORDENES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);        
    
        sbMensaje    VARCHAR2(30000);

        --definicion de cursores
        --cursor datos de la persona
        cursor cuGE_PERSON(inuUSER_ID GE_PERSON.USER_ID%type) is
          select * from GE_PERSON g where g.USER_ID = inuUSER_ID;

        -- cursor del estado de proceso
        cursor cuLDCI_ESTAPROC is
          select * from LDCI_ESTAPROC where PROCCODI = nuestaproc;

        --cursor del mensaje de procesamiento
        cursor cuMesaproc is
          select * from LDCI_MESAPROC where MESAPROC = nuestaproc;

        -- cursor del XML de parametros
        cursor cuPARAMETROS(clXML in VARCHAR2) is
          SELECT PARAMETROS.*
            FROM XMLTable('/PARAMETROS/PARAMETRO' PASSING XMLType(clXML)
                          COLUMNS row_num for ordinality,
                          "NOMBRE" VARCHAR2(300) PATH 'NOMBRE',
                          "VALOR" VARCHAR2(300) PATH 'VALOR') AS PARAMETROS;

        --variables tipo registro
        reMesaProc      LDCI_MESAPROC%rowtype;
        reLDCI_ESTAPROC cuLDCI_ESTAPROC%rowtype;
        reGE_PERSON     cuGE_PERSON%rowtype;
    
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        --determina el usuario que esta realizando la operacion
        open cuGE_PERSON(SA_BOUSER.fnuGetUserId(UT_SESSION.GETUSER));
        fetch cuGE_PERSON into reGE_PERSON;
        close cuGE_PERSON;

        open cuLDCI_ESTAPROC;
        fetch cuLDCI_ESTAPROC into reLDCI_ESTAPROC;
        close cuLDCI_ESTAPROC;

        if (reGE_PERSON.E_MAIL is not null or reGE_PERSON.E_MAIL <> '') then

            -- genera el cuerpo del correo
            sbMensaje := sbMensaje  ||   '<html><body>';
            sbMensaje := sbMensaje  ||   '<table  border="1px" width="100%">';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td colspan="2"><h1>Estado del proceso<h1></td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Identificador</b></td>';
            sbMensaje := sbMensaje  ||   '<td>' || reLDCI_ESTAPROC.PROCCODI || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Fecha inicio</b></td>';
            sbMensaje := sbMensaje  ||  '<td>' ||
                               to_char(reLDCI_ESTAPROC.PROCFEIN,
                                       'DD/MM/YYYY HH:MM:SS') || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Fecha final</b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td>' ||
                               to_char(reLDCI_ESTAPROC.PROCFEFI,
                                       'DD/MM/YYYY HH:MM:SS') || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Usuario</b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td>' || reLDCI_ESTAPROC.PROCUSUA || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Terminal</b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td>' || reLDCI_ESTAPROC.PROCTERM || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Programa</b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td>' || reLDCI_ESTAPROC.PROCPROG || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||  
                               '<td><b>Estado [R=Registrado P=procesando, F=Finalizado]</b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td>' || reLDCI_ESTAPROC.PROCESTA || '</td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '</table>';

            -- lee los datos de consulta
            sbMensaje := sbMensaje  ||   '<table  border="1px" width="100%">';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||  
                               '<td colspan="2"><h2>Datos de procesamiento<h2></td>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||   '<td><b>Parametro<b></td>';
            sbMensaje := sbMensaje  ||   '<td><b>Valor<b></td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '</body></html>';

            -- recorre el XML de parametros
            for rePARAMETROS in cuPARAMETROS(reLDCI_ESTAPROC.PROCPARA) loop
                sbMensaje := sbMensaje  ||   '<tr>';
                sbMensaje := sbMensaje  ||  
                                     '<td>' || rePARAMETROS.NOMBRE || '</td>';
                sbMensaje := sbMensaje  ||  
                                     '<td>' || rePARAMETROS.VALOR || '</td>';
                sbMensaje := sbMensaje  ||   '</tr>';
            end loop;

            sbMensaje := sbMensaje  ||   '</table>';

            -- lee los mensajes del proceso
            sbMensaje := sbMensaje  ||   '<table  border="1px" width="100%">';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||  
                               '<td colspan="3"><h2>Mensajes de procesamiento<h2></td>';
            sbMensaje := sbMensaje  ||   '<tr>';
            sbMensaje := sbMensaje  ||  
                               '<td><b>Consecutivo del mensaje<b></td>';
            sbMensaje := sbMensaje  ||   '<td><b>Mensaje<b></td>';
            sbMensaje := sbMensaje  ||  
                               '<td><b>Tipo [E Error, I Informacion, W Advertencia, S Satisfactorio]<b></td>';
            sbMensaje := sbMensaje  ||   '</tr>';
            sbMensaje := sbMensaje  ||   '</body></html>';

            -- recorre los mensajes
            for reMesaProc in cuMesaproc loop
            
                sbMensaje := sbMensaje  ||   '<tr>';
                sbMensaje := sbMensaje  ||  
                                     '<td>' || reMesaProc.MESACODI || '</td>';
                sbMensaje := sbMensaje  ||  
                                     '<td>' || reMesaProc.MESADESC || '</td>';
                sbMensaje := sbMensaje  ||  
                                     '<td>' || reMesaProc.MESATIPO || '</td>';
                sbMensaje := sbMensaje  ||   '</tr>';
            end loop;
            
            sbMensaje := sbMensaje  ||   '</table>';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => reGE_PERSON.E_MAIL,
                isbAsunto           => 'Notificacion de envio de ordenes a sistema externo',
                isbMensaje          => sbMensaje
            );                                       

        else
            sbMensaje := 'El usuario ' || reGE_PERSON.PERSON_ID || '-' ||
                       reGE_PERSON.NAME_ ||
                       ' no tiene configurado el correo electronico.';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electronico (' || reGE_PERSON.NAME_ || ')',
                isbMensaje          => sbMensaje
            );   

        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    end NOTIFICARPROCESOORDENES;

  PROCEDURE PROLIMPIARTEMPORALES AS
  BEGIN
    Delete From LDCI_ACTIVIDADORDEN;
    Delete From LDCI_ORDEN;
  END PROLIMPIARTEMPORALES;

  Procedure PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId   In NUMBER,
                                          inuGeograLocationId  In NUMBER,
                                          inuConsCycleId       In NUMBER,
                                          Inuoperatingsectorid In NUMBER,
                                          inuRouteId           In NUMBER,
                                          Idtinitialdate       In Date,
                                          Idtfinaldata         In Date,
                                          Inutasktypeid        In Number,
                                          inuOrderStatusId     In NUMBER,
                                          Onuerrorcode         Out Number,
                                          Osberrormsg          Out Varchar2) As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.PROCESARORDENESLECTURATRANSAC
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor                                   Fecha      Descripcion
         carlosvl<carlos.virgen@olsoftware.com> 07-02-2014 #NC-87252: Manejo del numero de registros por lote mediante un parametro del sistema
    */
    -- variables para la asignacion del cursor
    TYPE refRegistros is REF CURSOR;
    Recregistros Refregistros;
    -- atributos del cursor de ordenes
    Nuorder_Id             Ldci_Orden.Order_Id%Type;
    Nutask_Type_Id         Ldci_Orden.Task_Type_Id%Type;
    Nuorder_Status_Id      Ldci_Orden.Order_Status_Id%Type;
    Nuaddress_Id           Ldci_Orden.Address_Id%Type;
    Sbaddress              Ldci_Orden.Address%Type;
    Nugeogra_Location_Id   Ldci_Orden.Geogra_Location_Id%Type;
    Nuneighborthood        Ldci_Orden.Neighborthood%Type;
    Nuoper_Sector_Id       Ldci_Orden.Oper_Sector_Id%Type;
    Nuroute_Id             Ldci_Orden.Route_Id%Type;
    Nuconsecutive          Ldci_Orden.Consecutive%Type;
    Nupriority             Ldci_Orden.Priority%Type;
    Dtassigned_Date        Ldci_Orden.Assigned_Date%Type;
    Dtarrange_Hour         Ldci_Orden.Arrange_Hour%Type;
    Dtcreated_Date         Ldci_Orden.Created_Date%Type;
    Dtexec_Estimate_Date   Ldci_Orden.Exec_Estimate_Date%Type;
    dtMax_Date_To_Legalize LDCI_ORDEN.Max_Date_To_Legalize%type;

    -- variables para el manejo del procesameinto
    nuLotes         number(4) := 0;
    nuRegistrosLote number(4) := 0; --#NC-87252: carlosvl: 07-02-2014: Se inicializa en cero la variable. (Valor anterior 3200)
    sbRegistrosLote LDCI_CARASEWE.CASEDESE%type; --#NC-87252: carlosvl: 07-02-2014: Variable que almacena el numero de registros por lote
    nuContadorRows  number(4) := 0;
    nuLote          number := 1;
    nuTransac       number := 0;
    cantOrds        number := 0;
    cantActs        number := 0;
    nuCantActs      number := 0;
    OnuFLAFPROCESO  number := 0;
    nuMesacodi      LDCI_MESAPROC.MESACODI%TYPE;
    isbParametros   VARCHAR2(2000);
    nuUserID        SA_USER.USER_ID%TYPE;
    nuPersonID      ge_person.person_id%type;
    sbSubnetmask    sa_user.mask%type;
    sbCorreo        VARCHAR2(250);
    nuFlagGeneral   number := 0;

    errorPara01 EXCEPTION; -- #NC-87252: carlosvl: 07-02-2014: Se define la excepcion para validar la carga del parametro
  Begin

    isbParametros := '<Parametros>
                        <parametro>
                            <nombre>OperatingUnitId</nombre>
                            <valor>' ||
                     inuOperatingUnitId ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>GeograLocationId</nombre>
                            <valor>' ||
                     inuGeograLocationId ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>ConsCycleId</nombre>
                            <valor>' || inuConsCycleId ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>operatingsectorid</nombre>
                            <valor>' ||
                     Inuoperatingsectorid ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>RouteId</nombre>
                            <valor>' || inuRouteId ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>initialdate</nombre>
                            <valor>' || Idtinitialdate ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>finaldata</nombre>
                            <valor>' || Idtfinaldata ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>tasktypeid</nombre>
                            <valor>' || Inutasktypeid ||
                     '</valor>
                        </parametro>
                        <parametro>
                            <nombre>OrderStatusId</nombre>
                            <valor>' ||
                     inuOrderStatusId || '</valor>
                        </parametro>
                    </Parametros>
                    ';
    /* CREAR TRANSACCION  */
    LDCI_PKMESAWS.proCreaEstaProc('WS_ENVIO_ORDENES',
                                  isbParametros,
                                  CURRENT_DATE,
                                  'P',
                                  sys_context('USERENV', 'CURRENT_USER'),
                                  null,
                                  null,
                                  nuTransac,
                                  Onuerrorcode,
                                  Osberrormsg);

    --#NC-87252: carlosvl: 07-02-2014: Se inicializa la variable nuRegistrosLote con el valor del parametro WS_ENVIO_ORDENES -> NRO_REG_LOTE
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES',
                                       'NRO_REG_LOTE',
                                       sbRegistrosLote,
                                       OSBERRORMSG);
    if (OSBERRORMSG != '0') then
      RAISE errorPara01;
    else
      nuRegistrosLote := to_number(sbRegistrosLote);
    end if; --if(OSBERRORMSG != '0') then

    IF Onuerrorcode = 0 THEN
      /* CARGAR ORDENES */
      OS_GETWORKORDERS(Inuoperatingunitid,
                       Inugeogralocationid,
                       Inuconscycleid,
                       Inuoperatingsectorid,
                       inuRouteId,
                       Idtinitialdate,
                       Idtfinaldata,
                       Inutasktypeid,
                       Inuorderstatusid,
                       Recregistros,
                       Onuerrorcode,
                       Osberrormsg);

      IF Onuerrorcode = 0 then

        /* CARGAR PERSISTIR ORDEN */
        loop
          Fetch Recregistros
            Into Nuorder_Id,
                 Nutask_Type_Id,
                 Nuorder_Status_Id,
                 Nuaddress_Id,
                 Sbaddress,
                 Nugeogra_Location_Id,
                 Nuneighborthood,
                 Nuoper_Sector_Id,
                 Nuroute_Id,
                 Nuconsecutive,
                 Nupriority,
                 Dtassigned_Date,
                 Dtarrange_Hour,
                 Dtcreated_Date,
                 Dtexec_Estimate_Date,
                 dtMax_Date_To_Legalize;

          EXIT WHEN Recregistros%notfound;

          LDCI_PKVALIDASIGELEC.PROVALIDAORDEN(nuTransac,
                                              Nuorder_Id,
                                              Nutask_Type_Id,
                                              Nuorder_Status_Id,
                                              Nuaddress_Id,
                                              Sbaddress,
                                              Nugeogra_Location_Id,
                                              Nuneighborthood,
                                              Nuoper_Sector_Id,
                                              Nuroute_Id,
                                              Nuconsecutive,
                                              Nupriority,
                                              Dtassigned_Date,
                                              Dtarrange_Hour,
                                              Dtcreated_Date,
                                              Dtexec_Estimate_Date,
                                              dtMax_Date_To_Legalize,
                                              OnuFLAFPROCESO);

          IF OnuFLAFPROCESO = 0 THEN
            Insert Into LDCI_ORDEN
              (Order_Id,
               Task_Type_Id,
               Order_Status_Id,
               Address_Id,
               Address,
               Geogra_Location_Id,
               Neighborthood,
               Oper_Sector_Id,
               Route_Id,
               Consecutive,
               Priority,
               Assigned_Date,
               Arrange_Hour,
               Created_Date,
               Exec_Estimate_Date,
               Max_Date_To_Legalize,
               TRANSAC_ID,
               LOTE,
               PAQUETES)
            Values
              (Nuorder_Id,
               Nutask_Type_Id,
               Nuorder_Status_Id,
               Nuaddress_Id,
               Sbaddress,
               Nugeogra_Location_Id,
               Nuneighborthood,
               Nuoper_Sector_Id,
               Nuroute_Id,
               Nuconsecutive,
               Nupriority,
               Dtassigned_Date,
               Dtarrange_Hour,
               dtCreated_Date,
               dtExec_Estimate_Date,
               dtMax_Date_To_Legalize,
               nuTransac,
               nuLote,
               nuLotes);
            cantOrds := cantOrds + 1;

            /* CARGAR ACTIVIDADES DE LA ORDEN */
            PROCESOACTIVIDADESORDEN(nuOrder_Id,
                                    nuCantActs,
                                    nuTransac,
                                    OnuFLAFPROCESO);

            if OnuFLAFPROCESO = 0 then
              cantActs       := cantActs + nuCantActs;
              nuContadorRows := nuContadorRows + 1;

              if nuContadorRows = nuRegistrosLote then
                nuContadorRows := 0;
                nuLote         := nuLote + 1;
              end if; --if nuContadorRows = nuRegistrosLote then
            else
              nuFlagGeneral := 1;
              LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                            'No se validaron satisfacotiriamente las actividades de la orden: ' ||
                                            nuOrder_Id,
                                            'E',
                                            CURRENT_DATE,
                                            nuMesacodi,
                                            Onuerrorcode,
                                            Osberrormsg);
            end if; --if OnuFLAFPROCESO = 0  then

          END IF; --IF OnuFLAFPROCESO = 0 THEN
          COMMIT;

        end loop; -- loop

        if nuFlagGeneral = 0 then
          /*Definir cuantos paquetes se generaron*/
          nuLotes := ceil(Recregistros%rowcount / nuRegistrosLote);

          ut_trace.trace(nuTransac || ' ' || nuLotes || ' ' || cantOrds || ' ' ||
                         cantacts,
                         15);
          LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                        'Cantidad de Lotes: ' || nuLotes,
                                        'I',
                                        CURRENT_DATE,
                                        nuMesacodi,
                                        ONUERRORCODE,
                                        OSBERRORMSG);

          LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                        'Cantidad de Ordenes: ' || cantOrds,
                                        'I',
                                        CURRENT_DATE,
                                        nuMesacodi,
                                        ONUERRORCODE,
                                        OSBERRORMSG);

          LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                        'Cantidad Actividades: ' ||
                                        cantacts,
                                        'I',
                                        CURRENT_DATE,
                                        nuMesacodi,
                                        ONUERRORCODE,
                                        OSBERRORMSG);
          Close Recregistros;

          if nuLotes > 0 then
            for contador in 1 .. nuLotes loop
              /*
                GENERAR PAYLOADS POR LOTE
              */
              ut_trace.trace('Creando payload lote : ' || contador ||
                             ' de ' || nuLotes,
                             15);
              PROGENERARPAYLOADSORDENES(nuTransac,
                                        contador,
                                        nuLotes,
                                        Onuerrorcode,
                                        Osberrormsg);

              if Onuerrorcode != 0 then
                LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                              Osberrormsg,
                                              'E',
                                              CURRENT_DATE,
                                              nuMesacodi,
                                              Onuerrorcode,
                                              Osberrormsg);
              end if; --if Onuerrorcode != 0 then
            end loop; -- for contador in 1 .. nuLotes loop

            -- actualiza el proceso
            LDCI_PKMESAWS.PROACTUESTAPROC(nuTransac,
                                          CURRENT_DATE,
                                          'R',
                                          Onuerrorcode,
                                          Osberrormsg);
          else
            -- crea un mensaje de excepcion
            LDCI_PKMESAWS.PROCREAMENSPROC(nuTransac,
                                          'La cantidad de lotes no es valida ',
                                          'E',
                                          CURRENT_DATE,
                                          nuMesacodi,
                                          Onuerrorcode,
                                          Osberrormsg);
          end if; -- if nuLotes > 0 then

        else
          Osberrormsg := 'No puede generar payloads. ';
          LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                        Osberrormsg,
                                        'E',
                                        CURRENT_DATE,
                                        nuMesacodi,
                                        Onuerrorcode,
                                        Osberrormsg);
        end if;

        Osberrormsg := 'Finalizo el procesamiento de ordenes. ';
        LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                      Osberrormsg,
                                      'I',
                                      CURRENT_DATE,
                                      nuMesacodi,
                                      Onuerrorcode,
                                      Osberrormsg);

        commit;

        /*
          ENVIAR NOTIFICACION
        */
        --ut_trace.trace('Antes de enviar correo: ' ,15);

        NOTIFICARPROCESOORDENES(nuTransac);
        LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                      'Se envio correo electronico',
                                      'I',
                                      CURRENT_DATE,
                                      nuMesacodi,
                                      Onuerrorcode,
                                      Osberrormsg);
        -- ut_trace.trace('despues de enviar correo: ' ,15);

        /*
          LIMPIAR TABLA TEMPORAL
        */
        PROLIMPIARTEMPORALES;
        COMMIT;

      ELSE
        /*
          GUARDAR MENSAJE
        */
        LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                      Osberrormsg,
                                      'E',
                                      CURRENT_DATE,
                                      nuMesacodi,
                                      Onuerrorcode,
                                      Osberrormsg);

        /*
         ENVIAR NOTIFICACION
        */
        ut_trace.trace('Antes de enviar correo: ', 15);
        NOTIFICARPROCESOORDENES(nuTransac);
        ut_trace.trace('despues de enviar correo: ', 15);
      end IF;

    ELSE
      /*
        NO CREO EL PROCESO
      */
      GI_BOERRORS.SETERRORCODEARGUMENT(2741, Osberrormsg);
      raise ex.CONTROLLED_ERROR;
    END IF;

  EXCEPTION

    When Errorpara01 then
      --#NC-87252: carlosvl: 07-02-2014: Se registra la excepcion generada
      ONUERRORCODE := -1;
      OSBERRORMSG  := 'ERROR: <LDCI_PKGESTLEGAORDEN.PROCESARORDENESLECTURATRANSAC>: Error en carga de parametros: ' ||
                      OSBERRORMSG;
      LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                    OSBERRORMSG,
                                    'E',
                                    CURRENT_DATE,
                                    nuMesacodi,
                                    Onuerrorcode,
                                    Osberrormsg);
      PROLIMPIARTEMPORALES;
      COMMIT;
    WHEN OTHERS THEN
      LDCI_PKMESAWS.proCreaMensProc(nuTransac,
                                    'ERROR: ' || SQLERRM || '. ' ||
                                    Dbms_Utility.Format_Error_Backtrace,
                                    'E',
                                    CURRENT_DATE,
                                    nuMesacodi,
                                    Onuerrorcode,
                                    Osberrormsg);
      PROLIMPIARTEMPORALES;
      COMMIT;
  END PROCESARORDENESLECTURATRANSAC;

  procedure PROLEGALIZARORDEN(ISBDATAORDER  in varchar2,
                              IDTINITDATE   in date,
                              IDTFINALDATE  in date,
                              IDTCHANGEDATE in date,
                              Resultado     out Number,
                              Msj           out Varchar2) AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.PROLEGALIZARORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura, permite legalizar ordenes de lectura

      Historia de Modificaciones
      Autor                 Fecha          Descripcion
      Jorge Valiente      06/07/2023       OSF-1311: Cambio de API OS_LEGALIZEORDERS por el nuevo API API_LEGALIZEORDERS
    */
  BEGIN
    API_LEGALIZEORDERS(ISBDATAORDER,
                      IDTINITDATE,
                      IDTFINALDATE,
                      IDTCHANGEDATE,
                      Resultado,
                      Msj);
    if Resultado = 0 then
      commit;
      Msj := 'Legalizo correctamente';
    else
      Dbms_Output.Put_Line('Rollback: ' || Resultado || ' - ' || Msj);
      rollback;
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
  end PROLEGALIZARORDEN;

  Procedure PROCESOORDENES As
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.PROCESOORDENES
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Procedimeinto usado en el proceso en BATCH PBPIO

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    cnuNULL_ATTRIBUTE constant number := 2126;
    inuOperatingUnitId   NUMBER := -1;
    inuGeograLocationId  NUMBER := -1;
    inuConsCycleId       NUMBER;
    Inuoperatingsectorid NUMBER := -1;
    inuRouteId           NUMBER := -1;
    Idtinitialdate       Date;
    Idtfinaldata         Date;
    Inutasktypeid        Number := -1;
    inuOrderStatusId     NUMBER := 5;
    Onuerrorcode         Number;
    Osberrormsg          Varchar2(2000);
    sbParametros         VARCHAR2(200);
    sbOPERATING_UNIT_ID  ge_boInstanceControl.stysbValue;
    sbCOCICICL           ge_boInstanceControl.stysbValue;
    sbTASK_TYPE_ID       ge_boInstanceControl.stysbValue; --#NC-87453
    nuUserID             SA_USER.USER_ID%TYPE;
    nuPersonID           ge_person.person_id%type;
    sbSubnetmask         sa_user.mask%type;

  BEGIN

    sbOPERATING_UNIT_ID := ge_boInstanceControl.fsbGetFieldValue('OR_OPERATING_UNIT',
                                                                 'OPERATING_UNIT_ID');
    sbCOCICICL          := ge_boInstanceControl.fsbGetFieldValue('CONCCICL',
                                                                 'COCICICL');
    sbTASK_TYPE_ID      := ge_boInstanceControl.fsbGetFieldValue('OR_TASK_TYPES_ITEMS',
                                                                 'TASK_TYPE_ID'); --#NC-87453

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    --#NC-87453
    if (sbTASK_TYPE_ID is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo de Trabajo');
      raise ex.CONTROLLED_ERROR;
    end if;

    inuOperatingUnitId := nvl(to_number(sbOPERATING_UNIT_ID), 0);
    inuConsCycleId     := nvl(to_number(sbCOCICICL), 0);
    Inutasktypeid      := nvl(to_number(sbTASK_TYPE_ID), 0); --#NC-87453

    nuUserID   := sa_bouser.fnuGetUserId(ut_session.getuser);
    nuPersonID := GE_BCPerson.fnuGetFirstPersonByUserId(nuUserID);

    ut_trace.trace('Inicia PROCESARORDENESLECTURATRANSAC ' ||
                   ut_session.getuser,
                   15);
    ut_trace.trace('USER ID ' || nuUserID, 15);
    ut_trace.trace('PERSON ID ' || nuPersonID, 15);

    PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId,
                                  inuGeograLocationId,
                                  inuConsCycleId,
                                  Inuoperatingsectorid,
                                  inuRouteId,
                                  Idtinitialdate,
                                  Idtfinaldata,
                                  Inutasktypeid,
                                  inuOrderStatusId,
                                  Onuerrorcode,
                                  Osberrormsg);
    ut_trace.trace('Finaliza PROCESARORDENESLECTURATRANSAC. ' ||
                   Onuerrorcode || ' - ' || Osberrormsg,
                   15);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PROCESOORDENES;

  procedure PROSETFILEAT(inuActivity     in NUMBER,
                         isbFileName     in VARCHAR2,
                         isbObservation  in VARCHAR2,
                         icbFileSrc      in CLOB,
                         onuErrorCode    Out NUMBER,
                         osbErrorMessage Out VARCHAR2) as
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       PROCEDIMIENTO : LDCI_PKGESTLEGAORDEN.PROSETFILEAT
       AUTOR      : OLSoftware / Carlos E. Virgen
       FECHA      : 07/02/2013
       RICEF      : I017
       DESCRIPCION: Carga la informacion de la imagen, tansformandola de  HEX a BIN,
            hanciendo el llamado al API OS_LOADFILETOREADING.

      Historia de Modificaciones
      Autor   Fecha   Descripcion

    create table LDCI_OS_LOADFILETOREADING (inuActivity NUMBER(15),
                                            isbFileName VARCHAR2(100),
                      isbObservation VARCHAR2(250),
                      icbFileSrc CLOB,
                      icbFileSrcCode64 CLOB,
                      icbFileSrcDecode64 CLOB,
                      ibbFileSrc BLOB);

      alter table LDCI_OS_LOADFILETOREADING add (icbFileSrcCode64 CLOB,icbFileSrcDecode64 CLOB);


     */

    -- define variables
    ibbFileSrc BLOB := EMPTY_BLOB();

    -- excepciones
    exce_OS_LOADFILETOREADING EXCEPTION; -- manejo de excepciones del API OS_LOADFILETOREADING

    function fcbClobToBlob(p_clob_in in clob) return blob is
      v_blob           blob;
      v_offset         integer;
      v_buffer_varchar varchar2(32000);
      v_buffer_raw     raw(32000);
      v_buffer_size    binary_integer := 32000;
    begin
      --
      if p_clob_in is null then
        return null;
      end if;
      --
      dbms_lob.createtemporary(v_blob, TRUE);
      v_offset := 1;
      for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size) loop
        dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
        v_buffer_raw := hextoraw(v_buffer_varchar);
        dbms_lob.writeappend(v_blob,
                             utl_raw.length(v_buffer_raw),
                             v_buffer_raw);
        v_offset := v_offset + v_buffer_size;
      end loop; -- for i in 1..ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size)
      return v_blob;
    end fcbClobToBlob;

  begin
    -- convierte el texto HEX en BLOB
    ibbFileSrc := fcbClobToBlob(icbFileSrc);

    -- hace el llamado al API icbFileSrc
    OS_LOADFILETOREADING(inuActivity,
                         isbFileName,
                         isbObservation,
                         ibbFileSrc,
                         onuErrorCode,
                         osbErrorMessage);

    if (onuErrorCode <> 0) then
      raise exce_OS_LOADFILETOREADING;
    else
      -- libera el espacio temporal
      dbms_lob.freetemporary(ibbFileSrc);
      commit;
    end if; -- if (onuErrorCode <> 0) then

  Exception
    When exce_OS_LOADFILETOREADING then
      rollback;
      --Raise_Application_Error(-20100, 'ERROR: [PROSETFILEAT.Exception.exce_OS_LOADFILETOREADING]: ' || osbErrorMessage);
    when others then
      rollback;
      onuErrorCode    := SQLCODE;
      osbErrorMessage := 'ERROR: [PROSETFILEAT.Exception.others]: Error no controlado : ' ||
                         chr(13) || SQLERRM || ' | ' ||
                         Dbms_Utility.Format_Error_Backtrace;
      --Raise_Application_Error(-20100, 'ERROR: [PROSETFILEAT.Exception.others]: Error no controlado : ' || chr(13) || SQLERRM || ' | ' || Dbms_Utility.Format_Error_Backtrace);
  end PROSETFILEAT;

  procedure proLegalizaOrdenes as
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKGESTLEGAORDEN.proLegalizaLoteOrdenes
     * Tiquete : I058 Provision de consumo
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 24/06/2013
     * Descripcion : Registra la informacion de la provision de consumo en la tabla IC_MOVIMIEN
     *
     * Parametros:
      * IN: iclXMLOrdenes: Codigo del elemento de medicion
                    <!-- mensaje para el paquete de integracion -->
                    <!-- nuevo dise?o -->
                    <?xml version="1.0" encoding="UTF-8" ?>
                    <LISTA_ORDENES>
                      <ORDEN>
               <ISBDATAORDER>4499528|9688|2929||3607397>1;READING>123>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;</ISBDATAORDER>
               <IDTINITDATE>2013-11-21 16:57:00</IDTINITDATE>
               <IDTFINALDATE>2013-11-21 16:57:00</IDTFINALDATE>
                        <IDTCHANGEDATE>2013-11-21 16:57:00</IDTCHANGEDATE>
                      </ORDEN>
                      <ORDEN>
               <ISBDATAORDER>4499528|9688|2929||3607397>1;READING>123>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;</ISBDATAORDER>
               <IDTINITDATE>2013-11-21 16:57:00</IDTINITDATE>
               <IDTFINALDATE>2013-11-21 16:57:00</IDTFINALDATE>
                        <IDTCHANGEDATE>2013-11-21 16:57:00</IDTCHANGEDATE>
                      </ORDEN>
                    </LISTA_ORDENES>
     * OUT: orfMensProc: Codigo del mensaje de respuesta
      *
      *
     * Autor                    Fecha         Descripcion
     * carlosvl                 09-04-2013    Creacion del procedimiento
     * JESUS VIVERO (LUDYCOM)   12-02-2015    #20150212: jesusv: Se cambia de posicion las confirmaciones de transacciones
     * Jorge Valiente      06/07/2023       OSF-1311: Cambio de API OS_LEGALIZEORDERS por el nuevo API API_LEGALIZEORDERS     
    **/
    -- definicion de variables
    onuMessageCode NUMBER;
    osbMessageText VARCHAR2(2000);
    boExcepcion    BOOLEAN;

    nuCodMensajeLega Number;
    sbMensajeLega    Varchar2(2000);

    sbCASECODI LDCI_CARASEWE.CASEDESE%type := 'WS_ENVIO_ORDENES';

    -- variables para el manejo del proceso LDCI_ESTAPROC
    sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;
    cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;
    dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;
    sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;
    nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;
    nuORDEN    LDCI_ORDENESALEGALIZAR.order_id%type;
    sbEstOrden LDCI_ORDENESALEGALIZAR.state%type;
    -- variables para la creacion de los mensajes LDCI_MESAENVWS
    nuMESACODI LDCI_MESAENVWS.MESACODI%type;

    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    cursor cuORDENES is
      SELECT *
        FROM LDCI_ORDENESALEGALIZAR
       WHERE STATE in ('P' /*, 'G', 'EN'*/);

    -- definicion de variables tipo registro
    reIC_DOCUGENE IC_DOCUGENE%rowtype;

    -- excepciones
    excep_PROCARASERVWEB exception;
    excep_ESTAPROC       exception;

    /*
    * NC:    Validacion de ordenes ya legalizada
    * Autor: Hector Fabio Dominguez
    * Fecha: 18-12-2013
    */

    sbMensajeValidaOrd VARCHAR2(1000);

    sbEstaOrdenGest Ldci_Ordenmoviles.Estado_Envio%Type;
    sbProcesoLegaOk Varchar2(1); --#20150212: jesusv: Se crea flag de validacion de proceso de legalizacion ya que el codigo de error no se puede usar porque lo resetean a 0 dentro de algunos procesos

  begin
    -- inicializa el mensaje de salida
    onuMessageCode := 0;
    osbMessageText := null;
    boExcepcion    := false;

    -- realiza la creacion del proceso
    cbPROCPARA := ' <PARAMETROS>
                                <PARAMETRO>
                                    <NOMBRE>iclXMLOrdenes</NOMBRE>
                                    <VALOR>iclXMLOrdenes</VALOR>
                                </PARAMETRO>
                              </PARAMETROS>';

    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,
                                  ICBPROCPARA     => cbProcPara,
                                  IDTPROCFEIN     => SYSDATE,
                                  ISBPROCESTA     => 'P',
                                  ISBPROCUSUA     => null,
                                  ISBPROCTERM     => null,
                                  ISBPROCPROG     => null,
                                  ONUPROCCODI     => nuPROCCODI,
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (onuMessageCode <> 0) then
      RAISE excep_ESTAPROC;
    end if; --if (onuMessageCode <> 0) then

    -- Recorre el listado de ordenes a legalziar
    for reLISTA_ORDENES in cuORDENES loop
      onuMessageCode  := 0;
      osbMessageText  := null;
      sbProcesoLegaOk := Null;

      nuCodMensajeLega := 0;
      sbMensajeLega    := Null;

      nuORDEN := reLISTA_ORDENES.ORDER_ID;
      --DBMS_OUTPUT.PUT_LINE('ISBDATAORDER  = ' || reLISTA_ORDENES.ISBDATAORDER);
      --DBMS_OUTPUT.PUT_LINE('IDTINITDATE   = ' || reLISTA_ORDENES.IDTINITDATE);
      --DBMS_OUTPUT.PUT_LINE('IDTFINALDATE  = ' || reLISTA_ORDENES.IDTFINALDATE);
      --DBMS_OUTPUT.PUT_LINE('IDTCHANGEDATE = ' || reLISTA_ORDENES.IDTCHANGEDATE);

      -- Llama el API de lagalizacion de Ordenes
      API_LEGALIZEORDERS(reLISTA_ORDENES.DATAORDER,
                        to_date(reLISTA_ORDENES.INITDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        to_date(reLISTA_ORDENES.FINALDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        to_date(reLISTA_ORDENES.CHANGEDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        onuMessageCode,
                        osbMessageText);

      /*
      * NC:    Validacion de ordenes ya legalizadas
      * Autor: Hector Fabio Dominguez
      * Fecha: 18-12-2013
      */

      /*
      * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden
      */

      IF (onuMessageCode = 2582) THEN

        /*
        * Validamos Si la orden se encuentra legalizada
        */
        IF LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega(nuORDEN,
                                                     sbMensajeValidaOrd) = 1 THEN
          /*
          * Si la orden se encuentra legalizada
          * entonces reasignamos a 0 para que el mensaje
          * sea considerado como exitoso
          */
          onuMessageCode := 0;
          osbMessageText := 'ORDEN LEGALIZADA PREVIAMENTE' ||
                            osbMessageText;
        ELSE
          /*
          * En caso de que no este legalizada, agregamos la traza al mensaje
          * para que se guarde posteriormente
          */
          osbMessageText := osbMessageText || ' ' || sbMensajeValidaOrd;
        END IF;

      END IF;

      nuCodMensajeLega := onuMessageCode;
      sbMensajeLega    := osbMessageText;

      --valida el mensaje de salida de la orden
      if (onuMessageCode = 0) then

        sbMensajeLega := 'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' ||
                         osbMessageText;

        LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                         ISBMESATIPO     => 'I',
                                         INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                         ISBMESADESC     => sbMensajeLega, --'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                         ISBMESAVAL1     => to_char(nuORDEN),
                                         ISBMESAVAL2     => null,
                                         ISBMESAVAL3     => null,
                                         ISBMESAVAL4     => null,
                                         IDTMESAFECH     => sysdate,
                                         ONUMESACODI     => nuMESACODI,
                                         ONUERRORCODE    => onuMessageCode,
                                         OSBERRORMESSAGE => osbMessageText);

        sbEstOrden      := 'L';
        sbEstaOrdenGest := 'G';

        --commit; --#20150212: jesusv: Se quita commit
        sbProcesoLegaOk := 'S'; --#20150212: jesusv: Se confirma que el proceso es OK

      else
        boExcepcion := true;

        sbMensajeLega := 'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' ||
                         osbMessageText;

        LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                         ISBMESATIPO     => 'E',
                                         INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                         ISBMESADESC     => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                         ISBMESAVAL1     => to_char(nuORDEN),
                                         ISBMESAVAL2     => null,
                                         ISBMESAVAL3     => null,
                                         ISBMESAVAL4     => null,
                                         IDTMESAFECH     => sysdate,
                                         ONUMESACODI     => nuMESACODI,
                                         ONUERRORCODE    => onuMessageCode,
                                         OSBERRORMESSAGE => osbMessageText);
        sbEstOrden      := 'G';
        sbEstaOrdenGest := 'F';

        --rollback;  --#20150212: jesusv: Se quita rollback
        sbProcesoLegaOk := 'N'; --#20150212: jesusv: Se confirma que el proceso fue con error

      end if; --      if (onuMessageCode = 0) then

      proActualizaEstado(nuORDEN,
                         nuCodMensajeLega, --onuMessageCode,
                         sbMensajeLega, --osbMessageText,
                         sbEstOrden);
      LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada(inuOrden        => nuORDEN,
                                                      isbEstado       => sbEstaOrdenGest /*'G'*/,
                                                      onuErrorCode    => onuMessageCode,
                                                      osbErrorMessage => osbMessageText);

      --#20150212: jesusv: (INICIO) - Se valida si existe error para cambiar el estado de procesamiento de la orden
      If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
        Commit;
      Else
        Rollback;
      End If; --   If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
    --#20150212: jesusv: (FIN) - Se valida si existe error para cambiar el estado de procesamiento de la orden

    end loop; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

    -- finaliza el procesamiento
    LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,
                                  IDTPROCFEFI     => sysdate,
                                  ISBPROCESTA     => 'F',
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (boExcepcion = false) then
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'Proceso ha terminado satisfactoriamente.',
                                    ISBMESATIPO     => 'S',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if; --if (boExcepcion = false) then

  exception
    when excep_ESTAPROC then
      LDCI_pkWebServUtils.Procrearerrorlogint('proLegalizaOrdenes',
                                              1,
                                              osbMessageText,
                                              null,
                                              null);
    when others then
      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'SQLCODE: ' ||
                                                       SQLCODE || ' : ' ||
                                                       SQLERRM,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'TRACE: ' ||
                                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      rollback;

  end proLegalizaOrdenes;

  procedure proLegalizaOrdenesSistema(isbSistema ldci_ordenesalegalizar.system%type) as
    /* -------------------------------------------------------------------------------------------------------------------------------------------------------
     Propiedad Intelectual Gases del Caribe SA ESP
     Nombre  : LDCI_PKGESTLEGAORDEN.proLegalizaLoteOrdenes
     Autor   : Eduardo Aguera
     Fecha   : 28/12/2017
     Descripcion : Basado en proLegalizaOrdenes. Se crea para independizar la legalizacion de ordenes por sistema.

     Historial de modificaciones
     Autor                    Fecha         Descripcion
     Eduardo Aguera           28/12/2017    Creacion del procedimiento en el dia de los inocentes ;)
     Miguel Ballesteros       14/01/2020    CASO 250 - Se modifica la cadena de legalizacion de la variable 
                                            SARTA para tener en cuenta el valor de la cantidad por el tipo de causal
     dsaltarin                02/12/2020    614: Se corrige la forma de obtener el identificador de or_order_Activity
     Jorge Valiente           30/06/2023    OSF-1311: Actualizar el API llamado OS_LEGALIZEORDERS por el API llamado API_LEGALIZEORDERS
    -------------------------------------------------------------------------------------------------------------------------------------------------------**/
    --definicion de variables
    onuMessageCode   NUMBER;
    osbMessageText   VARCHAR2(2000);
  --- variable caso 250 --
    onuMessageCode2   NUMBER:= 0;
    osbMessageText2  VARCHAR2(2000):= null;
  --- fin caso 250 -------
    boExcepcion      BOOLEAN;
    nuCodMensajeLega Number;
    sbMensajeLega    Varchar2(2000);

    sbCASECODI LDCI_CARASEWE.CASEDESE%type := 'WS_ENVIO_ORDENES';

    -- variables para el manejo del proceso LDCI_ESTAPROC
    sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;
    cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;
    dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;
    sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;
    nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;
    nuORDEN    LDCI_ORDENESALEGALIZAR.order_id%type;
    sbEstOrden LDCI_ORDENESALEGALIZAR.state%type;
    -- variables para la creacion de los mensajes LDCI_MESAENVWS
    nuMESACODI LDCI_MESAENVWS.MESACODI%type;

    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    /* Cursor cuORDENES is
    select a.order_id, a.system, a.dataorder, a.initdate, a.finaldate, a.changedate, a.messagecode, a.messagetext, a.state, a.fecha_recepcion, a.fecha_procesado, a.fecha_notificado, a.veces_procesado
    from LDCI_ORDENESALEGALIZAR a, or_order_activity ac, servsusc
    where a.state = 'P'
    and a.System = 'WS_SIGELEC'
    and a.fecha_recepcion <= trunc(sysdate)+1
    and ac.order_id = a.order_id
    and ac.product_id = sesunuse
    and sesucicl = 4616
    and rownum <= 500;*/

    Cursor cuORDENES is
      select order_id,
             system,
             dataorder,
             initdate,
             finaldate,
             changedate,
             messagecode,
             messagetext,
             state,
             fecha_recepcion,
             fecha_procesado,
             fecha_notificado,
             veces_procesado
        from LDCI_ORDENESALEGALIZAR
       where state = 'P'
         and System = isbSistema
       order by fecha_recepcion asc;

    -- definicion de variables tipo registro
    reIC_DOCUGENE IC_DOCUGENE%rowtype;

    -- excepciones
    excep_PROCARASERVWEB exception;
    excep_ESTAPROC       exception;

    sbMensajeValidaOrd VARCHAR2(1000);

    sbEstaOrdenGest Ldci_Ordenmoviles.Estado_Envio%Type;
    sbProcesoLegaOk Varchar2(1); --#20150212: jesusv: Se crea flag de validacion de proceso de legalizacion ya que el codigo de error no se puede usar porque lo resetean a 0 dentro de algunos procesos

    --- registro para guardar los datos
    type tyrcDataRecord is record(
      Order_Id         LDCI_ORDENESALEGALIZAR.Order_Id%type,
      system           LDCI_ORDENESALEGALIZAR.system%type,
      dataorder        LDCI_ORDENESALEGALIZAR.dataorder%type,
      initdate         LDCI_ORDENESALEGALIZAR.initdate%type,
      finaldate        LDCI_ORDENESALEGALIZAR.finaldate%type,
      changedate       LDCI_ORDENESALEGALIZAR.changedate%type,
      messagecode      LDCI_ORDENESALEGALIZAR.messagecode%type,
      messagetext      LDCI_ORDENESALEGALIZAR.messagetext%type,
      state            LDCI_ORDENESALEGALIZAR.state%type,
      fecha_recepcion  LDCI_ORDENESALEGALIZAR.fecha_recepcion%type,
      fecha_procesado  LDCI_ORDENESALEGALIZAR.fecha_procesado%type,
      fecha_notificado LDCI_ORDENESALEGALIZAR.fecha_notificado%type,
      veces_procesado  LDCI_ORDENESALEGALIZAR.veces_procesado%type);

    nuCommit number(5);
    type tytbDataTable is table of tyrcDataRecord index by binary_integer;
    reLISTA_ORDENES tytbDataTable;
    nucausal        or_order.causal_id%type;
    NUCaus3612    or_order.causal_id%type;
    nuTITR12457   or_order.TASK_TYPE_ID%type;
    sbcausal        varchar2(100);
    sbactivity      varchar2(100);
    ttid            or_order.task_type_id%type;
    ccid            or_order.causal_id%type;
    nucausparam     ge_causal.causal_id%TYPE;
    nuactivity      or_order_activity.activity_id%type;
    nuactivityoa    or_order_activity.order_activity_id%type;
    onuErrorCode    number;
    osbErrorMessage VARCHAR2(2000);
    sarta           LDCI_ORDENESALEGALIZAR.dataorder%type;
    isbTaskTypeChg varchar2(4000);
    n number;
  mp number(4);
  ntt or_order.task_type_id%type;
  ncc or_order.causal_id%type;

  sbFlagAplica VARCHAR2(1) :='N';
  
  ---- caso 250 ---
    nuClassCausalid         open.ge_causal.class_causal_id%type;
    nuClassCausAnt      open.ge_causal.class_causal_id%type;
    CURSOR CUGETCLASSCAUSAL (nuCausal_id    GE_CAUSAL.CAUSAL_ID%TYPE) IS
        select g.class_causal_id CLASE_Causal
            from ge_causal g
            where g.causal_id = nuCausal_id;
   tbCadena   ut_string.TYTB_STRING;
   sbSeparador VARCHAR2(1) := '|';   
   
   sbCadOrden  varchar2(4000);
   sbCadCausal  varchar2(4000);
   sbCadPersona  varchar2(4000);
   sbCadDatAdi  varchar2(4000);
   sbCadActiv  varchar2(4000);
   sbCadItems  varchar2(4000);
   sbLect  varchar2(4000);
   sbCadCom  varchar2(4000);
   sbCadFechEjec  varchar2(4000);
   nuOrderActivitynew  open.or_order_activity.order_activity_id%type;
               
  --- fin de caso 250 ---
  
  begin

--    dbms_output.put_line('entre');

    --parametro para obtener el codigo del servicio de gas
    -- inicializa el mensaje de salida
    onuMessageCode := 0;
    osbMessageText := null;
    boExcepcion    := false;

  IF fblaplicaentrega('OSS_RVP_VHMR_2002254_3')  THEN
    sbFlagAplica := 'S';
  END IF;

    -- realiza la creacion del proceso
    cbPROCPARA := ' <PARAMETROS>
                                <PARAMETRO>
                                    <NOMBRE>iclXMLOrdenes</NOMBRE>
                                    <VALOR>iclXMLOrdenes</VALOR>
                                </PARAMETRO>
                              </PARAMETROS>';

    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,
                                  ICBPROCPARA     => cbProcPara,
                                  IDTPROCFEIN     => SYSDATE,
                                  ISBPROCESTA     => 'P',
                                  ISBPROCUSUA     => null,
                                  ISBPROCTERM     => null,
                                  ISBPROCPROG     => null,
                                  ONUPROCCODI     => nuPROCCODI,
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (onuMessageCode <> 0) then
      RAISE excep_ESTAPROC;
    end if; --if (onuMessageCode <> 0) then

    -- Recorre el listado de ordenes a legalizar
    --for reLISTA_ORDENES in cuORDENES loop

  --  dbms_output.put_line('voy a recorrer ordenes');


    OPEN cuORDENES;
    LOOP
      FETCH cuORDENES BULK COLLECT
        INTO reLISTA_ORDENES LIMIT 1000;
   --   dbms_output.put_line('hizo el primer bulk collect');
      FOR i in 1 .. reLISTA_ORDENES.count loop
        onuMessageCode  := 0;
        osbMessageText  := null;
        sbProcesoLegaOk := Null;
        dbms_output.put_line('estoy en la orden ----'||to_char(reLISTA_ORDENES(i).ORDER_ID));
        nuCodMensajeLega := 0;
        sbMensajeLega    := Null;
        sarta:=reLISTA_ORDENES(i).DATAORDER;
        nuORDEN := reLISTA_ORDENES(i).ORDER_ID;


    IF sbFlagAplica = 'S' THEN

    --  DBMS_OUTPUT.PUT_LINE('VOY A BUSCAR TIPO DE TRABAJO');
      -- 200-2254 busca el tipo de trabajo y la causal de ya tenerla de la orden a legalizar
      select task_type_id,causal_id into ttid,ccid from or_order where order_id=reLISTA_ORDENES(i).order_id;
     -- DBMS_OUTPUT.PUT_LINE('TIPO DE TRABAJO='||TO_CHAR(TTID));
      -- 200-2254 busca la causal con la que se esta legalizando la orden desde el sistema legado, en la sarta con que viene del sistema legado
      select substr(reLISTA_ORDENES(i).DATAORDER,instr(reLISTA_ORDENES(i).DATAORDER,'|',1)+1,instr(reLISTA_ORDENES(i).DATAORDER,'|',1,2)-instr(reLISTA_ORDENES(i).DATAORDER,'|',1)-1) INTO SBCAUSAL from dual;

     -- DBMS_OUTPUT.PUT_LINE('CAUSAL A LEGALIZAR ='||SBCAUSAL);
      IF SBCAUSAL IS NOT NULL OR SBCAUSAL<>'' OR SBCAUSAL<>' ' THEN
         nucausal:=to_number(sbcausal);           
      end if;

      /*  NUCaus3612    :=  dald_parameter.fnuGetNumeric_Value('CAUSAL3612',NULL);
      nuTITR12457   :=  dald_parameter.fnuGetNumeric_Value('TIPOTR12457',NULL);  */

          -- 200-2466 busca marca del usuario en la tabla PR_PROD_SUSPENSION
    begin
        /* select suspension_type_id 
           into mp 
       from pr_prod_suspension 
       where active='Y' and 
             product_id=(select product_id 
                                from or_order_activity 
                    where order_id=reLISTA_ORDENES(i).order_id and rownum<=1) and 
           rownum=1
           order by register_date desc; */

         select nvl(SUSPENSION_TYPE_ID,101)
                into mp
        from ldc_marca_producto
        where id_producto=(select product_id 
                                from or_order_activity 
                    where order_id=reLISTA_ORDENES(i).order_id and rownum<=1) and 
           rownum=1;
      exception 
         when others then
           mp:=101;
      end;
      --DBMS_OUTPUT.PUT_LINE('MARCA='||TO_CHAR(MP));
      if mp<>-1 then -- tiene marca
         -- 200-2466 busca si la combinacion de la causal con tipo de trabajo y marca esta configurada en la tabla LDCCONFCTSUSPA
       begin
          select tipotrabajon , causaln , actividadn
            into ntt,ncc,nuactivity
        from LDCCONFCTSUSPA 
          where tipotrabajoo=ttid and 
                causalo=nucausal and
              marca=mp;
      n:=1;
     exception
         when others then 
        n:=0;
     end;
       if n = 1 then  -- encontro configuracion
           -- DBMS_OUTPUT.PUT_LINE('ENCONTRO CONFIGURACION');
          -- 200-2466 busca nuevo tipo de trabajo, nueva causal y nueva actividad a cambiar segun configuracion

          /* select tipotrabajon , causaln , actividadn
            into ntt,ncc,nuactivity
        from LDCCONFCTSUSPA 
          where tipotrabajoo=ttid and 
                causalo=nucausal and
              marca=mp; */ 

        -- 200-2466 BUSCA EL CODIGO DEL OR_ORDER_ACTIVITY QUE SE ESTA TRATANDO DE LEGALIZAR DESDE EL SISTEMA LEGADO
            select substr(reLISTA_ORDENES(i).DATAORDER,instr(reLISTA_ORDENES(i).DATAORDER,'|',1,4)+1,instr(reLISTA_ORDENES(i).DATAORDER,'>',1)-instr(reLISTA_ORDENES(i).DATAORDER,'|',1,4)-1) INTO SBactivity from dual;
            if sbactivity is not null or sbactivity <>'' or sbactivity <> ' ' then
               nuactivityoa:=to_number(sbactivity);
            end if;   
            UT_XmlUtilities.Freexml;
        isbTaskTypeChg:='<ORDER><ORDER_ID>'||TO_CHAR(reLISTA_ORDENES(i).order_id)||'</ORDER_ID><NEW_TASK_TYPE>'||to_char(ntt)||'</NEW_TASK_TYPE><ACTIVITIES><ACTIVITY><ACTIVITY_ID>'||TO_CHAR(nUActivity)||'</ACTIVITY_ID><RELATED_ACTIVITY_ID>'||nuactivityoa||'</RELATED_ACTIVITY_ID></ACTIVITY></ACTIVITIES></ORDER>';
           -- dbms_output.put_line('va a cambiar tt y activity'||isbTaskTypeChg);
            OS_CHANGE_TASKTYPE (isbTaskTypeChg, onuMessageCode, osbMessageText);
        if onuMessageCode=0 then -- se cambio con exito el tipo de trabajo y la actividad y se procede a cambiar la cadena de legalizacion cambiando la causal y la or_order_activity
              -- DBMS_OUTPUT.PUT_LINE('CAMBIO CON EXITO');
           --614
           --Se corrige la forma de obtener el id
           --select max(order_activity_id) into nuOrderActivitynew from or_order_activity where order_id=reLISTA_ORDENES(i).order_id;
           select order_activity_id into nuOrderActivitynew from ( select order_activity_id, register_date  from or_order_activity where order_id=reLISTA_ORDENES(i).order_id and status != 'F' order by register_date desc) where rownum=1;
               /* Se coloca en comentario en caso 0000250
         select replace(reLISTA_ORDENES(i).DATAORDER,'|'||sbcausal  ||'|','|'||to_char(ncc) ||'|') into sarta from dual; -- se reemplaza la causal 
               SELECT REPLACE(SARTA                       ,'|'||SBACTIVITY||'>','|'||TO_CHAR(NUACTIVITYOA)||'>') INTO SARTA FROM DUAL;*/
         
         
               ---- modificacion caso 250 ----------
         ut_string.EXTSTRING(sarta, sbSeparador , tbCadena); 
         sbCadOrden:=tbCadena(1);
         sbCadCausal:=tbCadena(2);
         sbCadPersona:=tbCadena(3);
         sbCadDatAdi:=tbCadena(4);
         sbCadActiv:=tbCadena(5);
         sbCadItems:=tbCadena(6);
         sbLect:=tbCadena(7);
         sbCadCom:=tbCadena(8);
         IF tbCadena.exists(9) then
            sbCadFechEjec:=tbCadena(9);
         else
            sbCadFechEjec:=null;
         end if;
         
         --
          
           
         open CUGETCLASSCAUSAL(ncc);
         fetch CUGETCLASSCAUSAL into nuClassCausalid;
         close CUGETCLASSCAUSAL;
         
         nuClassCausAnt := open.dage_causal.fnugetclass_causal_id(nucausal, null);
         
         if nuClassCausalid = 1 and nuClassCausAnt = 2 then  -- 1 - exito
            sbCadCausal:=to_char(ncc);
            sbCadActiv:=replace(sbCadActiv,SBACTIVITY,nuOrderActivitynew);
            sbCadActiv:=replace(sbCadActiv,'>0','>1');
         elsif nuClassCausalid = 2 and nuClassCausAnt = 1 then  -- 2 - fallo
            sbCadCausal:=to_char(ncc);--tbCadena(2);
            sbCadActiv:=replace(sbCadActiv,SBACTIVITY,nuOrderActivitynew);
            sbCadActiv:=replace(sbCadActiv,'>1','>0');
         elsif  nuClassCausalid = nuClassCausAnt then
            sbCadCausal:=to_char(ncc);--tbCadena(2);          
         end if;
         
         sarta:= sbCadOrden||'|'||sbCadCausal||'|'||sbCadPersona||'|'||sbCadDatAdi||'|'||sbCadActiv||'|'||sbCadItems||'|'||sbLect||'|'||sbCadCom;
         if sbCadFechEjec is not null then
          sarta:=sarta||'|'||sbCadFechEjec;
         end if;
         --- fin modificacion caso 250 ---------       
               
        else
               DBMS_OUTPUT.PUT_LINE('error   ='||onuMessageCode||'-'||osbMessageText);
               LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                         ISBMESATIPO     => 'E',
                         INUERROR_LOG_ID => onuMessageCode, --onuMessageCode,
                         ISBMESADESC     => osbMessageText, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                         ISBMESAVAL1     => to_char(nuORDEN),
                         ISBMESAVAL2     => null,
                         ISBMESAVAL3     => null,
                         ISBMESAVAL4     => null,
                         IDTMESAFECH     => sysdate,
                         ONUMESACODI     => nuMESACODI,
                         ONUERRORCODE    => onuMessageCode2,
                         OSBERRORMESSAGE => osbMessageText2);
               sbProcesoLegaOk := 'N';
        end if;
        end if;
    end if;

      -- 200-2466 se comenta este desarrollo del 200-2254

      /*
      if (nucausal=NUCAUS3612 or ccid=NUCAUS3612) and ttid=NUTITR12457 then --200-2254 cambia tipo de trabajo, causal y actividad del or_order_activity 200-2254
         NUCausparam   := dald_parameter.fnuGetNumeric_Value('CAUSAL10450',NULL);
         nuactivity   :=  dald_parameter.fnuGetNumeric_Value('ACTIVITY10450',NULL); -- el valor de la actividad debe ir en el valor numerico del parametro
         -- BUSCA EL CODIGO DEL OR_ORDER_ACTIVITY QUE SE ESTA TRATANDO DE LEGALIZAR DESDE EL SISTEMA LEGADO
         select substr(reLISTA_ORDENES(i).DATAORDER,instr(reLISTA_ORDENES(i).DATAORDER,'|',1,4)+1,instr(reLISTA_ORDENES(i).DATAORDER,'>',1)-instr(reLISTA_ORDENES(i).DATAORDER,'|',1,4)-1) INTO SBactivity from dual;
         if sbactivity is not null or sbactivity <>'' or sbactivity <> ' ' then
          nuactivityoa:=to_number(sbactivity);
         end if;   
         UT_XmlUtilities.Freexml;
         isbTaskTypeChg:='<ORDER><ORDER_ID>'||TO_CHAR(reLISTA_ORDENES(i).order_id)||'</ORDER_ID><NEW_TASK_TYPE>'||'10450'||'</NEW_TASK_TYPE><ACTIVITIES><ACTIVITY><ACTIVITY_ID>'||TO_CHAR(nUActivity)||'</ACTIVITY_ID><RELATED_ACTIVITY_ID>'||nuactivityoa||'</RELATED_ACTIVITY_ID></ACTIVITY></ACTIVITIES></ORDER>';
         dbms_output.put_line('va a cambiar tt y activity'||isbTaskTypeChg);
         OS_CHANGE_TASKTYPE (isbTaskTypeChg, onuMessageCode, osbMessageText);
         if onuMessageCode=0 then -- se cambio con exito el tipo de trabajo y la actividad y se procede a cambiar la cadena de legalizacion cambiando la causal
                    -- y la or_order_activity
        select max(order_activity_id) into nuactivityoa from or_order_activity where order_id=reLISTA_ORDENES(i).order_id;
          select replace(reLISTA_ORDENES(i).DATAORDER,'|'||sbcausal  ||'|','|'||to_char(nucausparam) ||'|') into sarta from dual; -- se reemplaza la causal 
         SELECT REPLACE(SARTA                       ,'|'||SBACTIVITY||'>','|'||TO_CHAR(NUACTIVITYOA)||'>') INTO SARTA FROM DUAL;
         else
         -- DBMS_OUTPUT.PUT_LINE('error   ='||onuMessageCode||'-'||osbMessageText);
          LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                         ISBMESATIPO     => 'E',
                         INUERROR_LOG_ID => onuMessageCode, --onuMessageCode,
                         ISBMESADESC     => osbMessageText, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                         ISBMESAVAL1     => to_char(nuORDEN),
                         ISBMESAVAL2     => null,
                         ISBMESAVAL3     => null,
                         ISBMESAVAL4     => null,
                         IDTMESAFECH     => sysdate,
                         ONUMESACODI     => nuMESACODI,
                         ONUERRORCODE    => onuMessageCode,
                         OSBERRORMESSAGE => osbMessageText);
          sbProcesoLegaOk := 'N';
         end if; 
      end if; */
        END IF;

        if onuMessageCode = 0 then

            -- Llama el API de lagalizacion de Ordenes
            --OSF-1311 actializar API
            API_LEGALIZEORDERS(--reLISTA_ORDENES(i).DATAORDER,
                              sarta,
                              to_date(reLISTA_ORDENES(i).INITDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                              to_date(reLISTA_ORDENES(i).FINALDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                              to_date(reLISTA_ORDENES(i).CHANGEDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                              onuMessageCode,
                              osbMessageText);


        end if;

        /*
        * NC:    Validacion de ordenes ya legalizadas
        * Autor: Hector Fabio Dominguez
        * Fecha: 18-12-2013
        */

        /*
        * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden
        */

        IF (onuMessageCode = 2582) THEN

          /*
          * Validamos Si la orden se encuentra legalizada
          */
          IF LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega(nuORDEN,
                                                       sbMensajeValidaOrd) = 1 THEN
            /*
            * Si la orden se encuentra legalizada
            * entonces reasignamos a 0 para que el mensaje
            * sea considerado como exitoso
            */
            onuMessageCode := 0;
            osbMessageText := 'ORDEN LEGALIZADA PREVIAMENTE' ||
                              osbMessageText;
          ELSE
            /*
            * En caso de que no este legalizada, agregamos la traza al mensaje
            * para que se guarde posteriormente
            */
            osbMessageText := osbMessageText || ' ' || sbMensajeValidaOrd;
          END IF;

        END IF;

        nuCodMensajeLega := onuMessageCode;
        sbMensajeLega    := osbMessageText;

        --valida el mensaje de salida de la orden
        if (onuMessageCode = 0) then

          sbMensajeLega := 'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' ||
                           osbMessageText;

          LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                           ISBMESATIPO     => 'I',
                                           INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                           ISBMESADESC     => sbMensajeLega, --'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                           ISBMESAVAL1     => to_char(nuORDEN),
                                           ISBMESAVAL2     => null,
                                           ISBMESAVAL3     => null,
                                           ISBMESAVAL4     => null,
                                           IDTMESAFECH     => sysdate,
                                           ONUMESACODI     => nuMESACODI,
                                           ONUERRORCODE    => onuMessageCode,
                                           OSBERRORMESSAGE => osbMessageText);

          sbEstOrden      := 'L';
          sbEstaOrdenGest := 'G';

          --commit; --#20150212: jesusv: Se quita commit
          sbProcesoLegaOk := 'S'; --#20150212: jesusv: Se confirma que el proceso es OK

        else
          boExcepcion := true;

          sbMensajeLega := 'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' ||
                           osbMessageText;

          LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                           ISBMESATIPO     => 'E',
                                           INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                           ISBMESADESC     => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                           ISBMESAVAL1     => to_char(nuORDEN),
                                           ISBMESAVAL2     => null,
                                           ISBMESAVAL3     => null,
                                           ISBMESAVAL4     => null,
                                           IDTMESAFECH     => sysdate,
                                           ONUMESACODI     => nuMESACODI,
                                           ONUERRORCODE    => onuMessageCode,
                                           OSBERRORMESSAGE => osbMessageText);
          sbEstOrden      := 'G';
          sbEstaOrdenGest := 'F';

          --rollback;  --#20150212: jesusv: Se quita rollback
          sbProcesoLegaOk := 'N'; --#20150212: jesusv: Se confirma que el proceso fue con error

        end if; --      if (onuMessageCode = 0) then

        proActualizaEstado(nuORDEN,
                           nuCodMensajeLega, --onuMessageCode,
                           sbMensajeLega, --osbMessageText,
                           sbEstOrden);
        LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada(inuOrden        => nuORDEN,
                                                        isbEstado       => sbEstaOrdenGest /*'G'*/,
                                                        onuErrorCode    => onuMessageCode,
                                                        osbErrorMessage => osbMessageText);

        --#20150212: jesusv: (INICIO) - Se valida si existe error para cambiar el estado de procesamiento de la orden
        If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
          Commit;
        Else
          Rollback;
        End If; --   If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
      --#20150212: jesusv: (FIN) - Se valida si existe error para cambiar el estado de procesamiento de la orden

      --end loop; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

--DBMS_OUTPUT.PUT_LINE('SALGO LOOP INTERNO');
      end loop;
--DBMS_OUTPUT.PUT_LINE('SALGO LOOP EXTERNO 1');
      --exit when cuORDENES%notfound;
      exit;
--DBMS_OUTPUT.PUT_LINE('SALGO LOOP EXTERNO 2');
    END LOOP;
    close cuORDENES;

    -- finaliza el procesamiento
    LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,
                                  IDTPROCFEFI     => sysdate,
                                  ISBPROCESTA     => 'F',
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (boExcepcion = false) then
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'Proceso ha terminado satisfactoriamente.',
                                    ISBMESATIPO     => 'S',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if; --if (boExcepcion = false) then

  exception
    when excep_ESTAPROC then

      LDCI_pkWebServUtils.Procrearerrorlogint('proLegalizaOrdenes',
                                              1,
                                              osbMessageText,
                                              null,
                                              null);
    when others then

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'SQLCODE: ' ||
                                                       SQLCODE || ' : ' ||
                                                       SQLERRM,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'TRACE: ' ||
                                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      rollback;

  end proLegalizaOrdenesSistema;

  procedure proLegalizaOrdenesRelecturas(isbSistema ldci_ordenesalegalizar.system%type) as
    /* -------------------------------------------------------------------------------------------------------------------------------------------------------
     Propiedad Intelectual Gases del Caribe SA ESP
     Nombre  : LDCI_PKGESTLEGAORDEN.proLegalizaLoteOrdenes
     Autor   : Eduardo Aguera
     Fecha   : 28/12/2017
     Descripcion : Basado en proLegalizaOrdenes. Se crea para independizar la legalizacion de ordenes por sistema.

     Historial de modificaciones
     Autor                    Fecha         Descripcion
     Eduardo Aguera           28/12/2017    Creacion del procedimiento en el dia de los inocentes ;)
     Jorge Valiente           06/07/2023    OSF-1311: Cambio de API OS_LEGALIZEORDERS por el nuevo API API_LEGALIZEORDERS     
    -------------------------------------------------------------------------------------------------------------------------------------------------------**/
    --definicion de variables
    onuMessageCode   NUMBER;
    osbMessageText   VARCHAR2(2000);
    boExcepcion      BOOLEAN;
    nuCodMensajeLega Number;
    sbMensajeLega    Varchar2(2000);

    sbCASECODI LDCI_CARASEWE.CASEDESE%type := 'WS_ENVIO_ORDENES';

    -- variables para el manejo del proceso LDCI_ESTAPROC
    sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;
    cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;
    dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;
    sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;
    nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;
    nuORDEN    LDCI_ORDENESALEGALIZAR.order_id%type;
    sbEstOrden LDCI_ORDENESALEGALIZAR.state%type;
    -- variables para la creacion de los mensajes LDCI_MESAENVWS
    nuMESACODI LDCI_MESAENVWS.MESACODI%type;

    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    /* Cursor cuORDENES is
    select a.order_id, a.system, a.dataorder, a.initdate, a.finaldate, a.changedate, a.messagecode, a.messagetext, a.state, a.fecha_recepcion, a.fecha_procesado, a.fecha_notificado, a.veces_procesado
    from LDCI_ORDENESALEGALIZAR a, or_order_activity ac, servsusc
    where a.state = 'P'
    and a.System = 'WS_SIGELEC'
    and a.fecha_recepcion <= trunc(sysdate)+1
    and ac.order_id = a.order_id
    and ac.product_id = sesunuse
    and sesucicl = 4616
    and rownum <= 500;*/

    Cursor cuORDENES is
      select t.order_id,
             system,
             dataorder,
             initdate,
             finaldate,
             changedate,
             messagecode,
             messagetext,
             state,
             fecha_recepcion,
             fecha_procesado,
             fecha_notificado,
             veces_procesado
        from LDCI_ORDENESALEGALIZAR t, OR_ORDER x
       where state = 'P'
         and x.order_id = t.order_id
         and x.task_type_id = 10043
         and System = isbSistema
       order by fecha_recepcion asc;

    -- definicion de variables tipo registro
    reIC_DOCUGENE IC_DOCUGENE%rowtype;

    -- excepciones
    excep_PROCARASERVWEB exception;
    excep_ESTAPROC       exception;

    sbMensajeValidaOrd VARCHAR2(1000);

    sbEstaOrdenGest Ldci_Ordenmoviles.Estado_Envio%Type;
    sbProcesoLegaOk Varchar2(1); --#20150212: jesusv: Se crea flag de validacion de proceso de legalizacion ya que el codigo de error no se puede usar porque lo resetean a 0 dentro de algunos procesos

    --- registro para guardar los datos
    type tyrcDataRecord is record(
      Order_Id         LDCI_ORDENESALEGALIZAR.Order_Id%type,
      system           LDCI_ORDENESALEGALIZAR.system%type,
      dataorder        LDCI_ORDENESALEGALIZAR.dataorder%type,
      initdate         LDCI_ORDENESALEGALIZAR.initdate%type,
      finaldate        LDCI_ORDENESALEGALIZAR.finaldate%type,
      changedate       LDCI_ORDENESALEGALIZAR.changedate%type,
      messagecode      LDCI_ORDENESALEGALIZAR.messagecode%type,
      messagetext      LDCI_ORDENESALEGALIZAR.messagetext%type,
      state            LDCI_ORDENESALEGALIZAR.state%type,
      fecha_recepcion  LDCI_ORDENESALEGALIZAR.fecha_recepcion%type,
      fecha_procesado  LDCI_ORDENESALEGALIZAR.fecha_procesado%type,
      fecha_notificado LDCI_ORDENESALEGALIZAR.fecha_notificado%type,
      veces_procesado  LDCI_ORDENESALEGALIZAR.veces_procesado%type);

    nuCommit number(5);
    type tytbDataTable is table of tyrcDataRecord index by binary_integer;
    reLISTA_ORDENES tytbDataTable;

  begin
    --parametro para obtener el codigo del servicio de gas
    -- inicializa el mensaje de salida
    onuMessageCode := 0;
    osbMessageText := null;
    boExcepcion    := false;

    -- realiza la creacion del proceso
    cbPROCPARA := ' <PARAMETROS>
                                <PARAMETRO>
                                    <NOMBRE>iclXMLOrdenes</NOMBRE>
                                    <VALOR>iclXMLOrdenes</VALOR>
                                </PARAMETRO>
                              </PARAMETROS>';

    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,
                                  ICBPROCPARA     => cbProcPara,
                                  IDTPROCFEIN     => SYSDATE,
                                  ISBPROCESTA     => 'P',
                                  ISBPROCUSUA     => null,
                                  ISBPROCTERM     => null,
                                  ISBPROCPROG     => null,
                                  ONUPROCCODI     => nuPROCCODI,
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (onuMessageCode <> 0) then
      RAISE excep_ESTAPROC;
    end if; --if (onuMessageCode <> 0) then

    -- Recorre el listado de ordenes a legalizar
    --for reLISTA_ORDENES in cuORDENES loop

    OPEN cuORDENES;
    LOOP
      FETCH cuORDENES BULK COLLECT
        INTO reLISTA_ORDENES LIMIT 2000;

      FOR i in 1 .. reLISTA_ORDENES.count loop

        onuMessageCode  := 0;
        osbMessageText  := null;
        sbProcesoLegaOk := Null;

        nuCodMensajeLega := 0;
        sbMensajeLega    := Null;

        nuORDEN := reLISTA_ORDENES(i).ORDER_ID;
        --DBMS_OUTPUT.PUT_LINE('ISBDATAORDER  = ' || reLISTA_ORDENES.ISBDATAORDER);
        --DBMS_OUTPUT.PUT_LINE('IDTINITDATE   = ' || reLISTA_ORDENES.IDTINITDATE);
        --DBMS_OUTPUT.PUT_LINE('IDTFINALDATE  = ' || reLISTA_ORDENES.IDTFINALDATE);
        --DBMS_OUTPUT.PUT_LINE('IDTCHANGEDATE = ' || reLISTA_ORDENES.IDTCHANGEDATE);

        -- Llama el API de lagalizacion de Ordenes
        API_LEGALIZEORDERS(reLISTA_ORDENES(i).DATAORDER,
                          to_date(reLISTA_ORDENES(i).INITDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                          to_date(reLISTA_ORDENES(i).FINALDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                          to_date(reLISTA_ORDENES(i).CHANGEDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                          onuMessageCode,
                          osbMessageText);

        /*
        * NC:    Validacion de ordenes ya legalizadas
        * Autor: Hector Fabio Dominguez
        * Fecha: 18-12-2013
        */

        /*
        * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden
        */

        IF (onuMessageCode = 2582) THEN

          /*
          * Validamos Si la orden se encuentra legalizada
          */
          IF LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega(nuORDEN,
                                                       sbMensajeValidaOrd) = 1 THEN
            /*
            * Si la orden se encuentra legalizada
            * entonces reasignamos a 0 para que el mensaje
            * sea considerado como exitoso
            */
            onuMessageCode := 0;
            osbMessageText := 'ORDEN LEGALIZADA PREVIAMENTE' ||
                              osbMessageText;
          ELSE
            /*
            * En caso de que no este legalizada, agregamos la traza al mensaje
            * para que se guarde posteriormente
            */
            osbMessageText := osbMessageText || ' ' || sbMensajeValidaOrd;
          END IF;

        END IF;

        nuCodMensajeLega := onuMessageCode;
        sbMensajeLega    := osbMessageText;

        --valida el mensaje de salida de la orden
        if (onuMessageCode = 0) then

          sbMensajeLega := 'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' ||
                           osbMessageText;

          LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                           ISBMESATIPO     => 'I',
                                           INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                           ISBMESADESC     => sbMensajeLega, --'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                           ISBMESAVAL1     => to_char(nuORDEN),
                                           ISBMESAVAL2     => null,
                                           ISBMESAVAL3     => null,
                                           ISBMESAVAL4     => null,
                                           IDTMESAFECH     => sysdate,
                                           ONUMESACODI     => nuMESACODI,
                                           ONUERRORCODE    => onuMessageCode,
                                           OSBERRORMESSAGE => osbMessageText);

          sbEstOrden      := 'L';
          sbEstaOrdenGest := 'G';

          --commit; --#20150212: jesusv: Se quita commit
          sbProcesoLegaOk := 'S'; --#20150212: jesusv: Se confirma que el proceso es OK

        else
          boExcepcion := true;

          sbMensajeLega := 'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' ||
                           osbMessageText;

          LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                           ISBMESATIPO     => 'E',
                                           INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                           ISBMESADESC     => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                           ISBMESAVAL1     => to_char(nuORDEN),
                                           ISBMESAVAL2     => null,
                                           ISBMESAVAL3     => null,
                                           ISBMESAVAL4     => null,
                                           IDTMESAFECH     => sysdate,
                                           ONUMESACODI     => nuMESACODI,
                                           ONUERRORCODE    => onuMessageCode,
                                           OSBERRORMESSAGE => osbMessageText);
          sbEstOrden      := 'G';
          sbEstaOrdenGest := 'F';

          --rollback;  --#20150212: jesusv: Se quita rollback
          sbProcesoLegaOk := 'N'; --#20150212: jesusv: Se confirma que el proceso fue con error

        end if; --      if (onuMessageCode = 0) then

        proActualizaEstado(nuORDEN,
                           nuCodMensajeLega, --onuMessageCode,
                           sbMensajeLega, --osbMessageText,
                           sbEstOrden);
        LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada(inuOrden        => nuORDEN,
                                                        isbEstado       => sbEstaOrdenGest /*'G'*/,
                                                        onuErrorCode    => onuMessageCode,
                                                        osbErrorMessage => osbMessageText);

        --#20150212: jesusv: (INICIO) - Se valida si existe error para cambiar el estado de procesamiento de la orden
        If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
          Commit;
        Else
          Rollback;
        End If; --   If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
      --#20150212: jesusv: (FIN) - Se valida si existe error para cambiar el estado de procesamiento de la orden

      --end loop; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

      end loop;

      --exit when cuORDENES%notfound;
      exit;

    END LOOP;
    close cuORDENES;

    -- finaliza el procesamiento
    LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,
                                  IDTPROCFEFI     => sysdate,
                                  ISBPROCESTA     => 'F',
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (boExcepcion = false) then
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'Proceso ha terminado satisfactoriamente.',
                                    ISBMESATIPO     => 'S',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if; --if (boExcepcion = false) then

  exception
    when excep_ESTAPROC then
      LDCI_pkWebServUtils.Procrearerrorlogint('proLegalizaOrdenes',
                                              1,
                                              osbMessageText,
                                              null,
                                              null);
    when others then
      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'SQLCODE: ' ||
                                                       SQLCODE || ' : ' ||
                                                       SQLERRM,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'TRACE: ' ||
                                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      rollback;

  end proLegalizaOrdenesRelecturas;

  procedure proLegalizaOrdenesSistemaCiclo(isbSistema ldci_ordenesalegalizar.system%type,
                                           isbCicl    number) as
    /* -------------------------------------------------------------------------------------------------------------------------------------------------------
     Propiedad Intelectual Gases del Caribe SA ESP
     Nombre  : LDCI_PKGESTLEGAORDEN.proLegalizaLoteOrdenes
     Autor   : Eduardo Aguera
     Fecha   : 28/12/2017
     Descripcion : Basado en proLegalizaOrdenes. Se crea para independizar la legalizacion de ordenes por sistema.

     Historial de modificaciones
     Autor                    Fecha         Descripcion
     Eduardo Aguera           28/12/2017    Creacion del procedimiento en el dia de los inocentes ;)
     Jorge Valiente           06/07/2023    OSF-1311: Cambio de API OS_LEGALIZEORDERS por el nuevo API API_LEGALIZEORDERS     
    -------------------------------------------------------------------------------------------------------------------------------------------------------**/
    --definicion de variables
    onuMessageCode   NUMBER;
    osbMessageText   VARCHAR2(2000);
    boExcepcion      BOOLEAN;
    nuCodMensajeLega Number;
    sbMensajeLega    Varchar2(2000);

    sbCASECODI LDCI_CARASEWE.CASEDESE%type := 'WS_ENVIO_ORDENES';

    -- variables para el manejo del proceso LDCI_ESTAPROC
    sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;
    cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;
    dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;
    sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;
    nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;
    nuORDEN    LDCI_ORDENESALEGALIZAR.order_id%type;
    sbEstOrden LDCI_ORDENESALEGALIZAR.state%type;
    -- variables para la creacion de los mensajes LDCI_MESAENVWS
    nuMESACODI LDCI_MESAENVWS.MESACODI%type;

    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    Cursor cuORDENES is
      select a.order_id,
             a.system,
             a.dataorder,
             a.initdate,
             a.finaldate,
             a.changedate,
             a.messagecode,
             a.messagetext,
             a.state,
             a.fecha_recepcion,
             a.fecha_procesado,
             a.fecha_notificado,
             a.veces_procesado
        from LDCI_ORDENESALEGALIZAR a, or_order_activity ac, servsusc
       where a.state = 'P'
         and a.System = 'WS_SIGELEC'
         and ac.order_id = a.order_id
         and ac.product_id = sesunuse
         and sesucicl = isbCicl
         and rownum <= 500;

    -- definicion de variables tipo registro
    reIC_DOCUGENE IC_DOCUGENE%rowtype;

    -- excepciones
    excep_PROCARASERVWEB exception;
    excep_ESTAPROC       exception;

    sbMensajeValidaOrd VARCHAR2(1000);

    sbEstaOrdenGest Ldci_Ordenmoviles.Estado_Envio%Type;
    sbProcesoLegaOk Varchar2(1); --#20150212: jesusv: Se crea flag de validacion de proceso de legalizacion ya que el codigo de error no se puede usar porque lo resetean a 0 dentro de algunos procesos

  begin
    -- inicializa el mensaje de salida
    onuMessageCode := 0;
    osbMessageText := null;
    boExcepcion    := false;

    -- realiza la creacion del proceso
    cbPROCPARA := ' <PARAMETROS>
                                <PARAMETRO>
                                    <NOMBRE>iclXMLOrdenes</NOMBRE>
                                    <VALOR>iclXMLOrdenes</VALOR>
                                </PARAMETRO>
                              </PARAMETROS>';

    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,
                                  ICBPROCPARA     => cbProcPara,
                                  IDTPROCFEIN     => SYSDATE,
                                  ISBPROCESTA     => 'P',
                                  ISBPROCUSUA     => null,
                                  ISBPROCTERM     => null,
                                  ISBPROCPROG     => null,
                                  ONUPROCCODI     => nuPROCCODI,
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (onuMessageCode <> 0) then
      RAISE excep_ESTAPROC;
    end if; --if (onuMessageCode <> 0) then

    -- Recorre el listado de ordenes a legalizar
    for reLISTA_ORDENES in cuORDENES loop
      onuMessageCode  := 0;
      osbMessageText  := null;
      sbProcesoLegaOk := Null;

      nuCodMensajeLega := 0;
      sbMensajeLega    := Null;

      nuORDEN := reLISTA_ORDENES.ORDER_ID;
      --DBMS_OUTPUT.PUT_LINE('ISBDATAORDER  = ' || reLISTA_ORDENES.ISBDATAORDER);
      --DBMS_OUTPUT.PUT_LINE('IDTINITDATE   = ' || reLISTA_ORDENES.IDTINITDATE);
      --DBMS_OUTPUT.PUT_LINE('IDTFINALDATE  = ' || reLISTA_ORDENES.IDTFINALDATE);
      --DBMS_OUTPUT.PUT_LINE('IDTCHANGEDATE = ' || reLISTA_ORDENES.IDTCHANGEDATE);

      -- Llama el API de lagalizacion de Ordenes
      API_LEGALIZEORDERS(reLISTA_ORDENES.DATAORDER,
                        to_date(reLISTA_ORDENES.INITDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        to_date(reLISTA_ORDENES.FINALDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        to_date(reLISTA_ORDENES.CHANGEDATE /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                        onuMessageCode,
                        osbMessageText);

      /*
      * NC:    Validacion de ordenes ya legalizadas
      * Autor: Hector Fabio Dominguez
      * Fecha: 18-12-2013
      */

      /*
      * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden
      */

      IF (onuMessageCode = 2582) THEN

        /*
        * Validamos Si la orden se encuentra legalizada
        */
        IF LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega(nuORDEN,
                                                     sbMensajeValidaOrd) = 1 THEN
          /*
          * Si la orden se encuentra legalizada
          * entonces reasignamos a 0 para que el mensaje
          * sea considerado como exitoso
          */
          onuMessageCode := 0;
          osbMessageText := 'ORDEN LEGALIZADA PREVIAMENTE' ||
                            osbMessageText;
        ELSE
          /*
          * En caso de que no este legalizada, agregamos la traza al mensaje
          * para que se guarde posteriormente
          */
          osbMessageText := osbMessageText || ' ' || sbMensajeValidaOrd;
        END IF;

      END IF;

      nuCodMensajeLega := onuMessageCode;
      sbMensajeLega    := osbMessageText;

      --valida el mensaje de salida de la orden
      if (onuMessageCode = 0) then

        sbMensajeLega := 'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' ||
                         osbMessageText;

        LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                         ISBMESATIPO     => 'I',
                                         INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                         ISBMESADESC     => sbMensajeLega, --'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                         ISBMESAVAL1     => to_char(nuORDEN),
                                         ISBMESAVAL2     => null,
                                         ISBMESAVAL3     => null,
                                         ISBMESAVAL4     => null,
                                         IDTMESAFECH     => sysdate,
                                         ONUMESACODI     => nuMESACODI,
                                         ONUERRORCODE    => onuMessageCode,
                                         OSBERRORMESSAGE => osbMessageText);

        sbEstOrden      := 'L';
        sbEstaOrdenGest := 'G';

        --commit; --#20150212: jesusv: Se quita commit
        sbProcesoLegaOk := 'S'; --#20150212: jesusv: Se confirma que el proceso es OK

      else
        boExcepcion := true;

        sbMensajeLega := 'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' ||
                         osbMessageText;

        LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC     => nuPROCCODI,
                                         ISBMESATIPO     => 'E',
                                         INUERROR_LOG_ID => nuCodMensajeLega, --onuMessageCode,
                                         ISBMESADESC     => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                                         ISBMESAVAL1     => to_char(nuORDEN),
                                         ISBMESAVAL2     => null,
                                         ISBMESAVAL3     => null,
                                         ISBMESAVAL4     => null,
                                         IDTMESAFECH     => sysdate,
                                         ONUMESACODI     => nuMESACODI,
                                         ONUERRORCODE    => onuMessageCode,
                                         OSBERRORMESSAGE => osbMessageText);
        sbEstOrden      := 'G';
        sbEstaOrdenGest := 'F';

        --rollback;  --#20150212: jesusv: Se quita rollback
        sbProcesoLegaOk := 'N'; --#20150212: jesusv: Se confirma que el proceso fue con error

      end if; --      if (onuMessageCode = 0) then

      proActualizaEstado(nuORDEN,
                         nuCodMensajeLega, --onuMessageCode,
                         sbMensajeLega, --osbMessageText,
                         sbEstOrden);
      LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada(inuOrden        => nuORDEN,
                                                      isbEstado       => sbEstaOrdenGest /*'G'*/,
                                                      onuErrorCode    => onuMessageCode,
                                                      osbErrorMessage => osbMessageText);

      --#20150212: jesusv: (INICIO) - Se valida si existe error para cambiar el estado de procesamiento de la orden
      If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
        Commit;
      Else
        Rollback;
      End If; --   If Nvl(sbProcesoLegaOk, 'N') = 'S' Then
    --#20150212: jesusv: (FIN) - Se valida si existe error para cambiar el estado de procesamiento de la orden

    end loop; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

    -- finaliza el procesamiento
    LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,
                                  IDTPROCFEFI     => sysdate,
                                  ISBPROCESTA     => 'F',
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (boExcepcion = false) then
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'Proceso ha terminado satisfactoriamente.',
                                    ISBMESATIPO     => 'S',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if; --if (boExcepcion = false) then

  exception
    when excep_ESTAPROC then
      LDCI_pkWebServUtils.Procrearerrorlogint('proLegalizaOrdenes',
                                              1,
                                              osbMessageText,
                                              null,
                                              null);
    when others then
      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'SQLCODE: ' ||
                                                       SQLCODE || ' : ' ||
                                                       SQLERRM,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'TRACE: ' ||
                                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      rollback;

  end proLegalizaOrdenesSistemaCiclo;

  procedure proInsLoteOrdenesALegalizar(iclXMLOrdenes in CLOB) as
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKGESTLEGAORDEN.proInsLoteOrdenesALegalizar
     * Tiquete : I058 Provision de consumo
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 24/06/2013
     * Descripcion : Registra la informacion de la provision de consumo en la tabla IC_MOVIMIEN
     *
     * Parametros:
      * IN: iclXMLOrdenes: Codigo del elemento de medicion
                    <!-- mensaje para el paquete de integracion -->
                    <!-- nuevo dise?o -->
                    <?xml version="1.0" encoding="UTF-8" ?>
                    <ORDER_LIST>
                    <ORDER>
                         <ORDER_ID>4499528</ORDER_ID>
                         <SYSTEM>SISURE</SYSTEM>
                          <ISBDATAORDER> ;</ISBDATAORDER>
                          <IDTINITDATE>2013-11-21 16:57:00</IDTINITDATE>
                          <IDTFINALDATE>2013-11-21 16:57:00</IDTFINALDATE>
                          <IDTCHANGEDATE>2013-11-21 16:57:00</IDTCHANGEDATE>
                    </ORDER>
                    <ORDER>
                          <ORDER_ID>4499528</ORDER_ID>
                          <SYSTEM>SIMOCAR</SYSTEM>
                            <ISBDATAORDER>4499528|9688|2929||3607397>1;READING>123>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;</ISBDATAORDER>
                            <IDTINITDATE>2013-11-21 16:57:00</IDTINITDATE>
                          <IDTFINALDATE>2013-11-21 16:57:00</IDTFINALDATE>
                          <IDTCHANGEDATE>2013-11-21 16:57:00</IDTCHANGEDATE>
                    </ORDER>
                    </ORDER_LIST>
     * OUT: orfMensProc: Codigo del mensaje de respuesta
      *
      *
     * Autor                     Fecha         Descripcion
     * carlosvl                  09-04-2013    Creacion del procedimiento
     * JESUS VIVERO (LUDYCOM)    19-01-2015    #20150119: jesusv: Se agrega procesos de registro de logs y inicializacion de cursor de xistencia de orden
     * AAcuna                    10-04-2017    Ca 200-1200: Se modifica dependiendo el sistema si cambia la fecha de cambio de estado o no
    **/
    -- definicion de variables
    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    cursor cuLISTA_ORDENES(clXML in CLOB) is
      SELECT ORDENES.*
        FROM XMLTable('ORDER_LIST/ORDER' PASSING XMLType(clXML) COLUMNS
                      "ORDER_ID" NUMBER PATH 'ORDER_ID',
                      "SYSTEM" VARCHAR2(30) PATH 'SYSTEM',
                      "ISBDATAORDER" VARCHAR2(4000) PATH 'ISBDATAORDER',
                      "IDTINITDATE" VARCHAR2(21) PATH 'IDTINITDATE',
                      "IDTFINALDATE" VARCHAR2(21) PATH 'IDTFINALDATE',
                      "IDTCHANGEDATE" VARCHAR2(21) PATH 'IDTCHANGEDATE') AS ORDENES;

    -- Cursor para verificar si la orden ya existe en la tabla de legalizaciones
    Cursor cuExisteOrden(inuOrdenId In Number) Is
      Select Order_Id, System, State
        From Ldci_OrdenesALegalizar
       Where Order_Id = inuOrdenId;

    -- Variables
    rgExisteOrden cuExisteOrden%RowType;

    --#20150119: jesusv: Se crea variable para registrar logs
    sbComentarios Ldci_Logs_Integraciones.Comentarios%Type;
    nuSecuencia   Number;
    nuRegistros   Number;
    exExcep Exception;

    --caso 200-1200
    csbEntrega2001200 CONSTANT VARCHAR2(100) := 'OSS_CON_AAC_2001200_2';
    dtChangeDate    date;
    sbMensajeValSys VARCHAR2(3200);

  begin

    --#20150119: jesusv: (Inicio) Se agrega para registro de logs
    sbComentarios := Null;
    nuRegistros   := 0;

    proCreaLogIntegra(iclXMLOrdenes,
                      sbComentarios,
                      nuRegistros,
                      nuSecuencia);
    --#20150119: jesusv: (Fin) Se agrega para registro de logs

    -- Recorre el listado de ordenes a legalziar
    For reLISTA_ORDENES In cuLISTA_ORDENES(iclXMLOrdenes) Loop

      nuRegistros := Nvl(nuRegistros, 0) + 1;

      -- Ingresa Ordenes a Legalizar
      rgExisteOrden := Null; --#20150119: jesusv: Se resetea registros para evitar error en registro de ordenes a legalizar si ya se habia detectado una existente

      Open cuExisteOrden(reLista_Ordenes.Order_Id);
      Fetch cuExisteOrden
        Into rgExisteOrden;
      Close cuExisteOrden;

      --Caso 200-1200
      if (fblaplicaentrega(csbEntrega2001200)) then

        dtChangeDate := fdtValidaSystem(reLista_Ordenes.System,
                                        reLista_Ordenes.idtChangeDate,
                                        sbMensajeValSys);
      else

        dtChangeDate := reLista_Ordenes.idtChangeDate;

      end if;
      --Fin caso 200-1200

      If rgExisteOrden.Order_Id Is Null Then

        Begin
          --#20150119: jesusv: Se agrega control de error
          Insert Into Ldci_OrdenesALegalizar
            (Order_Id,
             System,
             DataOrder,
             InitDate,
             FinalDate,
             ChangeDate,
             MessageCode,
             MessageText,
             State,
             Fecha_Recepcion --#20150119: jesusv: Se agrega campo de fecha de recepcion
             )
          values
            (reLista_Ordenes.Order_Id,
             reLista_Ordenes.System,
             reLista_Ordenes.isbDataOrder,
             To_Date(reLista_Ordenes.idtInitDate /*, 'YYYY-MM-DD HH24:MI:SS'*/),
             To_Date(reLista_Ordenes.idtFinalDate /*, 'YYYY-MM-DD HH24:MI:SS'*/),
             To_Date(dtChangeDate /*-200-1200 To_Date(reLista_Ordenes.idtChangeDate, 'YYYY-MM-DD HH24:MI:SS'*/),
             Null,
             Null,
             'P',
             Sysdate --#20150119: jesusv: Se agrega campo de fecha de recepcion
             );
        Exception
          When Others Then
            sbComentarios := SubStr(sbComentarios || ' >> ' || SqlErrM,
                                    1,
                                    4000);
            Raise exExcep;
        End; --#20150119: jesusv: Se agrega control de error

      Else
        --If rgExisteOrden.Order_Id Is Null Then

        If rgExisteOrden.State In ('G', 'EN') Then

          Begin
            --#20150119: jesusv: Se agrega control de error
            Update Ldci_OrdenesALegalizar
               Set System          = reLista_Ordenes.System,
                   DataOrder       = reLista_Ordenes.isbDataOrder,
                   InitDate        = To_Date(reLista_Ordenes.idtInitDate /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                   FinalDate       = To_Date(reLista_Ordenes.idtFinalDate /*, 'YYYY-MM-DD HH24:MI:SS'*/),
                   ChangeDate      = To_Date(dtChangeDate /*-200-1200, 'YYYY-MM-DD HH24:MI:SS'*/),
                   MessageCode     = Null,
                   MessageText     = Null,
                   State           = 'P',
                   Fecha_Recepcion = Sysdate --#20150119: jesusv: Se agrega campo de fecha de recepcion
             Where Order_Id = reLista_Ordenes.Order_Id;
          Exception
            When Others Then
              sbComentarios := SubStr(sbComentarios || ' >> ' || SqlErrM,
                                      1,
                                      4000);
              Raise exExcep;
          End; --#20150119: jesusv: Se agrega control de error

        End If; --If rgExisteOrden.State In ('G','EN') Then

      End If; --If rgExisteOrden.Order_Id Is Null Then

    End Loop; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

    proActuLogIntegra(nuSecuencia, Nvl(sbComentarios, 'OK'), nuRegistros); --#20150119: jesusv: Se agrega registro de logs

    Commit;

  exception
    When exExcep Then
      --#20150119: jesusv: Se agrega control de error para registro de logs
      proActuLogIntegra(nuSecuencia, sbComentarios, nuRegistros);
      Raise_Application_Error(-20100,
                              '[LDCI_PKGESTLEGAORDEN.proInsLoteOrdenesALegalizar]: ' ||
                              sbComentarios);
    when others then
      proActuLogIntegra(nuSecuencia, SqlErrM, nuRegistros); --#20150119: jesusv: Se agrega registro de logs
      RAISE_APPLICATION_ERROR(-20100,
                              '[LDCI_PKGESTLEGAORDEN.proInsLoteOrdenesALegalizar.others]:' ||
                              chr(13) || ' SQLCODE ' || SQLCODE ||
                              ' | SQLERRM ' || SQLERRM);
      rollback;

  end proInsLoteOrdenesALegalizar;

  procedure proActualizaEstado(inuOrden       in ldci_ordenesalegalizar.order_id%type,
                               inuMessageCode in ldci_ordenesalegalizar.messagecode%type,
                               isbMessageText in ldci_ordenesalegalizar.messagetext%type,
                               isbstate       in ldci_ordenesalegalizar.state%type) is

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_PKGESTLEGAORDEN.fnuValidaOrdLega
       AUTOR      : F.Castro
       FECHA      : 15-05-2014
       RICEF      : I015
       DESCRIPCION: Funcion para validar si una orden esta legalizada
                    retorna -1 si termino con error y osbmensaje con la descripcion
                    retorna 0 si no esta legalizada osbmensaje OK
                    retorna 1 si esta legazliada y osbmensaje OK
       NC:          Validacion si una orden es legalizada

      Historia de Modificaciones
      Autor                    Fecha         Descripcion
      JESUS VIVERO (LUDYCOM)   19-01-2015    #20150119: jesusv: Se agregan campos de control de fechas y procesamiento

      JESUS VIVERO (LUDYCOM)   12-02-2015    #20150212: jesusv: Se hace local el commit en la transaccion

    */

    /*
    * Valirable de control
    * 0= no legalizada 1= legalizada
    */

    PRAGMA AUTONOMOUS_TRANSACTION; --#20150212: jesusv: Se hace local el commit en la transaccion

  BEGIN
    update LDCI_ORDENESALEGALIZAR
       set MESSAGECODE      = nvl(inuMessageCode, MESSAGECODE),
           MESSAGETEXT      = nvl(isbMessageText, MESSAGETEXT),
           state            = isbstate,
           Fecha_Procesado  = Decode(isbstate,
                                     'L',
                                     Sysdate,
                                     'G',
                                     Sysdate,
                                     Fecha_Procesado), --#20150119: jesusv: Se agrega campo de fecha de procesado
           Fecha_Notificado = Decode(isbstate,
                                     'N',
                                     Sysdate,
                                     'EN',
                                     Sysdate,
                                     Fecha_Notificado), --#20150119: jesusv: Se agrega campo de fecha de notificado
           Veces_Procesado  = Decode(isbstate,
                                     'L',
                                     Nvl(Veces_Procesado, 0) + 1,
                                     'G',
                                     Nvl(Veces_Procesado, 0) + 1,
                                     Nvl(Veces_Procesado, 0)) --#20150119: jesusv: Se agrega campo de veces de procesado
     where order_id = inuOrden;
    commit;

  EXCEPTION
    WHEN OTHERS THEN
      -- osbMensaje:='Error actualizando estado de la orden '||DBMS_UTILITY.format_error_backtrace;
      null;
  END proActualizaEstado;

  procedure proNotificaOrdenesLegalizadas as
    /*
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
      PROCEDIMIENTO : LDCI_PKGESTLEGAORDEN.proNotificaOrdenesLegalizadas
      AUTOR      : OLSoftware / Carlos E. Virgen <carlos.virgen@olsoftware.com>
      FECHA      : 19/05/2015
      RICEF      : I001
      DESCRIPCION: Notifica las ordenes legaladas.

     Historia de Modificaciones
     Autor                    Fecha        Descripcion
     JESUS VIVERO (LUDYCOM)   30-01-2015   #20150130: jesusv: Se corrige cursor de ordenes notificadas en XML para asegurar actualizar el estado de las que pasaron por XML a PI
    */

    -- define variables
    nuTransac       NUMBER;
    nuMesacodi      LDCI_MESAENVWS.MESACODI%TYPE;
    onuErrorCode    NUMBER := 0;
    osbErrorMessage VARCHAR2(4000);
    sbSTATE         LDCI_ORDENESALEGALIZAR.STATE%type := 'L';
    sbSistNoti      LDCI_CARASEWE.CASEDESE%type;

    --Variables mensajes SOAP
    L_Payload  CLOB;
    l_response CLOB;
    qryCtx     DBMS_XMLGEN.ctxHandle;

    -- cursor de la configuracion de los sistemas por tipo de trabajo
    cursor cuLDCI_PKGESTLEGAORDEN is
      select distinct SISTEMA_ID from LDCI_SISTMOVILTIPOTRAB;

    /* #20150130: jesusv: Se quita cursor anterior de consulta para cambiarlo por lectura directa del XML con las ordenes reales notificadas
    -- cursores de las ordenes a legalizar
    cursor cuLDCI_ORDENESALEGALIZAR(isbSTATE      VARCHAR2,
                                    isbSISTEMA_ID VARCHAR2) is
      select MESSAGECODE CODIGO, ORDER_ID ORDEN, MESSAGETEXT MENSAJE, STATE ESTADO
        from LDCI_ORDENESALEGALIZAR
       where STATE in ('L', 'G')
         and SYSTEM = isbSISTEMA_ID;*/

    Cursor cuLdci_OrdenesALegalizar(isbXMLDat In Clob) Is --#20150130: jesusv: cursor de lectura directa del XML con las ordenes reales notificadas
      Select Datos.Orden
        From XMLTable('/RAIZ/orden' Passing XMLType(isbXMLDat) Columns
                      Orden Number Path 'numOrden') As Datos;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi Exception; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

    sbEstTipoNotif Ldci_OrdenesALegalizar.State%Type; -- Define el estado en tipo de notificacion (N=Notificada, EN= Error Notificado)

    sbEstadoOrden Ldci_Ordenesalegalizar.State%Type; --#20150130: jesusv: Se crea variable para estado de legalizacion

  begin

    --Recorre la configuracion
    for reLDCI_PKGESTLEGAORDEN in cuLDCI_PKGESTLEGAORDEN loop

      sbSistNoti := reLDCI_PKGESTLEGAORDEN.SISTEMA_ID || '_RESLEG';

      proCargaVarGlobal(sbSistNoti);
      if (LDCI_PKGESTLEGAORDEN.sbUrlWS is not null) then

        -- Genera el mensaje XML
        Qryctx := DBMS_XMLGEN.Newcontext('select SYSTEM      as "sistema",
                                                 ORDER_ID    as "numOrden",
                                                 MESSAGECODE as "codError",
                                                 MESSAGETEXT as "msjError"
                                          from LDCI_ORDENESALEGALIZAR
                                          where STATE in (''L'',''G'')
                                          and SYSTEM = :isbSISTEMA_ID');

        DBMS_XMLGEN.setNullHandling(qryCtx, 2);
        DBMS_XMLGEN.setRowSetTag(Qryctx,
                                 LDCI_PKGESTLEGAORDEN.sbInputMsgType);
        DBMS_XMLGEN.setRowTag(qryCtx, 'orden');
        --DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSTATE', sbSTATE);
        DBMS_XMLGEN.setBindvalue(qryCtx,
                                 'isbSISTEMA_ID',
                                 reLDCI_PKGESTLEGAORDEN.SISTEMA_ID);

        l_payload := dbms_xmlgen.getXML(qryCtx);

        --Valida si proceso registrosa
        If (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) Then

          dbms_xmlgen.closeContext(qryCtx);
          /*RAISE excepNoProcesoRegi;
          end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then*/

        Else

          dbms_xmlgen.closeContext(qryCtx);
          L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
          LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                         sbSistNoti,
                                         -1,
                                         nuTransac,
                                         null,
                                         L_Payload,
                                         0,
                                         0,
                                         nuMesacodi,
                                         onuErrorCode,
                                         osbErrorMessage);

          onuErrorCode := nvl(onuErrorCode, 0);

          --DBMS_OUTPUT.put_line(Replace(L_Payload, LDCI_PKGESTLEGAORDEN.sbInputMsgType, 'RAIZ'));

          if (onuErrorCode = 0) then
            --for reLDCI_ORDENESALEGALIZAR in cuLDCI_ORDENESALEGALIZAR(sbSTATE, reLDCI_PKGESTLEGAORDEN.SISTEMA_ID) loop --#20150130: jesusv: Se quita referencia cursor anterior
            For reLdci_OrdenesALegalizar In cuLdci_OrdenesALegalizar(Replace(L_Payload,
                                                                             LDCI_PKGESTLEGAORDEN.sbInputMsgType,
                                                                             'RAIZ')) Loop
              --#20150130: jesusv: Se crea referencia a nuevo cursor de XML

              --#20150130: jesusv: (ini) Se agrega consulta de estado de legalizacion de la orden
              sbEstadoOrden := Null;

              Select State
                Into sbEstadoOrden
                From Ldci_Ordenesalegalizar
               Where Order_Id = reLdci_OrdenesALegalizar.Orden;
              --#20150130: jesusv: (fin) Se agrega consulta de estado de legalizacion de la orden

              --If reLdci_OrdenesALegalizar.Estado = 'L' Then --#20150130: jesusv: Se quita validacion referente al cursor anterior
              If sbEstadoOrden = 'L' Then
                --#20150130: jesusv: Se valida con la variable de estado de legalizacion
                sbEstTipoNotif := 'N';
              Else
                sbEstTipoNotif := 'EN';
              End If;

              --DBMS_OUTPUT.put_line(reLDCI_ORDENESALEGALIZAR.ORDEN);

              proActualizaEstado(inuOrden       => reLDCI_ORDENESALEGALIZAR.ORDEN,
                                 inuMessageCode => null,
                                 isbMessageText => null,
                                 isbstate       => sbEstTipoNotif);
            end loop; --for reLDCI_ORDENESALEGALIZAR in cuLDCI_ORDENESALEGALIZAR(sbSTATE) loop
          else
            LDCI_PKWEBSERVUTILS.Procrearerrorlogint('proNotificaOrdenesLegalizadas',
                                                    1,
                                                    osbErrorMessage,
                                                    null,
                                                    null);
          end if; --if (onuErrorCode = 0) then

        End If; --If (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) > 0) Then

      end if; --if (LDCI_PKGESTLEGAORDEN.sbUrlWS is not null)   then

    end loop; --for reLDCI_PKGESTLEGAORDEN in cuLDCI_PKGESTLEGAORDEN loop
  exception
    WHEN excepNoProcesoRegi THEN
      onuErrorCode    := -1;
      osbErrorMessage := 'LDCI_PKGESTLEGAORDEN.proNotificaOrdenesLegalizadas.excepNoProcesoRegi]: La consulta no ha arrojo registros';
      LDCI_pkWebServUtils.Procrearerrorlogint('proNotificaOrdenesLegalizadas',
                                              1,
                                              osbErrorMessage,
                                              null,
                                              null);
      rollback;
    when others then
      rollback;
      onuErrorCode    := SQLCODE;
      osbErrorMessage := '[LDCI_PKGESTLEGAORDEN.proNotificaOrdenesLegalizadas.others]: Error no controlado : ' ||
                         chr(13) || SQLERRM;
      LDCI_pkWebServUtils.Procrearerrorlogint('proNotificaOrdenesLegalizadas',
                                              1,
                                              osbErrorMessage,
                                              null,
                                              null);
  end proNotificaOrdenesLegalizadas;

  ---------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  PROCEDURE procLegalizaActivity(inuorden        in or_order.order_id%type,
                                 inuopera        in or_order.operating_unit_id%type,
                                 inucausal       in or_order.causal_id%type,
                                 sbcomment       in or_order_activity.comment_%type,
                                 onuErrorCode    in out NUMBER,
                                 osbErrorMessage in out VARCHAR2)

   AS

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKGESTLEGAORDEN.procLegalizaActivity
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 27/06/2014
             RICEF   : I085
       DESCRIPCION   : Proceso que realiza la legalizacion de ordenes por actividad.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ      27/06/2014   Creacion del proceso

    **************************************************************************/
    nurespuesta boolean;
    nupack      or_order_activity.package_id%type;

    sender    ld_parameter.value_chain%type;
    sbcorreos ld_parameter.value_chain%type;
    nuperson  or_oper_unit_persons.person_id%type;

  BEGIN

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procLegalizaActivity', 15);

    if dald_parameter.fblExist('IDEN_ACCI_ESPLEG_PORTAL') then

      begin
        select o.person_id
          into nuperson
          from or_oper_unit_persons o
         where operating_unit_id = inuopera
           and rownum = 1;
      exception
        when OTHERS then
          osbErrorMessage := 'Error Consultando la persona de la unidad operativa: ' ||
                             inuopera ||
                             DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
          onuErrorCode    := -1;
          Errors.getError(onuErrorCode, osbErrorMessage);
      end;

      os_legalizeorderallactivities(inuorden, --rgorders.order_id,
                                    inucausal, --or_boconstants.cnuSuccesCausal,
                                    nuperson, --ld_boutilflow.fnuGetPersonToLegal(inuopera),
                                    sysdate,
                                    sysdate,
                                    sbcomment,
                                    null, --new parameter add for open
                                    onuErrorCode,
                                    osbErrorMessage);
      --si existe error levanta mensaje
      if onuErrorCode <> 0 then

        sender    := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER');
        sbcorreos := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_RECIBE_FNB_WEB');
        --       smtp_host   VARCHAR2(256) := OPEN.DAGE_PARAMETER.FSBGETVALUE('HOST_MAIL',NULL);
        ldc_email.mail(sender,
                       -- 'hainer.torrenegra@stackpointer.co',
                       sbcorreos,
                       'Error Aprobando de venta Brilla Portal Web',
                       'La orden ' || inuorden ||
                       'No se ha podido legalizar por el siguiente error : ' ||
                       onuErrorCode || ' ' || 'Descripcion del error : ' ||
                       osbErrorMessage || ' ' ||
                       'Favor conultar con el administrador');

        RAISE ex.CONTROLLED_ERROR;
      else

        begin
          select o.package_id
            into nupack
            from or_order_activity o
           where o.order_id = inuorden;

        EXCEPTION
          WHEN OTHERS THEN
            errors.geterror(onuErrorCode, osbErrorMessage);
        end;

        if nupack IS not null then
          mo_bowf_pack_interfac.PrepNotToWfPack(nupack, --10903024,
                                                dald_parameter.fnuGetNumeric_Value('IDEN_ACCI_ESPLEG_PORTAL'),
                                                MO_BOCausal.fnuGetSuccess,
                                                MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,
                                                FALSE);
        end if;

      end if;
    else
      gw_boerrors.checkerror(2741,
                             'Los parametros de configuracion ' ||
                             'IDEN_ACCI_ESPLEG_PORTAL' ||
                             ' de la accion del flujo se encuentran en blanco, favor Validar');

    end if;

    onuErrorCode    := 0;
    osbErrorMessage := '';

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procLegalizaActivity', 15);
  EXCEPTION
    WHEN OTHERS THEN
      errors.geterror(onuErrorCode, osbErrorMessage);

  END procLegalizaActivity;

  ---------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  PROCEDURE procInstDefect(NUORDER_ACTIVITY_ID or_activ_defect.order_activity_id%type,
                           NUDEFECT_ID         or_activ_defect.defect_id%type,
                           onuErrorCode        in out NUMBER,
                           osbErrorMessage     in out VARCHAR2)

   AS

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKGESTLEGAORDEN.procInstArtefac
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 23/07/2014
             RICEF   : I062,I063,I064
       DESCRIPCION   : Proceso que realiza el insert de las ordenes x artefactos.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ      27/06/2014   Creacion del proceso

    **************************************************************************/
    nuseq number;

  BEGIN

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procInstDefect', 15);

    nuseq := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('or_activ_appliance',
                                                 'OPEN.SEQ_OR_ACTIV_DEFECT_156818');

    INSERT INTO or_activ_defect
    VALUES
      (nuseq, NUORDER_ACTIVITY_ID, NUDEFECT_ID);

    onuErrorCode    := 0;
    osbErrorMessage := '';

    COMMIT;

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procInstDefect', 15);
  EXCEPTION
    WHEN OTHERS THEN
      errors.geterror(onuErrorCode, osbErrorMessage);

  END procInstDefect;

  ---------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  PROCEDURE procInstArtefac(nuORDER_ACTIVITY_ID or_activ_appliance.order_activity_id%type,
                            nuAPPLIANCE_ID      or_activ_appliance.appliance_id%type,
                            nuAMOUNT            or_activ_appliance.amount%type,
                            onuErrorCode        in out NUMBER,
                            osbErrorMessage     in out VARCHAR2)

   AS

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKGESTLEGAORDEN.procInstArtefac
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 23/07/2014
             RICEF   : I062,I063,I064
       DESCRIPCION   : Proceso que realiza el insert de las ordenes x artefactos.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ      23/07/2014   Creacion del proceso

    **************************************************************************/

    nuseq number;
  BEGIN

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procInstArtefac', 15);

    nuseq := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('or_activ_appliance',
                                                 'OPEN.SEQ_OR_ACTIV_APPLIA_156826');
    INSERT INTO or_activ_appliance
    VALUES
      (nuseq, nuORDER_ACTIVITY_ID, nuAPPLIANCE_ID, nuAMOUNT);

    onuErrorCode    := 0;
    osbErrorMessage := '';

    COMMIT;

    UT_Trace.Trace('LDCI_PKGESTLEGAORDEN.procInstArtefac', 15);
  EXCEPTION
    WHEN OTHERS THEN
      errors.geterror(onuErrorCode, osbErrorMessage);

  END procInstArtefac;

END LDCI_PKGESTLEGAORDEN;
/

