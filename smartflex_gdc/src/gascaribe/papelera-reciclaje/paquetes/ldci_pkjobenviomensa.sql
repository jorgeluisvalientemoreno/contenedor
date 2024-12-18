CREATE OR REPLACE PACKAGE LDCI_PKJOBENVIOMENSA AS
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       : LDCI_PKJOBENVIOMENSA
     AUTOR         : OLSoftware / Mauricio Fernando Ortiz
     FECHA         : 18/04/2013
     REQUERIMIENTO : PETI-SMARTFLEX
     DESCRIPCION: Paquete que tiene el procedimiento del job de envio de mensajes de
                  integracion.
    Historia de Modificaciones
    Autor                   Fecha         Descripcion
    JESUS VIVERO (LUDYCOM)  14-04-2015    Creacion del proceso para notificar mensajes de la caja gris no enviados a PI
    Eduardo Ag?era          01/12/2017    200-1278 Modificacion a procedimiento de env?o de alertas por correo
    Lubin Pineda            15/05/2024    OSF-2603: Se ajusta proNofificaMensNoEnviados
  ************************************************************************/
  PROCEDURE PROENVIOMENSAJES(ISBINTERFAZ IN LDCI_DEFISEWE.DESECODI%TYPE);
  Procedure proNofificaMensNoEnviados;
  Procedure DeleteLDCI_MESAENVWS;
END LDCI_PKJOBENVIOMENSA;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKJOBENVIOMENSA AS
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  :
 * Tiquete :
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Reenvia Mensajes pendientes.
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
 * Mauricio ORtiz     18/04/2013    Ajustes del paquete
 * AAcuna(JM)200-1011 13-03-2017    Borrado y commit por cada 1000 registros-Ajustes del paquete
**/

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P
 PROCEDIMIENTO : PROENVIOMENSAJES
         AUTOR : Arquitecsoft/Hector Fabio Dominguez
         FECHA : 18/05/2011
 DESCRIPCION : Reenvia Mensajes pendientes.
 Parametros de Entrada
    ISBINTERFAZ IN LDCI_DEFISEWE.DESECODI%TYPE
 Parametros de Salida
 Historia de Modificaciones
 Autor        Fecha       Descripcion.
 Mauricio ORtiz     18/04/2013    Ajustes del paquete
 Hector Dominguez   15/12/2013    Se vuelve a dejar el parametro de cantidad de intentos
 Hector Dominguez   17/10/2013    Cuando la cantidad de intentos  es -1 se reenvia infinitamente
 LJLB               26/02/2018    Se agrega proceso para anular la tabla LDCI_LOGANULPAGO
