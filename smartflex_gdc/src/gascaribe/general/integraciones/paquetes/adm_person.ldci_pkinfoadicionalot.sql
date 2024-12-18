CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALOT AS
  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  :
   * RICEF   : I074 - I075
   * Autor   : Jose Donado <jdonado@gascaribe.com>
   * Fecha   : 04-06-2014
   * Descripcion : Paquete gestion de informacion adicional de ordenes moviles

   *
   * Historia de Modificaciones
   * Autor                         Fecha       Descripcion
   * JESUS VIVERO (LUDYCOM)        24-04-2015  #149251-20150424: jesviv: Se agrega calculo de descuento maximo de refinanciacion y fecha de pago como sysdate + dias de gracia
   * JESUS VIVERO (LUDYCOM)        13-05-2015  #148643-20150513: jesviv: Se corrige funcion fnuDescuentoMaxRefinan para calcular de forma correcta el descuento maximo
   * SAMUEL PACHECO (SINCECOMP)    20-01-2016  ca 100-7282: se corrigen error en (Proregistracotizacion) registro de venta cotizada al momento de reenvia venta; de igual forma
                                               se contrala y notifica como error cuando se intenta reenviar una venta ya aplicada

  **/

 PROCEDURE proRecibeGestionAdicional(isbSistema      in VARCHAR2,
                                      isbOperacion    in VARCHAR2,
                                      inuIdProcExter  in NUMBER,
                                      inuOrden        in NUMBER,
                                      isbXML          in CLOB,
                                      onuErrorCode    out NUMBER,
                                      osbErrorMessage out VARCHAR2);

  PROCEDURE proProcesaGestionAdicional(isbSistema   in VARCHAR2,
                                       isbOperacion in VARCHAR2 /*, onuErrorCode out NUMBER, osbErrorMessage out VARCHAR2*/);
  procedure proNotiRespInfoAdic;




END LDCI_PKINFOADICIONALOT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALOT AS

