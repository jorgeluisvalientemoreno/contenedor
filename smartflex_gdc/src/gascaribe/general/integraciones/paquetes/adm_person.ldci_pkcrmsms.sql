CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMSMS AS
/*
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
   PAQUETE       : LDCI_PKCRMSMS
   AUTOR         : Jose Donado
   FECHA         : 14/07/2022
   JIRA          : INT-114
   DESCRIPCION: Paquete que tiene la logica de envio de SMS a celulares de cliente

  Historia de Modificaciones
  Autor   Fecha      Descripcion.
*/
  PROCEDURE PROENVIASMS(inuCliente IN OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                        isbCelulares IN VARCHAR2,
                        isbMensaje IN CLOB,
                        oclRespuesta OUT CLOB,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROENVIAWHATSAPP(inuCliente IN OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                        isbCelulares IN VARCHAR2,
                        isbParametros IN CLOB,
                        oclRespuesta OUT CLOB,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROVALIDACELS(isbCelulares IN VARCHAR2,
                        osbCelulares OUT VARCHAR2,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROLOGMSG(inuCliente IN OPEN.LDCI_LOGENVIOMSG.LEMCLIE%TYPE,
                      isbCelulares IN OPEN.LDCI_LOGENVIOMSG.LEMCELS%TYPE,
                      inuTipo IN OPEN.LDCI_LOGENVIOMSG.LEMTIPO%TYPE,
                      isbEstado IN OPEN.LDCI_LOGENVIOMSG.LEMESTA%TYPE,
                      idtFechaEnv IN OPEN.LDCI_LOGENVIOMSG.LEMFEEN%TYPE,
                      idtFechaResp IN OPEN.LDCI_LOGENVIOMSG.LEMFERE%TYPE,
                      iclRespuestaEnv IN OPEN.LDCI_LOGENVIOMSG.LEMREEN%TYPE,
                      isbRespuestaCli IN OPEN.LDCI_LOGENVIOMSG.LEMREUS%TYPE,
                      onuErrorCode OUT NUMBER,
                      osbErrorMessage OUT VARCHAR2);

END LDCI_PKCRMSMS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMSMS AS

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROENVIASMS
                  AUTOR : Jose Donado
                   FECHA : 14/07/2022

 DESCRIPCION : Procedimiento para armar y enviar el SMS a lista celulares

 Parametros de Entrada

 inuCliente -> Id de cliente al cual se le enviara SMS
 isbCelulares -> Lista de n?meros de celular, separadas por coma, al cual se le enviara SMS
 isbMensaje -> Mensaje a enviar

 Parametros de Salida

    oclRespuesta       JSON de respuesta del servicio
    onuErrorCode       Codigo de error del proceso
    osbErrorMessage    Mensaje de error del proceso

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROENVIASMS(inuCliente IN OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                        isbCelulares IN VARCHAR2,
                        isbMensaje IN CLOB,
                        oclRespuesta OUT CLOB,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2) AS

content                 CLOB;--varchar2(32000);
req                     utl_http.req;
resp                    utl_http.resp;
sbSoapResponseSegmented CLOB;
l_text                  VARCHAR2(32767);
sbCelulares             OPEN.GE_SUBSCRIBER.PHONE%TYPE;

sbUrwl                  OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbMethod                OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbContentType           OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbOriginator            OPEN.LDCI_CARASEWE.CASEDESC%TYPE;

sbStatusHttp            VARCHAR2(200) := '';
sbErrorHttp             VARCHAR2(200) := '';

errorParam              EXCEPTION; --Excepcion que verifica que ingresen los parametros de entrada
errorServicio           EXCEPTION; --Excepcion que verifica si no hay conexi?n al servicio de SMS

BEGIN

  --Carga Parametrizaciones del servicio
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_SMS','WSURL2',sbUrwl,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_SMS','METHOD',sbMethod,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_SMS','CONTENT_TYPE',sbContentType,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_SMS','ORIGINATOR',sbOriginator,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;

  --Seccion de validaciones a datos de entrada
  IF inuCliente IS NULL THEN
    onuErrorCode := -1;
    osbErrorMessage := 'Debe ingresar un ID de cliente valido';
    RETURN;
  END IF;

  PROVALIDACELS(isbCelulares,sbCelulares,onuErrorCode,osbErrorMessage);
  IF onuErrorCode <> 0 THEN
    RETURN;
  END IF;

  --Armado de mensaje de entrada para consumir el servicio
  content := '{ "originator": "' || sbOriginator || '", "recipients": [' || sbCelulares || '], "body": "' || isbMensaje || '" }';
  content := replace(content, chr(10), '');
  content := replace(content, chr(13), '');

  --armado y ejecuci?e peticion
  req := utl_http.begin_request(sbUrwl, sbMethod);
  utl_http.set_header(req, 'content-type', sbContentType);
  utl_http.set_header(req, 'content-length', length(content));
  utl_http.write_text(req, content);
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

  oclRespuesta := sbSoapResponseSegmented;

  DBMS_LOB.freetemporary(sbSoapResponseSegmented);

  DBMS_OUTPUT.put_line(content);

  IF sbStatusHttp <> '200' THEN
    sbErrorHttp := 'Fallo la conexion http status: ' || sbStatusHttp || '-' || sbErrorHttp;
    RAISE errorServicio;
  END IF;

  PROLOGMSG(inuCliente,sbCelulares,1,'ENVIADO',SYSDATE,NULL,oclRespuesta,NULL,onuErrorCode,osbErrorMessage);

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Exitoso';

  DBMS_OUTPUT.put_line('Codigo de error: ' || onuErrorCode || ' - Mensaje: ' || osbErrorMessage);
  DBMS_OUTPUT.put_line(oclRespuesta);

EXCEPTION
  WHEN errorParam THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR PARAMETROS: <Envio de SMS - PROENVIASMS>: ' || Dbms_Utility.Format_Error_Backtrace;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_SMS', 2, osbErrorMessage, null, null);
  WHEN errorServicio THEN
    onuErrorCode := -2;
    osbErrorMessage := 'Error al conectar al servicio de SMS: ' || sbErrorHttp;
    osbErrorMessage := 'ERROR - OTHERS: <Envio de SMS - PROENVIASMS>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_SMS', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Cliente -> ' || inuCliente || ' - Celulares -> ' || isbCelulares || ' - Mensaje -> ' || isbMensaje, null);
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Envio de SMS - PROENVIASMS>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_SMS', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Cliente -> ' || inuCliente || ' - Celulares -> ' || isbCelulares || ' - Mensaje -> ' || isbMensaje, null);
END PROENVIASMS;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROENVIAWHATSAPP
                  AUTOR : Jose Donado
                   FECHA : 22/08/2022

 DESCRIPCION : Procedimiento para armar y enviar mensaje de Whatsapp a lista de celulares

 Parametros de Entrada

 inuCliente -> Id de cliente al cual se le enviara Whatsapp
 isbCelulares -> Lista de numeros de celular, separadas por coma, al cual se le enviara Whatsapp
 isbParametros -> cadena con los parametros de la plantilla

 Parametros de Salida

    clRespuesta        JSON de respuesta del servicio
    onuErrorCode       Codigo de error del proceso
    osbErrorMessage    Mensaje de error del proceso

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROENVIAWHATSAPP(inuCliente IN OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                        isbCelulares IN VARCHAR2,
                        isbParametros IN CLOB,
                        oclRespuesta OUT CLOB,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2) AS

content                 CLOB;--VARCHAR2(32000);
req                     utl_http.req;
resp                    utl_http.resp;
sbSoapResponseSegmented CLOB;
l_text                  VARCHAR2(32767);
sbCelulares             OPEN.GE_SUBSCRIBER.PHONE%TYPE;
sbParametros            CLOB;

sbUrwl                  OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbMethod                OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbContentType           OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbIntegrationId         OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbNameSpace             OPEN.LDCI_CARASEWE.CASEDESC%TYPE;
sbPlantilla             OPEN.LDCI_CARASEWE.CASEDESC%TYPE;

sbStatusHttp            VARCHAR2(200) := '';
sbErrorHttp             VARCHAR2(200) := '';

errorParam              EXCEPTION; --Excepcion que verifica que ingresen los parametros de entrada
errorServicio           EXCEPTION; --Excepcion que verifica si no hay conexi?n al servicio de whatsapp

CURSOR cuParametros(sbParams CLOB) IS
SELECT regexp_substr(TO_CHAR(sbParams),'[^|]+', 1, LEVEL) Parametro
FROM dual
CONNECT BY regexp_substr(TO_CHAR(sbParams), '[^|]+', 1, LEVEL) IS NOT NULL;

CURSOR cuCelulares(sbCel VARCHAR2) IS
SELECT regexp_substr(sbCel,'[^,]+', 1, LEVEL) Celular
FROM dual
CONNECT BY regexp_substr(sbCel, '[^,]+', 1, LEVEL) IS NOT NULL;

rgCelulares cuCelulares%ROWTYPE;
rgParametros cuParametros%ROWTYPE;

BEGIN

  --Carga Parametrizaciones del servicio
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','WSURL',sbUrwl,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','METHOD',sbMethod,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','CONTENT_TYPE',sbContentType,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','INTEGRATION_ID',sbIntegrationId,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','NAMESPACE',sbNameSpace,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;
  LDCI_pkWebServUtils.proCaraServWeb('WS_ENVIA_WA','PLANTILLA',sbPlantilla,osbErrorMessage);
  IF(osbErrorMessage != '0') THEN
       RAISE errorParam;
  END IF;

  --Seccion de validaciones a datos de entrada
  IF inuCliente IS NULL THEN
    onuErrorCode := -1;
    osbErrorMessage := 'Debe ingresar un ID de cliente valido';
    RETURN;
  END IF;

  PROVALIDACELS(isbCelulares,sbCelulares,onuErrorCode,osbErrorMessage);
  IF onuErrorCode <> 0 THEN
    RETURN;
  END IF;

  --Armado dinamico de la cadena de parametros
  FOR rgParametros IN cuParametros(isbParametros)
    LOOP
      sbParametros := sbParametros || '{
                            "type": "text",
                            "text": "' || rgParametros.Parametro || '"
                        },';
  END LOOP;

  sbParametros := RTRIM(sbParametros,',');

  FOR rgCelulares IN cuCelulares(sbCelulares)
  LOOP

    BEGIN
      --Armado de mensaje de entrada para consumir el servicio
      content := '{
        "destination": {
            "integrationId": "' || sbIntegrationId || '",
            "destinationId": ' || rgCelulares.Celular || '
        },
        "author": {
            "role": "appMaker"
        },
        "messageSchema": "whatsapp",
        "message": {
            "type": "template",
            "template": {
                "namespace": "' || sbNameSpace || '",
                "name": "' || sbPlantilla || '",
                "language": {
                    "policy": "deterministic",
                    "code": "es"
                },
                "components": [
                    {
                        "type": "body",
                        "parameters": [' || sbParametros || ']
                    }
                ]
            }
        }
    }';
      content := replace(content, chr(10), '');
      content := replace(content, chr(13), '');

      --armado y ejecuci?e peticion
      req := utl_http.begin_request(sbUrwl, sbMethod);
      utl_http.set_header(req, 'content-type', sbContentType);
      utl_http.set_header(req, 'content-length', length(content));
      utl_http.write_text(req, content);
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

      oclRespuesta := sbSoapResponseSegmented;

      DBMS_LOB.freetemporary(sbSoapResponseSegmented);

      DBMS_OUTPUT.put_line(content);

      IF sbStatusHttp <> '200' THEN
        sbErrorHttp := 'Fallo la conexion http status: ' || sbStatusHttp || '-' || sbErrorHttp;
        RAISE errorServicio;
      END IF;

      PROLOGMSG(inuCliente,rgCelulares.Celular,2,'ENVIADO',SYSDATE,NULL,oclRespuesta,NULL,onuErrorCode,osbErrorMessage);
    EXCEPTION
      WHEN errorServicio THEN
        onuErrorCode := -2;
        osbErrorMessage := 'Error al conectar al servicio de whatsapp: ' || sbErrorHttp;
        osbErrorMessage := 'ERROR - OTHERS: <Envio de Whatsapp - PROENVIAWHATSAPP>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
        LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_WA', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Cliente -> ' || inuCliente || ' - Celular -> ' || rgCelulares.Celular || ' - Parametros -> ' || isbParametros, null);
    END;
  END LOOP;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Exitoso';

  DBMS_OUTPUT.put_line('Codigo de error: ' || onuErrorCode || ' - Mensaje: ' || osbErrorMessage);
  DBMS_OUTPUT.put_line(oclRespuesta);

