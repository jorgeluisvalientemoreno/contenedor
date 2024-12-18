CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKSOAPAPI AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P 

 PROCEDIMIENTO : LDCI_PKSOAPAPI.sql
         AUTOR : Hector Fabio Dominguez
         FECHA : 19/05/2011

 DESCRIPCION : Paquete de interfaz con SAP(PI),tiene como funcion principal el
               consumo de Servicios Web desdes la base datos
               Tiquete 143105.
 Parametros de Entrada

    isbUsuario    VARCHAR2
    isbPassword   VARCHAR2

 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    19/05/2011  Creacion del paquete
 HECTORFDV    14/05/2013  Ajustes caracteres especiales
 JOSDON       23/11/2023  INT-404 Modifcacion de paquete para manejo de respuestas de gran tamano
                          Creacion de Procedimiento fsbSoapSegmentedCallLargeSync para la mensajeria sincrona de gran tamano
************************************************************************/

sbStatusHttp      VARCHAR2(200);
sbErrorHttp       VARCHAR2(200);
sbMensaje         LDCI_mesaenvws.mesahttperror%TYPE;
sbTraceError      LDCI_mesaenvws.mesatraceerror%TYPE;
boolHttpError     BOOLEAN;
boolSoapError     BOOLEAN;
sbSoapRequest     CLOB;

PROCEDURE proSetProtocol(isbProtocol IN VARCHAR2);

PROCEDURE proSetProxyAuth(isbUsuario  IN VARCHAR2,
                          isbPassword IN VARCHAR2);

PROCEDURE proCreateSoapPackage(isbNameSpace  IN VARCHAR,
                               isbPayLoad    IN CLOB,
                               sbSoapRequest OUT CLOB);

FUNCTION fsbSoapCall
                    ( sbPayload     IN CLOB
                    , sbEndPoint    IN VARCHAR2
                    , sbSoapAction  IN VARCHAR2
                    , sbNameSpace IN VARCHAR2
                    ) return varchar2;

FUNCTION fsbClearChar  ( isbXml     IN CLOB  ) RETURN CLOB;

FUNCTION fsbSoapSegmentedCallLargeSync
                                (sbPayload     IN CLOB,
                                 sbEndPoint    IN VARCHAR2,
                                 sbSoapAction  IN VARCHAR2,
                                 sbNameSpace   IN VARCHAR2)
RETURN CLOB;

FUNCTION fsbSoapSegmentedCall
                                (sbPayload     IN CLOB,
                                 sbEndPoint    IN VARCHAR2,
                                 sbSoapAction  IN VARCHAR2,
                                 sbNameSpace   IN VARCHAR2)
RETURN CLOB;

FUNCTION fsbSoapSegmentedCallSync  ( sbPayload     IN CLOB,
                                      sbEndPoint    IN VARCHAR2,
                                      sbSoapAction  IN VARCHAR2,
                                      sbNameSpace IN VARCHAR2)
RETURN CLOB;

FUNCTION fsbSoapSegmentedCallSyncExt  ( sbWSParam   IN VARCHAR2,
                                      sbPayload     IN CLOB,
                                      sbEndPoint    IN VARCHAR2,
                                      sbSoapAction  IN VARCHAR2,
                                      sbNameSpace IN VARCHAR2)
RETURN CLOB;
END LDCI_PKSOAPAPI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKSOAPAPI AS

sbUsuario VARCHAR2(100);
sbPassword VARCHAR2(100);
sbPasswordWallet VARCHAR2(100);


-- En todos los casos si no s define el protocolo, por defeco usar? http
sbProtocol VARCHAR2(10) :=  'http';


/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proSetProtocol.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Setea el tipo de protocolo para enviar las las pticiones
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/
PROCEDURE proSetProtocol(isbProtocol IN VARCHAR2) AS
BEGIN
  sbProtocol := isbProtocol;
END;



/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proSetProtocol.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Setea las credenciales necesairas para usar BASIC AUTHENTICATION
 *
 * Parametros
 *
 * isbUsuario   VARCHAR2
 * isbPassword  VARCHAR2
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

-- ---------------------------------------------------------------------
PROCEDURE proSetProxyAuth(isbUsuario IN VARCHAR2, isbPassword IN VARCHAR2) AS
-- ---------------------------------------------------------------------
BEGIN
  sbUsuario  := isbUsuario;
  sbPassword := isbPassword;
END;
-- ---------------------------------------------------------------------
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : fsbClearChar.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Realiza la limpieza de los caracteres especiales
 *
 * Parametros

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del procedimiento
**/


FUNCTION fsbClearChar  ( isbXml     IN CLOB  ) RETURN CLOB
IS
sbXmlOut CLOB:='';
nuContLimpia NUMBER:=1;
BEGIN
WHILE nuContLimpia <= DBMS_LOB.getlength(isbXml) LOOP

        sbXmlOut := sbXmlOut||CONVERT(DBMS_LOB.SUBSTR(isbXml, 15000 , nuContLimpia),'UTF8');

        nuContLimpia := nuContLimpia +15000;
    END LOOP;
RETURN sbXmlOut;

EXCEPTION
WHEN OTHERS THEN
RETURN isbXml;
END;

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : fsbSoapCall.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Realiza el consumo del servicio web, en una sola peticion
 *
 * Parametros
 * sbPayload     IN CLOB
 * sbEndPoint    IN VARCHAR2
 * sbSoapAction  IN VARCHAR2
 * sbNameSpace IN VARCHAR2
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/


FUNCTION fsbSoapCall  ( sbPayload     IN CLOB,
                        sbEndPoint    IN VARCHAR2,
                        sbSoapAction  IN VARCHAR2,
                        sbNameSpace   IN VARCHAR2)
