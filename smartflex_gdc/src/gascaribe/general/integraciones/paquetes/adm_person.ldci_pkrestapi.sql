CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKRESTAPI AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKRESTAPI.sql
         AUTOR : Jose Donado
         FECHA : 13/09/2024

 DESCRIPCION : Paquete de integraciones,tiene como funcion principal el
               consumo de Servicios Web tipo REST desdes la base datos
               Caso IN-747.

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 JOSDON       13/09/2024  Creacion del paquete
************************************************************************/

sbStatusHttp      VARCHAR2(200);
sbErrorHttp       VARCHAR2(200);
sbMensaje         LDCI_mesaenvws.mesahttperror%TYPE;
sbTraceError      LDCI_mesaenvws.mesatraceerror%TYPE;
boolHttpError     BOOLEAN;
boolRESTError     BOOLEAN;
boolTimeOut       BOOLEAN;
sbRESTRequest     CLOB;
sbRESTResponse    CLOB;

PROCEDURE proSetProtocol(isbProtocol IN VARCHAR2);

PROCEDURE proSetProxyAuth(isbUsuario  IN VARCHAR2, isbPassword IN VARCHAR2);

PROCEDURE proSetProxyToken(isbToken IN VARCHAR2);

FUNCTION fsbClearChar(isbJson IN CLOB) RETURN CLOB;

FUNCTION fsbGetToken(inuUtilCod IN VARCHAR2) RETURN VARCHAR2;

FUNCTION fsbEncodeToken(isbToken IN VARCHAR2) RETURN VARCHAR2;

FUNCTION fsbDecodeToken(isbToken IN VARCHAR2) RETURN VARCHAR2;

FUNCTION fsbRESTSegmCallExtLargeSync(sbWSParam IN VARCHAR2, sbPayload IN CLOB) RETURN CLOB;

END LDCI_PKRESTAPI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKRESTAPI AS

sbUsuario VARCHAR2(100);
sbPassword VARCHAR2(100);
sbPasswordWallet VARCHAR2(100);
sbToken          VARCHAR2(3000);


-- En todos los casos si no s define el protocolo, por defeco usar? http
sbProtocol VARCHAR2(10) :=  'http';


/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : proSetProtocol
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 13/09/2024
 * Descripcion : Setea el tipo de protocolo para enviar las las peticiones
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado   13/09/2024    Creacion del procedimiento
**/

PROCEDURE proSetProtocol(isbProtocol IN VARCHAR2) AS
BEGIN
  sbProtocol := isbProtocol;
END;



/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : proSetProxyAuth
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 13/09/2024
 * Descripcion : Setea las credenciales necesairas para usar BASIC AUTHENTICATION
 *
 * Parametros
 *
 * isbUsuario   VARCHAR2
 * isbPassword  VARCHAR2
 * Autor              Fecha         Descripcion
 * Jose Donado        13/09/2024    Creacion del procedimiento
**/

-- ---------------------------------------------------------------------
PROCEDURE proSetProxyAuth(isbUsuario IN VARCHAR2, isbPassword IN VARCHAR2) AS
-- ---------------------------------------------------------------------
BEGIN
  sbUsuario  := isbUsuario;
  sbPassword := isbPassword;
END;

/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : proSetProxyToken
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 16/09/2024
 * Descripcion : Setea las credenciales necesairas para usar BASIC AUTHENTICATION
 *
 * Parametros
 *
 * isbToken   VARCHAR2
 * Autor              Fecha         Descripcion
 * Jose Donado        16/09/2024    Creacion del procedimiento
**/

-- ---------------------------------------------------------------------
PROCEDURE proSetProxyToken(isbToken IN VARCHAR2) AS
-- ---------------------------------------------------------------------
BEGIN
  sbToken  := isbToken;
END;

-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbClearChar
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 13/09/2024
 * Descripcion : Realiza la limpieza de los caracteres especiales
 *
 * Parametros
 *isbJson CLOB

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        13/09/2024    Creacion del procedimiento
**/