EXCEPTION
  WHEN errorParam THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR PARAMETROS: <Envio de Whatsapp - PROENVIAWHATSAPP>: ' || Dbms_Utility.Format_Error_Backtrace;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_WA', 2, osbErrorMessage, null, null);
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Envio de Whatsapp - PROENVIAWHATSAPP>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_WA', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Cliente -> ' || inuCliente || ' - Celulares -> ' || isbCelulares || ' - Parametros -> ' || isbParametros, null);
END PROENVIAWHATSAPP;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROVALIDACELS
                 AUTOR : Jose Donado
                 FECHA : 22/08/2022

 DESCRIPCION : Procedimiento para validar formato de la cadena de celulares

 Parametros de Entrada

 isbCelulares -> Cadena de n?meros celulares

 Parametros de Salida

    osbCelulares       Lista depurada de n?meros celulares separada por coma
    onuErrorCode       Codigo de error del proceso
    osbErrorMessage    Mensaje de error del proceso

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROVALIDACELS(isbCelulares IN VARCHAR2,
                        osbCelulares OUT VARCHAR2,
                        onuErrorCode OUT NUMBER,
                        osbErrorMessage OUT VARCHAR2) AS

sbCels                  VARCHAR2(2000) := '';

CURSOR cuCelulares(sbCel VARCHAR2) IS
SELECT regexp_substr(sbCel,'[^,]+', 1, LEVEL) Celular
FROM dual
CONNECT BY regexp_substr(sbCel, '[^,]+', 1, LEVEL) IS NOT NULL;