return VARCHAR2
  IS


    /*
     * Atributos necesarios para la seguridad
     */

    sbPathWallet LDCI_CARASEWE.CASEVALO%type;

    /*
    * Patametros necesarios para validacion SOAP
    *
    */

    sbSoapSuccess LDCI_CARASEWE.CASEVALO%type;

   /*
    * Atributos para guardar el contenido a setear durante la construccion de
    * la cacebera http
    *
    **/
    sbAcceptEncondig LDCI_CARASEWE.CASEVALO%type;
    sbContentType    LDCI_CARASEWE.CASEVALO%type;
    sbUserAgent      LDCI_CARASEWE.CASEVALO%type;
    sbSoapEncode     LDCI_CARASEWE.CASEVALO%type;

   /*
    * Variable que almace paquete de envio y recepcion SOAP
    */

    sbSoapResponse           CLOB;
    sbSoapResponseSegmented  VARCHAR2(3000);
    xSoapResponse            XMLTYPE;

   /*
    * Atributos para manejo de http request
    *
    */

    http_req       utl_http.req;
    http_resp      utl_http.resp;

   /*
    * Atributos para manejo de errores
    *
    */
    sbMens VARCHAR2(1000);

  BEGIN
  sbUsuario:=LDCI_PKAPIUTIL.procRestoreDataWS('UBA');
  sbPassword:=LDCI_PKAPIUTIL.procRestoreDataWS('PBA');
  sbPasswordWallet:=LDCI_PKAPIUTIL.procRestoreDataWS('PCD');
  sbSoapRequest:=null;
  sbMensaje := 'OK';
  sbTraceError:='Sin Traza Disponible';
  boolSoapError:=false;
  boolHttpError:=false;
  sbErrorHttp:=NULL;

 /*
  * Cargo los paraetros de validacion SOAP
  */
  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPSUCCESS',sbSoapSuccess,sbMens);


 /*
  * Cargo los paraetros Conexion http
  */
  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_CONTENTTYPE',sbContentType,sbMens);
  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_ACCEPT_ENCODING',sbAcceptEncondig,sbMens);
  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_USERAGENT',sbUserAgent,sbMens);

  /*
   * Cargo los parametros de seguridad
   */

   LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_PATH_WALLET',sbPathWallet,sbMens);
  /*
   * Limpio el payload para evitar que se genere timeout
   * por caracter de escape no terminado
   *
   */
  --sbPayload:=replace(sbPayload,chr(38)||'amp;','');
  /*
   * Invoco el prodedimiento que se encarga de contruir el paquete SOAP de
   * acuerdo al namspace y al payload.
   *
   */

   proCreateSoapPackage(sbNameSpace,sbPayload,sbSoapRequest);
   /*
    * limpio la cadena la peticion de caracteres
    */
   sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
   sbSoapRequest:=replace(replace(sbSoapRequest,chr(38),''),';','');
   /*
   ?* Cargo el certificado de la CA, en caso de que se use SSL
    *
    */

    IF lower(sbProtocol)='https' THEN
      utl_http.set_wallet(sbPathWallet,sbPasswordWallet);
    END IF;

    /*
   ?* Inicio la peticion http
    *
    */

    http_req:= utl_http.begin_request( sbEndPoint, 'POST', 'HTTP/1.1');
    utl_http.set_response_error_check(FALSE);

   /*
   ?* Seteo credenciales de autenticacion basica
    *
    */
    IF sbUsuario IS NOT NULL THEN
      utl_http.set_authentication(http_req,sbUsuario,sbPassword,'Basic',for_proxy => FALSE);
    END IF;


   /*
   ?* Creo la cabecera http
    *
    */
    utl_http.set_header(http_req, 'Accept-Encoding', sbAcceptEncondig);
    utl_http.set_header(http_req, 'Content-Type', sbContentType);
    utl_http.set_header(http_req, 'SOAPAction', sbSoapAction);
    utl_http.set_header(http_req, 'User-Agent', sbUserAgent);
    utl_http.set_header(http_req, 'Content-Length', length(sbSoapRequest));


   /*
    * Escribo el paquete soap en el POSTDATA de la cabecera http.
    */
    utl_http.write_text(http_req, sbSoapRequest);

    /*
     * Obtengo la respuesta del servidor http
     */

    http_resp:= utl_http.get_response(http_req);

    --dbms_output.put_line ( 'Status code: ' || http_resp.status_code );
    --dbms_output.put_line ( 'Reason phrase: ' || http_resp.reason_phrase );

    sbStatusHttp:=http_resp.status_code;
    sbErrorHttp:=http_resp.reason_phrase;

    /*
    FOR i IN 1..utl_http.get_header_count(http_resp) LOOP
      utl_http.get_header(http_resp, i, nameHeader, valueHeader);
      dbms_output.put_line(nameHeader || ': ' || valueHeader);
    END LOOP;
    */
/*
 * Este proceso se debe realizar especificamente con la funcion read-line, ya que
 * Para la version de oracle varias de las funciones de lectura
 * se encuentran bugueadas, mientras que read_line, no usa los parametros de tama?o de mensajes
 * lo que permite leer el mensaje a pesar del bug en la version de Oracle.
 */

 --dbms_output.put_line('Iniciando Lectura');
  BEGIN

    LOOP
        utl_http.read_line(http_resp, sbSoapResponseSegmented, TRUE);
        sbSoapResponse:=sbSoapResponse||sbSoapResponseSegmented;
        --dbms_output.put_line(sbSoapResponseSegmented);
    END LOOP;

   EXCEPTION
  WHEN utl_http.end_of_body THEN
     /*
      * Termino la conexion http
      */
       utl_http.end_response(http_resp);
  END;




  -- Si el paquete SOAP no corresponde al mensaje de exito, entonces hay un problema con el paquete SOAP enviado

  IF sbSoapSuccess<>sbSoapResponse THEN
    boolSoapError:=TRUE;
  END IF;

  /*
   * Se incluye control para status http diferente de 200
   */
  IF sbStatusHttp<>'200' THEN
    boolHttpError:=TRUE;
    sbMensaje:='Fallo la conexion http status: '||sbStatusHttp;
    sbTraceError:='Sin traza disponible';
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  END IF;

  RETURN sbSoapResponse;