FUNCTION fsbClearChar  ( isbJson     IN CLOB  ) RETURN CLOB
IS
sbJsonOut CLOB:='';
nuContLimpia NUMBER:=1;
BEGIN
WHILE nuContLimpia <= DBMS_LOB.getlength(isbJson) LOOP

        sbJsonOut := sbJsonOut||CONVERT(DBMS_LOB.SUBSTR(isbJson, 15000 , nuContLimpia),'UTF8');

        nuContLimpia := nuContLimpia +15000;
    END LOOP;
RETURN sbJsonOut;

EXCEPTION
WHEN OTHERS THEN
     RETURN isbJson;
END;


-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbGetToken
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 17/09/2024
 * Descripcion : Obtiene el token configurado para determinada integracion
 *
 * Parametros
 * inuUtilCod VARCHAR2

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        17/09/2024    Creacion del procedimiento
**/
FUNCTION fsbGetToken(inuUtilCod IN VARCHAR2) RETURN VARCHAR2
IS
osbToken VARCHAR2(3000);
  CURSOR CuRestoreData IS
        SELECT UTILDATA
        FROM LDCI_utilws WHERE utilcod=inuUtilCod;
  rgRestore CuRestoreData%rowtype;

  BEGIN
    OPEN CuRestoreData;
      FETCH CuRestoreData INTO rgRestore;
    CLOSE CuRestoreData;

    RETURN rgRestore.UTILDATA;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN inuUtilCod;
END ;


-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbEncodeToken
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 13/09/2024
 * Descripcion : Realiza el la codificaci?n de token para su posterior almacenamiento
 *
 * Parametros
 *isbToken VARCHAR2

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        13/09/2024    Creacion del procedimiento
**/
FUNCTION fsbEncodeToken(isbToken IN VARCHAR2) RETURN VARCHAR2
IS
osbToken VARCHAR2(3000);
  BEGIN
    osbToken := utl_encode.text_encode(isbToken,'WE8ISO8859P1', UTL_ENCODE.BASE64);
    RETURN osbToken;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN isbToken;
END ;


-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbDecodeToken
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 13/09/2024
 * Descripcion : Realiza el la decodificacion de token para su posterior uso
 *
 * Parametros
 *isbToken VARCHAR2

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        13/09/2024    Creacion del procedimiento
**/
FUNCTION fsbDecodeToken(isbToken IN VARCHAR2) RETURN VARCHAR2
IS
osbToken VARCHAR2(3000);
  BEGIN
    osbToken := utl_encode.text_decode(isbToken,'WE8ISO8859P1', UTL_ENCODE.BASE64);
    RETURN osbToken;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN isbToken;
END ;


