CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINBOX AS
  /***********************************************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

   Paquete     : LDCI_PKINBOX
   Descripcion : Paquete de integraciones personalizado para revision periodica.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proRegistraInbox(inuexternal_process in LDCI_INBOX.proceso_externo%type,
                             isbsystem           in LDCI_INBOX.sistema%type,
                             isboperation        in LDCI_INBOX.operacion%type,
                             iclxml              in LDCI_INBOX.xml%type,
                             onucode_osf         out LDCI_INBOX.codigo_osf%type,
                             osbmessage_osf      out LDCI_INBOX.mensaje_osf%type);

  /********Procedimiento 2***********/
  PROCEDURE proRegistraInboxDet(inuinbox_id        in LDCI_INBOXDET.inbox_id%type, --LLAVE FORANEA DE LDCI_INBOX
                                inuproceso_externo in LDCI_INBOXDET.proceso_externo%type,
                                isbsystem          in LDCI_INBOXDET.sistema%type,
                                isboperation       in LDCI_INBOXDET.operacion%type,
                                iclxml             in LDCI_INBOXDET.xml%type,
                                inucontract        in LDCI_INBOXDET.CONTRATO%type,
                                inoproduct         in LDCI_INBOXDET.PRODUCTO%type,
                                inuoperative_unit  in LDCI_INBOXDET.UNIDAD_OPERATIVA%type,
                                inuorder           in LDCI_INBOXDET.orden%type,
                                inuId_Externo      in LDCI_OUTBOXDET.ID_EXTERNO%type,
                                onucode_osf        out LDCI_INBOX.codigo_osf%type,
                                osbmessage_osf     out LDCI_INBOX.mensaje_osf%type);

  /********Procedimiento 3***********/
  PROCEDURE proProcesaInboxDet(isbSistema   in VARCHAR2,
                               isbOperacion in VARCHAR2);
  /********Procedimiento 4***********/
  PROCEDURE proProcInboxXML(isboperation in LDCI_INBOXDET.operacion%type,
                            isbsystem    in LDCI_INBOXDET.Sistema%type);

