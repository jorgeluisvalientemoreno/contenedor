CREATE OR REPLACE PACKAGE PERSONALIZACIONES.LDCI_PKG_BOINTEGRA_TRM AS
/*
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
   PAQUETE      : LDCI_PKG_BOINTEGRA_TRM
   AUTOR        : Jose Donado
   FECHA        : 13/11/2024
   CASO       : IN-851
   DESCRIPCION  : Paquete que tiene la logica del proceso integracion de obtencion y replica de TRM

  Historia de Modificaciones
  Autor   Fecha      Descripcion.
  JOSDON  13/11/2024 IN-851: Creacion de procedimiento prcConsultaTRM para consulta de la TRM
*/
  PROCEDURE prcConsultaTRM(isbDiaTRM IN VARCHAR2, onuValorTRM OUT NUMBER,oclXMLTRM OUT CLOB, onuCodigoError OUT NUMBER,osbMensajeError OUT VARCHAR2);

END LDCI_PKG_BOINTEGRA_TRM;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.LDCI_PKG_BOINTEGRA_TRM AS

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 FUNCION : fblValidaXML
           AUTOR : Jose Donado
           FECHA : 13/11/2024

 DESCRIPCION : Funcion que permite verificar si la estructura de un CLOB corresponde a un XML valido

 Parametros de Entrada
 inXML:  CLOB a validar estructura de XML

 Salida
 0: Estructura valida de XML
 1: Estructura no corresponde a XML valido

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
FUNCTION  fblValidaXML(iclXML CLOB) RETURN BOOLEAN AS
  xmlData XMLTYPE;

  BEGIN
    xmlData := XMLTYPE(iclXML);
    RETURN TRUE;
  Exception
    WHEN OTHERS THEN
      RETURN FALSE;
END fblValidaXML;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 FUNCION : fblValidaDiaTRM
           AUTOR : Jose Donado
           FECHA : 22/11/2024

 DESCRIPCION : Funcion que permite verificar si la entrada de dia de TRM es una fecha valida

 Parametros de Entrada
 isbDiaTRM:  fecha en format YYYY-MM-DD

 Salida
 0: Fecha valida
 1: Entrada no es una fecha valida en fornmato YYYY-MM-DD

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
FUNCTION  fblValidaDiaTRM(isbDiaTRM VARCHAR2) RETURN BOOLEAN AS
  dtFechaTRM DATE;
  BEGIN
    IF REGEXP_LIKE (isbDiaTRM, '([0-9]{4,})([-])([0-9]{2,})([-])([0-9]{2,})') THEN
      dtFechaTRM := TO_DATE(isbDiaTRM,'YYYY-MM-DD');
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  
  Exception
    WHEN OTHERS THEN
      RETURN FALSE;
