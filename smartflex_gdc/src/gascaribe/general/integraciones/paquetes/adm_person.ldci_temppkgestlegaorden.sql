CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN
AS
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
      Lubin Pineda - MVM                     31/07/2023     OSF-1379:
                                                            * Se reemplaza os_legalizeorders por
                                                            api_legalizeorders
                                                            * Se reemplaza Errors.setError; por
                                                            pkg_error.setError;
                                                            * Se reemplaza GI_BOERRORS.SETERRORCODEARGUMENT
                                                            pkg_error.setErrorMessage
                                                            * Se reemplaza Errors.setError(nuCodMensaje,'..') por
                                                            pkg_error.setErrorMessage
                                                            * Se reemplaza Errors.setError(2741,'..') por
                                                            pkg_error.setErrorMessage
                                                            * Se reemplaza ERRORS.geterror por
                                                            pkg_error.getError
                                                            * Se cambia when ex.CONTROLLED_ERROR 
                                                            por WHEN pkg_error.Controlled_Error
                                                            * Se cambia raise ex.Controlled_Error
                                                            por pkg_error.Controlled_Error    
                                                            * Se quita RAISE pkg_Error.controlled_error 
                                                            despues de pkg_error.setErrorMessage
                                                            * Se reemplaza dbms_output.put_line por ut_trace.trace
                                                            * Se quita flbAplicaEntregaXCaso
                                                            * Se quita flbAplicaEntrega
                                                            * Se quitan variables que no se usan
                                                            * Se quita codigo que está en comentarios
                                                            * Se agrega traza de inicio y fin con ut_trace
                                                            * Se reemplaza signo de interrogación
                                                            * Se agrega pkg_utilidades.prAplicarPermisos
                                                            * Se agrega pkg_utilidades.prCrearSinonimos
      Lubin Pineda - MVM                     04/06/2023     OSF-1379:
                                                            * Se crea fsbCadLegSinItemsSinLect
                                                            * Se usa fsbCadLegSinItemsSinLect en procLegalizaActivity
                                                            * Se reemplaza os_legalizeorders por api_legalizeorders
      Lubin Pineda - MVM                     09/08/2023     OSF-1379:
                                                            * Se reemplaza gw_boerrors.checkerror por
                                                            pkg_error.setErrorMessage
                                                            * Se reemplaza pkErrors.NotifyError por 
                                                            pkg_Error.setError 
      Lubin Pineda - MVM                     14/05/2024     OSF-2603:
                                                            * Se ajusta NOTIFICARPROCESOORDENES y se
                                                            hace público para prueba por medio de tester                                                            
    */

    PROCEDURE PROSETFILEAT (inuActivity       IN     NUMBER,
                            isbFileName       IN     VARCHAR2,
                            isbObservation    IN     VARCHAR2,
                            icbFileSrc        IN     CLOB,
                            onuErrorCode         OUT NUMBER,
                            osbErrorMessage      OUT VARCHAR2);

    PROCEDURE PROCESARORDENESLECTURATRANSAC (
        inuOperatingUnitId     IN     NUMBER,
        inuGeograLocationId    IN     NUMBER,
        inuConsCycleId         IN     NUMBER,
        Inuoperatingsectorid   IN     NUMBER,
        inuRouteId             IN     NUMBER,
        Idtinitialdate         IN     DATE,
        Idtfinaldata           IN     DATE,
        Inutasktypeid          IN     NUMBER,
        inuOrderStatusId       IN     NUMBER,
        Onuerrorcode              OUT NUMBER,
        Osberrormsg               OUT VARCHAR2);

    FUNCTION fdtValidaSystem (
        istSystem           ldci_ordenesalegalizar.SYSTEM%TYPE,
        idtChangeDate       ldci_ordenesalegalizar.changedate%TYPE,
        osbMensaje      OUT VARCHAR2)
        RETURN DATE;

    PROCEDURE PROLEGALIZARORDEN (ISBDATAORDER    IN     VARCHAR2,
                                 IDTINITDATE     IN     DATE,
                                 IDTFINALDATE    IN     DATE,
                                 IDTCHANGEDATE   IN     DATE,
                                 Resultado          OUT NUMBER,
                                 Msj                OUT VARCHAR2);

    PROCEDURE proLegalizaOrdenes;

    PROCEDURE proLegalizaOrdenesSistema (
        isbSistema   ldci_ordenesalegalizar.SYSTEM%TYPE);

    PROCEDURE proNotificaOrdenesLegalizadas;

    PROCEDURE PROCESOORDENES;

    /*
    * NC:        Validacion si una orden esta o no
    *            legalizada, retorna 0 si no esta legalizada
    *            retorna 1 si esta legalizada, y -1 si termino errores
    * FECHA:     15-01-2013
    *
    * Autor:     Hector Fabio Dominguez
    *
    */

    FUNCTION fnuValidaOrdLega (isbIdOrden   IN     VARCHAR2,
                               osbMensaje      OUT VARCHAR2)
        RETURN NUMBER;

    PROCEDURE proInsLoteOrdenesALegalizar (iclXMLOrdenes IN CLOB);

    PROCEDURE proLegalizaOrdenesSistemaCiclo (
        isbSistema   ldci_ordenesalegalizar.SYSTEM%TYPE,
        isbCicl      NUMBER,
        isbCiclFin   NUMBER);

    PROCEDURE proActualizaEstado (
        inuOrden         IN ldci_ordenesalegalizar.order_id%TYPE,
        inuMessageCode   IN ldci_ordenesalegalizar.messagecode%TYPE,
        isbMessageText   IN ldci_ordenesalegalizar.messagetext%TYPE,
        isbstate         IN ldci_ordenesalegalizar.state%TYPE);

    PROCEDURE procLegalizaActivity (
        inuorden          IN     or_order.order_id%TYPE,
        inuopera          IN     or_order.operating_unit_id%TYPE,
        inucausal         IN     or_order.causal_id%TYPE,
        sbcomment         IN     or_order_activity.comment_%TYPE,
        onuErrorCode      IN OUT NUMBER,
        osbErrorMessage   IN OUT VARCHAR2);

    PROCEDURE procInstArtefac (
        nuORDER_ACTIVITY_ID          or_activ_appliance.order_activity_id%TYPE,
        nuAPPLIANCE_ID               or_activ_appliance.appliance_id%TYPE,
        nuAMOUNT                     or_activ_appliance.amount%TYPE,
        onuErrorCode          IN OUT NUMBER,
        osbErrorMessage       IN OUT VARCHAR2);

    PROCEDURE procInstDefect (
        NUORDER_ACTIVITY_ID          or_activ_defect.order_activity_id%TYPE,
        NUDEFECT_ID                  or_activ_defect.defect_id%TYPE,
        onuErrorCode          IN OUT NUMBER,
        osbErrorMessage       IN OUT VARCHAR2);

    PROCEDURE PRLEGALIZAOTSISTXHILOS (isbSistema        IN     VARCHAR2,
                                      inuProcEsta       IN     NUMBER,
                                      onuErrorCode         OUT NUMBER,
                                      osbErrorMessage      OUT VARCHAR2);

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      PROCESO : PRLEGALIZAOTSISTXHILOS
      AUTOR   : Luis Javier Lopez / Horbath
      FECHA   : 29/10/2019
      DESCRIPCION   : Proceso que se encarga de llamar al proceso de legalziacion por hilo

     Parametros de Entrada
       isbSistema sistema a legalizar ordenes
       inuProcEsta  numero de proceso estaproc
     Parametros de Salida
       onuErrorCode codigo de error
       osbErrorMessage mensaje de error

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
    **************************************************************************/

    PROCEDURE PRLEGALIZAORDENESSISTEMA_HILO (isbSistema     IN VARCHAR2,
                                             inuTotalHilo   IN NUMBER,
                                             inuHiloasig    IN NUMBER,
                                             inuProcEsta    IN NUMBER);

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      PROCESO : PRLEGALIZAORDENESSISTEMA_HILO
      AUTOR   : Luis Javier Lopez / Horbath
      FECHA   : 29/10/2019
      DESCRIPCION   : Proceso que se encarga de legalizar ordenes por hilos.

     Parametros de Entrada
       isbSistema sistema a legalizar ordenes
       inuTotalHilo  numero total de hilo
       inuHiloasig   hilo asignado
       inuProcEsta    proceso estaprog
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
    **************************************************************************/

    PROCEDURE PRVALIDAEJEPRO;
/***************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

    PROCESO : PRVALIDAEJEPRO
  AUTOR   : Luis Javier Lopez / Horbath
  FECHA   : 29/10/2019
  DESCRIPCION   : Proceso que se encarga de validar si hay algun proceso en ejecucion

   Parametros de Entrada

   Parametros de Salida

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
**************************************************************************/

    FUNCTION fsbCadLegSinItemsSinLect 
    ( 
        inuOrden        NUMBER,
        inuCausal       NUMBER,
        inuPersona      NUMBER,
        isbComentario   VARCHAR2        
    )
    RETURN VARCHAR2;
    
    PROCEDURE NOTIFICARPROCESOORDENES (
        nuestaproc   IN LDCI_ESTAPROC.PROCCODI%TYPE);
    