************************************************************************/
  PROCEDURE PROENVIOMENSAJES(ISBINTERFAZ IN LDCI_DEFISEWE.DESECODI%TYPE) AS
  CURSOR cuMessageSend(ISBWS IN LDCI_DEFISEWE.DESECODI%TYPE,intentos NUMBER) is
       SELECT *
       FROM LDCI_mesaenvws
       WHERE MESADEFI = ISBWS AND MESAESTADO = -1  AND DECODE(intentos,-1,intentos,DECODE(mesaintentos,NULL,0,mesaintentos))<=intentos
       ORDER BY MESAPROC DESC, MESACODI ASC;
      regMessageSend          cuMessageSend%ROWTYPE;
      sbResponse              CLOB;
      sbTargetFull            LDCI_carasewe.casevalo%type;
      SBNAMESPACE             LDCI_carasewe.casevalo%type;
      SBWSURL                 LDCI_carasewe.casevalo%type;
      SBHOST                  LDCI_carasewe.casevalo%type;
      SBSOAPACTION            LDCI_carasewe.casevalo%type;
      SBPUERTO                LDCI_carasewe.casevalo%type;
      SBPROTOCOLO             LDCI_carasewe.casevalo%type;
     -- SBPAYLOAD               LDCI_carasewe.casevalo%type;
      SBMENS                  LDCI_carasewe.casevalo%type;
      SBTIPO                  LDCI_carasewe.casevalo%type;
      nuEstado                NUMBER;
      nuIntentos              NUMBER;
      nuErrorCode NUMBER;
      sbErrorMessage VARCHAR2(2000);
  BEGIN
    LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SENDMESSA_HITS',nuIntentos,sbMens);
    FOR regMessageSend IN cuMessageSend(ISBINTERFAZ,nuIntentos)
          LOOP
            /*
              ACTUALIZAR ESTADO DEL PROCESO A: PROCESANDO 'P'
            */
             LDCI_PKMESAWS.PROACTUESTAPROC(regMessageSend.MESAPROC, null, 'P', nuErrorCode, sbErrorMessage );
             /*CONFIRMAR QUE SE ESTA PROCESANDO EL MENSAJE*/
             commit;
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'NAMESPACE',sbNameSpace,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'PROTOCOLO',sbProtocolo,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'WSURL',sbWSURL,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'HOST',sbHost,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'SOAPACTION',sbSoapAction,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'PUERTO',sbPuerto,sbMens);
            LDCI_pkWebServUtils.proCaraServWeb(ISBINTERFAZ,'TIPO',SBTIPO,sbMens);
            sbTargetFull        := lower(sbProtocolo)||'://'||sbHost||':'||sbPuerto||'/'||sbWSURL;
            LDCI_pksoapapi.proSetProtocol(lower(sbProtocolo));
            /*
              VALIDAR EL TIPO DEL SERVICIO QUE SE ESTA CONSUMIENDO, ES ASINCRONO
            */
            IF SBTIPO = 'ASYNC' THEN
                /*
                  CONSUMIR SERVICIO ASINCRONAMENTE
                */
                sbResponse := LDCI_pksoapapi.fsbSoapSegmentedCall(regMessageSend.mesaxmlpayload, sbTargetFull, sbSoapAction,sbNameSpace);
                /*
                  VALIDAR ERRORES SOAP Y HTTP
                */
                IF LDCI_pksoapapi.boolSoapError OR LDCI_pksoapapi.boolHttpError THEN
                  nuEstado:=-1;
                  /*
                    ACTUALIZAR ESTADO Y ASIGNAR ERRORES AL MENSAJE
                  */
                  LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                              LDCI_pksoapapi.boolHttpError,
                                                              LDCI_pksoapapi.boolSoapError,
                                                              LDCI_pksoapapi.sbErrorHttp,
                                                              sbResponse,
                                                              nuEstado);
                ELSE
                   nuEstado:=1;
                   /*
                    ACTUALIZAR ESTADO DEL MENSAJE
                   */
                   LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                              LDCI_pksoapapi.boolHttpError,
                                                              LDCI_pksoapapi.boolSoapError,
                                                              regMessageSend.mesahttperror,
                                                              sbResponse,
                                                              nuEstado);
                END IF;
            END IF;
            /*
              VALIDAR EL TIPO DEL SERVICIO QUE SE ESTA CONSUMIENDO, ES SINCRONO
            */
            IF SBTIPO = 'SYNC' THEN
                /*
                  CONSUMIR SERVICIO SINCRONAMENTE
                */
                sbResponse := LDCI_pksoapapi.fsbSoapSegmentedCallSync(regMessageSend.mesaxmlpayload, sbTargetFull, sbSoapAction,sbNameSpace);
                 /*
                  VALIDAR ERRORES HTTP
                */
                IF LDCI_pksoapapi.boolHttpError THEN
                  nuEstado:=-1;
                   /*
                    ACTUALIZAR ESTADO Y ASIGNAR ERRORES AL MENSAJE
                  */
                  LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                              LDCI_pksoapapi.boolHttpError,
                                                              LDCI_pksoapapi.boolSoapError,
                                                              LDCI_pksoapapi.sbErrorHttp,
                                                              sbResponse,
                                                              nuEstado);
                ELSE
                   nuEstado:=1;
                    /*
                    ACTUALIZAR ESTADO DEL MENSAJE
                   */
                    LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                              LDCI_pksoapapi.boolHttpError,
                                                              LDCI_pksoapapi.boolSoapError,
                                                              regMessageSend.mesahttperror,
                                                              sbResponse,
                                                              nuEstado);
                END IF;
            END IF;
            IF nuEstado = 1 THEN
              /*
                VALIDAR SI HA SIDO ENVIADO AL TOTALIDAD DE LOTES
              */
              IF regMessageSend.MESATAMLOT = regMessageSend.MESALOTACT THEN
                /*
                  SI SON IGUALES, SE DEBE ACTUALIZAR EL ESTADO Y FECHA DE PROCESAMIENTO
                */
                LDCI_PKMESAWS.PROACTUESTAPROC(regMessageSend.MESAPROC, SYSDATE, 'F', nuErrorCode, sbErrorMessage );
              END IF;
            END IF;
            COMMIT;
     END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
    LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
  END PROENVIOMENSAJES;

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Procedure proNofificaMensNoEnviados As
    /* -----------------------------------------------------------------------------------------------------------------
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Proceso : LDCI_PKJOBENVIOMENSA.proNofificaMensNoEnviados
     * Tiquete : test
     * Autor   : JESUS VIVERO (LUDYCOM) <jesus.vivero@ludycom.com>
     * Fecha   : 14-04-2015
     * Descripcion : Notifica mensajes en la tabla Ldci_MesaEnvWS (Caja Gris) que no se pudieron enviar a SAP PI.
     *
     * Historia de Modificaciones
     * Autor                   Fecha         Descripcion
       JESUS VIVERO (LUDYCOM)  14-04-2015    Creacion del proceso
       Eduardo Ag?era          01/12/2017    200-1278 Se adicionan consultas para el correo de alertas
    *-----------------------------------------------------------------------------------------------------------------*/
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proNofificaMensNoEnviados';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    -- Cursor para contar los mensajes pendientes
    Cursor cuHayMensPendientes(isbSistExcNotif Ldci_Carasewe.Casevalo%Type, inuIntentos In Number, inuHoras In Number) Is
     select sum(cantidad)
      from (
      Select Count(1) cantidad
      From   Ldci_Mesaenvws l
      Where  l.Mesaestado   = -1
      And    (l.Mesaintentos >= inuIntentos Or ((Sysdate - l.Mesafech)*24 >= inuHoras))
      And    l.Mesadefi Not In (Select REGEXP_SUBSTR(isbSistExcNotif,'[^|]+', 1, Level)
                                From   Dual
                                Connect By REGEXP_SUBSTR(isbSistExcNotif,'[^|]+', 1, Level) Is Not Null
                               ));
    --1. Ordenes que tienen m?s de X horas sin ser enviadas (LDCI_ORDENMOVILES)
    CURSOR culdci_ordenmoviles(nucurparam NUMBER) IS
     SELECT m.task_type_id,
           (SELECT t.description FROM or_task_type t WHERE t.task_type_id = m.task_type_id) desc_tipo_trabajo,
           to_char(fecha_registro,'yyyy/mm/dd') fecha, COUNT(1) cantidad
       FROM ldci_ordenmoviles m
      WHERE estado_envio = 'P'
        AND fecha_registro <= SYSDATE - (nucurparam/24)
      GROUP BY m.task_type_id, to_char(fecha_registro,'yyyy/mm/dd');

    --2. Anulaciones o novedades que ienen mas de X horas sin ser enviadas (LDCI_ORDENMOVILES)
    CURSOR culdci_ordenmovilespi(nucurparam NUMBER) IS
     SELECT m.task_type_id
            ,(SELECT t.description FROM or_task_type t WHERE t.task_type_id = m.task_type_id) desc_tipo_trabajo
           ,m.tipo_anulacion
           ,m.observacion_anula
           ,to_char(fecha_registro_anula,'yyyy/mm/dd') fecha_novedad
           ,COUNT(1) cantidad
       FROM ldci_ordenmoviles m
      WHERE estado_envio_anula = 'P'
        AND fecha_registro_anula <= SYSDATE - (nucurparam/24)
    GROUP BY m.task_type_id, m.tipo_anulacion,m.observacion_anula, to_char(fecha_registro_anula,'yyyy/mm/dd');

    --3. informacion adicional que tiene mas de X horas sin ser procesadas
    CURSOR culdci_infgestotmov(nucurparam NUMBER) IS
     SELECT sistema_id
           ,operacion
           ,to_char(fecha_recepcion,'yyyy/mm/dd') fecha
           ,COUNT(1) cantidad
       FROM Ldci_InfGestOtMov
      WHERE estado = 'P'
        AND fecha_recepcion <= SYSDATE - (nucurparam/24)
      GROUP BY sistema_id, operacion, to_char(fecha_recepcion,'yyyy/mm/dd');

    --4. Ordenes a legalizar que tienen mas de X horas sin ser procesadas
    CURSOR culdci_ordenesalegalizar(nucurparam NUMBER) IS
     SELECT system
           ,to_char(fecha_recepcion,'yyyy/mm/dd') fecha
           ,COUNT(1) cantidad
       FROM Ldci_ordenesalegalizar
      WHERE state = 'P'
        AND fecha_recepcion <= SYSDATE - (nucurparam/24)
      GROUP BY system, to_char(fecha_recepcion,'yyyy/mm/dd');

    --5. Mensajes de caja gris que tienen mas de X horas con error o sin enviar
    CURSOR culdci_mesaenvws(nucurparam NUMBER) IS
     SELECT m.mesadefi
           ,COUNT(1) cantidad
       FROM ldci_mesaenvws m
      WHERE m.mesaestado = -1
        AND m.mesafech <= SYSDATE - (nucurparam/24)
      GROUP BY m.mesadefi;

    -- Cursor para determinar la Base de Datos
    Cursor cuDataBase Is
      Select Ora_Database_Name Name
      From   Dual;

    -- Cursor para listar los mensajes pendientes
    Cursor cuMensPendientes(isbSistExcNotif Ldci_Carasewe.Casevalo%Type, inuIntentos In Number, inuHoras In Number) Is
      Select l.Mesafech,
             l.Mesacodi,
             l.Mesadefi,
             l.Mesaproc,
             l.Mesaestado,
             l.Mesaintentos,
             l.Mesahttperror,
             Trunc((Sysdate - l.Mesafech)*24) Horas,
             Trunc((((Sysdate - l.Mesafech)*24)-Trunc((Sysdate - l.Mesafech)*24))*60) Minutos,
             ROW_NUMBER() OVER (Order By l.MesaFech) Numero
      From   Ldci_Mesaenvws l
      Where  l.Mesaestado   = -1
      And    (l.Mesaintentos >= inuIntentos Or ((Sysdate - l.Mesafech)*24 >= inuHoras))
      And    l.Mesadefi Not In (Select REGEXP_SUBSTR(isbSistExcNotif,'[^|]+', 1, Level)
                                From   Dual
                                Connect By REGEXP_SUBSTR(isbSistExcNotif,'[^|]+', 1, Level) Is Not Null
                               )
      Order By l.MesaFech;

    -- Declaracion de variables
    rgDataBase       cuDataBase%RowType;