EXCEPTION

  WHEN UTL_HTTP.init_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.request_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo realizando peticion HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.bad_argument Then

    boolHttpError:=TRUE;
    sbMensaje:='Se encontro malos argumentos al invocar el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.bad_url Then

    boolHttpError:=TRUE;
    sbMensaje:='La URL no es correcta '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.protocol_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error de protocolo http '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.unknown_scheme Then

    boolHttpError:=TRUE;
    sbMensaje:='La url esta malformada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.header_not_found Then

    boolHttpError:=TRUE;
    sbMensaje:='Cabecera no encontrada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.illegal_call Then

    boolHttpError:=TRUE;
    sbMensaje:='La llamada al api no se puede realizar en esta etapa del proceso '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.http_server_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error Interno del servidor'||SQLERRM;
    sbTraceError:='Trace: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.http_client_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.too_many_requests Then

    utl_http.end_response(http_resp);
    boolHttpError:=TRUE;
    sbMensaje:='Existen varias peticiones HTTP activas '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.partial_multibyte_char Then

    boolHttpError:=TRUE;
    sbMensaje:='La operacion solicitada no pudo leerse completamente, car?cter multibyte encontrado '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.transfer_timeout Then

    boolHttpError:=TRUE;
    sbMensaje:='Se sobrepaso el tiempo limite de conexi?n '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN OTHERS THEN

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Desconocido '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  END;

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proCreateSoapPackage.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Crea el paquete SOAP de acuerdo a los parametros configurados
 *
 * Parametros
 * isbNameSpace   IN VARCHAR,
 * isbPayLoad     IN CLOB,
 * sbSoapRequest  OUT CLOB
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/


PROCEDURE proCreateSoapPackage(isbNameSpace   IN VARCHAR,
                               isbPayLoad     IN CLOB,
                               sbSoapRequest  OUT CLOB)
IS

  sbHeaderSOAP LDCI_CARASEWE.CASEVALO%type;
  sbFooterSOAP LDCI_CARASEWE.CASEVALO%type;
  sbMens    VARCHAR2(1000);

BEGIN

  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPAPI_HEADER',sbHeaderSOAP,sbMens);
  LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPAPI_FOOTER',sbFooterSOAP,sbMens);
  sbHeaderSOAP:=REPLACE(sbHeaderSOAP,'[@INPARAMNAMESPACE]',isbNameSpace);
  sbSoapRequest:=sbHeaderSOAP||isbPayLoad||sbFooterSOAP;
END proCreateSoapPackage;

/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : proCreateSoapPackageExt
 * Tiquete : INT-404
 * Autor   : Jose Donado
 * Fecha   : 13/12/2023
 * Descripcion : Crea el paquete SOAP de acuerdo a los parametros configurados para servicios externos
 *
 * Parametros
 * isbWSParam     IN VARCHAR2
 * isbNameSpace   IN VARCHAR,
 * isbPayLoad     IN CLOB,
 * sbSoapRequest  OUT CLOB
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado   13/12/2023    Creacion del procedimiento
**/


PROCEDURE proCreateSoapPackageExt(isbWSParam    IN VARCHAR2,
                               isbNameSpace   IN VARCHAR,
                               isbPayLoad     IN CLOB,
                               sbSoapRequest  OUT CLOB)
IS

  sbHeaderSOAP LDCI_CARASEWE.CASEVALO%type;
  sbFooterSOAP LDCI_CARASEWE.CASEVALO%type;
  sbMens    VARCHAR2(1000);

BEGIN

  LDCI_pkWebServUtils.proCaraServWeb(isbWSParam,'WS_CONFIG_SOAPAPI_HEADER',sbHeaderSOAP,sbMens);
  LDCI_pkWebServUtils.proCaraServWeb(isbWSParam,'WS_CONFIG_SOAPAPI_FOOTER',sbFooterSOAP,sbMens);
  sbHeaderSOAP:=REPLACE(sbHeaderSOAP,'[@INPARAMNAMESPACE]',isbNameSpace);
  sbSoapRequest:=sbHeaderSOAP||isbPayLoad||sbFooterSOAP;
  
END proCreateSoapPackageExt;

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : fsbSoapSegmentedCall.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Realiza consumo del servicio web en peticiones segmentadas
 *               Con el fin de evitar posibles inconvenientes de tama?o de
 *               paquetes, esto para procesos asincronos, en la que es necesario
                 evaluar los datos de la respuesta y no solo
 *
 * Parametros
 * isbNameSpace   IN VARCHAR,
 * isbPayLoad     IN CLOB,
 * sbSoapRequest  OUT CLOB
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/04/2013    Creacion del procedimiento
 * Jose Donado        23/11/2023    INT-404 Modificacion para retornar CLOB e invocar funci?n para mensajer?a de gran tama?o fsbSoapSegmentedCallLargeSync
**/

FUNCTION fsbSoapSegmentedCallSync  ( sbPayload     IN CLOB,
                                      sbEndPoint    IN VARCHAR2,
                                      sbSoapAction  IN VARCHAR2,
                                      sbNameSpace IN VARCHAR2)
RETURN CLOB
  IS
  sbSoapResponse           CLOB;
  BEGIN

      sbSoapResponse:=fsbSoapSegmentedCallLargeSync( sbPayload,sbEndPoint,sbSoapAction,sbNameSpace);
      boolSoapError:=FALSE;
    return sbSoapResponse;
  END fsbSoapSegmentedCallSync;
  

/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbSoapSegmentedCallLargeSync
 * Jira    : INT-404
 * Autor   : Jose Donado
 * Fecha   : 23/11/2023
 * Descripcion : Realiza consumo del servicio web en peticiones segmentadas de
 *               Con el fin de evitar posibles inconvenientes de tamano de
 *               paquetes. Se utiliza para respuestas cuyo XML es muy grande
 *
 * Parametros
 * sbPayload   IN CLOB,
 * sbEndPoint     IN VARCHAR2,
 * sbSoapAction  IN VARCHAR2,
 *sbNameSpace IN VARCHAR2
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado   23/11/2023    Creacion del paquete
**/

FUNCTION fsbSoapSegmentedCallLargeSync  ( sbPayload     IN CLOB,
                                 sbEndPoint    IN VARCHAR2,
                                 sbSoapAction  IN VARCHAR2,sbNameSpace IN VARCHAR2)
