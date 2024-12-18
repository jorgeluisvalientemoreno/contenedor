CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKOUTBOX IS
  /*****************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKOUTBOX
   Descripcion : Paquete de integraciones personalizado.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   02-08-2018       Sebastian Tapias      Se modifican los metodos <<proGeneraMensajeSOAP>>
                                                                   <<ProNotiResOutboxDet>>
  *****************************************************************/

  PROCEDURE proRegistraOutboxDet(inuinboxdet_id    in LDCI_OUTBOXDET.inboxdet_id%type,
                                 isbsystem         in LDCI_OUTBOXDET.sistema%type,
                                 isboperation      in LDCI_OUTBOXDET.operacion%type,
                                 inucontract       in LDCI_OUTBOXDET.CONTRATO%type,
                                 inuproduct        in LDCI_OUTBOXDET.PRODUCTO%type,
                                 inuoperative_unit in LDCI_OUTBOXDET.UNIDAD_OPERATIVA%type,
                                 inuorder          in LDCI_OUTBOXDET.orden%type,
                                 inuprocess_id     in LDCI_OUTBOXDET.proceso_id%type,
                                 inuId_Externo     in LDCI_OUTBOXDET.ID_EXTERNO%type,
                                 osbXMLRespuesta   in LDCI_PKREPODATAtype.tytabRespuesta,
                                 onuErrorCodi      in number,
                                 onucode_osf       out LDCI_INBOX.codigo_osf%type,
                                 osbmessage_osf    out LDCI_INBOX.mensaje_osf%type);

  procedure ProNotiResOutboxDet(isbsystem    in LDCI_OUTBOXDET.sistema%type,
                                isboperation in LDCI_OUTBOXDET.operacion%type);

  procedure proGeneraMensajeSOAP(isbsystem       IN LDCI_OUTBOXDET.sistema%TYPE,
                                 isboperation    IN LDCI_OUTBOXDET.operacion%TYPE,
                                 inuLote         IN NUMBER,
                                 onuErrorCode    OUT NUMBER,
                                 osbErrorMessage OUT VARCHAR2);