END LDCI_PKINBOX;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINBOX AS
  /***********************************************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

   Paquete     : LDCI_PKINBOX
   Descripcion : Paquete de integraciones personalizado para revision periodica.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  /***********************************************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

   Funcion     : proRegistraInbox
   Descripcion : Servicio encargado de ingresar datos en la tabla LDCI_INBOX.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proRegistraInbox(inuexternal_process in LDCI_INBOX.proceso_externo%type,
                             isbsystem           in LDCI_INBOX.sistema%type,
                             isboperation        in LDCI_INBOX.operacion%type,
                             iclxml              in LDCI_INBOX.xml%type,
                             onucode_osf         out LDCI_INBOX.codigo_osf%type,
                             osbmessage_osf      out LDCI_INBOX.mensaje_osf%type) AS

  BEGIN
    INSERT INTO LDCI_INBOX
      (CODIGO,
       proceso_externo,
       sistema,
       operacion,
       estado,
       xml,
       fecha_registro)
    VALUES
      (S_LDCI_INBOX.NEXTVAL,
       inuexternal_process,
       isbsystem,
       isboperation,
       open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_REG'),
       iclxml,
       sysdate);
    onucode_osf    := 0;
    osbmessage_osf := null;
    commit;
  EXCEPTION

    WHEN OTHERS THEN
      onucode_osf    := -1;
      osbmessage_osf := sqlerrm;
      dbms_output.put_line('Error al ejecutar el paquete proRegistraInbox' ||
                           sqlerrm);
      raise_application_error(-20010,
                              'Error al ejecutar el paquete proRegistraInbox');
  END proRegistraInbox;
  /***********************************************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

   Funcion     : proRegistraInboxDet
   Descripcion : Servicio encargado de ingresar datos en la tabla LDCI_INBOXDET.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proRegistraInboxDet(inuinbox_id        in LDCI_INBOXDET.inbox_id%type, --LLAVE FORANEA DE LDCI_INBOX
                                inuproceso_externo in LDCI_INBOXDET.proceso_externo%type,
                                isbsystem          in LDCI_INBOXDET.sistema%type,
                                isboperation       in LDCI_INBOXDET.operacion%type,
                                iclxml             in LDCI_INBOXDET.xml%type,
                                inucontract        in LDCI_INBOXDET.CONTRATO%type,
                                inoproduct         in LDCI_INBOXDET.PRODUCTO%type,
                                inuoperative_unit  in LDCI_INBOXDET.UNIDAD_OPERATIVA%type,
                                inuorder           in LDCI_INBOXDET.orden%type,
                                inuId_Externo      in LDCI_OUTBOXDET.ID_EXTERNO%type,
                                onucode_osf        out LDCI_INBOX.codigo_osf%type,
                                osbmessage_osf     out LDCI_INBOX.mensaje_osf%type) AS

  BEGIN
    INSERT INTO LDCI_INBOXDET
      (codigo,
       inbox_id,
       proceso_externo,
       sistema,
       operacion,
       estado,
       xml,
       fecha_registro,
       contrato,
       producto,
       unidad_operativa,
       orden,
       id_externo)
    VALUES
      (s_ldci_inboxdet.nextval,
       inuinbox_id,
       inuproceso_externo,
       isbsystem,
       isboperation,
       open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_REG'),
       iclxml,
       sysdate,
       inucontract,
       inoproduct,
       inuoperative_unit,
       inuorder,
       inuId_Externo);
    onucode_osf    := 0;
    osbmessage_osf := null;

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      onucode_osf    := -1;
      osbmessage_osf := SQLERRM;
      dbms_output.put_line('Error al ejecutar el paquete proRegistraInboxDet ');
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINBOX.proRegistraInboxDet',
                                              1,
                                              'El proceso fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace || ' ' ||
                                              SQLERRM,
                                              null,
                                              null);

  END proRegistraInboxDet;
  /***********************************************************************************************************
    Propiedad Intelectual de JM Gestion Informatica

   Funcion     : proProcesaInboxDet
   Descripcion : Servicio encargado procesar cada registro de la tabla LDCI_INBOXDET para
                 insertarlos en la tabla LCDI_OUTBOXDET el cual esta basado en el procedimiento generico LDCI_PKINFOADICIONALOT.proProcesaGestionAdicional
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proProcesaInboxDet(isbSistema   in VARCHAR2,
                               isbOperacion in VARCHAR2) AS
    menError        LDCI_INBOX.Mensaje_Osf%type;
    codigoInbox     LDCI_INBOX.CODIGO%type;
    sbSQL           VARCHAR2(4000);
    osbXMLRespuesta LDCI_PKREPODATAtype.tytabRespuesta;
    sbXMLRespuesta  SYS_REFCURSOR;
    sbProcedimiento LDCI_OPERACION.procedimiento%TYPE;
    codigoInboxdet  LDCI_INBOXDET.Codigo%TYPE; --guarda el codigo del mensaje a procesar
    MenErr          LDCI_INBOXDET.Mensaje_Osf%type; -- mensaje de error
    i               number;

    sbEstadoProcesado VARCHAR(1) := 'P';
    sbCodigoError     ldci_inboxdet.codigo_osf%TYPE;
    sbMensajeError    ldci_inboxdet.mensaje_osf%TYPE;

    CURSOR cuInboxDet IS
      SELECT CODIGO,
             INBOX_ID,
             PROCESO_EXTERNO,
             SISTEMA,
             OPERACION,
             ESTADO,
             XML,
             FECHA_REGISTRO,
             fecha_procesado,
             CONTRATO,
             PRODUCTO,
             UNIDAD_OPERATIVA,
             ORDEN,
             codigo_osf,
             MENSAJE_OSF,
             id_externo
        FROM LDCI_INBOXDET
       WHERE ESTADO = 'R'
         AND SISTEMA = isbSistema
         AND OPERACION = isbOperacion;

    CURSOR cuProceso(sbSistema   LDCI_OPERACION.sistema%TYPE,
                     sbOperacion LDCI_OPERACION.operacion%type) IS
      SELECT s.procedimiento
        FROM LDCI_OPERACION s
       WHERE s.sistema = sbSistema
         AND s.operacion = sbOperacion;

    onuErrorCodi NUMBER;
    osbErrorMsg  VARCHAR2(2000);
    --Estructura de respuesta
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  BEGIN

    --RECORRE LA TABLA LDCI_INBOXDET EN BUSQUEDA DE SOLICITUDES ADICIONALES PENDIENTES Y GESTIONADAS CON ERROR
    FOR REG IN cuInboxDet LOOP
      onuErrorCodi   := null;
      codigoInboxdet := REG.Codigo;

      BEGIN
        -- Busca el procedimiento a ejecutar segun configuracion
        open cuProceso(reg.SISTEMA, reg.operacion);
        fetch cuProceso
          into sbProcedimiento;
        if cuProceso%notfound then
          osbXMLRespuesta.DELETE;
          onuErrorCodi := 1;
          tyRegRespuesta.parametro := 'codigoError';
          tyRegRespuesta.valor := '1';
          osbXMLRespuesta(1) := tyRegRespuesta;
          tyRegRespuesta.parametro := 'mensajeError';
          tyRegRespuesta.valor := 'TIPO DE PROCESO NO DEFINIDO';
          osbXMLRespuesta(2) := tyRegRespuesta;
        end if;
        close cuProceso;

        --PROCESA LAS GESTIONES ADICIONALES
        IF NVL(onuErrorCodi, 0) = 0 THEN
          -- si encontro configuracion
          sbSQL := '  BEGIN' || chr(10) || '   ' || sbProcedimiento || '(' ||
                   chr(10) || '     CODIGO =>           :1,   ' || chr(10) ||
                   '     INBOX_ID =>         :2,   ' || chr(10) ||
                   '     inuProcesoExt =>    :3,   ' || chr(10) ||
                   '     isbSistema =>       :4,   ' || chr(10) ||
                   '     isbOperacion =>     :5,   ' || chr(10) ||
                   '     isbXML     =>       :7,   ' || chr(10) ||
                   '     inuContrato   =>    :10,  ' || chr(10) ||
                   '     inuProducto   =>    :11,  ' || chr(10) ||
                   '     inuUnid_oper   =>   :12,  ' || chr(10) ||
                   '     inuOrden   =>       :13,  ' || chr(10) ||
                   '     ocurRespuesta =>    :16,  ' || chr(10) ||
                   '     onuErrorCodi =>     :17,  ' || chr(10) ||
                   '     osbErrorMsg =>      :18); ' || chr(10) || 'END;';

          EXECUTE IMMEDIATE sbSQL
            using IN reg.codigo, IN reg.INBOX_ID, IN reg.PROCESO_EXTERNO, IN reg.SISTEMA, IN reg.operacion, IN reg.XML, IN reg.CONTRATO, IN reg.PRODUCTO, IN reg.UNIDAD_OPERATIVA, IN reg.ORDEN, OUT sbXMLRespuesta, OUT onuErrorCodi, OUT osbErrorMsg;

          -------------------------------
          --REQ.2001511 Se agrega Logica.
          -------------------------------
          -- pasa el cursor referenciado a la variable tipo tabla
          i := 1;
          loop
            fetch sbXMLRespuesta
              into tyRegRespuesta.parametro, tyRegRespuesta.valor;
            EXIT WHEN sbXMLRespuesta%NOTFOUND;
            osbXMLRespuesta(i) := tyRegRespuesta;
            i := i + 1;
          end loop;
          close sbXMLRespuesta;
        END IF;

        --VALIDA QUE EL CODIGO ERROR Y XML DE RESPUESTA NO ESTE NULL
        IF NVL(onuErrorCodi, 0) = 0 THEN

          FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
            IF (osbXMLRespuesta(i).PARAMETRO = 'codigoError') THEN
              sbCodigoError := TO_NUMBER(osbXMLRespuesta(i).VALOR);
              IF sbCodigoError = 0 OR sbCodigoError IS NULL THEN
                sbEstadoProcesado := 'P';
              ELSE
                sbEstadoProcesado := 'E';
              END IF;
            END IF;
            IF (osbXMLRespuesta(i).PARAMETRO = 'mensajeError') THEN
              sbMensajeError := osbXMLRespuesta(i).VALOR;
            END IF;

          END LOOP;

          UPDATE LDCI_INBOXDET L
             SET FECHA_PROCESADO = SYSDATE,
                 ESTADO          = sbEstadoProcesado,
                 CODIGO_OSF      = sbCodigoError,
                 MENSAJE_OSF     = sbMensajeError
           WHERE CODIGO = REG.CODIGO;

          COMMIT;

        ELSE

          UPDATE LDCI_INBOXDET L
             SET FECHA_PROCESADO = SYSDATE,
                 ESTADO          = 'E',
                 CODIGO_OSF      = onuErrorCodi,
                 MENSAJE_OSF     = osbErrorMsg
           WHERE CODIGO = REG.CODIGO;

          COMMIT;

        END IF;
        -------------------------------
        --REQ.2001511 Fin.
        -------------------------------

        LDCI_PKOUTBOX.proRegistraOutboxDet(reg.Codigo, --id de la tabla LDCI_INBOXDET
                                           reg.SISTEMA,
                                           reg.OPERACION,
                                           reg.CONTRATO,
                                           reg.PRODUCTO,
                                           reg.UNIDAD_OPERATIVA,
                                           reg.ORDEN,
                                           null,
                                           reg.id_externo,
                                           osbXMLRespuesta,
                                           onuErrorCodi,
                                           menError,
                                           codigoInbox);

      EXCEPTION

        WHEN OTHERS THEN
          rollback;
          MenErr := SQLERRM;
          UPDATE LDCI_INBOXDET
             SET estado      = open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_ERR'),
                 mensaje_osf = MenErr,
                 CODIGO_OSF  = -1
           where codigo = codigoInboxdet;
          commit;
          dbms_output.put_line('Error al ejecutar el Procedimineto proProcesaInboxDet ' ||
                               sqlerrm);
          LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINBOX.proProcesaInboxDet',
                                                  1,
                                                  'El proceso de gestion adicional fallo: ' ||
                                                  DBMS_UTILITY.format_error_backtrace || ' ' ||
                                                  SQLERRM,
                                                  null,
                                                  null);

          ROLLBACK;
      END;

    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error al ejecutar el Procedimineto proProcesaInboxDet ' ||
                           sqlerrm);
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINBOX.proProcesaInboxDet',
                                              1,
                                              'El proceso fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace || ' ' ||
                                              SQLERRM,
                                              null,
                                              null);
      ROLLBACK;
  END proProcesaInboxDet;
  /***********************************************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

   Funcion     : proProcInboxXMLArchivoInspec
   Descripcion : Servicio encargado de obtener el xml de la tabla LDCI_INBOX, dividirlos y enviarlos
                 a la tabla LDCI_INBOXDET.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proProcInboxXML(isboperation in LDCI_INBOXDET.operacion%type,
                            isbsystem    in LDCI_INBOXDET.Sistema%type) AS

    MenErr         LDCI_INBOX.Mensaje_Osf%type; -- mensaje de error
    vtag           ldci_operacion.tag%type; --Guarda el tag del xml padre
    subTag         ldci_operacion.tag%type; --almacena el tag del xml hijo
    codigoInbox    LDCI_INBOX.Codigo%TYPE; --guarda el codigo del mensaje a procesar
    onucode_osf    LDCI_INBOX.codigo_osf%type;
    nuError        LDCI_INBOX.codigo_osf%type;
    osbmessage_osf LDCI_INBOX.mensaje_osf%type;
    --Cursor que retorna el Todos los datos de la tabla LDCI_INBOX
    CURSOR cuinbox IS
      Select CODIGO,
             PROCESO_EXTERNO,
             SISTEMA,
             OPERACION,
             ESTADO,
             XML,
             FECHA_REGISTRO,
             fecha_procesado,
             codigo_osf,
             MENSAJE_OSF
        From LDCI_INBOX
       where operacion = isboperation
         and sistema = isbsystem
         and estado = 'R'
         order by fecha_registro ASC;

    cursor cuDivXml(xmlval clob, tag ldci_operacion.tag%type) is
      With ldci_mesaenvws As
       (Select Xmltype(xmlval) as str_Xml From Dual)
      Select x.subXml
        From ldci_mesaenvws x,
             Xmltable(tag Passing str_Xml Columns subXml xmltype Path '.') x;

    cursor cuValXml(val clob, tag ldci_operacion.tag%type) is
      Select Datos.idOrden,
             Datos.contrato,
             Datos.producto,
             Datos.unioper,
             Datos.idExterno
        From XMLTable(tag Passing XMLType(val) Columns idOrden Number Path
                      'idOrden',
                      contrato Number Path 'idContrato',
                      producto Number Path 'idProducto',
                      unioper Number Path 'idUnioper',
                      idExterno Number Path 'idExterno') As Datos;

    idOrden    LDCI_INBOXDET.Orden%type;
    idContrato LDCI_INBOXDET.Contrato%type;
    idProducto LDCI_INBOXDET.Producto%type;
    idUniOper  LDCI_INBOXDET.Unidad_Operativa%type;
    idExterno  LDCI_INBOXDET.ID_EXTERNO%type;

  BEGIN

    --Seleccionamos el tag principal para interpretar el XML
    select tag
      into vtag
      from LDCI_OPERACION OPE
     where OPE.OPERACION = isboperation
       and OPE.SISTEMA = isbsystem;

    --Identificamos el subTag
    subTag := SUBSTR(vtag, INSTR(vtag, '/', 1, 2));

    for regp in cuinbox loop
      if regp.xml is not null then
        --Recorremos cada XML detalle del XML general
        for regDet in cudivXml(regp.xml, vtag) loop

        BEGIN

          --Buscamos en el XML detalle las variables
          open cuValXml(regDet.subXml.getClobVal(), subTag);
          fetch cuValXml
            into idOrden, idContrato, idProducto, idUniOper, idExterno;
          close cuValXml;

          LDCI_PKINBOX.proRegistraInboxDet(regp.Codigo,
                                           regp.proceso_externo,
                                           regp.sistema,
                                           regp.operacion,
                                           regdet.subXml.getClobVal(),
                                           idContrato,
                                           idProducto,
                                           idUniOper,
                                           idOrden,
                                           idExterno,
                                           onucode_osf,
                                           osbmessage_osf);
          nuError := onucode_osf;
          MenErr  := osbmessage_osf;
          EXIT WHEN nuError <> 0;

          EXCEPTION
            WHEN OTHERS THEN
              close cuValXml;
              nuError := -1;
              MenErr := 'Error en el detalle del xml con codigo: ' || regp.codigo || ' - ERROR: ' || SQLERRM;
              ROLLBACK;
              LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINBOX-' || isbsystem || '-' || isboperation,
                                              1,
                                              'El proceso fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace || ' ' ||
                                              SQLERRM,
                                              null,
                                              null);
              EXIT WHEN TRUE;

          END;
        end loop;

        IF nuError <> 0 THEN
          UPDATE LDCI_INBOX
             SET estado      = open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_ERR'),
                 mensaje_osf = MenErr,
                 CODIGO_OSF  = -1
           where codigo = regp.codigo;
        ELSE
          UPDATE LDCI_INBOX
             SET estado          = open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_PRO'),
                 FECHA_PROCESADO = SYSDATE,
                 mensaje_osf     = 0,
                 CODIGO_OSF      = NULL
           where codigo = regp.codigo;
        END IF;
      else
        UPDATE LDCI_INBOX
           SET estado      = open.dald_parameter.fsbgetvalue_chain('OBT_EST_MEN_ERR'),
               mensaje_osf = 'No se encontro ningun xml padre',
               CODIGO_OSF  = -1
         where codigo = codigoInbox;
      end if;

      COMMIT;

    end loop;

  EXCEPTION
    WHEN OTHERS THEN
      Rollback;
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINBOX.proProcInboxXMLArchivoInspec',
                                              1,
                                              'El proceso fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace || ' ' ||
                                              SQLERRM,
                                              null,
                                              null);
  END proProcInboxXML;

END LDCI_PKINBOX;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKINBOX
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINBOX','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKINBOX to REXEREPORTES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKINBOX to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKINBOX to INTEGRADESA;
/