RETURN CLOB
  IS




    /*
     * Atributos necesarios para la seguridad
     */

     sbPathWallet LDCI_CARASEWE.CASEVALO%type;

    /*
    * Patametros necesarios para validacion SOAP
    *
    */

    sbSoapSuccess LDCI_CARASEWE.CASEVALO%type;

   /*
    * Atributos para guardar el contenido a setear durante la contruccion de
    * la cacebera http
    *
    **/
    sbAcceptEncondig LDCI_CARASEWE.CASEVALO%type;
    sbContentType    LDCI_CARASEWE.CASEVALO%type;
    sbUserAgent      LDCI_CARASEWE.CASEVALO%type;

    /*
    * Variable que almace paquete de envio y recepcion SOAP
    */
    sbSoapResponse           CLOB;
    sbSoapResponseSegmented  CLOB;
    l_text           VARCHAR2(32767);
    /*
    * Atributos para manejo de http request
    *
    */

    http_req utl_http.req;
    http_resp utl_http.resp;

   /*
    * Atributos para control de segmetaci?n de paquetes http
    *
    */
    nuIndex    NUMBER;
    nuLength   NUMBER;

   /*
    *
    * Atributos para el manejo de erroes.
    *
    */

    sbMens VARCHAR2(1000);
     x PLS_INTEGER;



  BEGIN

  /*
   * Inicializaco variables de control de errores.
   */
    sbMensaje := 'OK';
    sbTraceError:='Sin Traza Disponible';
    boolSoapError:=false;
    boolHttpError:=false;
    sbErrorHttp:='';
    sbPasswordWallet:=LDCI_PKAPIUTIL.procRestoreDataWS('PCD');

   /*
    * Cargo los paraetros de validacion SOAP
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPSUCCESS',sbSoapSuccess,sbMens);

   /*
    * Cargo los paraetros Conexion http
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_CONTENTTYPE',sbContentType,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_ACCEPT_ENCODING',sbAcceptEncondig,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_USERAGENT',sbUserAgent,sbMens);

  /*
   * Cargo los parametros de seguridad
   */

   LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_PATH_WALLET',sbPathWallet,sbMens);
  /*
   * Limpio el payload para evitar que se genere timeout
   * por caracter de escape no terminado
   *
   */

  --sbPayload:=replace(sbPayload,chr(38)||'amp;','');
  /*
   * Invoco el prodedimiento que se encarga de contruirme el paquete SOAP de
   * acuerdo al namspace y al payload.
   *
   */

   proCreateSoapPackage(sbNameSpace,sbPayload,sbSoapRequest);

   /*
    * limpio la peticion de caracteres
    */

    sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
    sbSoapRequest:=REPLACE(REPLACE(sbSoapRequest,chr(38),''),';','');
    sbSoapRequest:=fsbClearChar  ( sbSoapRequest) ;
    /*
    sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(209),convert(chr(209),'UTF8')),chr(241),convert(chr(241),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(193),convert(chr(193),'UTF8')),chr(201),convert(chr(201),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(205),convert(chr(205),'UTF8')),chr(211),convert(chr(211),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(218),convert(chr(218),'UTF8')),chr(225),convert(chr(225),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(233),convert(chr(233),'UTF8')),chr(237),convert(chr(237),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(243),convert(chr(243),'UTF8')),chr(250),convert(chr(250),'UTF8'));
    sbSoapRequest:=REPLACE(REPLACE(sbSoapRequest,chr(33),CONVERT(chr(33),'UTF8')),chr(161),CONVERT(chr(161),'UTF8'));
    sbSoapRequest:=replace(sbSoapRequest,chr(204),convert(chr(204),'UTF8'));
    sbSoapRequest:=replace(sbSoapRequest,chr(192),convert(chr(192),'UTF8'));
    */

   /*
    * Setea el tamano de la peticion, para posteriormente fijar el Content Lengtn
    * Necesario en la creaci?n del paquete HTTp
    *
    */

   nuLength:=nvl(length(sbSoapRequest), 0);
   nuIndex:=1;

   /*
    * Verifico el si se usar? o no SSL, para cagrar el WALLET que contiene el
    * Certificado de la CA
    *
    */
    IF lower(sbProtocol)='https' THEN
      utl_http.set_wallet(sbPathWallet, sbPasswordWallet);
    END IF;

   /*
    * Inicio la Petici?n HTTP
    *
    */
   http_req:= utl_http.begin_request( sbEndPoint, 'POST', 'HTTP/1.1');

   /*
    * Verifico la informaci?n de las credenciales para setear BASIC AUTHENTICATION
    * en la paticion http o https
    */
   sbUsuario:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('UBA'));
   sbPassword:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('PBA'));

    IF sbUsuario IS NOT NULL THEN
      utl_http.set_authentication(http_req,sbUsuario,sbPassword,'Basic',for_proxy => FALSE);
    END IF;

   /*
    * Contruyo  el paquete http de envio, necesario y definido para el consumo
    * del servicio web
    */
    utl_http.set_header(http_req, 'Accept-Encoding', sbAcceptEncondig);
    utl_http.set_header(http_req, 'Content-Type', sbContentType);
    --utl_http.set_header(http_req, 'Content-Type', 'text/xml');
    utl_http.set_header(http_req, 'SOAPAction', sbSoapAction);
    utl_http.set_header(http_req, 'User-Agent', sbUserAgent);
    utl_http.set_header(http_req, 'Content-Length', nuLength);
    utl_http.set_header (http_req, 'Transfer-Encoding', 'chunked'); --carlosvl
    --utl_http.set_body_charset(http_req,'UTF-8');
   -- utl_http.set_transfer_timeout(800);
    --utl_http.get_transfer_timeout(x);
    --dbms_output.put_line(x);


  /*
   * Realizo segmentaci?n del la petici?n que se enviar?, con el fin de evitar
   * problemas al momento de enviar grandes volumenes de informaci?n.
   *
   */

   /*
    * Escribo el paquete soap en el POSTDATA de la cabecera http.
    */
    WHILE nuIndex <= nuLength LOOP
       /*
        * Escribo el paquete SOAP en el POSTDATA de la cabecera http. usando convert para
        * encodear al characterset que corresponde
        */

            utl_http.write_raw(http_req,  UTL_RAW.CAST_TO_RAW (substr(sbSoapRequest,nuIndex , 15000)));--funcional

        nuIndex := nuIndex +15000;
    END LOOP;

    /*
     * Obtengo la respuesta del servidor http
     */

    --se agrega l?nea para obtener mayor detalle de la excepci?n
    UTL_HTTP.set_detailed_excp_support(TRUE);

    http_resp:= utl_http.get_response(http_req);
    --utl_http.read_text(http_resp, sbSoapResponse);
    /*
     * Se obtiene el status de la respuesta http
     */
     sbStatusHttp:=http_resp.status_code;
     sbErrorHttp := http_resp.reason_phrase;
    /*
     * Este proceso se debe realizar especificamente con la funcion read-line, ya que
     * Para la version de oracle varias de las funciones de lectura
     * se encuentran bugueadas, mientras que read_line, no usa los parametros de tama?o de mensajes
     * lo que permite leer el mensaje a pesar del bug en la version de Oracle.
     */

    -- Initialize the CLOB.
    DBMS_LOB.createtemporary(sbSoapResponseSegmented, false);
    BEGIN
        LOOP
          UTL_HTTP.read_text(http_resp, l_text, 2000);
          DBMS_LOB.writeappend (sbSoapResponseSegmented, LENGTH(l_text), l_text);
        END LOOP;
    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
          UTL_HTTP.end_response(http_resp);
    END;

    sbSoapResponse := sbSoapResponseSegmented;
    -- Si el paquete SOAP no corresponde al mensaje de exito, entonces hay un problema con el paquete SOAP enviado
