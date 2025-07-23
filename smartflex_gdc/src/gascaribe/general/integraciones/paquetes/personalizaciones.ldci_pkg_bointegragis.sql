CREATE OR REPLACE PACKAGE PERSONALIZACIONES.LDCI_PKG_BOINTEGRAGIS AS

  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

   PROCEDIMIENTO : LDCI_PKG_BOINTEGRAGIS
           AUTOR : Jose Donado
           FECHA : 18/09/2024

   DESCRIPCION : Paquete de integraciones que contiene funciones y procedimientos para consumir diferentes servicios con el GIS
                 Caso IN-747.

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   JOSDON       18/09/2024  Creacion del paquete
   FRESIE       08/11/2024  Creacion Procedimiento prcMarcaPredioCastigado
   FRESIE       08/11/2024  Creacion Procedimiento prcActCategoriaSubcategoria
   FRESIE       20/11/2024  Modificaciones realizadas por cambios en la nomenclatura de paquete, procedimientos y variables de OSF
   JOSDON       11/12/2024  IN-894 Creación Procedimiento prcCambioCiclo
  ************************************************************************/

  PROCEDURE prcObtenerCiclo(inuDepartamento IN NUMBER,
                            inuCategoria    IN NUMBER,
                            inuSubCategoria IN NUMBER,
                            oclRespuesta    OUT CLOB,
                            onuCodigoError  OUT NUMBER,
                            osbMensajeError OUT VARCHAR2);

  PROCEDURE prcMarcaPredioCastigado(inuIdPredio     IN NUMBER,
                                    isbCastigo      IN VARCHAR2,
                                    oclRespuesta    OUT CLOB,
                                    onuCodigoError  OUT NUMBER,
                                    osbMensajeError OUT VARCHAR2);

  PROCEDURE prcActCategoriaSubcategoria(inuContrato     IN NUMBER,
                                        inuCategoria    IN NUMBER,
                                        inuSubcategoria IN NUMBER,
                                        oclRespuesta    OUT CLOB,
                                        onuCodigoError  OUT NUMBER,
                                        osbMensajeError OUT VARCHAR2);
                                        
	PROCEDURE prcCambioCiclo(inuIdPredio     IN NUMBER,
                           inuIdDireccion  IN NUMBER,
                           inuCiclo        IN NUMBER,
                           inuIdOrden      IN NUMBER,
                           oclRespuesta    OUT CLOB,
                           onuCodigoError  OUT NUMBER,
                           osbMensajeError OUT VARCHAR2);