--    rgMensPendientes cuMensPendientes%RowType;
--    smtpConn         UTL_SMTP.Connection;
        sbFechaEjec      Varchar2(100) := To_Char(Sysdate, 'dd/mm/yyyy hh24:mi:ss');
        nuHayPend        Number;
        nuIntentos       Number;
        nuHoras          Number;
        sbSistExcNotif   Ldci_Carasewe.Casevalo%Type;
        sbEmails         Varchar2(2000);
        sbTiempo         Varchar2(20);
        sbMensError      Varchar2(4000);
        nucantidad1      NUMBER;
        nucantidad2      NUMBER;
        nucantidad3      NUMBER;
        nucantidad4      NUMBER;
        nucantidad5      NUMBER;
        nutiempo         NUMBER;
        enviaCorreo      boolean := false;
    
        sbMensCorreo     VARCHAR2(32000);

        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    Begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
    -- Se busca parametro de intentos para notificar mensajes no enviados
    LDCI_pkWebServUtils.proCaraServWeb(vCaseDese => 'WS_CONFIG_SOAPAPI',
                                       vCaseCodi => 'WS_CONFIG_NOSENDMESSA_HITS',
                                       vCaseValo => nuIntentos,
                                       sbMens    => sbMensError);
    -- Se busca parametro de intentos para notificar mensajes no enviados
    LDCI_pkWebServUtils.proCaraServWeb(vCaseDese => 'WS_CONFIG_SOAPAPI',
                                       vCaseCodi => 'WS_CONFIG_NOSENDMESSA_TIME',
                                       vCaseValo => nuHoras,
                                       sbMens    => sbMensError);
    -- Se busca parametro de intentos para notificar mensajes no enviados
    LDCI_pkWebServUtils.proCaraServWeb(vCaseDese => 'WS_CONFIG_SOAPAPI',
                                       vCaseCodi => 'WS_SIS_EXC_NOTI_NOSENDMESSA',
                                       vCaseValo => sbSistExcNotif,
                                       sbMens    => sbMensError);
    -- Se busca parametro de e-mails para notificar mensajes no enviados
    LDCI_pkWebServUtils.proCaraServWeb(vCaseDese => 'WS_CONFIG_SOAPAPI',
                                       vCaseCodi => 'WS_EMAIL_NOTIF_NOSENDMESSA',
                                       vCaseValo => sbEmails,
                                       sbMens    => sbMensError);

    -- Se busca que base de datos es
    Open cuDataBase;
    Fetch cuDataBase Into rgDataBase;
    Close cuDataBase;

    -- Se verifica que existan mensajes pendientes
    Open cuHayMensPendientes(sbSistExcNotif, nuIntentos, nuHoras);
    Fetch cuHayMensPendientes Into nuHayPend;
    Close cuHayMensPendientes;

    --Verificamos si alguna de las consultas tiene registros

    --1. Ordenes que tienen m?s de X horas sin ser enviadas (LDCI_ORDENMOVILES)
    nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MENS_ORDENES');
    SELECT COUNT(1) INTO nucantidad1
    FROM ldci_ordenmoviles m
    WHERE estado_envio = 'P'
    AND fecha_registro <= SYSDATE - (nutiempo/24);

    --2. Anulaciones o novedades que tienen mas de X horas sin ser enviadas (LDCI_ORDENMOVILES)
    nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_ANUL_NOVE');
    SELECT COUNT(1) INTO nucantidad2
    FROM ldci_ordenmoviles m
    WHERE estado_envio_anula = 'P'
    AND fecha_registro_anula <= SYSDATE - (nutiempo/24);

    --3. Informacion adicional que tiene mas de X horas sin ser procesadas
    nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_INF_ADI');
    SELECT COUNT(1) INTO nucantidad3
    FROM Ldci_InfGestOtMov
    WHERE estado = 'P'
    AND fecha_recepcion <= SYSDATE - (nutiempo/24);

    --4. Ordenes a legalizar que tienen mas de X horas sin ser procesadas
    nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_ORD_LEG');
    SELECT COUNT(1) INTO nucantidad4
    FROM Ldci_ordenesalegalizar
    WHERE state = 'P'
    AND fecha_recepcion <= SYSDATE - (nutiempo/24);

    --5. Mensajes de caja gris que tienen mas de X horas con error o sin enviar
    nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_CAJA_GRIS');
    SELECT COUNT(1) INTO nucantidad5
    FROM ldci_mesaenvws m
    WHERE m.mesaestado = -1
    AND m.mesafech <= SYSDATE - (nutiempo/24);


    if nucantidad1 > 0 or nucantidad2 > 0 or nucantidad3 > 0 or nucantidad4 > 0 or nucantidad5 > 0 then
      enviaCorreo := true;
    end if;

    --Si al menos una de las consultas tuvo registros se env?a el correo
    if enviaCorreo then

      sbMensCorreo := NULL;
      sbMensCorreo := sbMensCorreo  ||  '<html><body>';
      sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
      sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h3>Alertas de Integraciones: ' || sbFechaEjec || ' BD: ' || rgDataBase.Name ||'<h3></td></tr>';
      sbMensCorreo := sbMensCorreo  ||  '<tr>';
      sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Base de Datos</b></td>';
      sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || rgDataBase.Name || '</td>';
      sbMensCorreo := sbMensCorreo  ||  '</tr>';
      sbMensCorreo := sbMensCorreo  ||  '<tr>';
      sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Fecha de Ejecucion</b></td>';
      sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || sbFechaEjec || '</td>';
      sbMensCorreo := sbMensCorreo  ||  '</tr>';
      sbMensCorreo := sbMensCorreo  ||  '</table>';

      --1. Ordenes que tienen m?s de X horas sin ser enviadas (LDCI_ORDENMOVILES)
      nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MENS_ORDENES');

      IF nucantidad1 >= 1 THEN
        -- Se escribe el encabezado de la notificacion
        sbMensCorreo := sbMensCorreo  ||  '<br><br>';
        sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
        sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h1>Ordenes que tienen m?s de '||to_char(nutiempo)||' horas sin ser enviadas (LDCI_ORDENMOVILES)<h1></td></tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Total Mensajes</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || To_Char(Nvl(nucantidad1, 0)) || '</td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="4%"><b>Tipo trab</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="20%"><b>Descripcion</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="7%"><b>Fecha</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td align="right" width="7%"><b>cantidad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';

        FOR i IN culdci_ordenmoviles(nutiempo) LOOP
          sbMensCorreo := sbMensCorreo  ||  '<tr>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.task_type_id ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.desc_tipo_trabajo ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.fecha ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td align="right">'||To_Char(i.cantidad) ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '</tr>';
        END LOOP;
        sbMensCorreo := sbMensCorreo  ||  '</table>';
      end if;

      --2. Anulaciones o novedades que tienen mas de X horas sin ser enviadas (LDCI_ORDENMOVILES)
      nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_ANUL_NOVE');
      IF nucantidad2 > 0 THEN
        sbMensCorreo := sbMensCorreo  ||  '<br><br>';
        sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
        sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h1>Anulaciones o novedades que tienen mas de '||to_char(nutiempo)||' horas sin ser enviadas (LDCI_ORDENMOVILES)<h1></td></tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Total Mensajes</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || To_Char(Nvl(nucantidad2, 0)) || '</td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="4%"><b>Tipo trab</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="20%"><b>Descripcion</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="7%"><b>Tipo anulacion</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="20%"><b>Observacion</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="7%"><b>Fecha novedad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td align="right" width="7%"><b>Cantidad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';

        FOR i IN culdci_ordenmovilespi(nutiempo) LOOP
          sbMensCorreo := sbMensCorreo  ||  '<tr>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.task_type_id ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.desc_tipo_trabajo ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.tipo_anulacion ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.observacion_anula ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.fecha_novedad ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td align="right">'||To_Char(i.cantidad) ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '</tr>';
        END LOOP;
        sbMensCorreo := sbMensCorreo  ||  '</table>';
      end if;

      --3. Informacion adicional que tiene mas de X horas sin ser procesadas
      nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_INF_ADI');
      IF nucantidad3 >= 1 THEN
        -- Se escribe el encabezado de la notificacion
        sbMensCorreo := sbMensCorreo  ||  '<br><br>';
        sbMensCorreo := sbMensCorreo  ||  '<html><body>';
        sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
        sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h1>Informacion adicional que tiene mas de '||to_char(nutiempo)||' horas sin ser procesadas<h1></td></tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Total Mensajes</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || To_Char(Nvl(nucantidad3, 0)) || '</td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="4%"><b>Sistema</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="20%"><b>Operacion</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="7%"><b>Fecha</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td align="right" width="7%"><b>Cantidad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';

        FOR i IN culdci_infgestotmov(nutiempo) LOOP
          sbMensCorreo := sbMensCorreo  ||  '<tr>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.sistema_id ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.operacion ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.fecha||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td align="right">'||To_Char(i.cantidad) ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '</tr>';
        END LOOP;
        sbMensCorreo := sbMensCorreo  ||  '</table>';
      end if;

      --4. Ordenes a legalizar que tienen mas de X horas sin ser procesadas
      nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_ORD_LEG');
      IF nucantidad4 >= 1 THEN
        -- Se escribe el encabezado de la notificacion
        sbMensCorreo := sbMensCorreo  ||  '<br><br>';
        sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
        sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h1>Ordenes a legalizar que tienen mas de '||to_char(nutiempo)||' horas sin ser procesadas<h1></td></tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Total Mensajes</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || To_Char(Nvl(nucantidad4, 0)) || '</td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="4%"><b>Sistema</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="7%"><b>Fecha</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td align="right" width="7%"><b>Cantidad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';

        FOR i IN culdci_ordenesalegalizar(nutiempo) LOOP
          sbMensCorreo := sbMensCorreo  ||  '<tr>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.system ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.fecha  ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td align="right">'||To_Char(i.cantidad) ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '</tr>';
        END LOOP;
        sbMensCorreo := sbMensCorreo  ||  '</table>';
      end if;

      --5. Mensajes de caja gris que tienen mas de X horas con error o sin enviar
      nutiempo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TIEMPO_CONSULTA_MEN_CAJA_GRIS');
      IF nucantidad5 >= 1 THEN
        -- Se escribe el encabezado de la notificacion
        sbMensCorreo := sbMensCorreo  ||  '<br><br>';
        sbMensCorreo := sbMensCorreo  ||  '<table border="1px" width="100%">';
        sbMensCorreo := sbMensCorreo  ||  '<tr><td colspan="9"><h1>Mensajes de caja gris que tienen mas de '||to_char(nutiempo)||' horas con error o sin enviar<h1></td></tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><b>Total Mensajes</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td colspan="7">' || To_Char(Nvl(nucantidad5, 0)) || '</td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';
        sbMensCorreo := sbMensCorreo  ||  '<tr>';
        sbMensCorreo := sbMensCorreo  ||  '<td width="20%"><b>Sistema</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '<td align="right" width="7%"><b>Cantidad</b></td>';
        sbMensCorreo := sbMensCorreo  ||  '</tr>';

        FOR i IN culdci_mesaenvws(nutiempo) LOOP
          sbMensCorreo := sbMensCorreo  ||  '<tr>';
          sbMensCorreo := sbMensCorreo  ||  '<td>'||i.mesadefi||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '<td align="right">'||To_Char(i.cantidad) ||'</td>';
          sbMensCorreo := sbMensCorreo  ||  '</tr>';
        END LOOP;
        sbMensCorreo := sbMensCorreo  ||  '</table>';
      end if;

      --Cerramos el formato del correo
      sbMensCorreo := sbMensCorreo  ||  '</body>';
      sbMensCorreo := sbMensCorreo  ||  '</html>';

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbEmails,
            isbAsunto           => 'Alertas de Integraciones: ' || sbFechaEjec,
            isbMensaje          => sbMensCorreo
        );
                                       
    END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
  Exception
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
  End proNofificaMensNoEnviados;

  --------------------------------------------------------------------------------------------------------------------------------------------------------------
  Procedure DeleteLDCI_MESAENVWS AS
  /*
   * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
   *
   * Proceso : LDCI_PKJOBENVIOMENSA.DeleteLDCI_MESAENVWS
   * Tiquete : 7435
   * Autor   : Samuel Pacheco (Sincecomp) <samuel.pacheco@sincecomp.com>
   * Fecha   : 09-11-2015
   * Descripcion : se borran los mensajes en la tabla Ldci_MesaEnvWS (Caja Gris) teniendo en cuenta un parametro de LDPAR.
   *
   * Historia de Modificaciones
   * Autor                           Fecha         Descripcion
     Samuel Pacheco (Sincecomp)    09-11-2015    Creacion del proceso
     Nivis Carrasquilla (Ludycom)  01-02-2016    Valida si la entrega aplica para la gasera
     AAcuna(JM)-200-1011           13-03-2017    Borrado y commit por cada 1000 registros
 **/

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'DeleteLDCI_MESAENVWS';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
 
      --Declaraci?n de Variables
      Numdias number;
      --13-03-2017-200-1011
      nuCommit        number(5);
      ---13-03-2017 Types-200-1011
      type tyrcDataRecord is record(
        Mesacodi           Ldci_Mesaenvws.Mesacodi%type);
      type tytbDataTable is table of tyrcDataRecord index by binary_integer;
      rgLdci_Mesaenvws  tytbDataTable;
      nucontareg       NUMBER(8) DEFAULT 0;
      --Declaracion de cursores
      --13-03-2017-200-1011
      CURSOR cuMensajes (numDias number) IS
             Select o.mesacodi
             From   ldci_mesaenvws o
             Where  o.mesafech<= sysdate-numDias;

      -- Cursor ordenes
      CURSOR cu_ldci_ordenmoviles(nucumDias number) IS
       SELECT x.order_id
         FROM ldci_ordenmoviles x
        WHERE x.created_date <= SYSDATE - nucumDias;

      -- Cursor ordenes legaliza
      CURSOR cu_ldci_ordenesalegalizar(nucumDias number) IS
       SELECT x.order_id
         FROM ldci_ordenesalegalizar x
        WHERE x.initdate <= SYSDATE - nucumDias;

     -- Cursor tabla login
     CURSOR cu_ldci_logiint(nucumDias number) IS
      SELECT x.logicodi
        FROM ldci_logiint x
       WHERE x.logifech <= SYSDATE - nucumDias;

    -- Cursor tabla ldci_infgestotmov
     CURSOR cu_ldci_infgestotmov(nucumDias number) IS
      SELECT x.mensaje_id,x.sistema_id
        FROM ldci_infgestotmov x
       WHERE x.fecha_recepcion <= SYSDATE - nucumDias;

     -- Ticket LJLB 2001586-- se consulta informacion de la tabla LDCI_LOGANULPAGO
     CURSOR cuInfoLogAnulPago(nucumDias number) IS
     SELECT x.rowid id_tabla
     FROM LDCI_LOGANULPAGO x
     WHERE x.LOANFERE <= SYSDATE - nucumDias;

  Begin

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
  
  ---13-03-2017 - - Borrado por limite de registro-200-1011
  Numdias := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_DIAS_DEL_LDCI_MESAENVWS');
  nuCommit := 1000;--13-03-2017-200-1011
  OPEN cuMensajes(Numdias);--13-03-2017-200-1011
    LOOP
       FETCH cuMensajes BULK COLLECT INTO rgLdci_Mesaenvws LIMIT nuCommit;--13-03-2017-200-1011
             FOR i in 1 .. rgLdci_Mesaenvws.count loop--13-03-2017-200-1011
             -- ARA 200-87 NCZ.
             -- Si la entrega aplica para la gasera, se borran los mensajes guardados hace Numdias dias
             if ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) then
               delete from LDCI_MESAENVWS l
               where l.mesacodi=rgLdci_Mesaenvws(i).mesacodi;
             end if;
             END LOOP;
             commit;
       exit when cuMensajes%notfound;
    END LOOP;
  close cuMensajes;
  -- Borramos datos de la tabla ldci_ordenmoviles
  nucontareg := 0;
  FOR i IN cu_ldci_ordenmoviles(Numdias) LOOP
   IF ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) THEN
       DELETE ldci_ordenmoviles b
        WHERE b.order_id = i.order_id;
        nucontareg := nucontareg + 1;
        IF nucontareg >= 100 THEN
         COMMIT;
         nucontareg := 0;
        END IF;
   END IF;
  END LOOP;
  COMMIT;
    -- Borramos datos de la tabla ldci_ordenesalegalizar
  nucontareg := 0;
  FOR i IN cu_ldci_ordenesalegalizar(Numdias) LOOP
   IF ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) THEN
       DELETE ldci_ordenesalegalizar b
        WHERE b.order_id = i.order_id;
        nucontareg := nucontareg + 1;
        IF nucontareg >= 100 THEN
         COMMIT;
         nucontareg := 0;
        END IF;
   END IF;
  END LOOP;
  COMMIT;
  -- Borramos datos de la tabla ldci_logiint
  nucontareg := 0;
  FOR i IN cu_ldci_logiint(Numdias) LOOP
   IF ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) THEN
       DELETE ldci_logiint b
        WHERE b.logicodi = i.logicodi;
        nucontareg := nucontareg + 1;
        IF nucontareg >= 100 THEN
         COMMIT;
         nucontareg := 0;
        END IF;
   END IF;
  END LOOP;
  COMMIT;
    -- Borramos datos de la tabla ldci_infgestotmov y Ldci_MesaInfGesNotMovil
  nucontareg := 0;
  FOR i IN cu_ldci_infgestotmov(Numdias) LOOP
   IF ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) THEN
       DELETE ldci_infgestotmov b
        WHERE b.mensaje_id = i.mensaje_id;
       DELETE Ldci_MesaInfGesNotMovil v
        WHERE v.mensaje_id = i.mensaje_id
          AND v.valor      = i.sistema_id;
        nucontareg := nucontareg + 1;
        IF nucontareg >= 100 THEN
         COMMIT;
         nucontareg := 0;
        END IF;
   END IF;
  END LOOP;
  COMMIT;
  nucontareg := 0;
  --Ticket LJLB 2001586 -- se elimina la informacion de la tabla LDCI_LOGANULPAGO
  FOR i IN cuInfoLogAnulPago(Numdias) LOOP
   IF ( fsbAplicaEntrega('OSS_INT_NCZ_20087') = 'S' ) THEN
       DELETE LDCI_LOGANULPAGO b
        WHERE b.rowid = i.id_tabla;
        nucontareg := nucontareg + 1;
        IF nucontareg >= 100 THEN
         COMMIT;
         nucontareg := 0;
        END IF;
   END IF;
  END LOOP;

  COMMIT;
   
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
      
  Exception
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
End DeleteLDCI_MESAENVWS;
END LDCI_PKJOBENVIOMENSA;
/