--Se quita esta validaci?n ya que s?lo aplica para respuesta de transacciones as?ncronas
/*    IF sbSoapSuccess<>sbSoapResponse THEN
      boolSoapError:=TRUE;
    END IF;*/

      /*
       * Se incluye control para status http diferente de 200
       */
    IF sbStatusHttp<>'200' THEN
        boolHttpError:=TRUE;
        sbMensaje:='Fallo la conexion http status: '||sbStatusHttp||'-'||sbErrorHttp;
        sbTraceError:='Sin traza disponible';
        sbErrorHttp:=sbMensaje;
    END IF;


    /*
     * Termino la petici?n http
     *
     */
    --utl_http.end_response(http_resp);
    DBMS_LOB.freetemporary(sbSoapResponseSegmented);
    return sbSoapResponse;

EXCEPTION

  WHEN UTL_HTTP.init_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.request_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo realizando peticion HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.bad_argument Then

    boolHttpError:=TRUE;
    sbMensaje:='Se encontro malos argumentos al invocar el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.bad_url Then

    boolHttpError:=TRUE;
    sbMensaje:='La URL no es correcta '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.protocol_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error de protocolo http '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.unknown_scheme Then

    boolHttpError:=TRUE;
    sbMensaje:='La url esta malformada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.header_not_found Then

    boolHttpError:=TRUE;
    sbMensaje:='Cabecera no encontrada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.illegal_call Then

    boolHttpError:=TRUE;
    sbMensaje:='La llamada al api no se puede realizar en esta etapa del proceso '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.http_server_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error Interno del servidor'||SQLERRM;
    sbTraceError:='Trace: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.http_client_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.too_many_requests Then

    utl_http.end_response(http_resp);
    boolHttpError:=TRUE;
    sbMensaje:='Existen varias peticiones HTTP activas '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.partial_multibyte_char Then

    boolHttpError:=TRUE;
    sbMensaje:='La operacion solicitada no pudo leerse completamente, car?cter multibyte encontrado '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.transfer_timeout Then

    boolHttpError:=TRUE;
    sbMensaje:='Se sobrepaso el tiempo limite de conexi?n '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN OTHERS THEN

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Desconocido '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


END;


/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbSoapSegmentedCallExtLargeSync
 * Jira    : INT-404
 * Autor   : Jose Donado
 * Fecha   : 13/12/2023
 * Descripcion : Realiza consumo del servicio web EXTERNO en peticiones segmentadas 
 *               Con el fin de evitar posibles inconvenientes de tamano de
 *               paquetes. Se utiliza para respuestas cuyo XML es muy grande
 *
 * Parametros
 * sbPayload   IN CLOB,
 * sbEndPoint     IN VARCHAR2,
 * sbSoapAction  IN VARCHAR2,
 *sbNameSpace IN VARCHAR2
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado   13/12/2023    Creacion del paquete
**/

FUNCTION fsbSoapSegmCallExtLargeSync  ( sbWSParam     IN VARCHAR2,
                                 sbPayload     IN CLOB,
                                 sbEndPoint    IN VARCHAR2,
                                 sbSoapAction  IN VARCHAR2,
                                 sbNameSpace IN VARCHAR2)