END fblValidaDiaTRM;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : prcRegistraTRM
                 AUTOR : Jose Donado
                 FECHA : 22/11/2024

 DESCRIPCION : Procedimiento que registra localmente la TRM obtenida de la superfinanciera

 Parametros de Entrada
 isbDiaTRM:  Dia de consulta de la TRM. Si es nulo se consulta la TRM del dia

 Parametros de Salida

    onuCodigoError       Codigo de error de salida del procedimiento
    osbMensajeError      Mensaje de error de salida del procedimiento

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
  PROCEDURE prcRegistraTRM(irgRegistroTRM LDCI_TRM%ROWTYPE, onuCodigoError OUT NUMBER,osbMensajeError OUT VARCHAR2) AS

  BEGIN
    
    INSERT INTO LDCI_TRM(DIA_TRM, CODIGO, UNIDAD, FECHA_DESDE, FECHA_HASTA, VALOR_TRM, EXITO, XMLTRM, FECHA_REGISTRO)
    VALUES(irgRegistroTRM.Dia_Trm, irgRegistroTRM.Codigo, irgRegistroTRM.Unidad, irgRegistroTRM.Fecha_Desde, irgRegistroTRM.Fecha_Hasta, irgRegistroTRM.Valor_Trm, irgRegistroTRM.Exito, irgRegistroTRM.Xmltrm, irgRegistroTRM.Fecha_Registro);
    COMMIT;
    
    onuCodigoError := 0;
    osbMensajeError := '';

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      onuCodigoError := SQLCODE;
      osbMensajeError := SQLERRM;
      osbMensajeError := 'ERROR - OTHERS: <Registra TRM - prcRegistraTRM>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuCodigoError || ' - ' || osbMensajeError;
  END prcRegistraTRM;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : prcConsultaTRM
                 AUTOR : Jose Donado
                 FECHA : 13/11/2024

 DESCRIPCION : Procedimiento consultar la TRM del dia del servicio de la superfinanciera

 Parametros de Entrada
 isbDiaTRM:  Dia de consulta de la TRM. Si es nulo se consulta la TRM del dia

 Parametros de Salida

    onuCodigoError       Codigo de error de salida del procedimiento
    osbMensajeError    Mensaje de error de salida del procedimiento

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
  PROCEDURE prcConsultaTRM(isbDiaTRM IN VARCHAR2, onuValorTRM OUT NUMBER,oclXMLTRM OUT CLOB, onuCodigoError OUT NUMBER,osbMensajeError OUT VARCHAR2) AS

      --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlDestino   LDCI_CARASEWE.CASEVALO%TYPE;
    sbSoapAction   LDCI_CARASEWE.CASEVALO%TYPE;
    sbProtocolo    LDCI_CARASEWE.CASEVALO%TYPE;
    sbHost         LDCI_CARASEWE.CASEVALO%TYPE;
    sbPuerto       LDCI_CARASEWE.CASEVALO%TYPE;
    sbXmlRequest   LDCI_CARASEWE.CASEVALO%TYPE;
    sbMensaje      VARCHAR2(4000);

    --Parametros de logica de negocio
    sbWsNombre     LDCI_CARASEWE.CASEDESE%TYPE := 'WS_SUPERFINANC_TRM';
    nuError        NUMBER;
    sbRespuesta    VARCHAR2(4000);
    blXMLValido    BOOLEAN;
    blDiaTRMValido BOOLEAN;
    sbDiaTRM       VARCHAR2(10);
    sbDia          LDCI_TRM.DIA_TRM%TYPE;
    nuCodigo       LDCI_TRM.CODIGO%TYPE;
    sbUnidad       LDCI_TRM.UNIDAD%TYPE;
    dtFechaDesde   LDCI_TRM.FECHA_DESDE%TYPE;
    dtFechaHasta   LDCI_TRM.FECHA_HASTA%TYPE;
    nuValorTRM     LDCI_TRM.VALOR_TRM%TYPE;
    sbExito        LDCI_TRM.EXITO%TYPE;
    clXMLTRM       LDCI_TRM.XMLTRM%TYPE;
    sbFechaDesde   VARCHAR2(50);
    sbFechaHasta   VARCHAR2(50);
    rgRegistroTRM  LDCI_TRM%ROWTYPE;
    

    --Variables mensajes SOAP
    clPayload       CLOB;
    clRespuesta     CLOB;

    errorParametro      EXCEPTION;   -- Excepcion que verifica que ingresen los parametros de entrada
    excepNoProcesoSOAP  EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP
    excepXMLInvalido    EXCEPTION;   -- Excepcion que valida estructura del XML de entrada
    excepDiaTRMInvalido EXCEPTION;   -- Excepcion que valida que el dia de TRM a consultar sea una fecha valida en formato YYYY-MM-DD
    excepRegistroTRM    EXCEPTION;   -- Excepcion que verifica si la TRM pudo ser registrada de manera local en la tabla LDCI_TRM

    CURSOR cuLocalTRM(isbDia LDCI_TRM.DIA_TRM%TYPE) IS
    SELECT T.DIA_TRM,
           T.CODIGO,
           T.UNIDAD,
           T.FECHA_DESDE,
           T.FECHA_HASTA,
           T.VALOR_TRM,
           T.EXITO,
           T.XMLTRM
    FROM LDCI_TRM T
    WHERE T.DIA_TRM = isbDia;
                    
    CURSOR cuLecturaXML(iclRespuesta CLOB) IS
    SELECT RESPUESTA.*
    FROM xmltable(xmlnamespaces(     
                             'http://action.trm.services.generic.action.superfinanciera.nexura.sc.com.co/' as "ns2" 
                          ),  --XPath to specific node
                    '//ns2:queryTCRMResponse/return'   passing             
                     XMLType(iclRespuesta)                         
                     columns 
                          CODIGO          NUMBER          PATH 'id',
                          UNIDAD          VARCHAR2(20)    PATH 'unit', 
                          FECHA_DESDE     VARCHAR2(50)    PATH 'validityFrom',                                                  
                          FECHA_HASTA     VARCHAR2(50)    PATH 'validityTo',
                          VALOR_TRM       NUMBER          PATH 'value',
                          EXITO           VARCHAR2(10)    PATH 'success',
                          MENSAJE         VARCHAR2(2000)  PATH 'message'
                    ) RESPUESTA;  

  BEGIN
    onuCodigoError := 0;
    --PARAMETROS DE CONEXION HACIA EL SERVICIO
    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'NAMESPACE', sbNameSpace, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'WSURL', sbUrlWS, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'SOAPACTION', sbSoapAction, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'PROTOCOLO', sbProtocolo, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'PUERTO', sbPuerto, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'HOST', sbHost, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    ldci_pkWebServUtils.proCaraServWeb(sbWsNombre, 'XML_REQUEST', sbXmlRequest, sbMensaje);
    IF(sbMensaje != '0') THEN
         RAISE errorParametro;
    END IF;

    IF (isbDiaTRM IS NULL OR isbDiaTRM = '') THEN
      sbDiaTRM := to_char(SYSDATE, 'yyyy-mm-dd');
    ELSE
      sbDiaTRM := isbDiaTRM;
    END IF;
    
    blDiaTRMValido := fblValidaDiaTRM(sbDiaTRM);
    IF (NOT blDiaTRMValido) THEN
      RAISE excepDiaTRMInvalido;
    END IF;

    OPEN cuLocalTRM(to_date(sbDiaTRM,'YYYY-MM-DD'));
    FETCH cuLocalTRM INTO sbDia,nuCodigo,sbUnidad,dtFechaDesde,dtFechaHasta,nuValorTRM,sbExito,clXMLTRM;
    CLOSE cuLocalTRM;

    IF sbDia IS NULL THEN
      
      --arma la URL del servicio donde se enviara la interfaz
      sbUrlDestino := lower(sbProtocolo) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
      sbUrlDestino := trim(sbUrlDestino);

      --verifica si el dato es un XML valido
      clPayload := REPLACE(sbXmlRequest,'[@INPARAMDAYTRM]',sbDiaTRM);
      clPayload := REPLACE(clPayload, 'act:queryTCRM', 'queryTCRM');
      blXMLValido := fblValidaXML(clPayload);
      clPayload := REPLACE(clPayload, 'queryTCRM', 'act:queryTCRM');

      IF (NOT blXMLValido) THEN
        RAISE excepXMLInvalido;
      END IF;

      clPayload := REPLACE(clPayload, '<?xml version="1.0" encoding="UTF-8"?>');
      clPayload := TRIM(clPayload);
      
      --Hace el consumo del servicio Web
      LDCI_PKSOAPAPI.Prosetprotocol(sbProtocolo);
      clRespuesta := LDCI_PKSOAPAPI.fsbSoapSegmentedCallSyncExt(sbWsNombre,clPayload, sbUrlDestino, sbSoapAction, sbNameSpace);

      IF (LDCI_PKSOAPAPI.boolHttpError OR LDCI_PKSOAPAPI.Boolsoaperror) THEN
        Raise excepNoProcesoSOAP;
      END IF;
      
      OPEN cuLecturaXML(clRespuesta);
      FETCH cuLecturaXML INTO nuCodigo,sbUnidad,sbFechaDesde,sbFechaHasta,nuValorTRM,sbExito,sbMensaje;
      CLOSE cuLecturaXML;
      
      dtFechaDesde := CAST(to_timestamp_tz(sbFechaDesde, 'YYYY-MM-DD"T"HH24:MI:SSTZH:TZM') as DATE);   
      dtFechaHasta := CAST(to_timestamp_tz(sbFechaHasta, 'YYYY-MM-DD"T"HH24:MI:SSTZH:TZM') as DATE); 
      rgRegistroTRM.Dia_Trm := to_date(sbDiaTRM,'YYYY-MM-DD');
      rgRegistroTRM.Codigo := nuCodigo;
      rgRegistroTRM.Unidad := sbUnidad;
      rgRegistroTRM.Fecha_Desde := dtFechaDesde;
      rgRegistroTRM.Fecha_Hasta := dtFechaHasta;
      rgRegistroTRM.Valor_Trm := nuValorTRM;
      rgRegistroTRM.Exito := sbExito;
      rgRegistroTRM.Xmltrm := clRespuesta;
      rgRegistroTRM.Fecha_Registro := SYSDATE; 
      
      prcRegistraTRM(rgRegistroTRM, onuCodigoError, osbMensajeError);
      IF (onuCodigoError <> 0) THEN
        onuValorTRM := NULL;
        oclXMLTRM := NULL;
        Raise excepRegistroTRM;
      END IF;
                 
    ELSE
      clRespuesta := clXMLTRM;
    END IF;

    onuCodigoError := 0;
    osbMensajeError := 'Proceso Exitoso';
    onuValorTRM := nuValorTRM;
    oclXMLTRM := clRespuesta;

  EXCEPTION
    WHEN errorParametro THEN
      onuCodigoError := -1;
      osbMensajeError := 'ERROR PARAMETROS: <Consulta TRM - prcConsultaTRM>: ' || Dbms_Utility.Format_Error_Backtrace;
    WHEN excepDiaTRMInvalido THEN
      onuCodigoError := -2;
      osbMensajeError := 'La entrada debe ser una fecha valida en formato YYYY-MM-DD';
    WHEN excepXMLInvalido THEN
      onuCodigoError := -3;
      osbMensajeError := 'ERROR ESTRUCTURA XML: <Consulta TRM - prcConsultaTRM>: ';
    WHEN excepNoProcesoSOAP THEN
      onuCodigoError := -4;
      osbMensajeError := 'ERROR - excepNoProcesoSOAP: <Consulta TRM - prcConsultaTRM>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace || ' - ' || clRespuesta;
    WHEN excepRegistroTRM THEN
      onuCodigoError := -5;
      osbMensajeError := 'ERROR - excepRegistroTRM: <Consulta TRM - prcConsultaTRM>: Ocurrio un error registrando la TRM en OSF.' || ' - ' || osbMensajeError;
    WHEN OTHERS THEN
      onuCodigoError := -9999;
      osbMensajeError := SQLCODE || ' - ' || SQLERRM;
      osbMensajeError := 'ERROR - OTHERS: <Consulta TRM - prcConsultaTRM>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || osbMensajeError;
  END prcConsultaTRM;
  
END LDCI_PKG_BOINTEGRA_TRM;
/

BEGIN
	pkg_utilidades.praplicarpermisos('LDCI_PKG_BOINTEGRA_TRM', 'PERSONALIZACIONES');
	dbms_output.put_line('Permisos de la tabla PERSONALIZACIONES.LDCI_PKG_BOINTEGRA_TRM Ok.');
END;
/