-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbRESTSegmCallExtLargeSync
 * Caso    : IN-747
 * Autor   : Jose Donado
 * Fecha   : 16/09/2024
 * Descripcion : Realiza consumo del servicio web REST EXTERNO en peticiones segmentadas
 *               Con el fin de evitar posibles inconvenientes de tamano de
 *               paquetes. Se utiliza para respuestas con un JSON de gran tamano
 *
 * Parametros
 *isbToken VARCHAR2

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        16/09/2024    Creacion del procedimiento
**/
FUNCTION fsbRESTSegmCallExtLargeSync  (sbWSParam IN VARCHAR2, sbPayload IN CLOB)
RETURN CLOB
  IS

  sbProtocolo             LDCI_CARASEWE.CASEVALO%TYPE;
  sbHost                  LDCI_CARASEWE.CASEVALO%TYPE;
  sbPuerto                LDCI_CARASEWE.CASEVALO%TYPE;
  sbMetodo                LDCI_CARASEWE.CASEVALO%TYPE;
  sbContentType           LDCI_CARASEWE.CASEVALO%TYPE;
  sbUrlWS                 LDCI_CARASEWE.CASEVALO%TYPE;
  sbMens                  varchar2(4000);

  sbUrwl                  VARCHAR2(2000);
  oclRespuesta            CLOB;
  req                     UTL_HTTP.req;
  resp                    UTL_HTTP.resp;
  sbSoapResponseSegmented CLOB;
  l_text                  VARCHAR2(32767);
  API_KEY                 VARCHAR2(1000);
  nuIndex                 NUMBER := 1;
  nuLength                NUMBER;
  errorPara01             EXCEPTION;

  BEGIN
    boolTimeOut      := FALSE;
    sbTraceError     := '';
    sbErrorHttp      := '';
    boolHttpError    := FALSE;

    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'PROTOCOLO', sbProtocolo, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    --
    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    --
    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    --
    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'METODO', sbMetodo, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    --
    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'CONTENT_TYPE', sbContentType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    --
    ldci_pkWebServUtils.proCaraServWeb(sbWSParam, 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    sbUrwl := lower(sbProtocolo) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    DBMS_OUTPUT.put_line(sbUrwl);

    nuLength:=nvl(length(sbPayload), 0);

    -- Set headers
    req := utl_http.begin_request(sbUrwl, sbMetodo);
    utl_http.set_header(req, 'content-type', sbContentType);
    utl_http.set_header(req, 'Authorization', sbToken);
    utl_http.set_header(req, 'content-length', length(sbPayload));
    utl_http.set_header (req, 'Transfer-Encoding', 'chunked');

    WHILE nuIndex <= nuLength LOOP
        utl_http.write_raw(req,  UTL_RAW.CAST_TO_RAW (substr(sbPayload,nuIndex , 15000)));
        nuIndex := nuIndex +15000;
    END LOOP;

    --se agrega linea para obtener mayor detalle de la excepcion
    utl_http.set_detailed_excp_support(TRUE);
    resp := utl_http.get_response(req);

    sbStatusHttp := resp.status_code;
    sbErrorHttp  := resp.reason_phrase;

    --armado por bloques de la respuesta
    DBMS_LOB.createtemporary(sbSoapResponseSegmented, false);
    BEGIN
        LOOP
          UTL_HTTP.read_text(resp, l_text, 2000);
          DBMS_LOB.writeappend (sbSoapResponseSegmented, LENGTH(l_text), l_text);
        END LOOP;
    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
          UTL_HTTP.end_response(resp);
    END;

    IF sbStatusHttp<>'200' THEN
        boolHttpError := TRUE;
        sbErrorHttp  := 'Fallo la conexion http status: ' || sbStatusHttp || ' - ' || sbErrorHttp;
        sbTraceError  := 'Sin traza disponible';
    END IF;

    oclRespuesta := sbSoapResponseSegmented;
    DBMS_LOB.freetemporary(sbSoapResponseSegmented);
    RETURN oclRespuesta;

EXCEPTION
  WHEN Errorpara01 THEN
    boolHttpError := TRUE;
    oclRespuesta  := 'Fallo obteniendo parametros ' || sbWSParam || ' - ' || SQLERRM;
    sbTraceError  := 'Traza: ' || DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp   := oclRespuesta;
    return oclRespuesta;

  WHEN UTL_HTTP.transfer_timeout Then

    boolHttpError := TRUE;
    oclRespuesta  := 'Se sobrepaso el tiempo limite de conexion ' || SQLERRM;
    sbTraceError  := 'Traza: ' || DBMS_UTILITY.format_error_backtrace;
    boolTimeOut   := true;
    sbErrorHttp   := oclRespuesta;
    return oclRespuesta;

  WHEN OTHERS THEN

    boolHttpError := TRUE;
    oclRespuesta  := 'Fallo Desconocido '||SQLERRM;
    sbTraceError  := 'Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp   := oclRespuesta;
    return oclRespuesta;
END fsbRESTSegmCallExtLargeSync;

End LDCI_PKRESTAPI;
/
BEGIN
  pkg_utilidades.praplicarpermisos('LDCI_PKRESTAPI', 'ADM_PERSON');
  dbms_output.put_line('Permisos de la tabla ADM_PERSON.LDCI_PKRESTAPI Ok.');
END;
/  