RETURN CLOB
  IS




    /*
     * Atributos necesarios para la seguridad
     */

     sbPathWallet LDCI_CARASEWE.CASEVALO%type;

    /*
    * Patametros necesarios para validacion SOAP
    *
    */

    sbSoapSuccess LDCI_CARASEWE.CASEVALO%type;

   /*
    * Atributos para guardar el contenido a setear durante la contruccion de
    * la cacebera http
    *
    **/
    sbAcceptEncondig LDCI_CARASEWE.CASEVALO%type;
    sbContentType    LDCI_CARASEWE.CASEVALO%type;
    sbUserAgent      LDCI_CARASEWE.CASEVALO%type;

    /*
    * Variable que almace paquete de envio y recepcion SOAP
    */
    sbSoapResponse           CLOB;
    sbSoapResponseSegmented  CLOB;
    l_text           VARCHAR2(32767);
    /*
    * Atributos para manejo de http request
    *
    */

    http_req utl_http.req;
    http_resp utl_http.resp;

   /*
    * Atributos para control de segmetaci?n de paquetes http
    *
    */
    nuIndex    NUMBER;
    nuLength   NUMBER;

   /*
    *
    * Atributos para el manejo de erroes.
    *
    */

    sbMens VARCHAR2(1000);
     x PLS_INTEGER;



  BEGIN

  /*
   * Inicializaco variables de control de errores.
   */
    sbMensaje := 'OK';
    sbTraceError:='Sin Traza Disponible';
    boolSoapError:=false;
    boolHttpError:=false;
    sbErrorHttp:='';
    sbPasswordWallet:=LDCI_PKAPIUTIL.procRestoreDataWS('PCD');

   /*
    * Cargo los paraetros de validacion SOAP
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPSUCCESS',sbSoapSuccess,sbMens);

   /*
    * Cargo los paraetros Conexion http
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_CONTENTTYPE',sbContentType,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_ACCEPT_ENCODING',sbAcceptEncondig,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_USERAGENT',sbUserAgent,sbMens);

  /*
   * Cargo los parametros de seguridad
   */

   LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_PATH_WALLET',sbPathWallet,sbMens);
  /*
   * Limpio el payload para evitar que se genere timeout
   * por caracter de escape no terminado
   *
   */

  --sbPayload:=replace(sbPayload,chr(38)||'amp;','');
  /*
   * Invoco el prodedimiento que se encarga de contruirme el paquete SOAP de
   * acuerdo al namspace y al payload.
   *
   */

   proCreateSoapPackageExt(sbWSParam,sbNameSpace,sbPayload,sbSoapRequest);

   /*
    * limpio la peticion de caracteres
    */

    sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
    sbSoapRequest:=REPLACE(REPLACE(sbSoapRequest,chr(38),''),';','');
    sbSoapRequest:=fsbClearChar  ( sbSoapRequest) ;

   /*
    * Setea el tamano de la peticion, para posteriormente fijar el Content Lengtn
    * Necesario en la creaci?n del paquete HTTp
    *
    */

   nuLength:=nvl(length(sbSoapRequest), 0);
   nuIndex:=1;

   /*
    * Verifico el si se usar? o no SSL, para cagrar el WALLET que contiene el
    * Certificado de la CA
    *
    */
    IF lower(sbProtocol)='https' THEN
      utl_http.set_wallet(sbPathWallet, sbPasswordWallet);
    END IF;

   /*
    * Inicio la Petici?n HTTP
    *
    */
   http_req:= utl_http.begin_request( sbEndPoint, 'POST', 'HTTP/1.1');

   /*
    * Verifico la informaci?n de las credenciales para setear BASIC AUTHENTICATION
    * en la paticion http o https
    
   sbUsuario:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('UBA'));
   sbPassword:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('PBA'));

    IF sbUsuario IS NOT NULL THEN
      utl_http.set_authentication(http_req,sbUsuario,sbPassword,'Basic',for_proxy => FALSE);
    END IF;
    
    */

   /*
    * Contruyo  el paquete http de envio, necesario y definido para el consumo
    * del servicio web
    */
    utl_http.set_header(http_req, 'Accept-Encoding', sbAcceptEncondig);
    utl_http.set_header(http_req, 'Content-Type', sbContentType);
    --utl_http.set_header(http_req, 'Content-Type', 'text/xml');
    utl_http.set_header(http_req, 'SOAPAction', sbSoapAction);
    utl_http.set_header(http_req, 'User-Agent', sbUserAgent);
    utl_http.set_header(http_req, 'Content-Length', nuLength);
    utl_http.set_header (http_req, 'Transfer-Encoding', 'chunked'); --carlosvl


  /*
   * Realizo segmentaci?n del la petici?n que se enviar?, con el fin de evitar
   * problemas al momento de enviar grandes volumenes de informaci?n.
   *
   */

   /*
    * Escribo el paquete soap en el POSTDATA de la cabecera http.
    */
    WHILE nuIndex <= nuLength LOOP
       /*
        * Escribo el paquete SOAP en el POSTDATA de la cabecera http. usando convert para
        * encodear al characterset que corresponde
        */

            utl_http.write_raw(http_req,  UTL_RAW.CAST_TO_RAW (substr(sbSoapRequest,nuIndex , 15000)));--funcional

        nuIndex := nuIndex +15000;
    END LOOP;

    /*
     * Obtengo la respuesta del servidor http
     */

    --se agrega l?nea para obtener mayor detalle de la excepci?n
    UTL_HTTP.set_detailed_excp_support(TRUE);

    http_resp:= utl_http.get_response(http_req);
    --utl_http.read_text(http_resp, sbSoapResponse);
    /*
     * Se obtiene el status de la respuesta http
     */
     sbStatusHttp:=http_resp.status_code;
     sbErrorHttp := http_resp.reason_phrase;
    /*
     * Este proceso se debe realizar especificamente con la funcion read-line, ya que
     * Para la version de oracle varias de las funciones de lectura
     * se encuentran bugueadas, mientras que read_line, no usa los parametros de tama?o de mensajes
     * lo que permite leer el mensaje a pesar del bug en la version de Oracle.
     */

    -- Initialize the CLOB.
    DBMS_LOB.createtemporary(sbSoapResponseSegmented, false);
    BEGIN
        LOOP
          UTL_HTTP.read_text(http_resp, l_text, 2000);
          DBMS_LOB.writeappend (sbSoapResponseSegmented, LENGTH(l_text), l_text);
        END LOOP;
    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
          UTL_HTTP.end_response(http_resp);
    END;

    sbSoapResponse := sbSoapResponseSegmented;

    /*
     * Se incluye control para status http diferente de 200
     */
    IF sbStatusHttp<>'200' THEN
        boolHttpError:=TRUE;
        sbMensaje:='Fallo la conexion http status: '||sbStatusHttp||'-'||sbErrorHttp;
        sbTraceError:='Sin traza disponible';
        sbErrorHttp:=sbMensaje;
    END IF;


    /*
     * Termino la petici?n http
     *
     */
    --utl_http.end_response(http_resp);
    DBMS_LOB.freetemporary(sbSoapResponseSegmented);
    return sbSoapResponse;

EXCEPTION

  WHEN UTL_HTTP.init_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.request_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo realizando peticion HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.bad_argument Then

    boolHttpError:=TRUE;
    sbMensaje:='Se encontro malos argumentos al invocar el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.bad_url Then

    boolHttpError:=TRUE;
    sbMensaje:='La URL no es correcta '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.protocol_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error de protocolo http '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.unknown_scheme Then

    boolHttpError:=TRUE;
    sbMensaje:='La url esta malformada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.header_not_found Then

    boolHttpError:=TRUE;
    sbMensaje:='Cabecera no encontrada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.illegal_call Then

    boolHttpError:=TRUE;
    sbMensaje:='La llamada al api no se puede realizar en esta etapa del proceso '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.http_server_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error Interno del servidor'||SQLERRM;
    sbTraceError:='Trace: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.http_client_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.too_many_requests Then

    utl_http.end_response(http_resp);
    boolHttpError:=TRUE;
    sbMensaje:='Existen varias peticiones HTTP activas '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.partial_multibyte_char Then

    boolHttpError:=TRUE;
    sbMensaje:='La operacion solicitada no pudo leerse completamente, car?cter multibyte encontrado '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.transfer_timeout Then

    boolHttpError:=TRUE;
    sbMensaje:='Se sobrepaso el tiempo limite de conexi?n '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN OTHERS THEN

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Desconocido '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