END LDCI_PKOUTBOX;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKOUTBOX IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKOUTBOX
   Descripcion : Paquete de integraciones personalizado.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   02-08-2018       Sebastian Tapias      Se modifican los metodos <<proGeneraMensajeSOAP>>
                                                                   <<ProNotiResOutboxDet>>
  ************************************************************************************************************/
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : proRegistraOutboxDet
   Descripcion : Servicio encargado de Insertar datos en la tabla LDCI_OUTBOXDET
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proRegistraOutboxDet(inuinboxdet_id    in LDCI_OUTBOXDET.inboxdet_id%type,
                                 isbsystem         in LDCI_OUTBOXDET.sistema%type,
                                 isboperation      in LDCI_OUTBOXDET.operacion%type,
                                 inucontract       in LDCI_OUTBOXDET.CONTRATO%type,
                                 inuproduct        in LDCI_OUTBOXDET.PRODUCTO%type,
                                 inuoperative_unit in LDCI_OUTBOXDET.UNIDAD_OPERATIVA%type,
                                 inuorder          in LDCI_OUTBOXDET.orden%type,
                                 inuprocess_id     in LDCI_OUTBOXDET.proceso_id%type,
                                 inuId_Externo     in LDCI_OUTBOXDET.ID_EXTERNO%type,
                                 osbXMLRespuesta   in LDCI_PKREPODATAtype.tytabRespuesta,
                                 onuErrorCodi      in number,
                                 onucode_osf       out LDCI_INBOX.codigo_osf%type,
                                 osbmessage_osf    out LDCI_INBOX.mensaje_osf%type) AS
    contIdOutboxDet number(15) := 0;
    menErr          LDCI_OUTBOXDET.Mensaje_Osf%type; -- mensaje de error
    codigoInbox     LDCI_OUTBOXDET.CODIGO%type;
    i               number;
    tyRegRespuesta  LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;
    nuevoCod        LDCI_OUTBOXDET.CODIGO%type;
    contCorrectos   number default 0;
    contError       number default 0;

  BEGIN

    nuevoCod := S_LDCI_OUTBOXDET.NEXTVAL;
    INSERT INTO LDCI_OUTBOXDET
      (codigo,
       inboxdet_id,
       sistema,
       operacion,
       estado,
       fecha_registro,
       contrato,
       producto,
       unidad_operativa,
       orden,
       proceso_id,
       id_externo)

    VALUES
      (nuevoCod,
       inuinboxdet_id,
       isbsystem,
       isboperation,
       'R',
       sysdate,
       inucontract,
       inuproduct,
       inuoperative_unit,
       inuorder,
       inuprocess_id,
       inuId_Externo);

    --VALIDA QUE EL CODIGO ERROR Y XML DE RESPUESTA NO ESTE NULL
    IF NVL(onuErrorCodi, 0) = 0 THEN

      --ACTUALIZA LA SOLICITUD A GESTIONADA
      UPDATE LDCI_INBOXDET
         SET ESTADO = 'P', FECHA_PROCESADO = SYSDATE
       WHERE CODIGO = nuevoCod;

      FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
        contIdOutboxDet := contIdOutboxDet + 1;
        --REGISTRA EL RESULTADO DEL XML DE RESPUESTA en la
        --tabla  LDCI_OUTBOXDETVAL
        INSERT INTO LDCI_OUTBOXDETVAL
          (outboxdet_id, parametro_id, valor)
        VALUES
          (nuevoCod,
           osbXMLRespuesta(i).PARAMETRO,
           osbXMLRespuesta(i).VALOR);

        --ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
        if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
          UPDATE LDCI_INBOXDET
             SET CODIGO_OSF = osbXMLRespuesta(i).VALOR
           WHERE CODIGO = nuevoCod;
        elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
          UPDATE LDCI_INBOXDET
             SET MENSAJE_OSF = osbXMLRespuesta(i).VALOR
           WHERE CODIGO = nuevoCod;

        end if;

      END LOOP;
      contCorrectos := contCorrectos + 1;
      COMMIT;

    ELSE

      --ACTUALIZA LA SOLICITUD A GESTIONADA CON ERROR
      --DBMS_OUTPUT.PUT_LINE('ID: [' || nuevoCod || '] Fue gestionado con error.');
      UPDATE LDCI_INBOXDET
         SET ESTADO = 'RE', FECHA_PROCESADO = sysdate
       WHERE CODIGO = nuevoCod;

      contIdOutboxDet := 0;
      FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
        contIdOutboxDet := contIdOutboxDet + 1;
        --REGISTRA EL RESULTADO DEL XML DE RESPUESTA en la
        --tabla LDCI_OUTBOXDETVAL
        INSERT INTO LDCI_OUTBOXDETVAL
          (outboxdet_id, parametro_id, valor)
        VALUES
          (nuevoCod,
           osbXMLRespuesta(i).PARAMETRO,
           osbXMLRespuesta(i).VALOR);
        --ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
        if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
          UPDATE LDCI_INBOXDET
             SET CODIGO_OSF = osbXMLRespuesta(i).VALOR
           WHERE CODIGO = nuevoCod;
        elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
          UPDATE LDCI_INBOXDET
             SET MENSAJE_OSF = osbXMLRespuesta(i).VALOR
           WHERE CODIGO = nuevoCod;

        end if;
      END LOOP;
      contError := contError + 1;
      COMMIT;

    END IF;
    onucode_osf    := 0;
    osbmessage_osf := null;
    commit;
  EXCEPTION
    WHEN OTHERS THEN

      onucode_osf    := -1;
      osbmessage_osf := SQLERRM;
      dbms_output.put_line('Error al ejecutar el paquete LDCI_PKOUTBOX');
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKOUTBOX.proRegistraOutboxDet',
                                              1,
                                              'El proceso fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace || ' ' ||
                                              SQLERRM,
                                              null,
                                              null);
  END proRegistraOutboxDet;
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : ProNotiResOutboxDet
   Descripcion : Servicio encargado de mostrar  notificaciones de respuesta
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   02-08-2018       Sebastian Tapias      Se realiza logica para lotear registros
                                          y enviar respuestas.
  ************************************************************************************************************/
  PROCEDURE ProNotiResOutboxDet(isbsystem    in LDCI_OUTBOXDET.sistema%type,
                                isboperation in LDCI_OUTBOXDET.operacion%type) is

    CURSOR cuLDCI_OUTBOXDET IS
      SELECT MENS.CODIGO,
             MENS.SISTEMA,
             MENS.OPERACION,
             MENS.ORDEN,
             MENS.ESTADO
        FROM LDCI_OUTBOXDET MENS
       WHERE MENS.ESTADO = 'R'
         AND MENS.SISTEMA = isbsystem --REQ.200-2027 Nuevos Filtros.
         AND MENS.OPERACION = isboperation; --REQ.200-2027 Nuevos Filtros.

    onuErrorCode    NUMBER := 0;
    osbErrorMessage VARCHAR2(2000);
    sbEstado_Notif  LDCI_OUTBOXDET.ESTADO%Type;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
    --REQ.200-2027 Nuevas variables.
    nuLote         NUMBER := null; -- Variable para crear los lotes
    nuGuia         NUMBER := 0; -- Guia para saber la posicion del conteo.
    nuMaxGuia      NUMBER := open.dald_parameter.fnuGetNumeric_Value('LDCI_NUM_MENSAJE_RESPUESTA_XML',
                                                                     null); -- Guia para saber en que momento detener el conteo.
    sbObtieneDatos BOOLEAN := FALSE;
    sbObtieneLote  BOOLEAN := FALSE;
    --REQ.200-2027 <<--

  BEGIN
    -------------------------
    --REQ.200-2027 Logica >>>
    -------------------------
    --Seteo la obtencion del lote.
    sbObtieneLote := FALSE;

    --Recorro los registros a marcar
    FOR reLDCI_OUTBOXDET IN cuLDCI_OUTBOXDET LOOP
      --Si no tengo # de lote, lo obtengo.
      IF sbObtieneLote = FALSE THEN
        nuLote        := LDCI_SEQ_OUTBOXDET_PROCESS.NEXTVAL;
        sbObtieneLote := TRUE;
      END IF;
      --Lo dentengo cuando se igual al maximo permitido
      EXIT WHEN cuLDCI_OUTBOXDET%NOTFOUND OR cuLDCI_OUTBOXDET%NOTFOUND IS NULL;
      --Actualizo el registro con el # de lote correspondiente.
      UPDATE LDCI_OUTBOXDET MENS
         SET MENS.PROCESO_ID = nuLote
       WHERE MENS.CODIGO = reLDCI_OUTBOXDET.Codigo;
      --Marco que obtuve datos.
      sbObtieneDatos := TRUE;
      --Aumento en uno la guia.
      nuGuia := nuGuia + 1;
      --Cuando la guia llegue al tope envio el primer lote.
      IF nuGuia = nuMaxGuia THEN
        --notifica al sistema externo
        proGeneraMensajeSOAP(isbsystem,
                             isboperation,
                             nuLote,
                             onuErrorCode,
                             osbErrorMessage);

        IF (onuErrorCode <> 0) THEN
          LDCI_pkWebServUtils.Procrearerrorlogint('ProNotiResOutboxDet',
                                                  1,
                                                  osbErrorMessage,
                                                  null,
                                                  null);

        END IF;
        --Obtengo nuevo # de lote.
        nuLote        := LDCI_SEQ_OUTBOXDET_PROCESS.NEXTVAL;
        sbObtieneLote := TRUE;
        --Seteo la variable para comenzar nuevo conteo
        nuGuia := 0;
      END IF;

    END LOOP;

    IF sbObtieneDatos = TRUE THEN
      --notifica al sistema externo
      proGeneraMensajeSOAP(isbsystem,
                           isboperation,
                           nuLote,
                           onuErrorCode,
                           osbErrorMessage);

      IF (onuErrorCode <> 0) THEN
        LDCI_pkWebServUtils.Procrearerrorlogint('ProNotiResOutboxDet',
                                                1,
                                                osbErrorMessage,
                                                null,
                                                null);

      END IF;
    END IF;

    -------------------------
    --REQ.200-2027 Logica <<<
    -------------------------

    commit;

  EXCEPTION
    WHEN errorPara01 THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.errorPara01]: ' ||
                         osbErrorMessage;
    WHEN excepNoProcesoRegi THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.others]:' ||
                         SQLERRM;
  END ProNotiResOutboxDet;
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : proGeneraMensajeSOAP
   Descripcion : Servicio encargado de generar los mensajes para el procedimiento de
   notificaciones de respuesta
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   02-08-20118      Sebastian Tapias      Se realiza creacion de un nuevo XML de los archivos
                                          segun el lote, sistema y operacion ingresados.
  ************************************************************************************************************/
  PROCEDURE proGeneraMensajeSOAP(isbsystem       IN LDCI_OUTBOXDET.sistema%TYPE,
                                 isboperation    IN LDCI_OUTBOXDET.operacion%TYPE,
                                 inuLote         IN NUMBER,
                                 onuErrorCode    OUT NUMBER,
                                 osbErrorMessage OUT VARCHAR2) AS

    -- Cursor del Mensaje XML
    orfCursor      SYS_REFCURSOR;
    nuMesacodi     LDCI_MESAENVWS.MESACODI%TYPE;
    L_Payload      CLOB;
    qryCtx         DBMS_XMLGEN.ctxHandle;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    sbSistNotifica LDCI_CARASEWE.CASEDESE%type;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

  BEGIN

    onuErrorCode    := 0;
    osbErrorMessage := null;
    sbSistNotifica  := isboperation || '_RESP';

    -------------------------------------------
    --REQ.200-2027 --Se implementa nueva logica
    -------------------------------------------

    -- carga los parametos de la interfaz
    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbSistNotifica,
                                       'INPUT_MESSAGE_TYPE',
                                       sbInputMsgType,
                                       osbErrorMessage);

    IF (osbErrorMessage != '0') THEN
      RAISE errorPara01;
    END IF;

    OPEN orfCursor FOR
      SELECT inuLote      AS "idProceso",
             isbsystem    AS "sistema",
             isboperation AS "operacion",
             CURSOR (SELECT MENS.CODIGO     AS "codigo",
                            MENS.ID_EXTERNO AS "idExterno",
                            CURSOR (SELECT PARA.PARAMETRO_ID AS "idparametro",
                                           PARA.VALOR        AS "valor"
                                      FROM LDCI_OUTBOXDETVAL PARA
                                     where PARA.OUTBOXDET_ID = MENS.CODIGO)          AS "parametros"
                       FROM LDCI_OUTBOXDET MENS
                      WHERE MENS.ESTADO = 'R'
                        AND MENS.PROCESO_ID = inuLote
                        AND MENS.SISTEMA = isbsystem
                        AND MENS.OPERACION = isboperation)       AS "respuestas"
        FROM DUAL;

    -- Genera el mensaje XML
    Qryctx := Dbms_Xmlgen.Newcontext(orfCursor);

    DBMS_XMLGEN.Setrowsettag(Qryctx, sbInputMsgType);
    DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, false);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      RAISE excepNoProcesoRegi;
    end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<parametros_ROW>', '<parametro>');
    L_Payload := Replace(L_Payload, '</parametros_ROW>', '</parametro>');
    L_Payload := Replace(L_Payload, '<respuestas_ROW>', '<respuesta>');
    L_Payload := Replace(L_Payload, '</respuestas_ROW>', '</respuesta>');

    L_Payload := Trim(L_Payload);
    /*dbms_output.put_line('[proGeneraMensajeSOAP 594 L_Payload ]' ||
    chr(13) || L_Payload);*/

    -------------------------------------------
    --REQ.200-2027 --Fin
    -------------------------------------------

    -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   sbSistNotifica,
                                   -1,
                                   inuLote, --REQ,200-2027 Se agrega Lote.
                                   null,
                                   L_Payload,
                                   0,
                                   0,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

    onuErrorCode := nvl(onuErrorCode, 0);

    --REQ.200-2027 Con un solo error se comenta todo el lote como errado.
    --Si no existe error, se comenta todo el lote como correcto.
    IF onuErrorCode = 0 THEN
      UPDATE LDCI_OUTBOXDET MENS
         SET MENS.ESTADO          = 'P',
             MENS.CODIGO_OSF      = 0,
             MENS.MENSAJE_OSF     = 'OK',
             MENS.FECHA_PROCESADO = sysdate
       WHERE MENS.SISTEMA = isbsystem
         AND MENS.OPERACION = isboperation
         AND MENS.PROCESO_ID = inuLote;

    ELSE
      UPDATE LDCI_OUTBOXDET MENS
         SET MENS.ESTADO          = 'E',
             MENS.CODIGO_OSF      = onuErrorCode,
             MENS.MENSAJE_OSF     = osbErrorMessage,
             MENS.FECHA_PROCESADO = sysdate
       WHERE MENS.SISTEMA = isbsystem
         AND MENS.OPERACION = isboperation
         AND MENS.PROCESO_ID = inuLote;

    END IF;

    commit;

  EXCEPTION
    WHEN errorPara01 THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.errorPara01]: ' ||
                         osbErrorMessage;
    WHEN excepNoProcesoRegi THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.others]:' ||
                         SQLERRM;
  END proGeneraMensajeSOAP;

END LDCI_PKOUTBOX;
/

PROMPT Asignación de permisos para el paquete LDCI_PKOUTBOX
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKOUTBOX', 'ADM_PERSON');
end;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKOUTBOX to REXEREPORTES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKOUTBOX to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKOUTBOX to INTEGRADESA;
/