PROCEDURE proRecibeGestionAdicional(isbSistema      in VARCHAR2,
                                      isbOperacion    in VARCHAR2,
                                      inuIdProcExter  in NUMBER,
                                      inuOrden        in NUMBER,
                                      isbXML          in CLOB,
                                      onuErrorCode    out NUMBER,
                                      osbErrorMessage out VARCHAR2) AS
    /*
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Funcion  : proRecibeGestionAdicional
     * Tiquete :
     * Autor   : Jose Donado <jdonado@gascaribe.com>
     * Fecha   : 04-06-2014
     * Descripcion : Recibe el XML con la informacion adicional de la orden de trabajo
                     gestionada desde el movil
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
       Jose.Donado    04-06-2014 Creacion del procedimieno
    **/
    --Variables del Proceso
    nuContador NUMBER;
    --sbExisteGest    NUMBER;

    CURSOR cuSistema(sbSistema ldci_infoadicionalot.sistema%TYPE) IS
      /*SELECT COUNT(s.sistema_id)
        FROM ldci_sistmoviltipotrab s
       WHERE s.sistema_id = sbSistema;*/
       SELECT COUNT(s.sistema)
         FROM ldci_infoadicionalot s
        WHERE s.sistema = sbSistema;


    CURSOR cuOrden(nuOrden or_order.order_id%TYPE) IS
      SELECT o.order_id, o.order_status_id
        FROM or_order o
       WHERE o.order_id = nuOrden;

    CURSOR cuExisteGestion(sbSistema LDCI_INFGESTOTMOV.SISTEMA_ID%TYPE, nuIdProcExter LDCI_INFGESTOTMOV.PROCESO_EXTERNO_ID%TYPE) IS
      SELECT i.mensaje_id,
             i.sistema_id,
             i.operacion,
             i.order_id,
             i.proceso_externo_id,
             i.estado
        FROM LDCI_INFGESTOTMOV i
       WHERE i.sistema_id = sbSistema
         And i.proceso_externo_id = nuIdProcExter;

    reOrden         cuOrden%ROWTYPE;
    reExisteGestion cuExisteGestion%ROWTYPE;

    --Variables de manejo de error
    sbMsgError VARCHAR2(100);
    errDatosEntrada EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    errExisteGest EXCEPTION; --Excepcion que valida si ya existe gestion de la operacion

  BEGIN
    --validacion de los parametros de entrada
    IF isbSistema IS NOT NULL THEN
      OPEN cuSistema(isbSistema);
      FETCH cuSistema
        INTO nuContador;
      CLOSE cuSistema;

      IF nuContador = 0 THEN
        sbMsgError := 'El sistema movil ' || isbSistema ||
                      ' no se encuentra configurado en la tabla LDCI_INFOADICIONALOT';
        RAISE errDatosEntrada;
      END IF;
    ELSE
      sbMsgError := 'El identificador del sistema enviado no debe ser nulo.';
      RAISE errDatosEntrada;
    END IF;

    IF inuOrden IS NOT NULL THEN
      OPEN cuOrden(inuOrden);
      FETCH cuOrden
        INTO reOrden;
      CLOSE cuOrden;

      IF reOrden.Order_Id IS NULL THEN
        sbMsgError := 'La orden enviada ' || inuOrden ||
                      ' no existe en el sistema';
        RAISE errDatosEntrada;
      END IF;
      /*  ELSE
      sbMsgError := 'El numero de orden enviado no debe ser nulo.';
      RAISE errDatosEntrada;*/
    END IF;

    IF isbXML IS NULL THEN
      sbMsgError := 'No se recibio informacion de los datos adicionales de la orden ' ||
                    inuOrden || ' a gestionar.';
      RAISE errDatosEntrada;
    END IF;

    IF isbOperacion IS NULL THEN
      sbMsgError := 'No se recibio informacion de la operacion a ejecutar de la orden ' ||
                    inuOrden;
      RAISE errDatosEntrada;
    END IF;

    --Valida si ya se ha registrado la gestion
    OPEN cuExisteGestion(isbSistema, inuIdProcExter);
    FETCH cuExisteGestion
      INTO reExisteGestion;

    IF cuExisteGestion%NOTFOUND THEN
      --Almacena la informacion adicional enviada desde el movil para su gestion
      INSERT INTO LDCI_INFGESTOTMOV
        (MENSAJE_ID,
         SISTEMA_ID,
         OPERACION,
         ORDER_ID,
         PROCESO_EXTERNO_ID,
         XML_SOLICITUD,
         ESTADO,
         FECHA_RECEPCION,
         FECHA_PROCESADO,
         FECHA_NOTIFICADO)
      VALUES
        (LDCI_SEQINFOGESNOOT.NEXTVAL,
         isbSistema,
         isbOperacion,
         inuOrden,
         inuIdProcExter,
         isbXML,
         'P',
         SYSDATE,
         NULL,
         NULL);

      onuErrorCode := 0;
      COMMIT;

    ELSE
      IF reExisteGestion.Estado IN ('GE', 'EN') THEN
        UPDATE LDCI_INFGESTOTMOV
           SET XML_SOLICITUD = isbXML, ESTADO = 'P'
         WHERE MENSAJE_ID = reExisteGestion.Mensaje_Id;

        onuErrorCode := 0;
        COMMIT;
      ELSE
        CLOSE cuExisteGestion;
        sbMsgError := 'Ya existe gestion de ' || isbOperacion ||
                      ' de la orden ' || inuOrden;
        RAISE errExisteGest;
      END IF;

    END IF;

    CLOSE cuExisteGestion;

  EXCEPTION
    WHEN errDatosEntrada THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proRecibeGestionAdicional.errDatosEntrada]: Error en los datos de entrada, ' ||
                         sbMsgError;
    WHEN errExisteGest THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proRecibeGestionAdicional.errExisteGest]: Error insertando registro. ' ||
                         sbMsgError;
      --RAISE_APPLICATION_ERROR(-20999,sbMsgError);
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proRecibeGestionAdicional.others]: ' ||
                         SQLERRM;
  END proRecibeGestionAdicional;

  ---------------------------------------------------------------------------------------------------

  PROCEDURE proProcesaGestionAdicional(isbSistema   in VARCHAR2,
                                       isbOperacion in VARCHAR2 /*, onuErrorCode out NUMBER, osbErrorMessage out VARCHAR2*/) AS
    /* ------------------------------------------------------------------------------------------------
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Funcion  : proProcesaGestionAdicional
     * Tiquete :
     * Autor   : Harold Altamiranda <harold.altamiranda@stackpointer.co>
     * Fecha   : 11-07-2014
     * Descripcion : Procesa las solicitudes de gestion adicional
     *
     * Historia de Modificaciones
     * Autor          Fecha                  Descripcion
       Spacheco       15/10/2015             se modifica, para que al momento de registrar errores
                                             en la tabla LDCI_INFGESTOTMOV, registre el codigo de
                                             error (campo COD_ERROR_OSF), y el mensaje de error
                                             (campo MSG_ERROR_OSF)
       eaguera        25/11/2016             Se realiza correccion para setear en null la variable
                                             onuErrorCodi
    -------------------------------------------------------------------------------------------------**/

    sbSQL           VARCHAR2(4000);
    osbXMLRespuesta  LDCI_PKREPODATAtype.tytabRespuesta;
    sbXMLRespuesta  SYS_REFCURSOR;
   -- sbXMLRespuesta  varchar2(4000);
    nuErrorCodi     number(4);
    sbErrorMsg      varchar2(2000);
    sbProcedimiento ldci_infoadicionalot.procedimiento%TYPE;
    i               number;

    CURSOR cuSistema IS
      SELECT MENSAJE_ID,
             SISTEMA_ID,
             ORDER_ID,
             XML_SOLICITUD,
             ESTADO,
             OPERACION,
             proceso_externo_id ,
             fecha_recepcion ,
             fecha_procesado ,
             fecha_notificado ,
             cod_error_osf,
             msg_error_osf
        FROM LDCI_INFGESTOTMOV
       WHERE ESTADO in ('P' /*,'GE','EN'*/
             )
         AND SISTEMA_ID LIKE NVL(isbSistema, '%')
         AND OPERACION LIKE NVL(isbOperacion, '%');

      CURSOR cuProceso (sbSistema ldci_infoadicionalot.sistema%TYPE,
                        sbOperacion ldci_infoadicionalot.operacion%type) IS
       SELECT s.procedimiento
         FROM ldci_infoadicionalot s
        WHERE s.sistema = sbSistema
          AND s.operacion = sbOperacion;




    /*osbXMLRespuesta LDCI_PKREPODATAtype.tytabRespuesta;*/
    contError       number default 0;
    contCorrectos   number default 0;
    --contMesainf NUMBER;
    onuErrorCodi NUMBER;
    osbErrorMsg  VARCHAR2(2000);
    --Estructura de respuesta
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;
  BEGIN

    --RECORRE LA TABLA LDCI_INFOGESTIONOTMOVIL EN BUSQUEDA DE SOLICITUDES ADICIONALES PENDIENTES Y GESTIONADAS CON ERROR
    FOR REG IN cuSistema LOOP
      onuErrorCodi := null;

      BEGIN
        -- Busca el procedimiento a ejecutar segun configuracion
        open cuProceso (reg.sistema_id, reg.operacion);
        fetch cuProceso into sbProcedimiento;
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
         IF NVL(onuErrorCodi, 0) = 0 THEN -- si encontro configuracion
           sbSQL := '  BEGIN'||chr(10)||'   '||sbProcedimiento||'('||chr(10)||
                 '     MENSAJE_ID =>       :1,'||chr(10)||
                 '     isbSistema =>       :2,'||chr(10)||
                 '     inuOrden   =>       :3,  '||chr(10)||
                 '     isbXML     =>       :4,  '||chr(10)||
                 '     isbEstado =>        :5,  '||chr(10)||
                 '     isbOperacion =>     :6,  '||chr(10)||
                 '     inuProcesoExt =>    :7,  '||chr(10)||
                 '     idtFechaRece =>     :8,  '||chr(10)||
                 '     idtFechaProc =>     :9,  '||chr(10)||
                 '     idtFechaNoti =>     :10,  '||chr(10)||
                 '     inuCodErrOsf =>     :11,  '||chr(10)||
                 '     isbMsgErrOsf =>     :12,  '||chr(10)||
                 '     ocurRespuesta =>    :13,  '||chr(10)||
                 '     onuErrorCodi =>     :14,  '||chr(10)||
                 '     osbErrorMsg =>      :15);'||chr(10)||
                 'END;';


           EXECUTE IMMEDIATE sbSQL using IN reg.mensaje_id,
                                         IN reg.sistema_id,
                                         IN reg.order_id,
                                         IN reg.xml_solicitud,
                                         IN reg.estado,
                                         IN reg.operacion,
                                         IN reg.proceso_externo_id,
                                         IN reg.fecha_recepcion,
                                         IN reg.fecha_procesado,
                                         IN reg.fecha_notificado,
                                         IN reg.cod_error_osf,
                                         IN reg.msg_error_osf,
                                        OUT sbXMLRespuesta,
                                        OUT onuErrorCodi,
                                        OUT osbErrorMsg;

           -- pasa el cursor referenciado a la variable tipo tabla
           i := 1;
           loop
             fetch sbXMLRespuesta into tyRegRespuesta.parametro, tyRegRespuesta.valor;
             EXIT WHEN sbXMLRespuesta%NOTFOUND;
             osbXMLRespuesta(i) := tyRegRespuesta;
             i := i + 1;
           end loop;
           close sbXMLRespuesta;
         END IF;

          --VALIDA QUE EL CODIGO ERROR Y XML DE RESPUESTA NO ESTE NULL
          IF NVL(onuErrorCodi, 0) = 0 THEN

            --ACTUALIZA LA SOLICITUD A GESTIONADA
            UPDATE LDCI_INFGESTOTMOV
               SET ESTADO = 'G', FECHA_PROCESADO = SYSDATE
             WHERE MENSAJE_ID = REG.MENSAJE_ID;

            DELETE FROM LDCI_MESAINFGESNOTMOVIL
             WHERE MENSAJE_ID = REG.MENSAJE_ID;

            FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
              --REGISTRA EL RESULTADO DEL XML DE RESPUESTA
              INSERT INTO LDCI_MESAINFGESNOTMOVIL
                (MENSAJE_ID, PARAMETRO_ID, VALOR)
              VALUES
                (REG.MENSAJE_ID,
                 osbXMLRespuesta(i).PARAMETRO,
                 osbXMLRespuesta(i).VALOR);
              ---
              --ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
              if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
                UPDATE LDCI_INFGESTOTMOV
                   SET COD_ERROR_OSF = osbXMLRespuesta(i).VALOR
                 WHERE MENSAJE_ID = REG.MENSAJE_ID;
              elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
                UPDATE LDCI_INFGESTOTMOV
                   SET msg_error_osf = osbXMLRespuesta(i).VALOR
                 WHERE MENSAJE_ID = REG.MENSAJE_ID;

              end if;

            END LOOP;
            contCorrectos := contCorrectos + 1;
            COMMIT;

          ELSE

            --ACTUALIZA LA SOLICITUD A GESTIONADA CON ERROR
            --DBMS_OUTPUT.PUT_LINE('MENSAJE_ID: [' || REG.MENSAJE_ID || '] Fue gestionado con error.');
            UPDATE LDCI_INFGESTOTMOV
               SET ESTADO = 'GE', FECHA_PROCESADO = sysdate
             WHERE MENSAJE_ID = REG.MENSAJE_ID;

            DELETE FROM LDCI_MESAINFGESNOTMOVIL
             WHERE MENSAJE_ID = REG.MENSAJE_ID;

            FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
              --REGISTRA EL RESULTADO DEL XML DE RESPUESTA
              INSERT INTO LDCI_MESAINFGESNOTMOVIL
                (MENSAJE_ID, PARAMETRO_ID, VALOR)
              VALUES
                (REG.MENSAJE_ID,
                 osbXMLRespuesta(i).PARAMETRO,
                 osbXMLRespuesta(i).VALOR);

              --ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
              if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
                UPDATE LDCI_INFGESTOTMOV
                   SET COD_ERROR_OSF = osbXMLRespuesta(i).VALOR
                 WHERE MENSAJE_ID = REG.MENSAJE_ID;
              elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
                UPDATE LDCI_INFGESTOTMOV
                   SET msg_error_osf = osbXMLRespuesta(i).VALOR
                 WHERE MENSAJE_ID = REG.MENSAJE_ID;

              end if;
            END LOOP;
            contError := contError + 1;
            COMMIT;

          END IF;

        EXCEPTION

          WHEN OTHERS THEN
            --DBMS_OUTPUT.PUT_LINE('MENSAJE_ID: ' || REG.MENSAJE_ID || ' EXCEPTION: ' || SQLERRM);
            LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINFOADICIONALOT.proProcesaGestionAdicional',
                                                    1,
                                                    'El proceso de gestion adicional fallo: ' ||
                                                    DBMS_UTILITY.format_error_backtrace||' '||SQLERRM,
                                                    null,
                                                    null);

            ROLLBACK;
        END;

      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKINFOADICIONALOT.proProcesaGestionAdicional',
                                                1,
                                                'El proceso de gestion adicional fallo: ' ||
                                                DBMS_UTILITY.format_error_backtrace||' '||SQLERRM,
                                                null,
                                                null);
        ROLLBACK;

  END proProcesaGestionAdicional;

  procedure proActuEstaInfoMovil(inuMensajeId    in NUMBER,
                                 isbEstado       in VARCHAR2,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) as
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKMESAWS.proActuEstaInfoMovil
     * Tiquete : Acta: 20130417 Acta reunion Modificacion-Caja-GRIS.docx
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 17/04/2013
     * Descripcion : procedimeinto que actualiza el registro de proceso.
      * Parametros:
      IN :inuMensajeId: Id del mensaje
      IN: isbEstado: ESTADO DE LA SOLICITUD P[PENDIENTE] G[GESTIONADO] GE[GESTIONADO CON ERROR] N[NOTIFICADO] EN [ERROR NOTIFICADO]
      OUT:onuErrorCode: Codigo de error
      OUT:osbErrorMessage: Mensaje de excepcion

     * Historia de Modificaciones
     * Autor              Fecha         Descripcion
     * carlosvl           17/04/2013    Creacion del paquete
    **/
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- excepciones
    EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
  begin
    -- inicializa mensaje de salida
    onuErrorCode := 0;

    -- realia la insercion en la tabla LDCI_ESTAPROC
    Update Ldci_Infgestotmov
       Set Estado           = Isbestado,
           Fecha_Notificado = Decode(Isbestado,
                                     'N',
                                     Sysdate,
                                     'EN',
                                     Sysdate,
                                     Fecha_Notificado) --#20150120: jesusv: Se habilita fecha de notificado
     Where Mensaje_Id = Inumensajeid;

    if (SQL%notfound) then
      raise EXCEP_UPDATE_CHECK;
    end if; --if (SQL%notfound)   then

    commit;

  exception
    when EXCEP_UPDATE_CHECK then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proActuEstaInfoMovil.EXCEP_UPDATE_CHECK]: ' ||
                         chr(13) || 'No se encuentra el mensaje  ' ||
                         inuMensajeId || '.';
      LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaInfoMovil',
                                              1,
                                              osbErrorMessage,
                                              null,
                                              null);
    when others then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proActuEstaInfoMovil.others] Error no controlado: ' ||
                         SQLERRM || chr(13) ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
  end proActuEstaInfoMovil;

  procedure proGeneraMensajeSOAP(isbSistema      in VARCHAR2,
                                 inuMensajeId    in NUMBER,
                                 inuOrden        in NUMBER,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) AS

    /*
     * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
     *
     * Script      : LDCI_PKGESTNOTIORDEN.proGeneraMensajeSOAP
     * Ricef       : I075
     * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
     * Fecha       : 15-05-2014
     * Descripcion : Uso de DBMS_XMLGEN
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
      * carlos.virgen  15-05-2014 Version inicial
    **/

    -- Cursor del Mensaje XML
    orfCursor SYS_REFCURSOR;
    --nuCantOrds         NUMBER := 0;
    --nuCantActs         NUMBER := 0;
    nuMesacodi LDCI_MESAENVWS.MESACODI%TYPE;
    L_Payload  CLOB;
    --sbXmlTransac       VARCHAR2(500);
    --sbESTADO_ENVIO LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
    qryCtx         DBMS_XMLGEN.ctxHandle;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    sbSistNotifica LDCI_CARASEWE.CASEDESE%type;

    errorPara01 EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  begin
    onuErrorCode    := 0;
    osbErrorMessage := null;
    sbSistNotifica  := isbSistema || '_RESINFO';
    -- carga los parametos de la interfaz
    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbSistNotifica,
                                       'INPUT_MESSAGE_TYPE',
                                       sbInputMsgType,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    open orfCursor for
      select MENS.SISTEMA_ID         as "idSistema",
             MENS.OPERACION          as "idOperacion",
             MENS.ORDER_ID           as "idOrden",
             MENS.PROCESO_EXTERNO_ID as "idProcesoExterno",
             cursor (select PARA.PARAMETRO_ID as "idParametro",
                            PARA.VALOR        as "valorParametro"
                       from LDCI_MESAINFGESNOTMOVIL PARA
                      where PARA.MENSAJE_ID = MENS.MENSAJE_ID)                  as "detalleParametros"
        from LDCI_INFGESTOTMOV MENS
       where MENS.MENSAJE_ID = inuMensajeId
      /*and   MENS.ORDER_ID = inuOrden*/
      ;

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
    L_Payload := Replace(L_Payload,
                         '<detalleParametros_ROW>',
                         '<parametro>');
    L_Payload := Replace(L_Payload,
                         '</detalleParametros_ROW>',
                         '</parametro>');

    L_Payload := Trim(L_Payload);
    dbms_output.put_line('[proGeneraMensajeSOAP 594 L_Payload ]' ||
                         chr(13) || L_Payload);

    -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   sbSistNotifica, -- Sistema configurado en LDCI_CARASEWE
                                   -1,
                                   null,
                                   null,
                                   L_Payload,
                                   0,
                                   0,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

    onuErrorCode := nvl(onuErrorCode, 0);

  exception
    when errorPara01 then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proGeneraMensajeSOAP.errorPara01]: ' ||
                         osbErrorMessage;
    when excepNoProcesoRegi then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proGeneraMensajeSOAP.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    when others then
      osbErrorMessage := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proGeneraMensajeSOAP.others]:' ||
                         SQLERRM;
  end proGeneraMensajeSOAP;

  procedure proNotiRespInfoAdic is

    /*
     * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
     *
     * Script      : LDCI_PKGESTNOTIORDEN.proNotiRespInfoAdic
     * Ricef       : I075
     * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
     * Fecha       : 15-05-2014
     * Descripcion : Uso de DBMS_XMLGEN
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
      * carlos.virgen  15-05-2014 Version inicial
    **/

    cursor cuLDCI_INFOGESTIONOTMOVIL is
      select MENSAJE_ID,
             MENS.SISTEMA_ID,
             MENS.OPERACION,
             MENS.ORDER_ID,
             MENS.ESTADO
        from LDCI_INFGESTOTMOV MENS
       where MENS.ESTADO IN ('G', 'GE');

    onuErrorCode    NUMBER := 0;
    osbErrorMessage VARCHAR2(2000);
    --nuMesacodi          LDCI_MESAENVWS.MESACODI%TYPE;
    --L_Payload           CLOB;
    --sbXmlTransac        VARCHAR2(500);
    --sbESTADO_ENVIO      LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
    --qryCtx              DBMS_XMLGEN.ctxHandle;
    --sbInputMsgType      LDCI_CARASEWE.CASEVALO%type;
    sbEstado_Notif LDCI_INFGESTOTMOV.ESTADO%Type;

    errorPara01 EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

  begin

    for reLDCI_INFOGESTIONOTMOVIL in cuLDCI_INFOGESTIONOTMOVIL loop

      --notifica al sistema externo
      proGeneraMensajeSOAP(isbSistema      => reLDCI_INFOGESTIONOTMOVIL.SISTEMA_ID,
                           inuMensajeId    => reLDCI_INFOGESTIONOTMOVIL.MENSAJE_ID,
                           inuOrden        => reLDCI_INFOGESTIONOTMOVIL.ORDER_ID,
                           onuErrorCode    => onuErrorCode,
                           osbErrorMessage => osbErrorMessage);

      if (onuErrorCode = 0) then

        sbEstado_Notif := Null;
        Select Decode(reLDCI_INFOGESTIONOTMOVIL.ESTADO, 'G', 'N', 'EN')
          Into sbEstado_Notif
          From Dual;
        --- Activado por JJJM
        LDCI_PKINFOADICIONALOT.proActuEstaInfoMovil(inuMensajeId    => reLDCI_INFOGESTIONOTMOVIL.MENSAJE_ID,
                                                 isbEstado       => sbEstado_Notif,
                                                 onuErrorCode    => onuErrorCode,
                                                 osbErrorMessage => osbErrorMessage);

      else

        LDCI_pkWebServUtils.Procrearerrorlogint('proNotiRespInfoAdic',
                                                1,
                                                osbErrorMessage,
                                                null,
                                                null);

      end if; --if (onuErrorCode = 0) then

    end loop; --for reLDCI_INFOGESTIONOTMOVIL in cuLDCI_INFOGESTIONOTMOVIL loop

  exception
    when errorPara01 then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proNotiRespInfoAdic.errorPara01]: ' ||
                         osbErrorMessage;
    when excepNoProcesoRegi then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proNotiRespInfoAdic.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    when others then
      osbErrorMessage := -1;
      osbErrorMessage := '[LDCI_PKINFOADICIONALOT.proNotiRespInfoAdic.others]:' ||
                         SQLERRM;
  end proNotiRespInfoAdic;


End LDCI_PKINFOADICIONALOT;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALOT
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALOT','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKINFOADICIONALOT to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKINFOADICIONALOT to INTEGRADESA;
/
