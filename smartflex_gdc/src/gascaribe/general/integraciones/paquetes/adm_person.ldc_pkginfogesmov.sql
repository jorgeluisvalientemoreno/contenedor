CREATE OR REPLACE PACKAGE adm_person.LDC_PKGINFOGESMOV IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    25/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
  FUNCTION PROCERTINTAPROBMOV  Return constants.tyrefcursor;
    /**************************************************************************
      Autor       : Luis Salazar / Horbath
      Fecha       : 2018-08-22
      Ticket      : 200-2077
      Descripcion : Retorna los mensajes de aprobaciÿ³n de certificados tienen error de configuraciÿ³n en Smartflex.

      Parametros:
        1.Entrada : NINGUNO
        2.Salida  : Cursor con consulta

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      ---------------------------------------------------------------------------
      02-10-2020     Horbath    481. Se crea nueva consulta para que tenga en cuenta los
                                registros en estado GE
    ***************************************************************************/

  PROCEDURE PROCACTUALIZACERT ( sbIdMensaje   IN VARCHAR2,
                                nuCurrent IN NUMBER,
                                nuTotal   IN NUMBER,
                                nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                                sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE);
   /**************************************************************************
      Autor       : Luis Salazar / Horbath
      Fecha       : 2018-08-22
      Ticket      : 200-2077
      Descripcion : Proceso para cambio de estado de los certificados a P

      Parametros:
        1.Entrada : sbOrden: Identificador de la orden
                    nuCurrent: Seleccionado en el PB
                    nuTotal: Total de ordenes en el PB
        2.Salida  : nuCodError: Codigo de error
                    sbMensaje: Mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

END LDC_PKGINFOGESMOV;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGINFOGESMOV AS
  FUNCTION PROCERTINTAPROBMOV  Return constants.tyrefcursor IS
    /**************************************************************************
      Autor       : Luis Salazar / Horbath
      Fecha       : 2018-08-22
      Ticket      : 200-2077
      Descripcion : Proceso para cambio de estado de los certificados a P

      Parametros:
        1.Entrada : sbOrden: Identificador de la orden
                    nuCurrent: Seleccionado en el PB
                    nuTotal: Total de ordenes en el PB
        2.Salida  : nuCodError: Codigo de error
                    sbMensaje: Mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
     ---------------------------------------------------------------------------
     02-10-2020     Horbath     481. Se crea nueva consulta para que tenga en cuenta los
                                registros en estado GE
    ***************************************************************************/

     /* Cursor referenciado con datos de la consulta */
    rfresult constants.tyrefcursor;

    /* Mensaje que indica que falta un parametro requerido */
    cnunull_attribute Constant ge_message.message_id%Type := 2126;
    cnu_not_search_crit Constant ge_message.message_id%Type := 900619;
    csbENTREGA481   CONSTANT    VARCHAR2(10) := '0000481';


    /* Formato con que el PB instancia la fecha */
    sbdateformat  ge_boutilities.stystatementattribute;
    /* SISTEMAS */
    sbSistemas    ge_boinstancecontrol.stysbvalue;
    /* fecha inicial */
    sbfechainicial ge_boinstancecontrol.stysbvalue;
    /* fecha final */
    sbfechafinal   ge_boinstancecontrol.stysbvalue;
    /* Consulta de ordenes */
    sbsqlorders ge_boutilities.stystatement;
  BEGIN
    sbdateformat := ut_date.fsbdate_format;

    sbSistemas      := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CONFSISUSUA', 'COSISIST');
    sbfechainicial  := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXEC_INITIAL_DATE');
    sbfechafinal    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXECUTION_FINAL_DATE');

    IF sbfechainicial IS NOT NULL THEN
       sbfechainicial := TO_CHAR(TO_DATE(sbfechainicial,'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY')||' 00:00:00';
    END IF;

    IF sbfechafinal IS NOT NULL THEN
       sbfechafinal := TO_CHAR(TO_DATE(sbfechafinal,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59';
    END IF;
    --TICKET 200-2210 LJLB --se agrega codigo de error y mensaje de error

    -- Inicio cambio 481. Si no aplica la entrega ejecuta la consulta anterior
    IF NOT fblaplicaentregaxcaso(csbENTREGA481) THEN

        sbsqlorders := 'SELECT m.MENSAJE_ID MENSAJE_ID,
                             m.sistema_id SISTEMA,
                             m.operacion OPERACION,
                             m.order_id ORDEN,
                             m.ESTADO ESTADO,
                             m.fecha_recepcion FECHA_RECEPCION,
                             m.FECHA_PROCESADO,
                             m.FECHA_NOTIFICADO,
                             m.COD_ERROR_OSF Codigo_error,
                             m.MSG_ERROR_OSF Mensaje_error
                        FROM open.ldci_infgestotmov m
                        WHERE m.estado = ''EN'' AND
                          m.sistema_id = '''||sbSistemas||''' AND
                          m.FECHA_RECEPCION BETWEEN TO_DATE('''||sbfechainicial||''',''DD/MM/YYYY HH24:MI:SS'') AND TO_DATE('''||sbfechafinal||''',''DD/MM/YYYY HH24:MI:SS'')';

    ELSE

        sbsqlorders := 'SELECT m.MENSAJE_ID MENSAJE_ID,
                             m.sistema_id SISTEMA,
                             m.operacion OPERACION,
                             m.order_id ORDEN,
                             m.ESTADO ESTADO,
                             m.fecha_recepcion FECHA_RECEPCION,
                             m.FECHA_PROCESADO,
                             m.FECHA_NOTIFICADO,
                             m.COD_ERROR_OSF Codigo_error,
                             m.MSG_ERROR_OSF Mensaje_error
                        FROM open.ldci_infgestotmov m
                        WHERE m.estado IN (''EN'',''GE'') AND
                          m.sistema_id = '''||sbSistemas||''' AND
                          m.FECHA_RECEPCION BETWEEN TO_DATE('''||sbfechainicial||''',''DD/MM/YYYY HH24:MI:SS'') AND TO_DATE('''||sbfechafinal||''',''DD/MM/YYYY HH24:MI:SS'')';

    END If;
    -- Fin cambio 481.

    Open rfresult For
    sbsqlorders;


    RETURN rfresult;
  EXCEPTION
     WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR (-20000,'Error no controlado '||sbfechainicial||'-'||sbfechafinal);
  END PROCERTINTAPROBMOV;

  PROCEDURE PROCACTUALIZACERT ( sbIdMensaje IN VARCHAR2,
                                nuCurrent   IN NUMBER,
                                nuTotal     IN NUMBER,
                                nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                                sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
   /**************************************************************************
      Autor       : Luis Salazar / Horbath
      Fecha       : 2018-08-22
      Ticket      : 200-2077
      Descripcion : Proceso para cambio de estado de los certificados a P

      Parametros:
        1.Entrada : sbIdMensaje: Identificador del certificado
                    nuCurrent: Seleccionado en el PB
                    nuTotal: Total de ordenes en el PB
        2.Salida  : nuCodError: Codigo de error
                    sbMensaje: Mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    nuOrden     ldci_infgestotmov.order_id%TYPE;
    idMensaje   ldci_infgestotmov.MENSAJE_ID%TYPE;
    sbMensError LDC_INFOGESMOV_LOG.COMMENT_ERROR%TYPE;
    sbEstado    LDC_INFOGESMOV_LOG.ESTADO%TYPE;
    sbProceso   LDC_INFOGESMOV_LOG.PROCESO%TYPE;

    CURSOR cuDatosorde IS
    SELECT MSG_ERROR_OSF, ESTADO, PROCESO_EXTERNO_ID, ORDER_ID
    FROM ldci_infgestotmov
    WHERE MENSAJE_ID = idMensaje;

  BEGIN

   idMensaje := TO_NUMBER(sbIdMensaje);

   OPEN cuDatosorde;
   FETCH cuDatosorde INTO sbMensError, sbEstado, sbProceso, nuOrden;
   CLOSE cuDatosorde;


   INSERT INTO LDC_INFOGESMOV_LOG ( MENSAJE_ID, ORDER_ID, DATE_CREATE, COMMENT_ERROR, USUARIO, ESTADO, PROCESO )
                           VALUES ( idMensaje, nuOrden, SYSDATE, sbMensError, USER, sbEstado, sbProceso );

    UPDATE ldci_infgestotmov SET ESTADO = 'P'
    WHERE MENSAJE_ID = idMensaje;

    COMMIT;

  EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

  END PROCACTUALIZACERT;
END LDC_PKGINFOGESMOV;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGINFOGESMOV
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGINFOGESMOV', 'ADM_PERSON');
END;
/