END LDCI_PKG_BOINTEGRAGIS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.LDCI_PKG_BOINTEGRAGIS AS

  -- ---------------------------------------------------------------------
  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  : prcObtenerCiclo
   * Caso    : IN-747
   * Autor   : Jose Donado
   * Fecha   : 18/09/2024
   * Descripcion : Obtiene ciclo configurado en GIS para el departamento, categoria y subcategoria dado
   *
   * Parametros
   *inuDepartamento  NUMBER
   *inuCategoria     NUMBER
   *inuSubCategoria  NUMBER

   * Historia de Modificaciones
   * Autor              Fecha         Descripcion
   * Jose Donado        18/09/2024    Creacion del procedimiento
   * Freddy Sierra      20/11/2024    Modificaciones realizadas por cambios en la nomenclatura de paquete, procedimientos y variables de OSF
  **/
  PROCEDURE prcObtenerCiclo(inuDepartamento IN NUMBER,
                            inuCategoria    IN NUMBER,
                            inuSubCategoria IN NUMBER,
                            oclRespuesta    OUT CLOB,
                            onuCodigoError  OUT NUMBER,
                            osbMensajeError OUT VARCHAR2) AS

    sbParametro       LDCI_CARASEWE.CASEDESE%TYPE;
    clJsonEntrada     CLOB;
    sbToken           VARCHAR2(3000);
    sbStatusExpresion LDCI_CARASEWE.CASEVALO%TYPE;
    sbStatusError     LDCI_CARASEWE.CASEVALO%TYPE;
    sbDataExp         LDCI_CARASEWE.CASEVALO%TYPE;
    sbDataErrorExp    LDCI_CARASEWE.CASEVALO%TYPE;
    sbMensaje         VARCHAR2(4000);
    sbStatus          VARCHAR2(20);
    clData            CLOB;

    errorParametro EXCEPTION;
    errorEntradas  EXCEPTION;
    errorTimeOut   EXCEPTION;
    errorAPIServ   EXCEPTION;
    errorWS        EXCEPTION;

    CURSOR cuExpresionRespuesta(isbExpresion VARCHAR2,
                                isbRespuesta VARCHAR2) IS
      SELECT data
        FROM (SELECT DISTINCT REGEXP_SUBSTR(DBMS_LOB.SUBSTR(UPPER(isbRespuesta),
                                                            4000),
                                            UPPER(isbExpresion),
                                            1,
                                            1,
                                            'c',
                                            1) data
                FROM dual);

  BEGIN

    --Valida ingreso de datos de entrada
    --null;
    IF (inuDepartamento IS NULL) OR (inuCategoria IS NULL) OR
       (inuSubCategoria IS NULL) THEN
      RAISE errorEntradas;
    END IF;

    sbParametro := 'WS_GIS_CONSULTACICLO';

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS',
                                       sbStatusExpresion,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS_ERROR',
                                       sbStatusError,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'DATA',
                                       sbDataExp,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'DATA_ERROR_EXP',
                                       sbDataErrorExp,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    clJsonEntrada := '{"department":' || TO_CHAR(inuDepartamento) ||
                     ',"category":' || TO_CHAR(inuCategoria) ||
                     ',"subcategory":' || TO_CHAR(inuSubCategoria) || '}';

    sbToken := LDCI_PKRESTAPI.fsbGetToken('INTEG');
    sbToken := LDCI_PKRESTAPI.fsbDecodeToken(sbToken);
    LDCI_PKRESTAPI.proSetProxyToken(sbToken);
    oclRespuesta := LDCI_PKRESTAPI.fsbRESTSegmCallExtLargeSync(sbParametro,
                                                               clJsonEntrada);

    IF LDCI_PKRESTAPI.boolTimeOut THEN
      RAISE errorTimeOut;
    END IF;

    IF LDCI_PKRESTAPI.boolHttpError THEN
      RAISE errorAPIServ;
    END IF;

    OPEN cuExpresionRespuesta(sbStatusExpresion, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO sbStatus;
    CLOSE cuExpresionRespuesta;

    OPEN cuExpresionRespuesta(sbDataExp, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO clData;
    CLOSE cuExpresionRespuesta;

    IF sbStatus = sbStatusError THEN
      OPEN cuExpresionRespuesta(sbDataErrorExp, oclRespuesta);
      FETCH cuExpresionRespuesta
        INTO clData;
      CLOSE cuExpresionRespuesta;

      osbMensajeError := clData;

      RAISE errorWS;
    END IF;

    onuCodigoError  := 0;
    osbMensajeError := sbStatus || ' - ' || clData;

  EXCEPTION
    WHEN errorParametro THEN
      onuCodigoError  := -1;
      osbMensajeError := 'Fallo obteniendo parametros ' || SQLERRM;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorEntradas THEN
      onuCodigoError  := -2;
      osbMensajeError := 'Se deben ingresar los datos de entrada requeridos. [Dept:' ||
                         NVL(TO_CHAR(inuDepartamento), 'Nulo') ||
                         ' - Categ:' || NVL(TO_CHAR(inuCategoria), 'Nulo') ||
                         ' - Subcateg:' ||
                         NVL(TO_CHAR(inuSubCategoria), 'Nulo') || ' ]';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorAPIServ THEN
      onuCodigoError  := -3;
      osbMensajeError := LDCI_PKRESTAPI.sbErrorHttp;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorWS THEN
      onuCodigoError := -4;
      oclRespuesta   := '{"status": "error","data": "' || onuCodigoError ||
                        ' - ' || osbMensajeError || '"}';

    WHEN errorTimeOut THEN
      onuCodigoError  := -99;
      osbMensajeError := 'TimeOut al consumir el servicio de consulta ciclo del GIS';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN OTHERS THEN
      onuCodigoError  := -9999;
      osbMensajeError := 'Fallo Desconocido ' || SQLERRM || ' - ' ||
                         'Traza: ' || DBMS_UTILITY.format_error_backtrace;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';
  END prcObtenerCiclo;

  ------------------------------------------------------------------------
  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  : prcMarcaPredioCastigado
   * Caso    : IN-844
   * Autor   : Freddy Enrique Sierra Yepez
   * Fecha   : 08/11/2024
   * Descripcion : Procedimiento que permite realizar el marcado o desmarcado de castigo de un predio en GIS
   *
   * Parametros
   *inuIdPredio  NUMBER
   *isbCastigo  VARCHAR2

   * Historia de Modificaciones
   *    Autor            Fecha           Descripcion
   * Freddy Sierra     08/11/2024   Creacion del procedimiento
   * Freddy Sierra     20/11/2024   Modificaciones realizadas por cambios en la nomenclatura de paquete, procedimientos y variables de OSF
  **/
  PROCEDURE prcMarcaPredioCastigado(inuIdPredio     IN NUMBER,
                                    isbCastigo      IN VARCHAR2,
                                    oclRespuesta    OUT CLOB,
                                    onuCodigoError  OUT NUMBER,
                                    osbMensajeError OUT VARCHAR2) AS

    sbParametro       LDCI_CARASEWE.CASEDESE%TYPE;
    clJsonEntrada     CLOB;
    sbToken           VARCHAR2(3000);
    sbStatusExpresion LDCI_CARASEWE.CASEVALO%TYPE;
    sbStatusError     LDCI_CARASEWE.CASEVALO%TYPE;
    sbDataExp         LDCI_CARASEWE.CASEVALO%TYPE;
    sbMensaje         VARCHAR2(4000);
    sbStatus          VARCHAR2(20);
    clData            CLOB;

    errorParametro EXCEPTION;
    errorEntradas  EXCEPTION;
    errorTimeOut   EXCEPTION;
    errorAPIServ   EXCEPTION;
    errorWS        EXCEPTION;

    CURSOR cuExpresionRespuesta(isbExpresion VARCHAR2,
                                isbRespuesta VARCHAR2) IS
      SELECT data
        FROM (SELECT DISTINCT REGEXP_SUBSTR(DBMS_LOB.SUBSTR(UPPER(isbRespuesta),
                                                            4000),
                                            UPPER(isbExpresion),
                                            1,
                                            1,
                                            'c',
                                            1) data
                FROM dual);

  BEGIN

    --Valida ingreso de datos de entrada
    --null;
    IF (inuIdPredio IS NULL) OR (isbCastigo IS NULL) THEN
      RAISE errorEntradas;
    END IF;

    sbParametro := 'WS_GIS_PREDIO_CASTIGADO';

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS',
                                       sbStatusExpresion,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS_ERROR',
                                       sbStatusError,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'DATA',
                                       sbDataExp,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    clJsonEntrada := '{"propertyId":' || TO_CHAR(inuIdPredio) ||
                     ',"penaltyOption":"' || TO_CHAR(isbCastigo) || '"}';

    sbToken := LDCI_PKRESTAPI.fsbGetToken('INTEG');
    sbToken := LDCI_PKRESTAPI.fsbDecodeToken(sbToken);
    LDCI_PKRESTAPI.proSetProxyToken(sbToken);
    oclRespuesta := LDCI_PKRESTAPI.fsbRESTSegmCallExtLargeSync(sbParametro,
                                                               clJsonEntrada);
    --Valida tiempos altos de respuesta del servicio
    IF LDCI_PKRESTAPI.boolTimeOut THEN
      RAISE errorTimeOut;
    END IF;

    --Valida errores Http en el servicio
    IF LDCI_PKRESTAPI.boolHttpError THEN
      RAISE errorAPIServ;
    END IF;

    OPEN cuExpresionRespuesta(sbStatusExpresion, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO sbStatus;
    CLOSE cuExpresionRespuesta;

    OPEN cuExpresionRespuesta(sbDataExp, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO clData;
    CLOSE cuExpresionRespuesta;

    IF sbStatus = sbStatusError THEN

      osbMensajeError := clData;

      RAISE errorWS;
    END IF;

    onuCodigoError  := 0;
    osbMensajeError := sbStatus || ' - ' || clData;

  EXCEPTION

    WHEN errorParametro THEN
      onuCodigoError  := -1;
      osbMensajeError := 'Fallo obteniendo parametros ' || SQLERRM;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorEntradas THEN
      onuCodigoError  := -2;
      osbMensajeError := 'Se deben ingresar los datos de entrada requeridos. [Pred:' ||
                         NVL(TO_CHAR(inuIdPredio), 'Nulo') || ' - S/N:' ||
                         NVL(TO_CHAR(isbCastigo), 'Nulo') || ' ]';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorAPIServ THEN
      onuCodigoError  := -3;
      osbMensajeError := LDCI_PKRESTAPI.sbErrorHttp;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';
    WHEN errorWS THEN
      onuCodigoError := -4;
      oclRespuesta   := '{"status": "error","data": "' || onuCodigoError ||
                        ' - ' || osbMensajeError || '"}';

    WHEN errorTimeOut THEN
      onuCodigoError  := -99;
      osbMensajeError := 'TimeOut al consumir el servicio de marca predio castigado';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN OTHERS THEN
      onuCodigoError  := -9999;
      osbMensajeError := 'Fallo Desconocido ' || SQLERRM || ' - ' ||
                         'Traza: ' || DBMS_UTILITY.format_error_backtrace;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

  END prcMarcaPredioCastigado;

  ------------------------------------------------------------------------

  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  : prcActCategoriaSubcategoria
   * Caso    : IN-857
   * Autor   : Freddy Enrique Sierra Yepez
   * Fecha   : 15/11/2024
   * Descripcion : Procedimiento que permite realizar la actualizacion de categoria y subcategoria de un contrato en Gis
   *
   * Parametros
   *inuContrato     NUMBER
   *inuCategoria     NUMBER
   *inuSubcategoria  NUMBER

   * Historia de Modificaciones
   *    Autor            Fecha           Descripcion
   * Freddy Sierra     15/11/2024   Creacion del procedimiento
   * Freddy Sierra     20/11/2024   Modificaciones realizadas por cambios en la nomenclatura de paquete, procedimientos y variables de OSF
  **/
  PROCEDURE prcActCategoriaSubcategoria(inuContrato     IN NUMBER,
                                        inuCategoria    IN NUMBER,
                                        inuSubcategoria IN NUMBER,
                                        oclRespuesta    OUT CLOB,
                                        onuCodigoError  OUT NUMBER,
                                        osbMensajeError OUT VARCHAR2) AS

    sbParametro       LDCI_CARASEWE.CASEDESE%TYPE;
    clJsonEntrada     CLOB;
    sbToken           VARCHAR2(3000);
    sbStatusExpresion LDCI_CARASEWE.CASEVALO%TYPE;
    sbStatusError     LDCI_CARASEWE.CASEVALO%TYPE;
    sbDataExp         LDCI_CARASEWE.CASEVALO%TYPE;
    sbMensaje         VARCHAR2(4000);
    sbStatus          VARCHAR2(20);
    clData            CLOB;

    errorParametro EXCEPTION;
    errorEntradas  EXCEPTION;
    errorTimeOut   EXCEPTION;
    errorAPIServ   EXCEPTION;
    errorWS        EXCEPTION;

    CURSOR cuExpresionRespuesta(isbExpresion VARCHAR2,
                                isbRespuesta VARCHAR2) IS
      SELECT data
        FROM (SELECT DISTINCT REGEXP_SUBSTR(DBMS_LOB.SUBSTR(UPPER(isbRespuesta),
                                                            4000),
                                            UPPER(isbExpresion),
                                            1,
                                            1,
                                            'c',
                                            1) data
                FROM dual);

  BEGIN

    --Valida ingreso de datos de entrada
    --null;
    IF (inuContrato IS NULL) OR (inuCategoria IS NULL) OR
       (inuSubcategoria IS NULL) THEN
      RAISE errorEntradas;
    END IF;

    sbParametro := 'WS_GIS_ACTUALIZA_CATEG_SUBCA';

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS',
                                       sbStatusExpresion,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS_ERROR',
                                       sbStatusError,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'DATA',
                                       sbDataExp,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    clJsonEntrada := '{"contract":' || TO_CHAR(inuContrato) ||
                     ',"category":' || TO_CHAR(inuCategoria) ||
                     ',"subcategory":' || TO_CHAR(inuSubcategoria) || '}';

    sbToken := LDCI_PKRESTAPI.fsbGetToken('INTEG');
    sbToken := LDCI_PKRESTAPI.fsbDecodeToken(sbToken);
    LDCI_PKRESTAPI.proSetProxyToken(sbToken);
    oclRespuesta := LDCI_PKRESTAPI.fsbRESTSegmCallExtLargeSync(sbParametro,
                                                               clJsonEntrada);
    --Valida tiempos altos de respuesta del servicio
    IF LDCI_PKRESTAPI.boolTimeOut THEN
      RAISE errorTimeOut;
    END IF;

    --Valida errores Http en el servicio
    IF LDCI_PKRESTAPI.boolHttpError THEN
      RAISE errorAPIServ;
    END IF;

    OPEN cuExpresionRespuesta(sbStatusExpresion, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO sbStatus;
    CLOSE cuExpresionRespuesta;

    OPEN cuExpresionRespuesta(sbDataExp, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO clData;
    CLOSE cuExpresionRespuesta;

    IF sbStatus = sbStatusError THEN

      osbMensajeError := clData;

      RAISE errorWS;
    END IF;

    onuCodigoError  := 0;
    osbMensajeError := sbStatus || ' - ' || clData;

  EXCEPTION

    WHEN errorParametro THEN
      onuCodigoError  := -1;
      osbMensajeError := 'Fallo obteniendo parametros ' || SQLERRM;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorEntradas THEN
      onuCodigoError  := -2;
      osbMensajeError := 'Se deben ingresar los datos de entrada requeridos. [Cont:' ||
                         NVL(TO_CHAR(inuContrato), 'Nulo') || ' - Categ:' ||
                         NVL(TO_CHAR(inuCategoria), 'Nulo') ||
                         ' - Subcateg:' ||
                         NVL(TO_CHAR(inuSubcategoria), 'Nulo') || ' ]';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorAPIServ THEN
      onuCodigoError  := -3;
      osbMensajeError := LDCI_PKRESTAPI.sbErrorHttp;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';
    WHEN errorWS THEN
      onuCodigoError := -4;
      oclRespuesta   := '{"status": "error","data": "' || onuCodigoError ||
                        ' - ' || osbMensajeError || '"}';

    WHEN errorTimeOut THEN
      onuCodigoError  := -99;
      osbMensajeError := 'TimeOut al consumir el servicio que actualiza la categoria y subcategoria';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN OTHERS THEN
      onuCodigoError  := -9999;
      osbMensajeError := 'Fallo Desconocido ' || SQLERRM || ' - ' ||
                         'Traza: ' || DBMS_UTILITY.format_error_backtrace;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

  END prcActCategoriaSubcategoria;
  
  
  ------------------------------------------------------------------------

  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  : prcCambioCiclo
   * Caso    : IN-894
   * Autor   : Jose Donado
   * Fecha   : 11/12/2024
   * Descripcion : Procedimiento que permite realizar cambio de ciclo en GIS
   *
   * Parametros
   *inuIdPredio     NUMBER
   *inuIdDireccion  NUMBER
   *inuCiclo        NUMBER
   *inuIdOrden      NUMBER
   *isbUsuario      VARCHAR2

   * Historia de Modificaciones
   * Autor            Fecha           Descripcion
   * Jose Donado     11/12/2024       Creacion del procedimiento
  **/
  PROCEDURE prcCambioCiclo(inuIdPredio     IN NUMBER,
                           inuIdDireccion  IN NUMBER,
                           inuCiclo        IN NUMBER,
                           inuIdOrden      IN NUMBER,
                           oclRespuesta    OUT CLOB,
                           onuCodigoError  OUT NUMBER,
                           osbMensajeError OUT VARCHAR2) AS

    sbParametro       LDCI_CARASEWE.CASEDESE%TYPE;
    clJsonEntrada     CLOB;
    sbToken           VARCHAR2(3000);
    sbStatusExpresion LDCI_CARASEWE.CASEVALO%TYPE;
    sbStatusError     LDCI_CARASEWE.CASEVALO%TYPE;
    sbDataExp         LDCI_CARASEWE.CASEVALO%TYPE;
    sbMensaje         VARCHAR2(4000);
    sbStatus          VARCHAR2(20);
    clData            CLOB;
    sbUsuario         VARCHAR2(100) := '';

    errorParametro EXCEPTION;
    errorEntradas  EXCEPTION;
    errorTimeOut   EXCEPTION;
    errorAPIServ   EXCEPTION;
    errorWS        EXCEPTION;

    CURSOR cuExpresionRespuesta(isbExpresion VARCHAR2,
                                isbRespuesta VARCHAR2) IS
      SELECT data
        FROM (SELECT DISTINCT REGEXP_SUBSTR(DBMS_LOB.SUBSTR(UPPER(isbRespuesta),
                                                            4000),
                                            UPPER(isbExpresion),
                                            1,
                                            1,
                                            'c',
                                            1) data
                FROM dual);

  BEGIN

    --Valida ingreso de datos de entrada
    IF (inuIdPredio IS NULL) OR (inuIdDireccion IS NULL) OR
       (inuCiclo IS NULL) THEN
      RAISE errorEntradas;
    END IF;

    sbParametro := 'WS_GIS_CAMBIACICLO';
    
    sbUsuario := pkg_session.getUser();

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS',
                                       sbStatusExpresion,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'STATUS_ERROR',
                                       sbStatusError,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbParametro,
                                       'DATA',
                                       sbDataExp,
                                       sbMensaje);
    IF (sbMensaje != '0') THEN
      RAISE errorParametro;
    END IF;

    clJsonEntrada := '{"premiseId":' || inuIdPredio || ',
                       "addressId":' || inuIdDireccion || ',
                       "cycleId":' || inuCiclo || ',
                       "orderId":' || inuIdOrden || ',
                       "user": "' || sbUsuario || '"}';

/*    --
    DBMS_OUTPUT.put_line(clJsonEntrada);
    --*/
    
    sbToken := LDCI_PKRESTAPI.fsbGetToken('INTEG');
    sbToken := LDCI_PKRESTAPI.fsbDecodeToken(sbToken);
    LDCI_PKRESTAPI.proSetProxyToken(sbToken);
    oclRespuesta := LDCI_PKRESTAPI.fsbRESTSegmCallExtLargeSync(sbParametro,
                                                               clJsonEntrada);
                                                               
/*    --
    DBMS_OUTPUT.put_line(oclRespuesta);
    --    */                                                       
    --Valida tiempos altos de respuesta del servicio
    IF LDCI_PKRESTAPI.boolTimeOut THEN
      RAISE errorTimeOut;
    END IF;

    --Valida errores Http en el servicio
    IF LDCI_PKRESTAPI.boolHttpError THEN
      RAISE errorAPIServ;
    END IF;

    OPEN cuExpresionRespuesta(sbStatusExpresion, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO sbStatus;
    CLOSE cuExpresionRespuesta;

    OPEN cuExpresionRespuesta(sbDataExp, oclRespuesta);
    FETCH cuExpresionRespuesta
      INTO clData;
    CLOSE cuExpresionRespuesta;

    IF sbStatus = sbStatusError THEN

      osbMensajeError := clData;

      RAISE errorWS;
    END IF;

    onuCodigoError  := 0;
    osbMensajeError := sbStatus || ' - ' || clData;

  EXCEPTION

    WHEN errorParametro THEN
      onuCodigoError  := -1;
      osbMensajeError := 'Fallo obteniendo parametros ' || SQLERRM;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorEntradas THEN
      onuCodigoError  := -2;
      osbMensajeError := 'Se deben ingresar los datos de entrada requeridos. [Id Predio:' ||
                         NVL(TO_CHAR(inuIdPredio), 'Nulo') || ' - Id Direccion:' ||
                         NVL(TO_CHAR(inuIdDireccion), 'Nulo') ||
                         ' - Ciclo:' ||
                         NVL(TO_CHAR(inuCiclo), 'Nulo') || ' ]';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN errorAPIServ THEN
      onuCodigoError  := -3;
      osbMensajeError := LDCI_PKRESTAPI.sbErrorHttp;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';
    WHEN errorWS THEN
      onuCodigoError := -4;
      oclRespuesta   := '{"status": "error","data": "' || onuCodigoError ||
                        ' - ' || osbMensajeError || '"}';

    WHEN errorTimeOut THEN
      onuCodigoError  := -99;
      osbMensajeError := 'TimeOut al consumir servicio de cambio de ciclo';
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

    WHEN OTHERS THEN
      onuCodigoError  := -9999;
      osbMensajeError := 'Fallo Desconocido ' || SQLERRM || ' - ' ||
                         'Traza: ' || DBMS_UTILITY.format_error_backtrace;
      oclRespuesta    := '{"status": "error","data": "' || onuCodigoError ||
                         ' - ' || osbMensajeError || '"}';

  END prcCambioCiclo;

End LDCI_PKG_BOINTEGRAGIS;
/
BEGIN
  pkg_utilidades.praplicarpermisos('LDCI_PKG_BOINTEGRAGIS', 'PERSONALIZACIONES');
  dbms_output.put_line('Permisos del paquete PERSONALIZACIONES.LDCI_PKG_BOINTEGRAGIS Ok.');
END;
/