END LDCI_TEMPPKGESTLEGAORDEN;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN
AS

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'LDCI_TEMPPKGESTLEGAORDEN.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

    -- Carga variables globales
    sbInputMsgType   LDCI_CARASEWE.CASEVALO%TYPE;
    sbNameSpace      LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlWS          LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlDesti       LDCI_CARASEWE.CASEVALO%TYPE;
    sbSoapActi       LDCI_CARASEWE.CASEVALO%TYPE;
    sbProtocol       LDCI_CARASEWE.CASEVALO%TYPE;
    sbHost           LDCI_CARASEWE.CASEVALO%TYPE;
    sbPuerto         LDCI_CARASEWE.CASEVALO%TYPE;
    sbPrefijoLDC     LDCI_CARASEWE.CASEVALO%TYPE;
    sbDefiSewe       LDCI_DEFISEWE.DESECODI%TYPE;

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_TEMPPKGESTLEGAORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    PROCEDURE proCreaLogIntegra (iclInfoXml       IN     CLOB,
                                 isbComentarios   IN     VARCHAR2,
                                 inuRegistros     IN     NUMBER,
                                 onuSecuencia     IN OUT NUMBER)
    AS

        /*
           PROPIEDAD INTELECTUAL DE GASES DE GASES DEL CARIBE
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.proCreaLogIntegra
           AUTOR      : Jesus Vivero
           FECHA      : 19-01-2015
           RICEF      :
           DESCRIPCION: Proceso para registrar en log de integraciones

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */

        PRAGMA AUTONOMOUS_TRANSACTION;

        sbInsertaLog   Ldci_Carasewe.Casevalo%TYPE;
        nuSecuencia    NUMBER;
    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proCreaLogIntegra' , cnuNVLTRC );

        -- Se valida si se registra log
        SELECT NVL (Casevalo, 'N')
          INTO sbInsertaLog
          FROM Ldci_Carasewe
         WHERE Casecodi = 'LOG_INSERT_LEGA_ORDEN' AND Casedese = 'WS_SISURE';

        IF NVL (sbInsertaLog, 'N') = 'S'
        THEN
            -- Se busca el consecutivo de secuencia
            SELECT Ldci_Seq_Logs_Integraciones.NEXTVAL
              INTO nuSecuencia
              FROM DUAL;

            -- Se inserta el registro del log
            INSERT INTO Ldci_Logs_Integraciones (Secuencia,
                                                 Fecha,
                                                 Info_Xml,
                                                 Comentarios,
                                                 Cantidad_Registros)
                 VALUES (nuSecuencia,
                         SYSDATE,
                         iclInfoXml,
                         isbComentarios,
                         inuRegistros);

            COMMIT;

            onuSecuencia := nuSecuencia;
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proCreaLogIntegra' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Traza.Trace( 'Error ' || csbSP_NAME || 'proCreaLogIntegra|' || sqlerrm , cnuNVLTRC );        
            NULL;
    END proCreaLogIntegra;

    PROCEDURE proActuLogIntegra (inuSecuencia     IN NUMBER,
                                 isbComentarios   IN VARCHAR2,
                                 inuRegistros     IN NUMBER)
    AS

        /*
           PROPIEDAD INTELECTUAL DE GASES DE GASES DEL CARIBE
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.proActuLogIntegra
           AUTOR      : Jesus Vivero
           FECHA      : 19-01-2015
           RICEF      :
           DESCRIPCION: Proceso para actualizar en log de integraciones

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */

        PRAGMA AUTONOMOUS_TRANSACTION;

        sbInsertaLog   Ldci_Carasewe.Casevalo%TYPE;
        
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proActuLogIntegra' , cnuNVLTRC );    
            
        -- Se valida si se registra log
        SELECT NVL (Casevalo, 'N')
          INTO sbInsertaLog
          FROM Ldci_Carasewe
         WHERE Casecodi = 'LOG_INSERT_LEGA_ORDEN' AND Casedese = 'WS_SISURE';

        IF NVL (sbInsertaLog, 'N') = 'S'
        THEN
            -- Se actualiza el registro del log
            UPDATE Ldci_Logs_Integraciones
               SET Comentarios =
                       SUBSTR (Comentarios || '|' || isbComentarios, 1, 4000),
                   Cantidad_Registros = inuRegistros
             WHERE Secuencia = inuSecuencia;

            COMMIT;
        END IF;
            
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proActuLogIntegra' , cnuNVLTRC );    
                
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Traza.Trace( 'Error ' || csbSP_NAME || 'proActuLogIntegra|'|| sqlerrm , cnuNVLTRC );       
            NULL;
    END proActuLogIntegra;

    PROCEDURE proCargaVarGlobal (isbCASECODI IN LDCI_CARASEWE.CASECODI%TYPE)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           Procedimiento : LDCI_TEMPPKGESTLEGAORDEN.proCargaVarGlobal
           AUTOR      : OLSoftware / Carlos E. Virgen
           FECHA      : 25/02/2012
           RICEF      : REQ007-I062
           DESCRIPCION: Limpia y carga las variables globales

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        onuErrorCode      ge_error_log.Error_log_id%TYPE;
        osbErrorMessage   ge_error_log.description%TYPE;
        errorPara01       EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proCargaVarGlobal' , cnuNVLTRC );    
           
        LDCI_TEMPPKGESTLEGAORDEN.sbInputMsgType := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbNameSpace := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbUrlWS := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbUrlDesti := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbSoapActi := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbProtocol := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbHost := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbPuerto := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbPrefijoLDC := NULL;
        LDCI_TEMPPKGESTLEGAORDEN.sbDefiSewe := NULL;

        LDCI_TEMPPKGESTLEGAORDEN.sbDefiSewe := isbCASECODI;
        -- carga los parametos de la interfaz
        LDCI_PKWEBSERVUTILS.proCaraServWeb (
            isbCASECODI,
            'INPUT_MESSAGE_TYPE',
            LDCI_TEMPPKGESTLEGAORDEN.sbInputMsgType,
            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (
            isbCASECODI,
            'NAMESPACE',
            LDCI_TEMPPKGESTLEGAORDEN.sbNameSpace,
            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (isbCASECODI,
                                            'WSURL',
                                            LDCI_TEMPPKGESTLEGAORDEN.sbUrlWS,
                                            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (
            isbCASECODI,
            'SOAPACTION',
            LDCI_TEMPPKGESTLEGAORDEN.sbSoapActi,
            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (
            isbCASECODI,
            'PROTOCOLO',
            LDCI_TEMPPKGESTLEGAORDEN.sbProtocol,
            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (
            isbCASECODI,
            'PUERTO',
            LDCI_TEMPPKGESTLEGAORDEN.sbPuerto,
            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb (isbCASECODI,
                                            'HOST',
                                            LDCI_TEMPPKGESTLEGAORDEN.sbHost,
                                            osbErrorMessage);

        IF (osbErrorMessage != '0')
        THEN
            RAISE Errorpara01;
        END IF;

        LDCI_TEMPPKGESTLEGAORDEN.Sburldesti :=
               LOWER (LDCI_TEMPPKGESTLEGAORDEN.Sbprotocol)
            || '://'
            || LDCI_TEMPPKGESTLEGAORDEN.Sbhost
            || ':'
            || LDCI_TEMPPKGESTLEGAORDEN.Sbpuerto
            || '/'
            || LDCI_TEMPPKGESTLEGAORDEN.Sburlws;
        LDCI_TEMPPKGESTLEGAORDEN.sbUrlDesti :=
            TRIM (LDCI_TEMPPKGESTLEGAORDEN.sbUrlDesti);
            
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proCargaVarGlobal' , cnuNVLTRC );    
                    
    EXCEPTION
        WHEN Errorpara01
        THEN
            pkg_Traza.Trace( 'ERROR: [LDCI_TEMPPKGESTLEGAORDEN.proCargaVarGlobal]: Cargando el parametro :'
                || osbErrorMessage, cnuNVLTRC);
            COMMIT;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            COMMIT;
    END proCargaVarGlobal;

    FUNCTION fnuValidaOrdLega (isbIdOrden   IN     VARCHAR2,
                               osbMensaje      OUT VARCHAR2)
        RETURN NUMBER
    IS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega
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
        nuOrdenLega   NUMBER;

        /*
        * Cursor     : cuConsultaOrden
        * Descripcion: Cursor encargado de validar si la orden
        *              fue legalizada
        */

        CURSOR cuConsultaOrden IS
            SELECT COUNT (*)
              FROM OR_ORDER
             WHERE ORDER_STATUS_ID = 8 AND ORDER_ID = TO_NUMBER (isbIdOrden);
    BEGIN
        
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'fnuValidaOrdLega' , cnuNVLTRC );  
            
        osbMensaje := 'OK';

        /*
        * Se ejecuta la consulta de validacion
        */
        OPEN cuConsultaOrden;

        FETCH cuConsultaOrden INTO nuOrdenLega;

        CLOSE cuConsultaOrden;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'fnuValidaOrdLega' , cnuNVLTRC );
        
        RETURN nuOrdenLega;
    EXCEPTION
        WHEN OTHERS
        THEN
            osbMensaje :=
                   'Error consultando la orden '
                || DBMS_UTILITY.format_error_backtrace;
            RETURN -1;
    END fnuValidaOrdLega;

    FUNCTION fdtValidaSystem (
        istSystem           ldci_ordenesalegalizar.SYSTEM%TYPE,
        idtChangeDate       ldci_ordenesalegalizar.changedate%TYPE,
        osbMensaje      OUT VARCHAR2)
        RETURN DATE
    IS
        /*
         * Propiedad Intelectual Gases de Occidente SA ESP
         *
         * Script  : LDCI_TEMPPKGESTLEGAORDEN.fdtValidaSystem
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

        dtChangeDate   DATE;
        dato           NUMBER;
    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'fdtValidaSystem' , cnuNVLTRC );    
    
        SELECT COUNT (*)
          INTO dato
          FROM TABLE (
                   ldc_boutilities.splitstrings (
                       pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCI_VALCAMBIOEST'),
                       ','))
         WHERE COLUMN_VALUE LIKE '%' || istSystem || '%';

        IF (dato > 0)
        THEN
            dtChangeDate := NULL;
        ELSE
            dtChangeDate := idtChangeDate;
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'fdtValidaSystem' , cnuNVLTRC );
        
        RETURN dtChangeDate;
    EXCEPTION
        WHEN OTHERS
        THEN
            osbMensaje :=
                   'Error consultando la orden '
                || DBMS_UTILITY.format_error_backtrace;
            RETURN NULL;
    END fdtValidaSystem;

    PROCEDURE ENVIARORDENES
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.ENVIARORDENES
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        sbErrMens            VARCHAR2 (2000);
        sbNameSpace          LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlWS              LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlDesti           LDCI_CARASEWE.CASEVALO%TYPE;
        sbSoapActi           LDCI_CARASEWE.CASEVALO%TYPE;
        sbProtocol           LDCI_CARASEWE.CASEVALO%TYPE;
        sbHost               LDCI_CARASEWE.CASEVALO%TYPE;
        sbPuerto             LDCI_CARASEWE.CASEVALO%TYPE;
        Sbmens               VARCHAR2 (4000);

        --Variables mensajes SOAP
        L_Payload            CLOB;

        l_response           CLOB;
        qryCtx               DBMS_XMLGEN.ctxHandle;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'ENVIARORDENES' , cnuNVLTRC );
            
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'NAMESPACE',
                                            sbNameSpace,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'WSURL',
                                            sbUrlWS,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'SOAPACTION',
                                            sbSoapActi,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PROTOCOLO',
                                            sbProtocol,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PUERTO',
                                            sbPuerto,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'HOST',
                                            sbHost,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE Errorpara01;
        END IF;

        Sburldesti :=
               LOWER (Sbprotocol)
            || '://'
            || Sbhost
            || ':'
            || Sbpuerto
            || '/'
            || Sburlws;
        sbUrlDesti := TRIM (sbUrlDesti);

        -- Genera el mensaje XML
        Qryctx :=
            DBMS_XMLGEN.Newcontext (
                'Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",
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
        DBMS_XMLGEN.setNullHandling (qryCtx, 0);

        l_payload := DBMS_XMLGEN.getXML (qryCtx);

        --Valida si proceso registros
        IF (DBMS_XMLGEN.getNumRowsProcessed (qryCtx) = 0)
        THEN
            RAISE excepNoProcesoRegi;
        END IF;         --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

        DBMS_XMLGEN.closeContext (qryCtx);

        L_Payload := REPLACE (L_Payload, '<?xml version="1.0"?>');
        L_Payload := REPLACE (L_Payload, '<ROWSET', '<ordenes');
        L_Payload := REPLACE (L_Payload, '</ROWSET>', '</ordenes>');
        L_Payload := REPLACE (L_Payload, '<ROW>', '<orden>');
        L_Payload := REPLACE (L_Payload, '</ROW>', '</orden>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES>', '<actividades>');
        L_Payload := REPLACE (L_Payload, '</ACTIVIDADES>', '</actividades>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
        L_Payload :=
            REPLACE (L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');
        L_Payload :=
               '<urn:NotificarOrdenesLectura>'
            || L_Payload
            || '</urn:NotificarOrdenesLectura>';
        L_Payload := REPLACE (L_Payload, '&', '');
        L_Payload := REPLACE (L_Payload, '?', 'N');
        L_Payload := REPLACE (L_Payload, '?', 'n');
        L_Payload := TRIM (L_Payload);

        --Hace el consumo del servicio Web
        LDCI_PKSOAPAPI.Prosetprotocol (Sbprotocol);

        l_response :=
            LDCI_PKSOAPAPI.fsbSoapSegmentedCall (l_payload,
                                                 sbUrlDesti,
                                                 sbSoapActi,
                                                 sbNameSpace);

        dbms_output.put_line ('Response: ' ||  l_response);

        --Valida el proceso de peticion SOAP
        IF (LDCI_PKSOAPAPI.Boolsoaperror OR LDCI_PKSOAPAPI.Boolhttperror)
        THEN
            RAISE Excepnoprocesosoap;
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'ENVIARORDENES' , cnuNVLTRC );        

    EXCEPTION
        WHEN Errorpara01
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: Error en carga de parametros: '
                || sbMens;
        WHEN excepNoProcesoRegi
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros'
                || DBMS_UTILITY.format_error_backtrace;
        WHEN excepNoProcesoSOAP
        THEN
            Sberrmens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.'
                || DBMS_UTILITY.Format_Error_Backtrace;
    END ENVIARORDENES;

    PROCEDURE ENVIARORDENESTRANSAC (idTransac   IN NUMBER,
                                    lote        IN NUMBER,
                                    cantLotes   IN NUMBER)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.ENVIARORDENESTRANSAC
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        sbErrMens            VARCHAR2 (2000);
        sbNameSpace          LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlWS              LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlDesti           LDCI_CARASEWE.CASEVALO%TYPE;
        sbSoapActi           LDCI_CARASEWE.CASEVALO%TYPE;
        sbProtocol           LDCI_CARASEWE.CASEVALO%TYPE;
        sbHost               LDCI_CARASEWE.CASEVALO%TYPE;
        sbPuerto             LDCI_CARASEWE.CASEVALO%TYPE;
        Sbmens               VARCHAR2 (4000);

        --Variables mensajes SOAP
        L_Payload            CLOB;
        sbXmlTransac         VARCHAR2 (200);

        l_response           CLOB;
        qryCtx               DBMS_XMLGEN.ctxHandle;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'ENVIARORDENESTRANSAC' , cnuNVLTRC );    
            
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'NAMESPACE',
                                            sbNameSpace,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'WSURL',
                                            sbUrlWS,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'SOAPACTION',
                                            sbSoapActi,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PROTOCOLO',
                                            sbProtocol,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PUERTO',
                                            sbPuerto,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'HOST',
                                            sbHost,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE Errorpara01;
        END IF;

        Sburldesti :=
               LOWER (Sbprotocol)
            || '://'
            || Sbhost
            || ':'
            || Sbpuerto
            || '/'
            || Sburlws;
        sbUrlDesti := TRIM (sbUrlDesti);

        -- Genera el mensaje XML
        Qryctx :=
            DBMS_XMLGEN.Newcontext (
                'Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",
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

        DBMS_XMLGEN.setNullHandling (qryCtx, 0);

        l_payload := DBMS_XMLGEN.getXML (qryCtx);

        --Valida si proceso registros
        IF (DBMS_XMLGEN.getNumRowsProcessed (qryCtx) = 0)
        THEN
            RAISE excepNoProcesoRegi;
        END IF;         --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

        DBMS_XMLGEN.closeContext (qryCtx);

        L_Payload := REPLACE (L_Payload, '<?xml version="1.0"?>');
        L_Payload := REPLACE (L_Payload, '<ROWSET', '<ordenes');
        L_Payload := REPLACE (L_Payload, '</ROWSET>', '</ordenes>');
        L_Payload := REPLACE (L_Payload, '<ROW>', '<orden>');
        L_Payload := REPLACE (L_Payload, '</ROW>', '</orden>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES>', '<actividades>');
        L_Payload := REPLACE (L_Payload, '</ACTIVIDADES>', '</actividades>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
        L_Payload :=
            REPLACE (L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');

        sbXmlTransac := '<transaccion>
            <transaccion>' || idTransac || '</transaccion>
            <lote>' || lote || '</lote>
         </transaccion>';

        L_Payload :=
               '<urn:NotificarOrdenesLectura>'
            || sbXmlTransac
            || L_Payload
            || '</urn:NotificarOrdenesLectura>';
        L_Payload := REPLACE (L_Payload, '&', '');
        L_Payload := REPLACE (L_Payload, '?', 'N');
        L_Payload := REPLACE (L_Payload, '?', 'n');
        L_Payload := TRIM (L_Payload);

        --Hace el consumo del servicio Web
        LDCI_PKSOAPAPI.Prosetprotocol (Sbprotocol);

        pkg_Traza.Trace (
            'Enviando :' || TO_CHAR (CURRENT_DATE, 'DD/MM/YYYY HH:MI:SS'), cnuNVLTRC);
        l_response :=
            LDCI_PKSOAPAPI.fsbSoapSegmentedCall (l_payload,
                                                 sbUrlDesti,
                                                 sbSoapActi,
                                                 sbNameSpace);

        dbms_output.put_Line (
               'Response: '
            || l_response
            || ' '
            || TO_CHAR (CURRENT_DATE, 'DD/MM/YYYY HH:MI:SS'));

        --Valida el proceso de peticion SOAP
        IF (LDCI_PKSOAPAPI.Boolsoaperror OR LDCI_PKSOAPAPI.Boolhttperror)
        THEN
            dbms_output.put_Line (L_Response);
            RAISE Excepnoprocesosoap;
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'ENVIARORDENESTRANSAC' , cnuNVLTRC );
        
    EXCEPTION
        WHEN Errorpara01
        THEN
            pkg_Traza.Trace (Sbmens,cnuNVLTRC);
        WHEN excepNoProcesoRegi
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros'
                || DBMS_UTILITY.format_error_backtrace;
            pkg_Traza.Trace (sbErrMens,cnuNVLTRC);
        WHEN excepNoProcesoSOAP
        THEN
            Sberrmens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.'
                || DBMS_UTILITY.Format_Error_Backtrace;
            pkg_Traza.Trace (Sberrmens, cnuNVLTRC);
    END ENVIARORDENESTRANSAC;

    PROCEDURE CONFIRMARORDENES (idTransac   IN NUMBER,
                                cantLotes   IN NUMBER,
                                cantOrds    IN NUMBER,
                                cantActs    IN NUMBER)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.CONFIRMARORDENES
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        sbErrMens            VARCHAR2 (2000);
        sbNameSpace          LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlWS              LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlDesti           LDCI_CARASEWE.CASEVALO%TYPE;
        sbSoapActi           LDCI_CARASEWE.CASEVALO%TYPE;
        sbProtocol           LDCI_CARASEWE.CASEVALO%TYPE;
        sbHost               LDCI_CARASEWE.CASEVALO%TYPE;
        sbPuerto             LDCI_CARASEWE.CASEVALO%TYPE;
        Sbmens               VARCHAR2 (4000);

        --Variables mensajes SOAP
        L_Payload            CLOB;
        sbXmlTransac         VARCHAR2 (200);

        l_response           CLOB;
        qryCtx               DBMS_XMLGEN.ctxHandle;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'CONFIRMARORDENES' , cnuNVLTRC );
            
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'NAMESPACE',
                                            sbNameSpace,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'WSURL',
                                            sbUrlWS,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'SOAPACTION',
                                            sbSoapActi,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PROTOCOLO',
                                            sbProtocol,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PUERTO',
                                            sbPuerto,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'HOST',
                                            sbHost,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE Errorpara01;
        END IF;

        Sburldesti :=
               LOWER (Sbprotocol)
            || '://'
            || Sbhost
            || ':'
            || Sbpuerto
            || '/'
            || Sburlws;
        sbUrlDesti := TRIM (sbUrlDesti);

        sbXmlTransac :=
               '<idTransaccion>'
            || idTransac
            || '</idTransaccion>
            <cantidadLotes>'
            || cantLotes
            || '</cantidadLotes>
            <cantidadOrdenes>'
            || cantOrds
            || '</cantidadOrdenes>
            <cantidadActs>'
            || cantActs
            || '</cantidadActs>';

        L_Payload :=
               '<urn:ConfirmaTransacOrdRequest>'
            || sbXmlTransac
            || '</urn:ConfirmaTransacOrdRequest>';

        L_Payload := TRIM (L_Payload);

        --Hace el consumo del servicio Web
        LDCI_PKSOAPAPI.Prosetprotocol (Sbprotocol);
        
        pkg_Traza.Trace (
            'Enviando :' || TO_CHAR (CURRENT_DATE, 'DD/MM/YYYY HH:MI:SS'), cnuNVLTRC);
        l_response :=
            LDCI_PKSOAPAPI.fsbSoapSegmentedCall (l_payload,
                                                 sbUrlDesti,
                                                 sbSoapActi,
                                                 sbNameSpace);

        dbms_output.put_line (
               'Response: '
            || l_response
            || ' '
            || TO_CHAR (CURRENT_DATE, 'DD/MM/YYYY HH:MI:SS'));

        --Valida el proceso de peticion SOAP
        IF (LDCI_PKSOAPAPI.Boolsoaperror OR LDCI_PKSOAPAPI.Boolhttperror)
        THEN
            dbms_output.put_line (L_Response);

            RAISE Excepnoprocesosoap;
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'CONFIRMARORDENES' , cnuNVLTRC );
        
    EXCEPTION
        WHEN Errorpara01
        THEN
            pkg_Traza.Trace (Sbmens, cnuNVLTRC);
        WHEN excepNoProcesoRegi
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros'
                || DBMS_UTILITY.format_error_backtrace;
            pkg_Traza.Trace (sbErrMens, cnuNVLTRC);
        WHEN excepNoProcesoSOAP
        THEN
            Sberrmens :=
                   'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.'
                || DBMS_UTILITY.Format_Error_Backtrace;
            pkg_Traza.Trace (Sberrmens, cnuNVLTRC);
    END CONFIRMARORDENES;

    PROCEDURE CANCELARORDENES (idTransac IN NUMBER, lote IN NUMBER)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.CANCELARORDENES
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        sbErrMens            VARCHAR2 (2000);
        sbNameSpace          LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlWS              LDCI_CARASEWE.CASEVALO%TYPE;
        sbUrlDesti           LDCI_CARASEWE.CASEVALO%TYPE;
        sbSoapActi           LDCI_CARASEWE.CASEVALO%TYPE;
        sbProtocol           LDCI_CARASEWE.CASEVALO%TYPE;
        sbHost               LDCI_CARASEWE.CASEVALO%TYPE;
        sbPuerto             LDCI_CARASEWE.CASEVALO%TYPE;
        Sbmens               VARCHAR2 (4000);

        --Variables mensajes SOAP
        L_Payload            CLOB;
        sbXmlTransac         VARCHAR2 (200);

        l_response           CLOB;
        qryCtx               DBMS_XMLGEN.ctxHandle;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'CANCELARORDENES' , cnuNVLTRC );
            
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'NAMESPACE',
                                            sbNameSpace,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'WSURL',
                                            sbUrlWS,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'SOAPACTION',
                                            sbSoapActi,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PROTOCOLO',
                                            sbProtocol,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'PUERTO',
                                            sbPuerto,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'HOST',
                                            sbHost,
                                            sbMens);

        IF (sbMens != '0')
        THEN
            RAISE Errorpara01;
        END IF;

        Sburldesti :=
               LOWER (Sbprotocol)
            || '://'
            || Sbhost
            || ':'
            || Sbpuerto
            || '/'
            || Sburlws;
        sbUrlDesti := TRIM (sbUrlDesti);

        sbXmlTransac := '<transaccion>' || idTransac || '</transaccion>';

        L_Payload :=
               '<urn:CancelaTransacOrdRequest>'
            || sbXmlTransac
            || '</urn:CancelaTransacOrdRequest>';

        L_Payload := TRIM (L_Payload);

        --Hace el consumo del servicio Web
        LDCI_PKSOAPAPI.Prosetprotocol (Sbprotocol);


        l_response :=
            LDCI_PKSOAPAPI.fsbSoapSegmentedCall (l_payload,
                                                 sbUrlDesti,
                                                 sbSoapActi,
                                                 sbNameSpace);

        dbms_output.put_line ('Response: ' || l_response );

        --Valida el proceso de peticion SOAP
        IF (LDCI_PKSOAPAPI.Boolsoaperror OR LDCI_PKSOAPAPI.Boolhttperror)
        THEN
            RAISE Excepnoprocesosoap;
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'CANCELARORDENES' , cnuNVLTRC );

    EXCEPTION
        WHEN Errorpara01
        THEN
            pkg_Traza.Trace (Sbmens, cnuNVLTRC);
        WHEN excepNoProcesoRegi
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros'
                || DBMS_UTILITY.format_error_backtrace;
            pkg_Traza.Trace (sbErrMens, cnuNVLTRC);
        WHEN excepNoProcesoSOAP
        THEN
            Sberrmens :=
                   'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.'
                || DBMS_UTILITY.Format_Error_Backtrace;
            pkg_Traza.Trace (Sberrmens, cnuNVLTRC);
    END CANCELARORDENES;

    PROCEDURE NOTIFICARPROCESAMIENTO (
        INUPROCODI     IN     LDCI_ESTAPROC.PROCCODI%TYPE,
        Onuerrorcode      OUT NUMBER,
        Osberrormsg       OUT VARCHAR2)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.NOTIFICARPROCESAMIENTO
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        CURSOR CUESTAPROC IS
            SELECT *
              FROM LDCI_ESTAPROC
             WHERE PROCCODI = INUPROCODI;

        RECCUESTAPROC   LDCI_ESTAPROC%ROWTYPE;

        CURSOR CUPERSON (SBUSER GE_PERSON.USER_ID%TYPE)
        IS
            SELECT *
              FROM GE_PERSON
             WHERE user_id = SBUSER;

        CURSOR CUMENSAJES IS
            SELECT *
              FROM LDCI_MESAPROC
             WHERE MESAPROC = INUPROCODI;

    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'NOTIFICARPROCESAMIENTO' , cnuNVLTRC );
            
        OPEN CUESTAPROC;

        FETCH CUESTAPROC INTO RECCUESTAPROC;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'NOTIFICARPROCESAMIENTO' , cnuNVLTRC );        

    END NOTIFICARPROCESAMIENTO;

    PROCEDURE PROCESOACTIVIDADESORDEN (
        Orden            IN     LDCI_ACTIVIDADORDEN.Order_Id%TYPE,
        cantAtcs            OUT NUMBER,
        nuTransac        IN     NUMBER,
        OnuFLAFPROCESO   IN OUT NUMBER)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.PROCESOACTIVIDADESORDEN
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */
        TYPE refRegistros IS REF CURSOR;

        Resultado             NUMBER (18) := -1;
        Msj                   VARCHAR2 (200) := '';
        Recregistros          Refregistros;        

        Nuorder_Activity_Id   Ldci_Actividadorden.Order_Activity_Id%TYPE;
        Nuconsecutive         Ldci_Actividadorden.Consecutive%TYPE;
        Nuactivity_Id         Ldci_Actividadorden.Activity_Id%TYPE;
        Nuaddress_Id          Ldci_Actividadorden.Address_Id%TYPE;
        Sbaddress             Ldci_Actividadorden.Address%TYPE;
        Sbsubscriber_Name     Ldci_Actividadorden.Subscriber_Name%TYPE;
        Nuproduct_Id          Ldci_Actividadorden.Product_Id%TYPE;
        Sbservice_Number      Ldci_Actividadorden.Service_Number%TYPE;
        Sbmeter               Ldci_Actividadorden.Meter%TYPE;
        Nuproduct_Status_Id   Ldci_Actividadorden.Product_Status_Id%TYPE;
        Nusubscription_Id     Ldci_Actividadorden.Subscription_Id%TYPE;
        Nucategory_Id         Ldci_Actividadorden.Category_Id%TYPE;
        Nusubcategory_Id      Ldci_Actividadorden.Subcategory_Id%TYPE;
        Nucons_Cycle_Id       Ldci_Actividadorden.Cons_Cycle_Id%TYPE;
        Nucons_Period_Id      Ldci_Actividadorden.Cons_Period_Id%TYPE;
        Nubill_Cycle_Id       Ldci_Actividadorden.Bill_Cycle_Id%TYPE;
        Nubill_Period_Id      Ldci_Actividadorden.Bill_Period_Id%TYPE;
        Nuparent_Product_Id   Ldci_Actividadorden.Parent_Product_Id%TYPE;
        Sbparent_Address_Id   Ldci_Actividadorden.Parent_Address_Id%TYPE;
        Sbparent_Address      Ldci_Actividadorden.Parent_Address%TYPE;
        Sbcausal              Ldci_Actividadorden.Causal%TYPE;
        Nucons_Type_Id        Ldci_Actividadorden.Cons_Type_Id%TYPE;
        Numeter_Location      Ldci_Actividadorden.Meter_Location%TYPE;
        Nudigit_Quantity      Ldci_Actividadorden.Digit_Quantity%TYPE;
        Nulimit               Ldci_Actividadorden.LIMIT%TYPE;
        Sbretry               Ldci_Actividadorden.Retry%TYPE;
        Nuaverage             Ldci_Actividadorden.Average%TYPE;
        Nulast_Read           Ldci_Actividadorden.Last_Read%TYPE;
        Dtlast_Read_Date      Ldci_Actividadorden.Last_Read_Date%TYPE;
        Nuobservation_A       Ldci_Actividadorden.Observation_A%TYPE;
        Nuobservation_B       Ldci_Actividadorden.Observation_B%TYPE;
        NUObservation_C       Ldci_Actividadorden.Observation_C%TYPE;

        nuMesacodi            LDCI_MESAPROC.MESACODI%TYPE;
        nuFlagValida          NUMBER := 0;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROCESOACTIVIDADESORDEN' , cnuNVLTRC );
            
        cantAtcs := 0;
        /* CARGAR ACTIVIDADES DE LA ORDEN */
        OS_GETORDERACTIVITIES (Orden,
                               Recregistros,
                               Resultado,
                               Msj);

        --evaluar el resultado antes de recorrer el cursor
        IF Resultado = 0
        THEN
            LOOP
                FETCH Recregistros
                    INTO Nuorder_Activity_Id,
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

                EXIT WHEN Recregistros%NOTFOUND;
                cantAtcs := cantAtcs + 1;

                LDCI_PKVALIDASIGELEC.PROVALIDAACTIVIDAD (Orden,
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

                IF nuFlagValida = 0
                THEN
                    /* PERSISTIR ACTIVIDADES */
                    INSERT INTO LDCI_ACTIVIDADORDEN (ORDER_ID,
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
                                                     LIMIT,
                                                     Retry,
                                                     Average,
                                                     Last_Read,
                                                     Last_Read_Date,
                                                     Observation_A,
                                                     Observation_B,
                                                     Observation_C)
                         VALUES (Orden,
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
                ELSE
                    OnuFLAFPROCESO := 1;
                    EXIT;
                END IF;
            END LOOP;
        ELSE
            /*CREAR MENSAJE DE ERROR*/
            LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                           Msj,
                                           'E',
                                           CURRENT_DATE,
                                           nuMesacodi,
                                           Resultado,
                                           Msj);
        END IF;

        CLOSE Recregistros;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROCESOACTIVIDADESORDEN' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            /*CREAR MENSAJE DE ERROR*/
            OnuFLAFPROCESO := 1;
            LDCI_PKMESAWS.proCreaMensProc (
                nuTransac,
                   'ERROR: '
                || SQLERRM
                || '. TRACE:'
                || DBMS_UTILITY.format_error_backtrace,
                'E',
                CURRENT_DATE,
                nuMesacodi,
                Resultado,
                Msj);
    END PROCESOACTIVIDADESORDEN;

    PROCEDURE PROPROCESARRORDEN (
        nuTransac                IN     LDCI_ORDEN.TRANSAC_ID%TYPE,
        Nuorder_Id               IN     LDCI_ORDEN.Order_Id%TYPE,
        Nutask_Type_Id           IN     LDCI_ORDEN.Task_Type_Id%TYPE,
        Nuorder_Status_Id        IN     LDCI_ORDEN.Address_Id%TYPE,
        Nuaddress_Id             IN     LDCI_ORDEN.Address_Id%TYPE,
        Sbaddress                IN     LDCI_ORDEN.Address%TYPE,
        Nugeogra_Location_Id     IN     LDCI_ORDEN.Geogra_Location_Id%TYPE,
        Nuneighborthood          IN     LDCI_ORDEN.Neighborthood%TYPE,
        Nuoper_Sector_Id         IN     LDCI_ORDEN.Oper_Sector_Id%TYPE,
        Nuroute_Id               IN     LDCI_ORDEN.Route_Id%TYPE,
        Nuconsecutive            IN     LDCI_ORDEN.Consecutive%TYPE,
        Nupriority               IN     LDCI_ORDEN.Priority%TYPE,
        Dtassigned_Date          IN     LDCI_ORDEN.Assigned_Date%TYPE,
        Dtarrange_Hour           IN     LDCI_ORDEN.Arrange_Hour%TYPE,
        Dtcreated_Date           IN     LDCI_ORDEN.Created_Date%TYPE,
        Dtexec_Estimate_Date     IN     LDCI_ORDEN.Exec_Estimate_Date%TYPE,
        dtMax_Date_To_Legalize   IN     LDCI_ORDEN.Max_Date_To_Legalize%TYPE,
        OnuFLAFPROCESO           IN OUT NUMBER)
    AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.PROPROCESARRORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */

    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROPROCESARRORDEN' , cnuNVLTRC );
   
        NULL;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROPROCESARRORDEN' , cnuNVLTRC );
        
    EXCEPTION
        WHEN OTHERS
        THEN
            OnuFLAFPROCESO := 1;
    END PROPROCESARRORDEN;

    PROCEDURE PROGENERARPAYLOADSORDENES (nuTransac      IN     NUMBER,
                                         nuLote         IN     NUMBER,
                                         nuLotes        IN     NUMBER,
                                         Onuerrorcode      OUT NUMBER,
                                         Osberrormsg       OUT VARCHAR2)
    AS
        sbErrMens            VARCHAR2 (2000);

        nuMesacodi           LDCI_MESAENVWS.MESACODI%TYPE;

        --Variables mensajes SOAP
        L_Payload            CLOB;
        sbXmlTransac         VARCHAR2 (500);

        qryCtx               DBMS_XMLGEN.ctxHandle;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

        -- conteo de ordenes por lote
        CURSOR cuContordenes IS
            SELECT COUNT (ORD.ORDER_ID)     ORDENES
              FROM LDCI_ORDEN ORD
             WHERE ORD.LOTE = nuLote;

        -- conteo de actividades por lote
        CURSOR cuContAvtividades IS
            SELECT COUNT (ACT.ACTIVITY_ID)     ACTIVIDADES
              FROM LDCI_ORDEN ORD, LDCI_ACTIVIDADORDEN ACT
             WHERE ORD.ORDER_ID = ACT.ORDER_ID AND ORD.LOTE = nuLote;

        nuCantOrds           NUMBER := 0;
        nuCantActs           NUMBER := 0;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROGENERARPAYLOADSORDENES' , cnuNVLTRC );
            
        OPEN cuContordenes;

        FETCH cuContordenes INTO nuCantOrds;

        CLOSE cuContordenes;

        OPEN cuContAvtividades;

        FETCH cuContAvtividades INTO nuCantActs;

        CLOSE cuContAvtividades;

        -- Genera el mensaje XML
        Qryctx :=
            DBMS_XMLGEN.Newcontext (
                   'Select Ord.Order_Id as "idOrden",
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
From LDCI_ORDEN Ord where Ord.LOTE = '
                || nuLote);

        DBMS_XMLGEN.setNullHandling (qryCtx, 0);

        l_payload := DBMS_XMLGEN.getXML (qryCtx);

        --Valida si proceso registros
        IF (DBMS_XMLGEN.getNumRowsProcessed (qryCtx) = 0)
        THEN
            RAISE excepNoProcesoRegi;
        END IF;

        DBMS_XMLGEN.closeContext (qryCtx);

        L_Payload := REPLACE (L_Payload, '<?xml version="1.0"?>');
        L_Payload := REPLACE (L_Payload, '<ROWSET', '<ordenes');
        L_Payload := REPLACE (L_Payload, '</ROWSET>', '</ordenes>');
        L_Payload := REPLACE (L_Payload, '<ROW>', '<orden>');
        L_Payload := REPLACE (L_Payload, '</ROW>', '</orden>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES>', '<actividades>');
        L_Payload := REPLACE (L_Payload, '</ACTIVIDADES>', '</actividades>');
        L_Payload := REPLACE (L_Payload, '<ACTIVIDADES_ROW>', '<actividad>');
        L_Payload :=
            REPLACE (L_Payload, '</ACTIVIDADES_ROW>', '</actividad>');

        sbXmlTransac :=
               '<transaccion>
            <proceso>'
            || nuTransac
            || '</proceso>
            <lote>'
            || nuLote
            || '</lote>
            <cantidadLotes>'
            || nuLotes
            || '</cantidadLotes>
            <cantOrdenes>'
            || nuCantOrds
            || '</cantOrdenes>
            <cantActividades>'
            || nuCantActs
            || '</cantActividades>
         </transaccion>';

        L_Payload :=
               '<urn:NotificarOrdenesLectura>'
            || sbXmlTransac
            || L_Payload
            || '</urn:NotificarOrdenesLectura>';

        L_Payload := TRIM (L_Payload);

        LDCI_PKMESAWS.proCreaMensEnvio (CURRENT_DATE,
                                        'WS_ENVIO_ORDENES',
                                        -1,
                                        nuTransac,
                                        NULL,
                                        L_Payload,
                                        nuLote,
                                        nuLotes,
                                        nuMesacodi,
                                        Onuerrorcode,
                                        sbErrMens);

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROGENERARPAYLOADSORDENES' , cnuNVLTRC );
        
    EXCEPTION
        WHEN excepNoProcesoRegi
        THEN
            sbErrMens :=
                   'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros'
                || DBMS_UTILITY.format_error_backtrace;
            pkg_Traza.Trace (sbErrMens, cnuNVLTRC);
        WHEN OTHERS
        THEN
            Sberrmens :=
                   'ERROR ALMACENANDO PAYLOAD. '
                || SQLERRM
                || '. '
                || DBMS_UTILITY.Format_Error_Backtrace;
            pkg_Traza.Trace (Sberrmens, cnuNVLTRC);
    END PROGENERARPAYLOADSORDENES;

    PROCEDURE NOTIFICARPROCESOORDENES (
        nuestaproc   IN LDCI_ESTAPROC.PROCCODI%TYPE)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.NOTIFICARPROCESOORDENES
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */

        sbMensaje         VARCHAR2 (30000);

        --definicion de cursores
        --cursor datos de la persona
        CURSOR cuGE_PERSON (inuUSER_ID GE_PERSON.USER_ID%TYPE)
        IS
            SELECT *
              FROM GE_PERSON g
             WHERE g.USER_ID = inuUSER_ID;

        -- cursor del estado de proceso
        CURSOR cuLDCI_ESTAPROC IS
            SELECT *
              FROM LDCI_ESTAPROC
             WHERE PROCCODI = nuestaproc;

        --cursor del mensaje de procesamiento
        CURSOR cuMesaproc IS
            SELECT *
              FROM LDCI_MESAPROC
             WHERE MESAPROC = nuestaproc;

        -- cursor del XML de parametros
        CURSOR cuPARAMETROS (clXML IN VARCHAR2)
        IS
                 SELECT PARAMETROS.*
                   FROM XMLTABLE (
                            '/PARAMETROS/PARAMETRO'
                            PASSING XMLType (clXML)
                            COLUMNS row_num     FOR ORDINALITY,
                                    "NOMBRE"    VARCHAR2 (300) PATH 'NOMBRE',
                                    "VALOR"     VARCHAR2 (300) PATH 'VALOR')  AS PARAMETROS;

        --variables tipo registro
        reMesaProc        LDCI_MESAPROC%ROWTYPE;
        reLDCI_ESTAPROC   cuLDCI_ESTAPROC%ROWTYPE;
        reGE_PERSON       cuGE_PERSON%ROWTYPE;
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
        sbMensCorreo    VARCHAR2(4000);

    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'NOTIFICARPROCESOORDENES' , cnuNVLTRC );
        
        sbMensaje :=
            'Finalizo el procesamiento de ordenes de lectura para el ciclo.';

        /*
          OBTENER MENSAJES
        */

        --determina el usuario que esta realizando la operacion
        OPEN cuGE_PERSON (SA_BOUSER.fnuGetUserId (UT_SESSION.GETUSER));

        FETCH cuGE_PERSON INTO reGE_PERSON;

        CLOSE cuGE_PERSON;

        OPEN cuLDCI_ESTAPROC;

        FETCH cuLDCI_ESTAPROC INTO reLDCI_ESTAPROC;

        CLOSE cuLDCI_ESTAPROC;

        /*
          ENVIAR CORREO
        */
        IF (reGE_PERSON.E_MAIL IS NOT NULL OR reGE_PERSON.E_MAIL <> '')
        THEN

            -- genera el cuerpo del correo
            sbMensCorreo := sbMensCorreo  ||   '<html><body>';
            sbMensCorreo := sbMensCorreo  ||  
                                  '<table  border="1px" width="100%">';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  || '<td colspan="2"><h1>Estado del proceso<h1></td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Identificador</b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td>' || reLDCI_ESTAPROC.PROCCODI || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Fecha inicio</b></td>';
            sbMensCorreo := sbMensCorreo  ||  '<td>'
                || TO_CHAR (reLDCI_ESTAPROC.PROCFEIN, 'DD/MM/YYYY HH:MM:SS')
                || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Fecha final</b></td>';
            sbMensCorreo := sbMensCorreo  ||   
                   '<td>'
                || TO_CHAR (reLDCI_ESTAPROC.PROCFEFI, 'DD/MM/YYYY HH:MM:SS')
                || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Usuario</b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td>' || reLDCI_ESTAPROC.PROCUSUA || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Terminal</b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td>' || reLDCI_ESTAPROC.PROCTERM || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Programa</b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td>' || reLDCI_ESTAPROC.PROCPROG || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Estado [R=Registrado P=procesando, F=Finalizado]</b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td>' || reLDCI_ESTAPROC.PROCESTA || '</td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '</table>';

            -- lee los datos de consulta
            sbMensCorreo := sbMensCorreo  ||  
                                  '<table  border="1px" width="100%">';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||
                '<td colspan="2"><h2>Datos de procesamiento<h2></td>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Parametro<b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Valor<b></td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '</body></html>';

            -- recorre el XML de parametros
            FOR rePARAMETROS IN cuPARAMETROS (reLDCI_ESTAPROC.PROCPARA)
            LOOP
                sbMensCorreo := sbMensCorreo  ||   '<tr>';
                sbMensCorreo := sbMensCorreo  ||   '<td>' || rePARAMETROS.NOMBRE || '</td>';
                sbMensCorreo := sbMensCorreo  ||   '<td>' || rePARAMETROS.VALOR || '</td>';
                sbMensCorreo := sbMensCorreo  ||   '</tr>';
            END LOOP;

            sbMensCorreo := sbMensCorreo  ||   '</table>';

            -- lee los mensajes del proceso
            sbMensCorreo := sbMensCorreo  ||  
                                  '<table  border="1px" width="100%">';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td colspan="3"><h2>Mensajes de procesamiento<h2></td>';
            sbMensCorreo := sbMensCorreo  ||   '<tr>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Consecutivo del mensaje<b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Mensaje<b></td>';
            sbMensCorreo := sbMensCorreo  ||   '<td><b>Tipo [E Error, I Informacion, W Advertencia, S Satisfactorio]<b></td>';
            sbMensCorreo := sbMensCorreo  ||   '</tr>';
            sbMensCorreo := sbMensCorreo  ||   '</body></html>';

            -- recorre los mensajes
            FOR reMesaProc IN cuMesaproc
            LOOP
                sbMensCorreo := sbMensCorreo  ||   '<tr>';
                sbMensCorreo := sbMensCorreo  ||   '<td>' || reMesaProc.MESACODI || '</td>';
                sbMensCorreo := sbMensCorreo  ||   '<td>' || reMesaProc.MESADESC || '</td>';
                sbMensCorreo := sbMensCorreo  ||   '<td>' || reMesaProc.MESATIPO || '</td>';
                sbMensCorreo := sbMensCorreo  ||   '</tr>';
            END LOOP;

            sbMensCorreo := sbMensCorreo  ||   '</table>';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => reGE_PERSON.E_MAIL,
                isbAsunto           => 'Notificacion de envio de ordenes a sistema externo',
                isbMensaje          => sbMensCorreo
            );
                    
        ELSE
            sbMensaje :=
                   'El usuario '
                || reGE_PERSON.PERSON_ID
                || '-'
                || reGE_PERSON.NAME_
                || ' no tiene configurado el correo electronico.';
                
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electronico ('
                || reGE_PERSON.NAME_
                || ')',
                isbMensaje          => sbMensaje
            );
                
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'NOTIFICARPROCESOORDENES' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Traza.Trace (
                   'Error enviado correo: '
                || SQLERRM
                || '.'
                || DBMS_UTILITY.format_error_backtrace,
                cnuNVLTRC);
    END NOTIFICARPROCESOORDENES;

    PROCEDURE PROLIMPIARTEMPORALES
    AS
    BEGIN
        
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROLIMPIARTEMPORALES' , cnuNVLTRC );
            
        DELETE FROM LDCI_ACTIVIDADORDEN;

        DELETE FROM LDCI_ORDEN;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROLIMPIARTEMPORALES' , cnuNVLTRC );
        
    END PROLIMPIARTEMPORALES;

    PROCEDURE PROCESARORDENESLECTURATRANSAC (
        inuOperatingUnitId     IN     NUMBER,
        inuGeograLocationId    IN     NUMBER,
        inuConsCycleId         IN     NUMBER,
        Inuoperatingsectorid   IN     NUMBER,
        inuRouteId             IN     NUMBER,
        Idtinitialdate         IN     DATE,
        Idtfinaldata           IN     DATE,
        Inutasktypeid          IN     NUMBER,
        inuOrderStatusId       IN     NUMBER,
        Onuerrorcode              OUT NUMBER,
        Osberrormsg               OUT VARCHAR2)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.PROCESARORDENESLECTURATRANSAC
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Paquete de integracion de ordenes de lectura

          Historia de Modificaciones
          Autor                                   Fecha      Descripcion
             carlosvl<carlos.virgen@olsoftware.com> 07-02-2014 #NC-87252: Manejo del numero de registros por lote mediante un parametro del sistema
        */
        -- variables para la asignacion del cursor
        TYPE refRegistros IS REF CURSOR;

        Recregistros             Refregistros;
        -- atributos del cursor de ordenes
        Nuorder_Id               Ldci_Orden.Order_Id%TYPE;
        Nutask_Type_Id           Ldci_Orden.Task_Type_Id%TYPE;
        Nuorder_Status_Id        Ldci_Orden.Order_Status_Id%TYPE;
        Nuaddress_Id             Ldci_Orden.Address_Id%TYPE;
        Sbaddress                Ldci_Orden.Address%TYPE;
        Nugeogra_Location_Id     Ldci_Orden.Geogra_Location_Id%TYPE;
        Nuneighborthood          Ldci_Orden.Neighborthood%TYPE;
        Nuoper_Sector_Id         Ldci_Orden.Oper_Sector_Id%TYPE;
        Nuroute_Id               Ldci_Orden.Route_Id%TYPE;
        Nuconsecutive            Ldci_Orden.Consecutive%TYPE;
        Nupriority               Ldci_Orden.Priority%TYPE;
        Dtassigned_Date          Ldci_Orden.Assigned_Date%TYPE;
        Dtarrange_Hour           Ldci_Orden.Arrange_Hour%TYPE;
        Dtcreated_Date           Ldci_Orden.Created_Date%TYPE;
        Dtexec_Estimate_Date     Ldci_Orden.Exec_Estimate_Date%TYPE;
        dtMax_Date_To_Legalize   LDCI_ORDEN.Max_Date_To_Legalize%TYPE;

        -- variables para el manejo del procesameinto
        nuLotes                  NUMBER (4) := 0;
        nuRegistrosLote          NUMBER (4) := 0;
        sbRegistrosLote          LDCI_CARASEWE.CASEDESE%TYPE;
        nuContadorRows           NUMBER (4) := 0;
        nuLote                   NUMBER := 1;
        nuTransac                NUMBER := 0;
        cantOrds                 NUMBER := 0;
        cantActs                 NUMBER := 0;
        nuCantActs               NUMBER := 0;
        OnuFLAFPROCESO           NUMBER := 0;
        nuMesacodi               LDCI_MESAPROC.MESACODI%TYPE;
        isbParametros            VARCHAR2 (2000);
        nuFlagGeneral            NUMBER := 0;

        errorPara01              EXCEPTION;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROCESARORDENESLECTURATRANSAC' , cnuNVLTRC );
            
        isbParametros :=
               '<Parametros>
                        <parametro>
                            <nombre>OperatingUnitId</nombre>
                            <valor>'
            || inuOperatingUnitId
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>GeograLocationId</nombre>
                            <valor>'
            || inuGeograLocationId
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>ConsCycleId</nombre>
                            <valor>'
            || inuConsCycleId
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>operatingsectorid</nombre>
                            <valor>'
            || Inuoperatingsectorid
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>RouteId</nombre>
                            <valor>'
            || inuRouteId
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>initialdate</nombre>
                            <valor>'
            || Idtinitialdate
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>finaldata</nombre>
                            <valor>'
            || Idtfinaldata
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>tasktypeid</nombre>
                            <valor>'
            || Inutasktypeid
            || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>OrderStatusId</nombre>
                            <valor>'
            || inuOrderStatusId
            || '</valor>
                        </parametro>
                    </Parametros>
                    ';
        /* CREAR TRANSACCION  */
        LDCI_PKMESAWS.proCreaEstaProc (
            'WS_ENVIO_ORDENES',
            isbParametros,
            CURRENT_DATE,
            'P',
            SYS_CONTEXT ('USERENV', 'CURRENT_USER'),
            NULL,
            NULL,
            nuTransac,
            Onuerrorcode,
            Osberrormsg);

        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_ENVIO_ORDENES',
                                            'NRO_REG_LOTE',
                                            sbRegistrosLote,
                                            OSBERRORMSG);

        IF (OSBERRORMSG != '0')
        THEN
            RAISE errorPara01;
        ELSE
            nuRegistrosLote := TO_NUMBER (sbRegistrosLote);
        END IF;                                  --if(OSBERRORMSG != '0') then

        IF Onuerrorcode = 0
        THEN
            /* CARGAR ORDENES */
            OS_GETWORKORDERS (Inuoperatingunitid,
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

            IF Onuerrorcode = 0
            THEN
                /* CARGAR PERSISTIR ORDEN */
                LOOP
                    FETCH Recregistros
                        INTO Nuorder_Id,
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

                    EXIT WHEN Recregistros%NOTFOUND;

                    LDCI_PKVALIDASIGELEC.PROVALIDAORDEN (
                        nuTransac,
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

                    IF OnuFLAFPROCESO = 0
                    THEN
                        INSERT INTO LDCI_ORDEN (Order_Id,
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
                             VALUES (Nuorder_Id,
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
                        PROCESOACTIVIDADESORDEN (nuOrder_Id,
                                                 nuCantActs,
                                                 nuTransac,
                                                 OnuFLAFPROCESO);

                        IF OnuFLAFPROCESO = 0
                        THEN
                            cantActs := cantActs + nuCantActs;
                            nuContadorRows := nuContadorRows + 1;

                            IF nuContadorRows = nuRegistrosLote
                            THEN
                                nuContadorRows := 0;
                                nuLote := nuLote + 1;
                            END IF;
                        ELSE
                            nuFlagGeneral := 1;
                            LDCI_PKMESAWS.proCreaMensProc (
                                nuTransac,
                                   'No se validaron satisfacotiriamente las actividades de la orden: '
                                || nuOrder_Id,
                                'E',
                                CURRENT_DATE,
                                nuMesacodi,
                                Onuerrorcode,
                                Osberrormsg);
                        END IF;
                    END IF;

                    COMMIT;
                END LOOP;

                IF nuFlagGeneral = 0
                THEN
                    /*Definir cuantos paquetes se generaron*/
                    nuLotes := CEIL (Recregistros%ROWCOUNT / nuRegistrosLote);

                    pkg_Traza.Trace (
                           nuTransac
                        || ' '
                        || nuLotes
                        || ' '
                        || cantOrds
                        || ' '
                        || cantacts,
                        15);
                    LDCI_PKMESAWS.proCreaMensProc (
                        nuTransac,
                        'Cantidad de Lotes: ' || nuLotes,
                        'I',
                        CURRENT_DATE,
                        nuMesacodi,
                        ONUERRORCODE,
                        OSBERRORMSG);

                    LDCI_PKMESAWS.proCreaMensProc (
                        nuTransac,
                        'Cantidad de Ordenes: ' || cantOrds,
                        'I',
                        CURRENT_DATE,
                        nuMesacodi,
                        ONUERRORCODE,
                        OSBERRORMSG);

                    LDCI_PKMESAWS.proCreaMensProc (
                        nuTransac,
                        'Cantidad Actividades: ' || cantacts,
                        'I',
                        CURRENT_DATE,
                        nuMesacodi,
                        ONUERRORCODE,
                        OSBERRORMSG);

                    CLOSE Recregistros;

                    IF nuLotes > 0
                    THEN
                        FOR contador IN 1 .. nuLotes
                        LOOP
                            /*
                              GENERAR PAYLOADS POR LOTE
                            */
                            pkg_Traza.Trace (
                                   'Creando payload lote : '
                                || contador
                                || ' de '
                                || nuLotes,
                                15);
                            PROGENERARPAYLOADSORDENES (nuTransac,
                                                       contador,
                                                       nuLotes,
                                                       Onuerrorcode,
                                                       Osberrormsg);

                            IF Onuerrorcode != 0
                            THEN
                                LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                                               Osberrormsg,
                                                               'E',
                                                               CURRENT_DATE,
                                                               nuMesacodi,
                                                               Onuerrorcode,
                                                               Osberrormsg);
                            END IF;
                        END LOOP;

                        -- actualiza el proceso
                        LDCI_PKMESAWS.PROACTUESTAPROC (nuTransac,
                                                       CURRENT_DATE,
                                                       'R',
                                                       Onuerrorcode,
                                                       Osberrormsg);
                    ELSE
                        -- crea un mensaje de excepcion
                        LDCI_PKMESAWS.PROCREAMENSPROC (
                            nuTransac,
                            'La cantidad de lotes no es valida ',
                            'E',
                            CURRENT_DATE,
                            nuMesacodi,
                            Onuerrorcode,
                            Osberrormsg);
                    END IF;
                ELSE
                    Osberrormsg := 'No puede generar payloads. ';
                    LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                                   Osberrormsg,
                                                   'E',
                                                   CURRENT_DATE,
                                                   nuMesacodi,
                                                   Onuerrorcode,
                                                   Osberrormsg);
                END IF;

                Osberrormsg := 'Finalizo el procesamiento de ordenes. ';
                LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                               Osberrormsg,
                                               'I',
                                               CURRENT_DATE,
                                               nuMesacodi,
                                               Onuerrorcode,
                                               Osberrormsg);

                COMMIT;

                /*
                  ENVIAR NOTIFICACION
                */
                pkg_Traza.Trace('Antes de enviar correo: ' ,15);

                NOTIFICARPROCESOORDENES (nuTransac);
                LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                               'Se envio correo electronico',
                                               'I',
                                               CURRENT_DATE,
                                               nuMesacodi,
                                               Onuerrorcode,
                                               Osberrormsg);
                pkg_Traza.Trace('despues de enviar correo: ' ,15);

                /*
                  LIMPIAR TABLA TEMPORAL
                */
                PROLIMPIARTEMPORALES;
                COMMIT;
            ELSE
                /*
                  GUARDAR MENSAJE
                */
                LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                               Osberrormsg,
                                               'E',
                                               CURRENT_DATE,
                                               nuMesacodi,
                                               Onuerrorcode,
                                               Osberrormsg);

                /*
                 ENVIAR NOTIFICACION
                */
                pkg_Traza.Trace ('Antes de enviar correo: ', 15);
                NOTIFICARPROCESOORDENES (nuTransac);
                pkg_Traza.Trace ('despues de enviar correo: ', 15);
            END IF;
        ELSE
            /*
              NO CREO EL PROCESO
            */
            pkg_error.setErrorMessage ( isbMsgErrr => Osberrormsg);
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROCESARORDENESLECTURATRANSAC' , cnuNVLTRC );
        
    EXCEPTION
        WHEN Errorpara01
        THEN
            ONUERRORCODE := -1;
            OSBERRORMSG :=
                   'ERROR: <LDCI_TEMPPKGESTLEGAORDEN.PROCESARORDENESLECTURATRANSAC>: Error en carga de parametros: '
                || OSBERRORMSG;
            LDCI_PKMESAWS.proCreaMensProc (nuTransac,
                                           OSBERRORMSG,
                                           'E',
                                           CURRENT_DATE,
                                           nuMesacodi,
                                           Onuerrorcode,
                                           Osberrormsg);
            PROLIMPIARTEMPORALES;
            COMMIT;
        WHEN OTHERS
        THEN
            LDCI_PKMESAWS.proCreaMensProc (
                nuTransac,
                   'ERROR: '
                || SQLERRM
                || '. '
                || DBMS_UTILITY.Format_Error_Backtrace,
                'E',
                CURRENT_DATE,
                nuMesacodi,
                Onuerrorcode,
                Osberrormsg);
            PROLIMPIARTEMPORALES;
            COMMIT;
    END PROCESARORDENESLECTURATRANSAC;

    PROCEDURE PROLEGALIZARORDEN (ISBDATAORDER    IN     VARCHAR2,
                                 IDTINITDATE     IN     DATE,
                                 IDTFINALDATE    IN     DATE,
                                 IDTCHANGEDATE   IN     DATE,
                                 Resultado          OUT NUMBER,
                                 Msj                OUT VARCHAR2)
    AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.PROLEGALIZARORDEN
       AUTOR      : Mauricio Ortiz
       FECHA      : 15-01-2013
       RICEF      : I015
       DESCRIPCION: Paquete de integracion de ordenes de lectura, permite legalizar ordenes de lectura

      Historia de Modificaciones
      Autor   Fecha   Descripcion
    */
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROLEGALIZARORDEN' , cnuNVLTRC );
            
        api_legalizeorders (ISBDATAORDER,
                           IDTINITDATE,
                           IDTFINALDATE,
                           IDTCHANGEDATE,
                           Resultado,
                           Msj);

        IF Resultado = 0
        THEN
            COMMIT;
            Msj := 'Legalizo correctamente';
        ELSE
            pkg_Traza.Trace ('Rollback: ' || Resultado || ' - ' || Msj, cnuNVLTRC);
            ROLLBACK;
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROLEGALIZARORDEN' , cnuNVLTRC );
        
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
    END PROLEGALIZARORDEN;

    PROCEDURE PROCESOORDENES
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.PROCESOORDENES
           AUTOR      : Mauricio Ortiz
           FECHA      : 15-01-2013
           RICEF      : I015
           DESCRIPCION: Procedimeinto usado en el proceso en BATCH PBPIO

          Historia de Modificaciones
          Autor   Fecha   Descripcion
        */

        cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126;
        inuOperatingUnitId           NUMBER := -1;
        inuGeograLocationId          NUMBER := -1;
        inuConsCycleId               NUMBER;
        Inuoperatingsectorid         NUMBER := -1;
        inuRouteId                   NUMBER := -1;
        Idtinitialdate               DATE;
        Idtfinaldata                 DATE;
        Inutasktypeid                NUMBER := -1;
        inuOrderStatusId             NUMBER := 5;
        Onuerrorcode                 NUMBER;
        Osberrormsg                  VARCHAR2 (2000);
        sbOPERATING_UNIT_ID          ge_boInstanceControl.stysbValue;
        sbCOCICICL                   ge_boInstanceControl.stysbValue;
        sbTASK_TYPE_ID               ge_boInstanceControl.stysbValue;
        nuUserID                     SA_USER.USER_ID%TYPE;
        nuPersonID                   ge_person.person_id%TYPE;
        
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROCESOORDENES' , cnuNVLTRC );
            
        sbOPERATING_UNIT_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT',
                                                   'OPERATING_UNIT_ID');
        sbCOCICICL :=
            ge_boInstanceControl.fsbGetFieldValue ('CONCCICL', 'COCICICL');
        sbTASK_TYPE_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_TASK_TYPES_ITEMS',
                                                   'TASK_TYPE_ID');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        IF (sbTASK_TYPE_ID IS NULL)
        THEN
            pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Tipo de Trabajo');
        END IF;

        inuOperatingUnitId := NVL (TO_NUMBER (sbOPERATING_UNIT_ID), 0);
        inuConsCycleId := NVL (TO_NUMBER (sbCOCICICL), 0);
        Inutasktypeid := NVL (TO_NUMBER (sbTASK_TYPE_ID), 0);

        nuUserID := sa_bouser.fnuGetUserId (ut_session.getuser);
        nuPersonID := GE_BCPerson.fnuGetFirstPersonByUserId (nuUserID);

        pkg_Traza.Trace (
            'Inicia PROCESARORDENESLECTURATRANSAC ' || ut_session.getuser,
            15);
        pkg_Traza.Trace ('USER ID ' || nuUserID, 15);
        pkg_Traza.Trace ('PERSON ID ' || nuPersonID, 15);

        PROCESARORDENESLECTURATRANSAC (inuOperatingUnitId,
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
        pkg_Traza.Trace (
               'Finaliza PROCESARORDENESLECTURATRANSAC. '
            || Onuerrorcode
            || ' - '
            || Osberrormsg,
            15);
            

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROCESOORDENES' , cnuNVLTRC );
            
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END PROCESOORDENES;

    PROCEDURE PROSETFILEAT (inuActivity       IN     NUMBER,
                            isbFileName       IN     VARCHAR2,
                            isbObservation    IN     VARCHAR2,
                            icbFileSrc        IN     CLOB,
                            onuErrorCode         OUT NUMBER,
                            osbErrorMessage      OUT VARCHAR2)
    AS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           PROCEDIMIENTO : LDCI_TEMPPKGESTLEGAORDEN.PROSETFILEAT
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
        ibbFileSrc                  BLOB := EMPTY_BLOB ();

        -- excepciones
        exce_OS_LOADFILETOREADING   EXCEPTION; -- manejo de excepciones del API OS_LOADFILETOREADING

        FUNCTION fcbClobToBlob (p_clob_in IN CLOB)
            RETURN BLOB
        IS
            v_blob             BLOB;
            v_offset           INTEGER;
            v_buffer_varchar   VARCHAR2 (32000);
            v_buffer_raw       RAW (32000);
            v_buffer_size      BINARY_INTEGER := 32000;
        BEGIN

            pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'fcbClobToBlob' , cnuNVLTRC );
            
            IF p_clob_in IS NULL
            THEN
                RETURN NULL;
            END IF;

            --
            DBMS_LOB.createtemporary (v_blob, TRUE);
            v_offset := 1;

            FOR i
                IN 1 .. CEIL (DBMS_LOB.getlength (p_clob_in) / v_buffer_size)
            LOOP
                DBMS_LOB.read (p_clob_in,
                               v_buffer_size,
                               v_offset,
                               v_buffer_varchar);
                v_buffer_raw := HEXTORAW (v_buffer_varchar);
                DBMS_LOB.writeappend (v_blob,
                                      UTL_RAW.LENGTH (v_buffer_raw),
                                      v_buffer_raw);
                v_offset := v_offset + v_buffer_size;
            END LOOP;

            pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'fcbClobToBlob' , cnuNVLTRC );
            
            RETURN v_blob;
        END fcbClobToBlob;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PROSETFILEAT' , cnuNVLTRC );
                
        -- convierte el texto HEX en BLOB
        ibbFileSrc := fcbClobToBlob (icbFileSrc);

        -- hace el llamado al API icbFileSrc
        OS_LOADFILETOREADING (inuActivity,
                              isbFileName,
                              isbObservation,
                              ibbFileSrc,
                              onuErrorCode,
                              osbErrorMessage);

        IF (onuErrorCode <> 0)
        THEN
            RAISE exce_OS_LOADFILETOREADING;
        ELSE
            -- libera el espacio temporal
            DBMS_LOB.freetemporary (ibbFileSrc);
            COMMIT;
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PROSETFILEAT' , cnuNVLTRC );
                
    EXCEPTION
        WHEN exce_OS_LOADFILETOREADING
        THEN
            ROLLBACK;
        WHEN OTHERS
        THEN
            ROLLBACK;
            onuErrorCode := SQLCODE;
            osbErrorMessage :=
                   'ERROR: [PROSETFILEAT.Exception.others]: Error no controlado : '
                || CHR (13)
                || SQLERRM
                || ' | '
                || DBMS_UTILITY.Format_Error_Backtrace;
    END PROSETFILEAT;

    PROCEDURE proLegalizaOrdenes
    AS
        /*
         * Propiedad Intelectual Gases de Occidente SA ESP
         *
         * Script  : LDCI_TEMPPKGESTLEGAORDEN.proLegalizaLoteOrdenes
         * Tiquete : I058 Provision de consumo
         * Autor   : OLSoftware / Carlos E. Virgen Londono
         * Fecha   : 24/06/2013
         * Descripcion : Registra la informacion de la provision de consumo en la tabla IC_MOVIMIEN
         *
         * Parametros:
          * IN: iclXMLOrdenes: Codigo del elemento de medicion
                        <!-- mensaje para el paquete de integracion -->
                        <!-- nuevo diseño -->
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
        **/
        -- definicion de variables
        onuMessageCode         NUMBER;
        osbMessageText         VARCHAR2 (2000);
        boExcepcion            BOOLEAN;

        nuCodMensajeLega       NUMBER;
        sbMensajeLega          VARCHAR2 (2000);

        sbCASECODI             LDCI_CARASEWE.CASEDESE%TYPE := 'WS_ENVIO_ORDENES';

        -- variables para el manejo del proceso LDCI_ESTAPROC
        cbPROCPARA             LDCI_ESTAPROC.PROCPARA%TYPE;
        nuPROCCODI             LDCI_ESTAPROC.PROCCODI%TYPE;
        nuORDEN                LDCI_ORDENESALEGALIZAR.order_id%TYPE;
        sbEstOrden             LDCI_ORDENESALEGALIZAR.state%TYPE;
        -- variables para la creacion de los mensajes LDCI_MESAENVWS
        nuMESACODI             LDCI_MESAENVWS.MESACODI%TYPE;

        -- definicion de cursores
        --cursor que extrae la informacion del XML de entrada
        CURSOR cuORDENES IS
            SELECT *
              FROM LDCI_ORDENESALEGALIZAR
             WHERE STATE IN ('P'
                                );

        -- excepciones
        excep_PROCARASERVWEB   EXCEPTION;
        excep_ESTAPROC         EXCEPTION;

        /*
        * NC:    Validacion de ordenes ya legalizada
        * Autor: Hector Fabio Dominguez
        * Fecha: 18-12-2013
        */

        sbMensajeValidaOrd     VARCHAR2 (1000);

        sbEstaOrdenGest        Ldci_Ordenmoviles.Estado_Envio%TYPE;
        sbProcesoLegaOk        VARCHAR2 (1);
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proLegalizaOrdenes' , cnuNVLTRC );
            
        -- inicializa el mensaje de salida
        onuMessageCode := 0;
        osbMessageText := NULL;
        boExcepcion := FALSE;

        -- realiza la creacion del proceso
        cbPROCPARA := '	<PARAMETROS>
																<PARAMETRO>
																		<NOMBRE>iclXMLOrdenes</NOMBRE>
																		<VALOR>iclXMLOrdenes</VALOR>
																</PARAMETRO>
															</PARAMETROS>';

        LDCI_PKMESAWS.PROCREAESTAPROC (ISBPROCDEFI       => sbCASECODI,
                                       ICBPROCPARA       => cbProcPara,
                                       IDTPROCFEIN       => SYSDATE,
                                       ISBPROCESTA       => 'P',
                                       ISBPROCUSUA       => NULL,
                                       ISBPROCTERM       => NULL,
                                       ISBPROCPROG       => NULL,
                                       ONUPROCCODI       => nuPROCCODI,
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (onuMessageCode <> 0)
        THEN
            RAISE excep_ESTAPROC;
        END IF;

        -- Recorre el listado de ordenes a legalziar
        FOR reLISTA_ORDENES IN cuORDENES
        LOOP
            onuMessageCode := 0;
            osbMessageText := NULL;
            sbProcesoLegaOk := NULL;

            nuCodMensajeLega := 0;
            sbMensajeLega := NULL;

            nuORDEN := reLISTA_ORDENES.ORDER_ID;

            -- Llama el API de lagalizacion de Ordenes
            api_legalizeorders (reLISTA_ORDENES.DATAORDER,
                               TO_DATE (reLISTA_ORDENES.INITDATE 
                                                                ),
                               TO_DATE (reLISTA_ORDENES.FINALDATE 
                                                                 ),
                               TO_DATE (reLISTA_ORDENES.CHANGEDATE 
                                                                  ),
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

            IF (onuMessageCode = 2582)
            THEN
                /*
                * Validamos Si la orden se encuentra legalizada
                */
                IF LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega (
                       nuORDEN,
                       sbMensajeValidaOrd) =
                   1
                THEN
                    /*
                    * Si la orden se encuentra legalizada
                    * entonces reasignamos a 0 para que el mensaje
                    * sea considerado como exitoso
                    */
                    onuMessageCode := 0;
                    osbMessageText :=
                        'ORDEN LEGALIZADA PREVIAMENTE' || osbMessageText;
                ELSE
                    /*
                    * En caso de que no este legalizada, agregamos la traza al mensaje
                    * para que se guarde posteriormente
                    */
                    osbMessageText :=
                        osbMessageText || ' ' || sbMensajeValidaOrd;
                END IF;
            END IF;

            nuCodMensajeLega := onuMessageCode;
            sbMensajeLega := osbMessageText;

            --valida el mensaje de salida de la orden
            IF (onuMessageCode = 0)
            THEN
                sbMensajeLega :=
                       'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> '
                    || osbMessageText;

                LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                    INUMESAPROC       => nuPROCCODI,
                    ISBMESATIPO       => 'I',
                    INUERROR_LOG_ID   => nuCodMensajeLega,
                    ISBMESADESC       => sbMensajeLega,
                    ISBMESAVAL1       => TO_CHAR (nuORDEN),
                    ISBMESAVAL2       => NULL,
                    ISBMESAVAL3       => NULL,
                    ISBMESAVAL4       => NULL,
                    IDTMESAFECH       => SYSDATE,
                    ONUMESACODI       => nuMESACODI,
                    ONUERRORCODE      => onuMessageCode,
                    OSBERRORMESSAGE   => osbMessageText);

                sbEstOrden := 'L';
                sbEstaOrdenGest := 'G';

                sbProcesoLegaOk := 'S';
            ELSE
                boExcepcion := TRUE;

                sbMensajeLega :=
                       'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> '
                    || osbMessageText;

                LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                    INUMESAPROC       => nuPROCCODI,
                    ISBMESATIPO       => 'E',
                    INUERROR_LOG_ID   => nuCodMensajeLega,
                    ISBMESADESC       => sbMensajeLega,
                    ISBMESAVAL1       => TO_CHAR (nuORDEN),
                    ISBMESAVAL2       => NULL,
                    ISBMESAVAL3       => NULL,
                    ISBMESAVAL4       => NULL,
                    IDTMESAFECH       => SYSDATE,
                    ONUMESACODI       => nuMESACODI,
                    ONUERRORCODE      => onuMessageCode,
                    OSBERRORMESSAGE   => osbMessageText);
                sbEstOrden := 'G';
                sbEstaOrdenGest := 'F';

                sbProcesoLegaOk := 'N';
            END IF;

            proActualizaEstado (nuORDEN,
                                nuCodMensajeLega,
                                sbMensajeLega,
                                sbEstOrden);
            LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada (
                inuOrden          => nuORDEN,
                isbEstado         => sbEstaOrdenGest
                                                    ,
                onuErrorCode      => onuMessageCode,
                osbErrorMessage   => osbMessageText);

            IF NVL (sbProcesoLegaOk, 'N') = 'S'
            THEN
                COMMIT;
            ELSE
                ROLLBACK;
            END IF;

        END LOOP;

        -- finaliza el procesamiento
        LDCI_PKMESAWS.PROACTUESTAPROC (INUPROCCODI       => nuPROCCODI,
                                       IDTPROCFEFI       => SYSDATE,
                                       ISBPROCESTA       => 'F',
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (boExcepcion = FALSE)
        THEN
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'Proceso ha terminado satisfactoriamente.',
                ISBMESATIPO       => 'S',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proLegalizaOrdenes' , cnuNVLTRC );
        
    EXCEPTION
        WHEN excep_ESTAPROC
        THEN
            LDCI_pkWebServUtils.Procrearerrorlogint ('proLegalizaOrdenes',
                                                     1,
                                                     osbMessageText,
                                                     NULL,
                                                     NULL);
        WHEN OTHERS
        THEN
            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'SQLCODE: ' || SQLCODE || ' : ' || SQLERRM,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       =>
                    'TRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            ROLLBACK;
    END proLegalizaOrdenes;

    PROCEDURE proLegalizaOrdenesSistema (
        isbSistema   ldci_ordenesalegalizar.SYSTEM%TYPE)
    AS
        /* -------------------------------------------------------------------------------------------------------------------------------------------------------
         Propiedad Intelectual Gases del Caribe SA ESP
         Nombre  : LDCI_TEMPPKGESTLEGAORDEN.proLegalizaLoteOrdenes
         Autor   : Eduardo Aguera
         Fecha   : 28/12/2017
         Descripcion : Basado en proLegalizaOrdenes. Se crea para independizar la legalizacion de ordenes por sistema.

         Historial de modificaciones
         Autor                    Fecha         Descripcion
         Eduardo Aguera           28/12/2017    Creacion del procedimiento en el dia de los inocentes ;)
         LJLB                     29/10/2019    CA 193 se coloca validacion del sistema para ver si se ejecuta por hilo o no
        -------------------------------------------------------------------------------------------------------------------------------------------------------**/
        --definicion de variables
        onuMessageCode         NUMBER;
        osbMessageText         VARCHAR2 (2000);
        boExcepcion            BOOLEAN;
        nuCodMensajeLega       NUMBER;
        sbMensajeLega          VARCHAR2 (2000);

        sbCASECODI             LDCI_CARASEWE.CASEDESE%TYPE := 'WS_ENVIO_ORDENES';

        -- variables para el manejo del proceso LDCI_ESTAPROC
        cbPROCPARA             LDCI_ESTAPROC.PROCPARA%TYPE;
        nuPROCCODI             LDCI_ESTAPROC.PROCCODI%TYPE;
        nuORDEN                LDCI_ORDENESALEGALIZAR.order_id%TYPE;
        sbEstOrden             LDCI_ORDENESALEGALIZAR.state%TYPE;
        -- variables para la creacion de los mensajes LDCI_MESAENVWS
        nuMESACODI             LDCI_MESAENVWS.MESACODI%TYPE;

        -- definicion de cursores
        CURSOR cuORDENES IS
              SELECT order_id,
                     SYSTEM,
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
                FROM LDCI_ORDENESALEGALIZAR
               WHERE state = 'P' AND SYSTEM = isbSistema
            ORDER BY changedate ASC;

        -- excepciones
        excep_PROCARASERVWEB   EXCEPTION;
        excep_ESTAPROC         EXCEPTION;

        sbMensajeValidaOrd     VARCHAR2 (1000);

        sbEstaOrdenGest        Ldci_Ordenmoviles.Estado_Envio%TYPE;
        sbProcesoLegaOk        VARCHAR2 (1);

        --- registro para guardar los datos
        TYPE tyrcDataRecord IS RECORD
        (
            Order_Id            LDCI_ORDENESALEGALIZAR.Order_Id%TYPE,
            SYSTEM              LDCI_ORDENESALEGALIZAR.SYSTEM%TYPE,
            dataorder           LDCI_ORDENESALEGALIZAR.dataorder%TYPE,
            initdate            LDCI_ORDENESALEGALIZAR.initdate%TYPE,
            finaldate           LDCI_ORDENESALEGALIZAR.finaldate%TYPE,
            changedate          LDCI_ORDENESALEGALIZAR.changedate%TYPE,
            messagecode         LDCI_ORDENESALEGALIZAR.messagecode%TYPE,
            messagetext         LDCI_ORDENESALEGALIZAR.messagetext%TYPE,
            state               LDCI_ORDENESALEGALIZAR.state%TYPE,
            fecha_recepcion     LDCI_ORDENESALEGALIZAR.fecha_recepcion%TYPE,
            fecha_procesado     LDCI_ORDENESALEGALIZAR.fecha_procesado%TYPE,
            fecha_notificado    LDCI_ORDENESALEGALIZAR.fecha_notificado%TYPE,
            veces_procesado     LDCI_ORDENESALEGALIZAR.veces_procesado%TYPE
        );


        TYPE tytbDataTable IS TABLE OF tyrcDataRecord
            INDEX BY BINARY_INTEGER;

        reLISTA_ORDENES        tytbDataTable;

        sbSistperm             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCSISTPERMI'); --se almacena listado de sistemas
        nuEjeHilo              NUMBER := 0; --se almacena si el proceso se ejecuta por hilo o no
        nuHilproc              NUMBER;
        nuError                NUMBER;

    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proLegalizaOrdenesSistema' , cnuNVLTRC );
            
        --parametro para obtener el codigo del servicio de gas
        -- inicializa el mensaje de salida
        onuMessageCode := 0;
        osbMessageText := NULL;
        boExcepcion := FALSE;

        -- realiza la creacion del proceso
        cbPROCPARA := '	<PARAMETROS>
                                <PARAMETRO>
                                    <NOMBRE>iclXMLOrdenes</NOMBRE>
                                    <VALOR>iclXMLOrdenes</VALOR>
                                </PARAMETRO>
                              </PARAMETROS>';

        LDCI_PKMESAWS.PROCREAESTAPROC (ISBPROCDEFI       => sbCASECODI,
                                       ICBPROCPARA       => cbProcPara,
                                       IDTPROCFEIN       => SYSDATE,
                                       ISBPROCESTA       => 'P',
                                       ISBPROCUSUA       => NULL,
                                       ISBPROCTERM       => NULL,
                                       ISBPROCPROG       => NULL,
                                       ONUPROCCODI       => nuPROCCODI,
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (onuMessageCode <> 0)
        THEN
            RAISE excep_ESTAPROC;
        END IF;

        SELECT COUNT (1)
          INTO nuEjeHilo
          FROM (    SELECT REGEXP_SUBSTR (sbSistperm,
                                          '[^,]+',
                                          1,
                                          LEVEL)    AS sistema
                      FROM DUAL
                CONNECT BY REGEXP_SUBSTR (sbSistperm,
                                          '[^,]+',
                                          1,
                                          LEVEL)
                               IS NOT NULL) d
         WHERE d.sistema = isbSistema;


        --se valdia si se ejecuta proceso por hilo
        IF nuEjeHilo > 0
        THEN
            --se valida que no se este procesando los hilos
            SELECT COUNT (1)
              INTO nuHilproc
              FROM LDC_TEMJOBLEGA, dba_jobs
             WHERE job = CODIGO_JOB;

            IF nuHilproc = 0
            THEN
                PRLEGALIZAOTSISTXHILOS (isbSistema,
                                        nuPROCCODI,
                                        onuMessageCode,
                                        osbMessageText);

                --Si se genera error se registra
                IF onuMessageCode <> 0
                THEN
                    LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                        INUMESAPROC       => nuPROCCODI,
                        ISBMESATIPO       => 'E',
                        INUERROR_LOG_ID   => onuMessageCode,
                        ISBMESADESC       => osbMessageText,
                        ISBMESAVAL1       => TO_CHAR (nuORDEN),
                        ISBMESAVAL2       => NULL,
                        ISBMESAVAL3       => NULL,
                        ISBMESAVAL4       => NULL,
                        IDTMESAFECH       => SYSDATE,
                        ONUMESACODI       => nuMESACODI,
                        ONUERRORCODE      => onuMessageCode,
                        OSBERRORMESSAGE   => osbMessageText);
                    boExcepcion := TRUE;
                    ROLLBACK;
                ELSE
                    --se consulta si hubo error
                    SELECT COUNT (1)
                      INTO nuError
                      FROM LDCI_MESAPROC
                     WHERE MESAPROC = nuPROCCODI AND MESATIPO = 'E';

                    IF nuError > 0
                    THEN
                        boExcepcion := TRUE;
                    END IF;
                END IF;
            END IF;
        ELSE
            -- Recorre el listado de ordenes a legalizar
            OPEN cuORDENES;

            LOOP
                FETCH cuORDENES BULK COLLECT INTO reLISTA_ORDENES LIMIT 1000;

                FOR i IN 1 .. reLISTA_ORDENES.COUNT
                LOOP
                    onuMessageCode := 0;
                    osbMessageText := NULL;
                    sbProcesoLegaOk := NULL;

                    nuCodMensajeLega := 0;
                    sbMensajeLega := NULL;

                    nuORDEN := reLISTA_ORDENES (i).ORDER_ID;

                    -- Llama el API de lagalizacion de Ordenes
                    api_legalizeorders (
                        reLISTA_ORDENES (i).DATAORDER,
                        TO_DATE (reLISTA_ORDENES (i).INITDATE 
                                                             ),
                        TO_DATE (reLISTA_ORDENES (i).FINALDATE 
                                                              ),
                        TO_DATE (reLISTA_ORDENES (i).CHANGEDATE 
                                                               ),
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

                    IF (onuMessageCode = 2582)
                    THEN
                        /*
                        * Validamos Si la orden se encuentra legalizada
                        */
                        IF LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega (
                               nuORDEN,
                               sbMensajeValidaOrd) =
                           1
                        THEN
                            /*
                            * Si la orden se encuentra legalizada
                            * entonces reasignamos a 0 para que el mensaje
                            * sea considerado como exitoso
                            */
                            onuMessageCode := 0;
                            osbMessageText :=
                                   'ORDEN LEGALIZADA PREVIAMENTE'
                                || osbMessageText;
                        ELSE
                            /*
                            * En caso de que no este legalizada, agregamos la traza al mensaje
                            * para que se guarde posteriormente
                            */
                            osbMessageText :=
                                osbMessageText || ' ' || sbMensajeValidaOrd;
                        END IF;
                    END IF;

                    nuCodMensajeLega := onuMessageCode;
                    sbMensajeLega := osbMessageText;

                    --valida el mensaje de salida de la orden
                    IF (onuMessageCode = 0)
                    THEN
                        sbMensajeLega :=
                               'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> '
                            || osbMessageText;

                        LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                            INUMESAPROC       => nuPROCCODI,
                            ISBMESATIPO       => 'I',
                            INUERROR_LOG_ID   => nuCodMensajeLega, --onuMessageCode,
                            ISBMESADESC       => sbMensajeLega, --'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                            ISBMESAVAL1       => TO_CHAR (nuORDEN),
                            ISBMESAVAL2       => NULL,
                            ISBMESAVAL3       => NULL,
                            ISBMESAVAL4       => NULL,
                            IDTMESAFECH       => SYSDATE,
                            ONUMESACODI       => nuMESACODI,
                            ONUERRORCODE      => onuMessageCode,
                            OSBERRORMESSAGE   => osbMessageText);

                        sbEstOrden := 'L';
                        sbEstaOrdenGest := 'G';

                        sbProcesoLegaOk := 'S';
                    ELSE
                        boExcepcion := TRUE;

                        sbMensajeLega :=
                               'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> '
                            || osbMessageText;

                        LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                            INUMESAPROC       => nuPROCCODI,
                            ISBMESATIPO       => 'E',
                            INUERROR_LOG_ID   => nuCodMensajeLega, --onuMessageCode,
                            ISBMESADESC       => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                            ISBMESAVAL1       => TO_CHAR (nuORDEN),
                            ISBMESAVAL2       => NULL,
                            ISBMESAVAL3       => NULL,
                            ISBMESAVAL4       => NULL,
                            IDTMESAFECH       => SYSDATE,
                            ONUMESACODI       => nuMESACODI,
                            ONUERRORCODE      => onuMessageCode,
                            OSBERRORMESSAGE   => osbMessageText);
                        sbEstOrden := 'G';
                        sbEstaOrdenGest := 'F';

                        sbProcesoLegaOk := 'N';
                    END IF;

                    proActualizaEstado (nuORDEN,
                                        nuCodMensajeLega,
                                        sbMensajeLega,
                                        sbEstOrden);
                    LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada (
                        inuOrden          => nuORDEN,
                        isbEstado         => sbEstaOrdenGest
                                                            ,
                        onuErrorCode      => onuMessageCode,
                        osbErrorMessage   => osbMessageText);

                    IF NVL (sbProcesoLegaOk, 'N') = 'S'
                    THEN
                        COMMIT;
                    ELSE
                        ROLLBACK;
                    END IF;
                    
                END LOOP;

                EXIT;
            END LOOP;

            CLOSE cuORDENES;
        END IF;

        -- finaliza el procesamiento
        LDCI_PKMESAWS.PROACTUESTAPROC (INUPROCCODI       => nuPROCCODI,
                                       IDTPROCFEFI       => SYSDATE,
                                       ISBPROCESTA       => 'F',
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (boExcepcion = FALSE)
        THEN
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'Proceso ha terminado satisfactoriamente.',
                ISBMESATIPO       => 'S',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);
        END IF;
        
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proLegalizaOrdenesSistema' , cnuNVLTRC );
        
    EXCEPTION
        WHEN excep_ESTAPROC
        THEN
            LDCI_pkWebServUtils.Procrearerrorlogint ('proLegalizaOrdenes',
                                                     1,
                                                     osbMessageText,
                                                     NULL,
                                                     NULL);
        WHEN OTHERS
        THEN
            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'SQLCODE: ' || SQLCODE || ' : ' || SQLERRM,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       =>
                    'TRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            ROLLBACK;
    END proLegalizaOrdenesSistema;

    PROCEDURE proLegalizaOrdenesSistemaCiclo (
        isbSistema   ldci_ordenesalegalizar.SYSTEM%TYPE,
        isbCicl      NUMBER,
        isbCiclFin   NUMBER)
    AS
        /* -------------------------------------------------------------------------------------------------------------------------------------------------------
         Propiedad Intelectual Gases del Caribe SA ESP
         Nombre  : LDCI_TEMPPKGESTLEGAORDEN.proLegalizaLoteOrdenes
         Autor   : Eduardo Aguera
         Fecha   : 28/12/2017
         Descripcion : Basado en proLegalizaOrdenes. Se crea para independizar la legalizacion de ordenes por sistema.

         Historial de modificaciones
         Autor                    Fecha         Descripcion
         Eduardo Aguera           28/12/2017    Creacion del procedimiento en el dia de los inocentes ;)
         LJLB                     29/10/2019      CA 193 se registra proceso de estaprog y se envia correo
         jbrito                   27/12/2020      ca 492,Se modifica los cursores cuORDENES y cuORDENESCant eliminando el ROWNUM
                                                  y se agregar el rango desde el campo Ciclo inicial hasta el Ciclo Final
                                                  Se aplicar la funcionalidad BULK COLLECT
        -------------------------------------------------------------------------------------------------------------------------------------------------------**/
        --definicion de variables
        onuMessageCode         NUMBER;
        osbMessageText         VARCHAR2 (2000);
        boExcepcion            BOOLEAN;
        nuCodMensajeLega       NUMBER;
        sbMensajeLega          VARCHAR2 (2000);

        sbCASECODI             LDCI_CARASEWE.CASEDESE%TYPE := 'WS_ENVIO_ORDENES';

        -- variables para el manejo del proceso LDCI_ESTAPROC
        cbPROCPARA             LDCI_ESTAPROC.PROCPARA%TYPE;
        nuPROCCODI             LDCI_ESTAPROC.PROCCODI%TYPE;
        nuORDEN                LDCI_ORDENESALEGALIZAR.order_id%TYPE;
        sbEstOrden             LDCI_ORDENESALEGALIZAR.state%TYPE;
        -- variables para la creacion de los mensajes LDCI_MESAENVWS
        nuMESACODI             LDCI_MESAENVWS.MESACODI%TYPE;

        -- definicion de cursores
        --cursor que extrae la informacion del XML de entrada
        CURSOR cuORDENES IS
            SELECT a.order_id,
                   a.SYSTEM,
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
              FROM LDCI_ORDENESALEGALIZAR a, or_order_activity ac, servsusc
             WHERE     a.state = 'P'
                   AND a.SYSTEM = 'WS_SIGELEC'
                   AND ac.order_id = a.order_id
                   AND ac.product_id = sesunuse
                   AND sesucicl BETWEEN isbCicl AND isbCiclFin;

        --cursor que extrae la informacion del XML de entrada
        CURSOR cuORDENESCant IS
            SELECT COUNT (1)
              FROM LDCI_ORDENESALEGALIZAR a, or_order_activity ac, servsusc
             WHERE     a.state = 'P'
                   AND a.SYSTEM = 'WS_SIGELEC'
                   AND ac.order_id = a.order_id
                   AND ac.product_id = sesunuse
                   AND sesucicl BETWEEN isbCicl AND isbCiclFin;

        -- excepciones
        excep_PROCARASERVWEB   EXCEPTION;
        excep_ESTAPROC         EXCEPTION;

        sbMensajeValidaOrd     VARCHAR2 (1000);

        sbEstaOrdenGest        Ldci_Ordenmoviles.Estado_Envio%TYPE;
        sbProcesoLegaOk        VARCHAR2 (1);
        --INICIO CA 193
        seq_estaprog           NUMBER;                 --Se almacena secuencia
        nuTotal                NUMBER := 0;
        nuProcesados           NUMBER := 0;
        --sbAplicaEntr           VARCHAR2 (1) := 'N';
        sbprograma             VARCHAR2 (100) := 'LDCLEGOTLEC';
        nuexisteproc           NUMBER;
        sbSender               VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
        sbEmail                VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDCDESTILEGOTLEC');
        --FIN CA 193
        nuNumLote              NUMBER
            := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_PARNUMLOTEORD'); -- CA 492

        --- registro para guardar los datos
        TYPE tyrcDataRecord IS RECORD
        (
            Order_Id            LDCI_ORDENESALEGALIZAR.Order_Id%TYPE,
            SYSTEM              LDCI_ORDENESALEGALIZAR.SYSTEM%TYPE,
            dataorder           LDCI_ORDENESALEGALIZAR.dataorder%TYPE,
            initdate            LDCI_ORDENESALEGALIZAR.initdate%TYPE,
            finaldate           LDCI_ORDENESALEGALIZAR.finaldate%TYPE,
            changedate          LDCI_ORDENESALEGALIZAR.changedate%TYPE,
            messagecode         LDCI_ORDENESALEGALIZAR.messagecode%TYPE,
            messagetext         LDCI_ORDENESALEGALIZAR.messagetext%TYPE,
            state               LDCI_ORDENESALEGALIZAR.state%TYPE,
            fecha_recepcion     LDCI_ORDENESALEGALIZAR.fecha_recepcion%TYPE,
            fecha_procesado     LDCI_ORDENESALEGALIZAR.fecha_procesado%TYPE,
            fecha_notificado    LDCI_ORDENESALEGALIZAR.fecha_notificado%TYPE,
            veces_procesado     LDCI_ORDENESALEGALIZAR.veces_procesado%TYPE
        );

        TYPE tytbDataTable IS TABLE OF tyrcDataRecord
            INDEX BY BINARY_INTEGER;

        reLISTA_ORDENES        tytbDataTable;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proLegalizaOrdenesSistemaCiclo' , cnuNVLTRC );
            
        --se valida si hay algun proceso en ejecucion
        SELECT COUNT (1)
          INTO nuexisteproc
          FROM ESTAPROG
         WHERE     ESPRPROG LIKE '%LDCLEGOTLEC%'
               AND ESPRFEFI IS NULL
               AND (   ESPRFEFI IS NULL
                    OR ROUND ((SYSDATE - ESPRFEIN) * 24, 0) >= 24);

        --si existe proceso en ejecucion se lanza error
        IF nuexisteproc > 0
        THEN
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'Existe actualmente un proceso LDCLEGOTLEC en ejecucion');
        END IF;

        seq_estaprog := sqesprprog.NEXTVAL;

        sbprograma := sbprograma || seq_estaprog;

        --se valida cantidad de registros
        OPEN cuORDENESCant;

        FETCH cuORDENESCant INTO nuTotal;

        CLOSE cuORDENESCant;

        -- Calcula el numero de registros a procesar y se usa para insertar
        -- el registro en estaprog. smunozSAO213266
        pkstatusexeprogrammgr.addrecord (
            sbprograma,
            'Calculando Registros a Procesar ...',
            0);

        pkgeneralservices.committransaction;
        -- Inserta el registro de seguimiento del proceso en ESTAPROG
        pkstatusexeprogrammgr.updateestaprogat (
            sbprograma,
            'Proceso en Ejecuccion..',
            nuTotal,
            NULL);
        -- Aisenta en la base de datos el registro de seguimiento de la ejecucion del Proceso
        pkgeneralservices.committransaction;
 
        -- inicializa el mensaje de salida
        onuMessageCode := 0;
        osbMessageText := NULL;
        boExcepcion := FALSE;

        -- realiza la creacion del proceso
        cbPROCPARA := '	<PARAMETROS>
																<PARAMETRO>
																		<NOMBRE>iclXMLOrdenes</NOMBRE>
																		<VALOR>iclXMLOrdenes</VALOR>
																</PARAMETRO>
															</PARAMETROS>';

        LDCI_PKMESAWS.PROCREAESTAPROC (ISBPROCDEFI       => sbCASECODI,
                                       ICBPROCPARA       => cbProcPara,
                                       IDTPROCFEIN       => SYSDATE,
                                       ISBPROCESTA       => 'P',
                                       ISBPROCUSUA       => NULL,
                                       ISBPROCTERM       => NULL,
                                       ISBPROCPROG       => NULL,
                                       ONUPROCCODI       => nuPROCCODI,
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (onuMessageCode <> 0)
        THEN
            RAISE excep_ESTAPROC;
        END IF;                                --if (onuMessageCode <> 0) then

        -- Recorre el listado de ordenes a legalizar
        OPEN cuORDENES;

        LOOP
            FETCH cuORDENES BULK COLLECT INTO reLISTA_ORDENES LIMIT nuNumLote;

            FOR i IN 1 .. reLISTA_ORDENES.COUNT
            LOOP
                -- for reLISTA_ORDENES in cuORDENES loop
                onuMessageCode := 0;
                osbMessageText := NULL;
                sbProcesoLegaOk := NULL;

                nuCodMensajeLega := 0;
                sbMensajeLega := NULL;

                nuORDEN := reLISTA_ORDENES (i).ORDER_ID;

                -- Llama el API de lagalizacion de Ordenes
                api_legalizeorders (reLISTA_ORDENES (i).DATAORDER,
                                   TO_DATE (reLISTA_ORDENES (i).INITDATE 
                                                                        ),
                                   TO_DATE (reLISTA_ORDENES (i).FINALDATE 
                                                                         ),
                                   TO_DATE (reLISTA_ORDENES (i).CHANGEDATE 
                                                                          ),
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

                IF (onuMessageCode = 2582)
                THEN
                    /*
                    * Validamos Si la orden se encuentra legalizada
                    */
                    IF LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega (
                           nuORDEN,
                           sbMensajeValidaOrd) =
                       1
                    THEN
                        /*
                        * Si la orden se encuentra legalizada
                        * entonces reasignamos a 0 para que el mensaje
                        * sea considerado como exitoso
                        */
                        onuMessageCode := 0;
                        osbMessageText :=
                            'ORDEN LEGALIZADA PREVIAMENTE' || osbMessageText;
                    ELSE
                        /*
                        * En caso de que no este legalizada, agregamos la traza al mensaje
                        * para que se guarde posteriormente
                        */
                        osbMessageText :=
                            osbMessageText || ' ' || sbMensajeValidaOrd;
                    END IF;
                END IF;

                nuCodMensajeLega := onuMessageCode;
                sbMensajeLega := osbMessageText;

                --valida el mensaje de salida de la orden
                IF (onuMessageCode = 0)
                THEN
                    sbMensajeLega :=
                           'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> '
                        || osbMessageText;

                    LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                        INUMESAPROC       => nuPROCCODI,
                        ISBMESATIPO       => 'I',
                        INUERROR_LOG_ID   => nuCodMensajeLega,
                        ISBMESADESC       => sbMensajeLega,
                        ISBMESAVAL1       => TO_CHAR (nuORDEN),
                        ISBMESAVAL2       => NULL,
                        ISBMESAVAL3       => NULL,
                        ISBMESAVAL4       => NULL,
                        IDTMESAFECH       => SYSDATE,
                        ONUMESACODI       => nuMESACODI,
                        ONUERRORCODE      => onuMessageCode,
                        OSBERRORMESSAGE   => osbMessageText);

                    sbEstOrden := 'L';
                    sbEstaOrdenGest := 'G';
                    
                    sbProcesoLegaOk := 'S';
                ELSE
                    boExcepcion := TRUE;

                    sbMensajeLega :=
                           'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> '
                        || osbMessageText;

                    LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                        INUMESAPROC       => nuPROCCODI,
                        ISBMESATIPO       => 'E',
                        INUERROR_LOG_ID   => nuCodMensajeLega, --onuMessageCode,
                        ISBMESADESC       => sbMensajeLega, --'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,
                        ISBMESAVAL1       => TO_CHAR (nuORDEN),
                        ISBMESAVAL2       => NULL,
                        ISBMESAVAL3       => NULL,
                        ISBMESAVAL4       => NULL,
                        IDTMESAFECH       => SYSDATE,
                        ONUMESACODI       => nuMESACODI,
                        ONUERRORCODE      => onuMessageCode,
                        OSBERRORMESSAGE   => osbMessageText);
                    sbEstOrden := 'G';
                    sbEstaOrdenGest := 'F';

                    sbProcesoLegaOk := 'N';
                END IF;

                proActualizaEstado (nuORDEN,
                                    nuCodMensajeLega,
                                    sbMensajeLega,
                                    sbEstOrden);
                LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada (
                    inuOrden          => nuORDEN,
                    isbEstado         => sbEstaOrdenGest
                                                        ,
                    onuErrorCode      => onuMessageCode,
                    osbErrorMessage   => osbMessageText);

                IF NVL (sbProcesoLegaOk, 'N') = 'S'
                THEN
                    COMMIT;
                ELSE
                    ROLLBACK;
                END IF;

                IF MOD (nuprocesados, 20) = 0
                THEN
                    Pkstatusexeprogrammgr.Upstatusexeprogramat (
                        sbprograma,
                        'Proceso en ejecucion...',
                        nuTotal,
                        nuprocesados);
                    Pkgeneralservices.Committransaction;
                END IF;

                nuprocesados := nuprocesados + 1;

            END LOOP;

            EXIT WHEN cuORDENES%NOTFOUND;

        END LOOP;

        CLOSE cuORDENES; --for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

        -- finaliza el procesamiento
        LDCI_PKMESAWS.PROACTUESTAPROC (INUPROCCODI       => nuPROCCODI,
                                       IDTPROCFEFI       => SYSDATE,
                                       ISBPROCESTA       => 'F',
                                       ONUERRORCODE      => onuMessageCode,
                                       OSBERRORMESSAGE   => osbMessageText);

        IF (boExcepcion = FALSE)
        THEN
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'Proceso ha terminado satisfactoriamente.',
                ISBMESATIPO       => 'S',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);
        END IF;                                --if (boExcepcion = false) then

        pkstatusexeprogrammgr.upstatusexeprogramat (
            isbprog         => sbprograma,
            isbmens         => 'Proceso Finalizado',
            inutotalreg     => nuTotal,
            inucurrentreg   => nuprocesados);

        pkstatusexeprogrammgr.processfinishok (sbprograma);

        --se envia correo
        IF sbEmail IS NOT NULL
        THEN
  
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbSender,
                isbDestinatarios    => sbEmail,
                isbAsunto           => 'Finalizacion proceso PRIORIZACION DE ORDENES DE LECTURA POR CICLO',
                isbMensaje          => 'Buen dia, '
                                    || '<br>'
                                    || '<br>'
                                    || 'Se informa que se ha finalizado el proceso de PRIORIZACION DE ORDENES DE LECTURA POR CICLO ejecutado a las '
                                    || TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS')
                                    || ' por el usuario '
                                    || USER
                                    || ' - '
                                    || Dage_Person.Fsbgetname_ (ge_bopersonal.fnugetpersonid, NULL)
            );
                               
                                            
        END IF;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proLegalizaOrdenesSistemaCiclo' , cnuNVLTRC );
                
    EXCEPTION
        WHEN excep_ESTAPROC
        THEN
            LDCI_pkWebServUtils.Procrearerrorlogint ('proLegalizaOrdenes',
                                                     1,
                                                     osbMessageText,
                                                     NULL,
                                                     NULL);

            ROLLBACK;
            Pkstatusexeprogrammgr.Processfinishnok (sbprograma,
                                                    osbMessageText);
            COMMIT;
        WHEN OTHERS
        THEN
            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'SQLCODE: ' || SQLCODE || ' : ' || SQLERRM,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       =>
                    'TRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            ROLLBACK;

            Pkstatusexeprogrammgr.Processfinishnok (sbprograma,
                                                    osbMessageText);
            COMMIT;

    END proLegalizaOrdenesSistemaCiclo;

    PROCEDURE proInsLoteOrdenesALegalizar (iclXMLOrdenes IN CLOB)
    AS
        /*
         * Propiedad Intelectual Gases de Occidente SA ESP
         *
         * Script  : LDCI_TEMPPKGESTLEGAORDEN.proInsLoteOrdenesALegalizar
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
        CURSOR cuLISTA_ORDENES (clXML IN CLOB)
        IS
                        SELECT ORDENES.*
                          FROM XMLTABLE (
                                   'ORDER_LIST/ORDER'
                                   PASSING XMLType (clXML)
                                   COLUMNS "ORDER_ID"         NUMBER PATH 'ORDER_ID',
                                           "SYSTEM"           VARCHAR2 (30) PATH 'SYSTEM',
                                           "ISBDATAORDER"     VARCHAR2 (4000) PATH 'ISBDATAORDER',
                                           "IDTINITDATE"      VARCHAR2 (21) PATH 'IDTINITDATE',
                                           "IDTFINALDATE"     VARCHAR2 (21) PATH 'IDTFINALDATE',
                                           "IDTCHANGEDATE"    VARCHAR2 (21) PATH 'IDTCHANGEDATE')                                                                         AS   ORDENES;

        -- Cursor para verificar si la orden ya existe en la tabla de legalizaciones
        CURSOR cuExisteOrden (inuOrdenId IN NUMBER)
        IS
            SELECT Order_Id, SYSTEM, State
              FROM Ldci_OrdenesALegalizar
             WHERE Order_Id = inuOrdenId;

        -- Variables
        rgExisteOrden                cuExisteOrden%ROWTYPE;

        --#20150119: jesusv: Se crea variable para registrar logs
        sbComentarios                Ldci_Logs_Integraciones.Comentarios%TYPE;
        nuSecuencia                  NUMBER;
        nuRegistros                  NUMBER;
        exExcep                      EXCEPTION;

        dtChangeDate                 DATE;
        sbMensajeValSys              VARCHAR2 (3200);
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proInsLoteOrdenesALegalizar' , cnuNVLTRC );
            
        sbComentarios := NULL;
        nuRegistros := 0;

        proCreaLogIntegra (iclXMLOrdenes,
                           sbComentarios,
                           nuRegistros,
                           nuSecuencia);


        -- Recorre el listado de ordenes a legalziar
        FOR reLISTA_ORDENES IN cuLISTA_ORDENES (iclXMLOrdenes)
        LOOP
            nuRegistros := NVL (nuRegistros, 0) + 1;

            -- Ingresa Ordenes a Legalizar
            rgExisteOrden := NULL;

            OPEN cuExisteOrden (reLista_Ordenes.Order_Id);

            FETCH cuExisteOrden INTO rgExisteOrden;

            CLOSE cuExisteOrden;

            dtChangeDate :=
                fdtValidaSystem (reLista_Ordenes.SYSTEM,
                                 reLista_Ordenes.idtChangeDate,
                                 sbMensajeValSys);

            IF rgExisteOrden.Order_Id IS NULL
            THEN
                BEGIN
                    INSERT INTO Ldci_OrdenesALegalizar (Order_Id,
                                                        SYSTEM,
                                                        DataOrder,
                                                        InitDate,
                                                        FinalDate,
                                                        ChangeDate,
                                                        MessageCode,
                                                        MessageText,
                                                        State,
                                                        Fecha_Recepcion
                                                                       )
                         VALUES (reLista_Ordenes.Order_Id,
                                 reLista_Ordenes.SYSTEM,
                                 reLista_Ordenes.isbDataOrder,
                                 TO_DATE (reLista_Ordenes.idtInitDate 
                                                                     ),
                                 TO_DATE (reLista_Ordenes.idtFinalDate 
                                                                      ),
                                 TO_DATE (dtChangeDate /*-200-1200 To_Date(reLista_Ordenes.idtChangeDate, 'YYYY-MM-DD HH24:MI:SS'*/
                                                      ),
                                 NULL,
                                 NULL,
                                 'P',
                                 SYSDATE
                                        );
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbComentarios :=
                            SUBSTR (sbComentarios || ' >> ' || SQLERRM,
                                    1,
                                    4000);
                        RAISE exExcep;
                END;
            ELSE

                IF rgExisteOrden.State IN ('G', 'EN')
                THEN
                    BEGIN
                        UPDATE Ldci_OrdenesALegalizar
                           SET SYSTEM = reLista_Ordenes.SYSTEM,
                               DataOrder = reLista_Ordenes.isbDataOrder,
                               InitDate =
                                   TO_DATE (reLista_Ordenes.idtInitDate 
                                                                       ),
                               FinalDate =
                                   TO_DATE (reLista_Ordenes.idtFinalDate 
                                                                        ),
                               ChangeDate = TO_DATE (dtChangeDate 
                                                                 ),
                               MessageCode = NULL,
                               MessageText = NULL,
                               State = 'P',
                               Fecha_Recepcion = SYSDATE
                         WHERE Order_Id = reLista_Ordenes.Order_Id;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            sbComentarios :=
                                SUBSTR (sbComentarios || ' >> ' || SQLERRM,
                                        1,
                                        4000);
                            RAISE exExcep;
                    END;
                END IF;
            END IF;
        END LOOP;

        proActuLogIntegra (nuSecuencia,
                           NVL (sbComentarios, 'OK'),
                           nuRegistros);

        COMMIT;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proInsLoteOrdenesALegalizar' , cnuNVLTRC );
                
    EXCEPTION
        WHEN exExcep
        THEN
            proActuLogIntegra (nuSecuencia, sbComentarios, nuRegistros);
            Raise_Application_Error (
                -20100,
                   '[LDCI_TEMPPKGESTLEGAORDEN.proInsLoteOrdenesALegalizar]: '
                || sbComentarios);
        WHEN OTHERS
        THEN
            proActuLogIntegra (nuSecuencia, SQLERRM, nuRegistros);
            RAISE_APPLICATION_ERROR (
                -20100,
                   '[LDCI_TEMPPKGESTLEGAORDEN.proInsLoteOrdenesALegalizar.others]:'
                || CHR (13)
                || ' SQLCODE '
                || SQLCODE
                || ' | SQLERRM '
                || SQLERRM);
            ROLLBACK;
    END proInsLoteOrdenesALegalizar;

    PROCEDURE proActualizaEstado (
        inuOrden         IN ldci_ordenesalegalizar.order_id%TYPE,
        inuMessageCode   IN ldci_ordenesalegalizar.messagecode%TYPE,
        isbMessageText   IN ldci_ordenesalegalizar.messagetext%TYPE,
        isbstate         IN ldci_ordenesalegalizar.state%TYPE)
    IS
        /*
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
           FUNCION    : LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega
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
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proActualizaEstado' , cnuNVLTRC );
            
        UPDATE LDCI_ORDENESALEGALIZAR
           SET MESSAGECODE = NVL (inuMessageCode, MESSAGECODE),
               MESSAGETEXT = NVL (isbMessageText, MESSAGETEXT),
               state = isbstate,
               Fecha_Procesado =
                   DECODE (isbstate,
                           'L', SYSDATE,
                           'G', SYSDATE,
                           Fecha_Procesado),
               Fecha_Notificado =
                   DECODE (isbstate,
                           'N', SYSDATE,
                           'EN', SYSDATE,
                           Fecha_Notificado),
               Veces_Procesado =
                   DECODE (isbstate,
                           'L', NVL (Veces_Procesado, 0) + 1,
                           'G', NVL (Veces_Procesado, 0) + 1,
                           NVL (Veces_Procesado, 0))
         WHERE order_id = inuOrden;

        COMMIT;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proActualizaEstado' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END proActualizaEstado;

    PROCEDURE proNotificaOrdenesLegalizadas
    AS
        /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          PROCEDIMIENTO : LDCI_TEMPPKGESTLEGAORDEN.proNotificaOrdenesLegalizadas
          AUTOR      : OLSoftware / Carlos E. Virgen <carlos.virgen@olsoftware.com>
          FECHA      : 19/05/2015
          RICEF      : I001
          DESCRIPCION: Notifica las ordenes legaladas.

         Historia de Modificaciones
         Autor                    Fecha        Descripcion
         JESUS VIVERO (LUDYCOM)   30-01-2015   #20150130: jesusv: Se corrige cursor de ordenes notificadas en XML para asegurar actualizar el estado de las que pasaron por XML a PI
        */

        -- define variables
        nuTransac            NUMBER;
        nuMesacodi           LDCI_MESAENVWS.MESACODI%TYPE;
        onuErrorCode         NUMBER := 0;
        osbErrorMessage      VARCHAR2 (4000);
        sbSistNoti           LDCI_CARASEWE.CASEDESE%TYPE;

        --Variables mensajes SOAP
        L_Payload            CLOB;
        qryCtx               DBMS_XMLGEN.ctxHandle;

        -- cursor de la configuracion de los sistemas por tipo de trabajo
        CURSOR cuLDCI_TEMPPKGESTLEGAORDEN IS
            SELECT DISTINCT SISTEMA_ID
              FROM LDCI_SISTMOVILTIPOTRAB;
              
        CURSOR cuLdci_OrdenesALegalizar (isbXMLDat IN CLOB)
        IS
              SELECT Datos.Orden
                FROM XMLTABLE ('/RAIZ/orden'
                               PASSING XMLType (isbXMLDat)
                               COLUMNS Orden    NUMBER PATH 'numOrden')  As Datos;

        errorPara01          EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi   EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP   EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

        sbEstTipoNotif       Ldci_OrdenesALegalizar.State%TYPE; -- Define el estado en tipo de notificacion (N=Notificada, EN= Error Notificado)

        sbEstadoOrden        Ldci_Ordenesalegalizar.State%TYPE; --#20150130: jesusv: Se crea variable para estado de legalizacion
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'proNotificaOrdenesLegalizadas' , cnuNVLTRC );
            
        --Recorre la configuracion
        FOR reLDCI_TEMPPKGESTLEGAORDEN IN cuLDCI_TEMPPKGESTLEGAORDEN
        LOOP
            sbSistNoti := reLDCI_TEMPPKGESTLEGAORDEN.SISTEMA_ID || '_RESLEG';

            proCargaVarGlobal (sbSistNoti);

            IF (LDCI_TEMPPKGESTLEGAORDEN.sbUrlWS IS NOT NULL)
            THEN
                -- Genera el mensaje XML
                Qryctx :=
                    DBMS_XMLGEN.Newcontext (
                        'select SYSTEM      as "sistema",
                                                 ORDER_ID    as "numOrden",
                                                 MESSAGECODE as "codError",
                                                 MESSAGETEXT as "msjError"
                                          from LDCI_ORDENESALEGALIZAR
                                          where STATE in (''L'',''G'')
                                          and SYSTEM = :isbSISTEMA_ID');

                DBMS_XMLGEN.setNullHandling (qryCtx, 2);
                DBMS_XMLGEN.setRowSetTag (
                    Qryctx,
                    LDCI_TEMPPKGESTLEGAORDEN.sbInputMsgType);
                DBMS_XMLGEN.setRowTag (qryCtx, 'orden');
                DBMS_XMLGEN.setBindvalue (
                    qryCtx,
                    'isbSISTEMA_ID',
                    reLDCI_TEMPPKGESTLEGAORDEN.SISTEMA_ID);

                l_payload := DBMS_XMLGEN.getXML (qryCtx);

                --Valida si proceso registrosa
                IF (DBMS_XMLGEN.getNumRowsProcessed (qryCtx) = 0)
                THEN
                    DBMS_XMLGEN.closeContext (qryCtx);
                ELSE
                    DBMS_XMLGEN.closeContext (qryCtx);
                    L_Payload := REPLACE (L_Payload, '<?xml version="1.0"?>');
                    LDCI_PKMESAWS.proCreaMensEnvio (CURRENT_DATE,
                                                    sbSistNoti,
                                                    -1,
                                                    nuTransac,
                                                    NULL,
                                                    L_Payload,
                                                    0,
                                                    0,
                                                    nuMesacodi,
                                                    onuErrorCode,
                                                    osbErrorMessage);

                    onuErrorCode := NVL (onuErrorCode, 0);

                    IF (onuErrorCode = 0)
                    THEN
                        FOR reLdci_OrdenesALegalizar
                            IN cuLdci_OrdenesALegalizar (
                                   REPLACE (
                                       L_Payload,
                                       LDCI_TEMPPKGESTLEGAORDEN.sbInputMsgType,
                                       'RAIZ'))
                        LOOP

                            sbEstadoOrden := NULL;

                            SELECT State
                              INTO sbEstadoOrden
                              FROM Ldci_Ordenesalegalizar
                             WHERE Order_Id = reLdci_OrdenesALegalizar.Orden;

                            IF sbEstadoOrden = 'L'
                            THEN
                                sbEstTipoNotif := 'N';
                            ELSE
                                sbEstTipoNotif := 'EN';
                            END IF;

                            proActualizaEstado (
                                inuOrden         => reLDCI_ORDENESALEGALIZAR.ORDEN,
                                inuMessageCode   => NULL,
                                isbMessageText   => NULL,
                                isbstate         => sbEstTipoNotif);
                        END LOOP;
                    ELSE
                        LDCI_PKWEBSERVUTILS.Procrearerrorlogint (
                            'proNotificaOrdenesLegalizadas',
                            1,
                            osbErrorMessage,
                            NULL,
                            NULL);
                    END IF;
                END IF;
            END IF;
        END LOOP;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'proNotificaOrdenesLegalizadas' , cnuNVLTRC );
                
    EXCEPTION
        WHEN excepNoProcesoRegi
        THEN
            onuErrorCode := -1;
            osbErrorMessage :=
                'LDCI_TEMPPKGESTLEGAORDEN.proNotificaOrdenesLegalizadas.excepNoProcesoRegi]: La consulta no ha arrojo registros';
            LDCI_pkWebServUtils.Procrearerrorlogint (
                'proNotificaOrdenesLegalizadas',
                1,
                osbErrorMessage,
                NULL,
                NULL);
            ROLLBACK;
        WHEN OTHERS
        THEN
            ROLLBACK;
            onuErrorCode := SQLCODE;
            osbErrorMessage :=
                   '[LDCI_TEMPPKGESTLEGAORDEN.proNotificaOrdenesLegalizadas.others]: Error no controlado : '
                || CHR (13)
                || SQLERRM;
            LDCI_pkWebServUtils.Procrearerrorlogint (
                'proNotificaOrdenesLegalizadas',
                1,
                osbErrorMessage,
                NULL,
                NULL);
    END proNotificaOrdenesLegalizadas;

    FUNCTION fsbCadLegSinItemsSinLect 
    ( 
        inuOrden        NUMBER,
        inuCausal       NUMBER,
        inuPersona      NUMBER,
        isbComentario   VARCHAR2        
    )
    RETURN VARCHAR2
    IS
        sbCadLegSinItemsSinLect    VARCHAR2(1000);
        
        CURSOR cuActividades
        IS
        SELECT order_activity_id
        FROM or_order_activity oa
        WHERE oa.order_id = inuOrden
        AND oa.status = 'R';
        
        TYPE tytbActividades IS TABLE OF cuActividades%ROWTYPE INDEX BY BINARY_INTEGER;
       
        tbActividades tytbActividades;
        
        sbActividades   VARCHAR2(500);
        
        nuCantidad      NUMBER;
        
        nuClaseCausal   NUMBER;

        CURSOR cuClaseCausal
        IS
        SELECT ca.class_causal_id
        FROM ge_causal ca
        WHERE ca.causal_id = inuCausal;
            
    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'fsbCadenaLegalizacion' , cnuNVLTRC );
        
        OPEN cuActividades;
        FETCH cuActividades BULK COLLECT INTO tbActividades;
        CLOSE cuActividades;
        
        OPEN cuClaseCausal;
        FETCH cuClaseCausal INTO nuClaseCausal;
        CLOSE cuClaseCausal;
        
        nuCantidad := CASE WHEN nuClaseCausal = 1 then 1 ELSE 0 END;
        
        FOR ind IN 1..5 LOOP
            IF tbActividades.EXISTS(ind) THEN
                sbActividades := sbActividades || tbActividades(ind).order_activity_id || '>' || nuCantidad;
            END IF;           
            IF ind < 5 THEN
                sbActividades := sbActividades || ';';
            END IF;
        END LOOP;
        
        sbCadLegSinItemsSinLect := inuorden ||'|' ||
        inuCausal   || '|' ||
        inuPersona  || '|' ||
        ''          || '|' ||                       -- Datos Adicionales
        sbActividades || '|' ||                     -- Actividades
        '' || '|' ||                                -- ItemsElementos
        '' || '|' ||                                -- LecturasElementos            
        '1277;' || isbComentario || '|' ||              -- Comentario
        TO_CHAR(SYSDATE, 'dd-mm-yyyy hh24:mi:ss') || ';' || TO_CHAR(SYSDATE, 'dd-mm-yyyy hh24:mi:ss');

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'fsbCadenaLegalizacion' , cnuNVLTRC );

        RETURN sbCadLegSinItemsSinLect;

    END fsbCadLegSinItemsSinLect;
        
    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procLegalizaActivity (
        inuorden          IN     or_order.order_id%TYPE,
        inuopera          IN     or_order.operating_unit_id%TYPE,
        inucausal         IN     or_order.causal_id%TYPE,
        sbcomment         IN     or_order_activity.comment_%TYPE,
        onuErrorCode      IN OUT NUMBER,
        osbErrorMessage   IN OUT VARCHAR2)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_TEMPPKGESTLEGAORDEN.procLegalizaActivity
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 27/06/2014
                 RICEF   : I085
           DESCRIPCION   : Proceso que realiza la legalizacion de ordenes por actividad.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
         KARBAQ      27/06/2014   Creacion del proceso
         jpinedc    04/06/2023     OSF-1379: * Se crea fsbCadLegSinItemsSinLect
                                    * Se usa fsbCadLegSinItemsSinLect en procLegalizaActivity
                                    * Se reemplaza os_legalizeorders por api_legalizeorders         
        **************************************************************************/
        nupack        or_order_activity.package_id%TYPE;

        sender        ld_parameter.value_chain%TYPE;
        sbcorreos     ld_parameter.value_chain%TYPE;
        nuperson      or_oper_unit_persons.person_id%TYPE;
        
        sbCadLegalizacion   VARCHAR2(1000);

        CURSOR cuOrden
        IS
        SELECT EXEC_INITIAL_DATE, EXECUTION_FINAL_DATE
        FROM or_order od
        WHERE od.order_id = inuorden;
        
        rcOrden cuOrden%ROWTYPE;
                
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'procLegalizaActivity' , cnuNVLTRC );
            
        IF dald_parameter.fblExist ('IDEN_ACCI_ESPLEG_PORTAL')
        THEN
            BEGIN
                SELECT o.person_id
                  INTO nuperson
                  FROM or_oper_unit_persons o
                 WHERE operating_unit_id = inuopera AND ROWNUM = 1;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osbErrorMessage :=
                           'Error Consultando la persona de la unidad operativa: '
                        || inuopera
                        || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                    onuErrorCode := -1;
                    pkg_Error.getError (onuErrorCode, osbErrorMessage);
            END;
            
            sbCadLegalizacion := fsbCadLegSinItemsSinLect( inuorden, inucausal, nuperson , sbcomment );
            
            pkg_Traza.Trace( 'sbCadLegalizacion[' || sbCadLegalizacion || ']' , cnuNVLTRC );            
    
            OPEN cuOrden;
            FETCH cuOrden INTO rcOrden;
            CLOSE cuOrden;
                                    
            api_legalizeorders
            (
                sbCadLegalizacion,
                rcOrden.EXEC_INITIAL_DATE,
                rcOrden.EXECUTION_FINAL_DATE,
                SYSDATE,
                onuErrorCode,
                osbErrorMessage
            );                

            --si existe error levanta mensaje
            IF onuErrorCode <> 0
            THEN
                sender :=
                    pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
                sbcorreos :=
                    pkg_BCLD_Parameter.fsbObtieneValorCadena (
                        'LDC_SMTP_RECIBE_FNB_WEB');
                                               
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sender,
                    isbDestinatarios    => sbcorreos,
                    isbAsunto           => 'Error Aprobando de venta Brilla Portal Web',
                    isbMensaje          => 'La orden '
                    || inuorden
                    || 'No se ha podido legalizar por el siguiente error : '
                    || onuErrorCode
                    || ' '
                    || 'Descripcion del error : '
                    || osbErrorMessage
                    || ' '
                    || 'Favor conultar con el administrador'
                );

                RAISE pkg_Error.CONTROLLED_ERROR;
            ELSE
                BEGIN
                    SELECT o.package_id
                      INTO nupack
                      FROM or_order_activity o
                     WHERE o.order_id = inuorden;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        pkg_Error.getError (onuErrorCode, osbErrorMessage);
                END;

                IF nupack IS NOT NULL
                THEN
                    mo_bowf_pack_interfac.PrepNotToWfPack (
                        nupack,
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                            'IDEN_ACCI_ESPLEG_PORTAL'),
                        MO_BOCausal.fnuGetSuccess,
                        MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,
                        FALSE);
                END IF;
            END IF;
        ELSE
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                   'Los parametros de configuracion '
                || 'IDEN_ACCI_ESPLEG_PORTAL'
                || ' de la accion del flujo se encuentran en blanco, favor Validar');
        END IF;

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'procLegalizaActivity' , cnuNVLTRC );
        
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
    END procLegalizaActivity;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procInstDefect (
        NUORDER_ACTIVITY_ID          or_activ_defect.order_activity_id%TYPE,
        NUDEFECT_ID                  or_activ_defect.defect_id%TYPE,
        onuErrorCode          IN OUT NUMBER,
        osbErrorMessage       IN OUT VARCHAR2)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_TEMPPKGESTLEGAORDEN.procInstArtefac
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 23/07/2014
                 RICEF   : I062,I063,I064
           DESCRIPCION   : Proceso que realiza el insert de las ordenes x artefactos.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
         KARBAQ      27/06/2014   Creacion del proceso

        **************************************************************************/
        nuseq   NUMBER;
    BEGIN

        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'procInstDefect' , cnuNVLTRC );
            
        nuseq :=
            GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE (
                'or_activ_appliance',
                'OPEN.SEQ_OR_ACTIV_DEFECT_156818');

        INSERT INTO or_activ_defect
             VALUES (nuseq, NUORDER_ACTIVITY_ID, NUDEFECT_ID);

        onuErrorCode := 0;
        osbErrorMessage := '';

        COMMIT;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'procInstDefect' , cnuNVLTRC );

    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
    END procInstDefect;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procInstArtefac (
        nuORDER_ACTIVITY_ID          or_activ_appliance.order_activity_id%TYPE,
        nuAPPLIANCE_ID               or_activ_appliance.appliance_id%TYPE,
        nuAMOUNT                     or_activ_appliance.amount%TYPE,
        onuErrorCode          IN OUT NUMBER,
        osbErrorMessage       IN OUT VARCHAR2)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_TEMPPKGESTLEGAORDEN.procInstArtefac
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 23/07/2014
                 RICEF   : I062,I063,I064
           DESCRIPCION   : Proceso que realiza el insert de las ordenes x artefactos.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
         KARBAQ      23/07/2014   Creacion del proceso

        **************************************************************************/

        nuseq   NUMBER;
    BEGIN
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'procInstArtefac' , cnuNVLTRC );
    
        nuseq :=
            GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE (
                'or_activ_appliance',
                'OPEN.SEQ_OR_ACTIV_APPLIA_156826');

        INSERT INTO or_activ_appliance
             VALUES (nuseq,
                     nuORDER_ACTIVITY_ID,
                     nuAPPLIANCE_ID,
                     nuAMOUNT);

        onuErrorCode := 0;
        osbErrorMessage := '';

        COMMIT;

        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'procInstArtefac' , cnuNVLTRC );

    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
    END procInstArtefac;

    PROCEDURE PRLEGALIZAOTSISTXHILOS (isbSistema        IN     VARCHAR2,
                                      inuProcEsta       IN     NUMBER,
                                      onuErrorCode         OUT NUMBER,
                                      osbErrorMessage      OUT VARCHAR2)
    IS
        /***************************************************************
           PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            PROCESO : PRLEGALIZAOTSISTXHILOS
            AUTOR   : Luis Javier Lopez / Horbath
            FECHA   : 29/10/2019
            DESCRIPCION   : Proceso que se encarga de llamar al proceso de legalziacion por hilo

           Parametros de Entrada
             isbSistema sistema a legalizar ordenes
             inuProcEsta  numero de proceso estaproc
           Parametros de Salida
             onuErrorCode codigo de error
             osbErrorMessage mensaje de error

           Historia de Modificaciones

           Autor        Fecha       Descripcion.
        **************************************************************************/
        nuCantHilo   NUMBER
            := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDCNUMJOBS'); --se almacena cantidad de hilos
        sbWhat       VARCHAR2 (4000);             --Se almacena accion del job
        nujob        NUMBER;                                  --numero del job
        sw           BOOLEAN;
        nuHilproc    NUMBER;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PRLEGALIZAOTSISTXHILOS' , cnuNVLTRC );
    
        --se procesa hilos
        FOR reg IN 1 .. nuCantHilo
        LOOP
            nujob := NULL;
            sbWhat :=
                   'BEGIN'
                || CHR (10)
                || '   LDCI_TEMPPKGESTLEGAORDEN.PRLEGALIZAORDENESSISTEMA_HILO('''
                || isbSistema
                || ''','
                || CHR (10)
                || nuCantHilo
                || ','
                || CHR (10)
                || reg
                || ','
                || CHR (10)
                || inuProcEsta
                || ' );'
                || CHR (10)
                || 'END;';
            pkg_Traza.Trace (sbWhat, cnuNVLTRC);
            DBMS_JOB.submit (nujob, sbWhat, SYSDATE + 1 / 3600);

            IF nujob IS NOT NULL
            THEN
                INSERT INTO LDC_TEMJOBLEGA (CODIGO_JOB,
                                            FECHA_REGISTRO,
                                            NUME_HILO)
                     VALUES (nujob, SYSDATE, reg);
            END IF;

            COMMIT;
        END LOOP;

        --se espera termine proceso
        sw := TRUE;

        WHILE sw
        LOOP
            SELECT COUNT (1)
              INTO nuHilproc
              FROM LDC_TEMJOBLEGA, dba_jobs
             WHERE job = CODIGO_JOB;

            IF nuHilproc = 0
            THEN
                sw := FALSE;
            END IF;
        END LOOP;

        --se eliminan registros
        DELETE FROM LDC_TEMJOBLEGA;

        COMMIT;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PRLEGALIZAOTSISTXHILOS' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;

            DELETE FROM LDC_TEMJOBLEGA;

            COMMIT;
            osbErrorMessage := 'Error generando Job ' || SQLERRM;
            onuErrorCode := -1;
    END PRLEGALIZAOTSISTXHILOS;

    PROCEDURE PRLEGALIZAORDENESSISTEMA_HILO (isbSistema     IN VARCHAR2,
                                             inuTotalHilo   IN NUMBER,
                                             inuHiloasig    IN NUMBER,
                                             inuProcEsta    IN NUMBER)
    IS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

          PROCESO : PRLEGALIZAORDENESSISTEMA_HILO
          AUTOR   : Luis Javier Lopez / Horbath
          FECHA   : 29/10/2019
          DESCRIPCION   : Proceso que se encarga de legalizar ordenes por hilos.

         Parametros de Entrada
           isbSistema sistema a legalizar ordenes
           inuTotalHilo  numero total de hilo
           inuHiloasig   hilo asignado
           inuProcEsta    proceso estaprog
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
        **************************************************************************/
        --definicion de variables
        onuMessageCode         NUMBER;
        osbMessageText         VARCHAR2 (2000);
        boExcepcion            BOOLEAN;
        nuCodMensajeLega       NUMBER;
        sbMensajeLega          VARCHAR2 (2000);

        -- variables para el manejo del proceso LDCI_ESTAPROC
        nuPROCCODI             LDCI_ESTAPROC.PROCCODI%TYPE;
        nuORDEN                LDCI_ORDENESALEGALIZAR.order_id%TYPE;
        sbEstOrden             LDCI_ORDENESALEGALIZAR.state%TYPE;
        -- variables para la creacion de los mensajes LDCI_MESAENVWS
        nuMESACODI             LDCI_MESAENVWS.MESACODI%TYPE;

        CURSOR cuORDENES IS
              SELECT order_id,
                     SYSTEM,
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
                FROM LDCI_ORDENESALEGALIZAR
               WHERE     state = 'P'
                     AND SYSTEM = isbSistema
                     AND MOD (order_id, inuTotalHilo) + 1 = inuHiloasig
            ORDER BY fecha_recepcion ASC;

        -- excepciones
        excep_PROCARASERVWEB   EXCEPTION;
        excep_ESTAPROC         EXCEPTION;

        sbMensajeValidaOrd     VARCHAR2 (1000);

        sbEstaOrdenGest        Ldci_Ordenmoviles.Estado_Envio%TYPE;
        sbProcesoLegaOk        VARCHAR2 (1);

        --- registro para guardar los datos
        TYPE tyrcDataRecord IS RECORD
        (
            Order_Id            LDCI_ORDENESALEGALIZAR.Order_Id%TYPE,
            SYSTEM              LDCI_ORDENESALEGALIZAR.SYSTEM%TYPE,
            dataorder           LDCI_ORDENESALEGALIZAR.dataorder%TYPE,
            initdate            LDCI_ORDENESALEGALIZAR.initdate%TYPE,
            finaldate           LDCI_ORDENESALEGALIZAR.finaldate%TYPE,
            changedate          LDCI_ORDENESALEGALIZAR.changedate%TYPE,
            messagecode         LDCI_ORDENESALEGALIZAR.messagecode%TYPE,
            messagetext         LDCI_ORDENESALEGALIZAR.messagetext%TYPE,
            state               LDCI_ORDENESALEGALIZAR.state%TYPE,
            fecha_recepcion     LDCI_ORDENESALEGALIZAR.fecha_recepcion%TYPE,
            fecha_procesado     LDCI_ORDENESALEGALIZAR.fecha_procesado%TYPE,
            fecha_notificado    LDCI_ORDENESALEGALIZAR.fecha_notificado%TYPE,
            veces_procesado     LDCI_ORDENESALEGALIZAR.veces_procesado%TYPE
        );

        TYPE tytbDataTable IS TABLE OF tyrcDataRecord
            INDEX BY BINARY_INTEGER;

        reLISTA_ORDENES        tytbDataTable;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PRLEGALIZAORDENESSISTEMA_HILO' , cnuNVLTRC );
            
        onuMessageCode := 0;
        osbMessageText := NULL;
        boExcepcion := FALSE;
        nuPROCCODI := inuProcEsta;

        OPEN cuORDENES;

        LOOP
            FETCH cuORDENES BULK COLLECT INTO reLISTA_ORDENES LIMIT 1000;

            FOR i IN 1 .. reLISTA_ORDENES.COUNT
            LOOP
                onuMessageCode := 0;
                osbMessageText := NULL;
                sbProcesoLegaOk := NULL;

                nuCodMensajeLega := 0;
                sbMensajeLega := NULL;

                nuORDEN := reLISTA_ORDENES (i).ORDER_ID;

                proActualizaEstado (inuOrden         => nuORDEN,
                                    inuMessageCode   => NULL,
                                    isbMessageText   => NULL,
                                    isbstate         => 'X');

                -- Llama el API de lagalizacion de Ordenes
                api_legalizeorders (reLISTA_ORDENES (i).DATAORDER,
                                   TO_DATE (reLISTA_ORDENES (i).INITDATE
                                                                        ),
                                   TO_DATE (reLISTA_ORDENES (i).FINALDATE
                                                                         ),
                                   TO_DATE (reLISTA_ORDENES (i).CHANGEDATE
                                                                          ),
                                   onuMessageCode,
                                   osbMessageText);

                /*
                * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden
                */

                IF (onuMessageCode = 2582)
                THEN
                    /*
                    * Validamos Si la orden se encuentra legalizada
                    */
                    IF LDCI_TEMPPKGESTLEGAORDEN.fnuValidaOrdLega (
                           nuORDEN,
                           sbMensajeValidaOrd) =
                       1
                    THEN
                        /*
                        * Si la orden se encuentra legalizada
                        * entonces reasignamos a 0 para que el mensaje
                        * sea considerado como exitoso
                        */
                        onuMessageCode := 0;
                        osbMessageText :=
                            'ORDEN LEGALIZADA PREVIAMENTE' || osbMessageText;
                    ELSE
                        /*
                        * En caso de que no este legalizada, agregamos la traza al mensaje
                        * para que se guarde posteriormente
                        */
                        osbMessageText :=
                            osbMessageText || ' ' || sbMensajeValidaOrd;
                    END IF;
                END IF;

                nuCodMensajeLega := onuMessageCode;
                sbMensajeLega := osbMessageText;

                --valida el mensaje de salida de la orden
                IF (onuMessageCode = 0)
                THEN
                    sbMensajeLega :=
                           'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> '
                        || osbMessageText;

                    LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                        INUMESAPROC       => nuPROCCODI,
                        ISBMESATIPO       => 'I',
                        INUERROR_LOG_ID   => nuCodMensajeLega,
                        ISBMESADESC       => sbMensajeLega,
                        ISBMESAVAL1       => TO_CHAR (nuORDEN),
                        ISBMESAVAL2       => NULL,
                        ISBMESAVAL3       => NULL,
                        ISBMESAVAL4       => NULL,
                        IDTMESAFECH       => SYSDATE,
                        ONUMESACODI       => nuMESACODI,
                        ONUERRORCODE      => onuMessageCode,
                        OSBERRORMESSAGE   => osbMessageText);

                    sbEstOrden := 'L';
                    sbEstaOrdenGest := 'G';

                    sbProcesoLegaOk := 'S';
                ELSE
                    boExcepcion := TRUE;

                    sbMensajeLega :=
                           'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> '
                        || osbMessageText;

                    LDCI_PKMESAWS.PROCREAMENSAJEPROC (
                        INUMESAPROC       => nuPROCCODI,
                        ISBMESATIPO       => 'E',
                        INUERROR_LOG_ID   => nuCodMensajeLega,
                        ISBMESADESC       => sbMensajeLega,
                        ISBMESAVAL1       => TO_CHAR (nuORDEN),
                        ISBMESAVAL2       => NULL,
                        ISBMESAVAL3       => NULL,
                        ISBMESAVAL4       => NULL,
                        IDTMESAFECH       => SYSDATE,
                        ONUMESACODI       => nuMESACODI,
                        ONUERRORCODE      => onuMessageCode,
                        OSBERRORMESSAGE   => osbMessageText);
                    sbEstOrden := 'G';
                    sbEstaOrdenGest := 'F';

                    sbProcesoLegaOk := 'N';
                END IF;

                proActualizaEstado (nuORDEN,
                                    nuCodMensajeLega,
                                    sbMensajeLega,
                                    sbEstOrden);
                LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada (
                    inuOrden          => nuORDEN,
                    isbEstado         => sbEstaOrdenGest
                                                        ,
                    onuErrorCode      => onuMessageCode,
                    osbErrorMessage   => osbMessageText);

                IF NVL (sbProcesoLegaOk, 'N') = 'S'
                THEN
                    COMMIT;
                ELSE
                    ROLLBACK;
                END IF;

            END LOOP;

            EXIT WHEN cuORDENES%NOTFOUND;

        END LOOP;

        CLOSE cuORDENES;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PRLEGALIZAORDENESSISTEMA_HILO' , cnuNVLTRC );
                
    EXCEPTION
        WHEN OTHERS
        THEN
            proActualizaEstado (inuOrden         => nuORDEN,
                                inuMessageCode   => NULL,
                                isbMessageText   => NULL,
                                isbstate         => 'P');
            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       => 'SQLCODE: ' || SQLCODE || ' : ' || SQLERRM,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            --registra los mensajes de error
            LDCI_PKMESAWS.PROCREAMENSPROC (
                INUMESAPROC       => nuPROCCODI,
                ISBMESADESC       =>
                    'TRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                ISBMESATIPO       => 'E',
                IDTMESAFECH       => SYSDATE,
                ONUMESACODI       => nuMESACODI,
                ONUERRORCODE      => onuMessageCode,
                OSBERRORMESSAGE   => osbMessageText);

            ROLLBACK;
    END PRLEGALIZAORDENESSISTEMA_HILO;

    PROCEDURE PRVALIDAEJEPRO
    IS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

          PROCESO : PRVALIDAEJEPRO
          AUTOR   : Luis Javier Lopez / Horbath
          FECHA   : 29/10/2019
          DESCRIPCION   : Proceso que se encarga de validar la ejecucion del PB LDCLEGOTLEC

         Parametros de Entrada

         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
        **************************************************************************/
        nuexisteproc   NUMBER;
    BEGIN
    
        pkg_Traza.Trace( 'Inicia ' || csbSP_NAME || 'PRVALIDAEJEPRO' , cnuNVLTRC );
            
        --se valida si hay algun proceso en ejecucion
        SELECT COUNT (1)
          INTO nuexisteproc
          FROM ESTAPROG
         WHERE     ESPRPROG LIKE '%LDCLEGOTLEC%'
               AND ESPRFEFI IS NULL
               AND (   ESPRFEFI IS NULL
                    OR ROUND ((SYSDATE - ESPRFEIN) * 24, 0) >= 24);

        --si existe proceso en ejecucion se lanza error
        IF nuexisteproc > 0
        THEN
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'Existe actualmente un proceso LDCLEGOTLEC en ejecucion');
        END IF;
        
        pkg_Traza.Trace( 'Termina ' || csbSP_NAME || 'PRVALIDAEJEPRO' , cnuNVLTRC );
                
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
    END PRVALIDAEJEPRO;
END LDCI_TEMPPKGESTLEGAORDEN;
/

PROMPT Otorgando permisos de ejecución sobre LDCI_TEMPPKGESTLEGAORDEN
BEGIN
    pkg_utilidades.prAplicarPermisos( 'LDCI_TEMPPKGESTLEGAORDEN', 'ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN to DBMONITOR;
GRANT EXECUTE on ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN to REXEINNOVA;
GRANT EXECUTE on ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_TEMPPKGESTLEGAORDEN to INTEGRADESA;
/