rgCelulares cuCelulares%ROWTYPE;

BEGIN

  osbCelulares := isbCelulares;

  IF isbCelulares IS NULL THEN
    onuErrorCode := -1;
    osbErrorMessage := 'Debe ingresar la cadena de celulares a validar';
    RETURN;
  END IF;

  --Se procede depurar y verificar si la cadena de celulares contiene informacion valida
  osbCelulares := REGEXP_REPLACE(TRIM(osbCelulares),'[^[:digit:]-|,;/\]',''); --Elimina cualquier caracter no numerico, diferente a separadores (-|,;/\])
  osbCelulares := LTRIM(osbCelulares,'0');--Elimina ceros a la izquierda
  osbCelulares := REGEXP_REPLACE(osbCelulares,'[,;/|\-]',',');--Reemplaza cualquier caracter separador por coma

  IF LENGTH(NVL(TRIM(osbCelulares),' ')) < 10 THEN
    onuErrorCode := -1;
    osbErrorMessage := 'Debe ingresar un numero celular valido';
    RETURN;
  END IF;

  --Separa cada n?mero de celular enviado en la cadena, para proceder a validarlo
  FOR rgCelulares IN cuCelulares(osbCelulares)
    LOOP
      IF LENGTH(TRIM(rgCelulares.Celular)) < 10 THEN
        CONTINUE;
      END IF;

      IF SUBSTR(rgCelulares.Celular,1,2) <> '57' THEN
        sbCels := sbCels || '"57' || rgCelulares.Celular || '",';
      ELSE
        sbCels := sbCels || '"' || rgCelulares.Celular || '",';
      END IF;
  END LOOP;

  sbCels := RTRIM(sbCels,',');
  osbCelulares := sbCels;

  onuErrorCode := 0;
  osbErrorMessage := 'Cadena de celulares depuarada';