END fsbSoapSegmCallExtLargeSync;


/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : fsbSoapSegmentedCallSyncExt
 * Tiquete : INT-404
 * Autor   : Jose Donado
 * Fecha   : 13/12/2023
 * Descripcion : Realiza consumo del servicio web Externo en peticiones segmentadas
 *               Con el fin de evitar posibles inconvenientes de tamano de
 *               paquetes, esto para procesos sincronos, en la que es necesario
                 evaluar los datos de la respuesta
 *
 * Parametros
 * sbWSParam   IN VARCHAR2,
 * isbNameSpace   IN VARCHAR,
 * isbPayLoad     IN CLOB,
 * sbSoapRequest  OUT CLOB
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Jose Donado        13/12/2023    INT-404 Creacion de la funcion
**/

FUNCTION fsbSoapSegmentedCallSyncExt  ( sbWSParam   IN VARCHAR2,
                                      sbPayload     IN CLOB,
                                      sbEndPoint    IN VARCHAR2,
                                      sbSoapAction  IN VARCHAR2,
                                      sbNameSpace IN VARCHAR2)
RETURN CLOB
  IS
  sbSoapResponse           CLOB;
  BEGIN

      sbSoapResponse:=fsbSoapSegmCallExtLargeSync( sbWSParam,sbPayload,sbEndPoint,sbSoapAction,sbNameSpace);

      boolSoapError:=FALSE;
    return sbSoapResponse;
  END fsbSoapSegmentedCallSyncExt;
  

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : fsbSoapSegmentedCall.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Realiza consumo del servicio web en peticiones segmentadas de
 *               Con el fin de evitar posibles inconvenientes de tama?o de
 *               paquetes
 *
 * Parametros
 * isbNameSpace   IN VARCHAR,
 * isbPayLoad     IN CLOB,
 * sbSoapRequest  OUT CLOB

 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

FUNCTION fsbSoapSegmentedCall  ( sbPayload     IN CLOB,
                                 sbEndPoint    IN VARCHAR2,
                                 sbSoapAction  IN VARCHAR2,sbNameSpace IN VARCHAR2)