EXCEPTION
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <LDCI_PKCRMSMS.PROVALIDACELS>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKCRMSMS.provalidacels', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Celulares -> ' || isbCelulares, null);
END PROVALIDACELS;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROLOGMSG
                 AUTOR : Jose Donado
                 FECHA : 25/07/2022

 DESCRIPCION : Procedimiento registro de log

 Parametros de Entrada

 inuCliente -> Id de cliente al cual se le enviara SMS
 isbCelulares -> Lista de numeros de celular
 inuTipo -> Tipo de mensaje [1-SMS, 2-WHATSAPP]
 isbEstado -> Estado del mensaje
 idtFechaEnv -> Fecha de envio del mensaje
 idtFechaResp -> Fecha respuesta de cliente
 iclRespuestaEnv -> Respuesta del servicio de envio de mensaje
 isbRespuestaCli -> Respuesta de cliente

 Parametros de Salida

    onuErrorCode       Codigo de error del proceso
    osbErrorMessage    Mensaje de error del proceso

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROLOGMSG(inuCliente IN OPEN.LDCI_LOGENVIOMSG.LEMCLIE%TYPE,
                    isbCelulares IN OPEN.LDCI_LOGENVIOMSG.LEMCELS%TYPE,
                    inuTipo IN OPEN.LDCI_LOGENVIOMSG.LEMTIPO%TYPE,
                    isbEstado IN OPEN.LDCI_LOGENVIOMSG.LEMESTA%TYPE,
                    idtFechaEnv IN OPEN.LDCI_LOGENVIOMSG.LEMFEEN%TYPE,
                    idtFechaResp IN OPEN.LDCI_LOGENVIOMSG.LEMFERE%TYPE,
                    iclRespuestaEnv IN OPEN.LDCI_LOGENVIOMSG.LEMREEN%TYPE,
                    isbRespuestaCli IN OPEN.LDCI_LOGENVIOMSG.LEMREUS%TYPE,
                    onuErrorCode OUT NUMBER,
                    osbErrorMessage OUT VARCHAR2) AS

PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

  INSERT INTO OPEN.LDCI_LOGENVIOMSG(LEMCLIE,LEMCELS,LEMTIPO,LEMESTA,LEMFEEN,LEMFERE,LEMREEN,LEMREUS)
  VALUES(inuCliente,isbCelulares,inuTipo,isbEstado,idtFechaEnv,idtFechaResp,iclRespuestaEnv,isbRespuestaCli);

  COMMIT;

  onuErrorCode := 0;
  osbErrorMessage := 'Registro de log exitoso';

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Log Envio de SMS - PROLOGMSG>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
    LDCI_pkWebServUtils.Procrearerrorlogint('WS_ENVIA_SMS', 2, osbErrorMessage, 'INFORMACION DE ENTRADA: Cliente -> ' || inuCliente, null);
END PROLOGMSG;


END LDCI_PKCRMSMS;
/

PROMPT Asignación de permisos para el paquete LDCI_PKCRMSMS
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKCRMSMS', 'ADM_PERSON');
end;
/