RETURN CLOB
  IS




    /*
     * Atributos necesarios para la seguridad
     */

     sbPathWallet LDCI_CARASEWE.CASEVALO%type;

    /*
    * Patametros necesarios para validacion SOAP
    *
    */

    sbSoapSuccess LDCI_CARASEWE.CASEVALO%type;

   /*
    * Atributos para guardar el contenido a setear durante la contruccion de
    * la cacebera http
    *
    **/
    sbAcceptEncondig LDCI_CARASEWE.CASEVALO%type;
    sbContentType    LDCI_CARASEWE.CASEVALO%type;
    sbUserAgent      LDCI_CARASEWE.CASEVALO%type;

    /*
    * Variable que almace paquete de envio y recepcion SOAP
    */
    sbSoapResponse           CLOB;
    sbSoapResponseSegmented  VARCHAR2(3000);
    /*
    * Atributos para manejo de http request
    *
    */

    http_req utl_http.req;
    http_resp utl_http.resp;

   /*
    * Atributos para control de segmetaci?n de paquetes http
    *
    */
    nuIndex    NUMBER;
    nuLength   NUMBER;

   /*
    *
    * Atributos para el manejo de erroes.
    *
    */

    sbMens VARCHAR2(1000);
     x PLS_INTEGER;



  BEGIN

  /*
   * Inicializaco variables de control de errores.
   */
    sbMensaje := 'OK';
    sbTraceError:='Sin Traza Disponible';
    boolSoapError:=false;
    boolHttpError:=false;
    sbErrorHttp:='';
    sbPasswordWallet:=LDCI_PKAPIUTIL.procRestoreDataWS('PCD');

   /*
    * Cargo los paraetros de validacion SOAP
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SOAPSUCCESS',sbSoapSuccess,sbMens);

   /*
    * Cargo los paraetros Conexion http
    */
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_CONTENTTYPE',sbContentType,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_ACCEPT_ENCODING',sbAcceptEncondig,sbMens);
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_HTTP_USERAGENT',sbUserAgent,sbMens);

  /*
   * Cargo los parametros de seguridad
   */

   LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_PATH_WALLET',sbPathWallet,sbMens);
  /*
   * Limpio el payload para evitar que se genere timeout
   * por caracter de escape no terminado
   *
   */

  --sbPayload:=replace(sbPayload,chr(38)||'amp;','');
  /*
   * Invoco el prodedimiento que se encarga de contruirme el paquete SOAP de
   * acuerdo al namspace y al payload.
   *
   */

   proCreateSoapPackage(sbNameSpace,sbPayload,sbSoapRequest);

   /*
    * limpio la peticion de caracteres
    */

    sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
    sbSoapRequest:=REPLACE(REPLACE(sbSoapRequest,chr(38),''),';','');
    sbSoapRequest:=fsbClearChar  ( sbSoapRequest) ;
    /*
    sbSoapRequest:=replace(sbSoapRequest,chr(38)||'amp;','');
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(209),convert(chr(209),'UTF8')),chr(241),convert(chr(241),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(193),convert(chr(193),'UTF8')),chr(201),convert(chr(201),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(205),convert(chr(205),'UTF8')),chr(211),convert(chr(211),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(218),convert(chr(218),'UTF8')),chr(225),convert(chr(225),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(233),convert(chr(233),'UTF8')),chr(237),convert(chr(237),'UTF8'));
    sbSoapRequest:=replace(replace(sbSoapRequest,chr(243),convert(chr(243),'UTF8')),chr(250),convert(chr(250),'UTF8'));
    sbSoapRequest:=REPLACE(REPLACE(sbSoapRequest,chr(33),CONVERT(chr(33),'UTF8')),chr(161),CONVERT(chr(161),'UTF8'));
    sbSoapRequest:=replace(sbSoapRequest,chr(204),convert(chr(204),'UTF8'));
    sbSoapRequest:=replace(sbSoapRequest,chr(192),convert(chr(192),'UTF8'));
    */

   /*
    * Setea el tamano de la peticion, para posteriormente fijar el Content Lengtn
    * Necesario en la creaci?n del paquete HTTp
    *
    */

   nuLength:=nvl(length(sbSoapRequest), 0);
   nuIndex:=1;

   /*
    * Verifico el si se usar? o no SSL, para cagrar el WALLET que contiene el
    * Certificado de la CA
    *
    */
    IF lower(sbProtocol)='https' THEN
      utl_http.set_wallet(sbPathWallet, sbPasswordWallet);
    END IF;

   /*
    * Inicio la Petici?n HTTP
    *
    */
   http_req:= utl_http.begin_request( sbEndPoint, 'POST', 'HTTP/1.1');

   /*
    * Verifico la informaci?n de las credenciales para setear BASIC AUTHENTICATION
    * en la paticion http o https
    */
   sbUsuario:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('UBA'));
   sbPassword:=trim(LDCI_PKAPIUTIL.procRestoreDataWS('PBA'));

    IF sbUsuario IS NOT NULL THEN
      utl_http.set_authentication(http_req,sbUsuario,sbPassword,'Basic',for_proxy => FALSE);
    END IF;

   /*
    * Contruyo  el paquete http de envio, necesario y definido para el consumo
    * del servicio web
    */
    utl_http.set_header(http_req, 'Accept-Encoding', sbAcceptEncondig);
    utl_http.set_header(http_req, 'Content-Type', sbContentType);
    --utl_http.set_header(http_req, 'Content-Type', 'text/xml');
    utl_http.set_header(http_req, 'SOAPAction', sbSoapAction);
    utl_http.set_header(http_req, 'User-Agent', sbUserAgent);
    utl_http.set_header(http_req, 'Content-Length', nuLength);
    --utl_http.set_body_charset(http_req,'UTF-8');
   -- utl_http.set_transfer_timeout(800);
    --utl_http.get_transfer_timeout(x);
    --dbms_output.put_line(x);


  /*
   * Realizo segmentaci?n del la petici?n que se enviar?, con el fin de evitar
   * problemas al momento de enviar grandes volumenes de informaci?n.
   *
   */

   /*
    * Escribo el paquete soap en el POSTDATA de la cabecera http.
    */
    WHILE nuIndex <= nuLength LOOP
       /*
        * Escribo el paquete SOAP en el POSTDATA de la cabecera http. usando convert para
        * encodear al characterset que corresponde
        */

            utl_http.write_raw(http_req,  UTL_RAW.CAST_TO_RAW (substr(sbSoapRequest,nuIndex , 15000)));--funcional

        nuIndex := nuIndex +15000;
    END LOOP;

    /*
     * Obtengo la respuesta del servidor http
     */



    http_resp:= utl_http.get_response(http_req);
    --utl_http.read_text(http_resp, sbSoapResponse);
    /*
     * Se obtiene el status de la respuesta http
     */
     sbStatusHttp:=http_resp.status_code;
    /*
     * Este proceso se debe realizar especificamente con la funcion read-line, ya que
     * Para la version de oracle varias de las funciones de lectura
     * se encuentran bugueadas, mientras que read_line, no usa los parametros de tama?o de mensajes
     * lo que permite leer el mensaje a pesar del bug en la version de Oracle.
     */
      BEGIN

        LOOP
            utl_http.read_line(http_resp, sbSoapResponseSegmented, TRUE);
            sbSoapResponse:=sbSoapResponse||sbSoapResponseSegmented;
            --dbms_output.put_line(sbSoapResponseSegmented);
        END LOOP;

       EXCEPTION
      WHEN utl_http.end_of_body THEN
         /*
          * Termino la conexion http
          */
           utl_http.end_response(http_resp);
      END;

   -- Si el paquete SOAP no corresponde al mensaje de exito, entonces hay un problema con el paquete SOAP enviado

        IF sbSoapSuccess<>sbSoapResponse THEN
          boolSoapError:=TRUE;
        END IF;

          /*
           * Se incluye control para status http diferente de 200
           */
          IF sbStatusHttp<>'200' THEN
            boolHttpError:=TRUE;
            sbMensaje:='Fallo la conexion http status: '||sbStatusHttp;
            sbTraceError:='Sin traza disponible';
            sbErrorHttp:=sbMensaje;
          END IF;


    /*
     * Termino la petici?n http
     *
     */
    --utl_http.end_response(http_resp);

    return sbSoapResponse;

EXCEPTION

  WHEN UTL_HTTP.init_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.request_failed Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo realizando peticion HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.bad_argument Then

    boolHttpError:=TRUE;
    sbMensaje:='Se encontro malos argumentos al invocar el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.bad_url Then

    boolHttpError:=TRUE;
    sbMensaje:='La URL no es correcta '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.protocol_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error de protocolo http '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.unknown_scheme Then

    boolHttpError:=TRUE;
    sbMensaje:='La url esta malformada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.header_not_found Then

    boolHttpError:=TRUE;
    sbMensaje:='Cabecera no encontrada '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.illegal_call Then

    boolHttpError:=TRUE;
    sbMensaje:='La llamada al api no se puede realizar en esta etapa del proceso '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.http_server_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Error Interno del servidor'||SQLERRM;
    sbTraceError:='Trace: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
--

  WHEN UTL_HTTP.http_client_error Then

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Inicializado el paquete UTL_HTTP '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;
  --

  WHEN UTL_HTTP.too_many_requests Then

    utl_http.end_response(http_resp);
    boolHttpError:=TRUE;
    sbMensaje:='Existen varias peticiones HTTP activas '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN UTL_HTTP.partial_multibyte_char Then

    boolHttpError:=TRUE;
    sbMensaje:='La operacion solicitada no pudo leerse completamente, car?cter multibyte encontrado '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;

  WHEN UTL_HTTP.transfer_timeout Then

    boolHttpError:=TRUE;
    sbMensaje:='Se sobrepaso el tiempo limite de conexi?n '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


  WHEN OTHERS THEN

    boolHttpError:=TRUE;
    sbMensaje:='Fallo Desconocido '||SQLERRM;
    sbTraceError:='Traza: '||DBMS_UTILITY.format_error_backtrace;
    sbErrorHttp:=sbMensaje;
    return sbMensaje;


END;
End LDCI_PKSOAPAPI;
/

PROMPT Asignación de permisos para el método LDCI_PKSOAPAPI
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKSOAPAPI', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKSOAPAPI to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKSOAPAPI to INTEGRADESA;
/
