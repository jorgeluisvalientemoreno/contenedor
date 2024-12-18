CREATE OR REPLACE PACKAGE adm_person.ldc_pkgotssincobsingar IS
 /*****************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-17
    caso        : CA-672
    Descripcion : CA-672 - Paquete para los procesos de ordenes sin cobro y sin garant?a
	
	   Fecha           IDEntrega           Modificacion
  ============    ================    ============================================
  10/07/2024        PAcosta            OSF-2893: Cambio de esquema ADM_PERSON
                                       Retiro marcacion esquema .open objetos de lógica      
  15-05-2024	 	JSOTO			   OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo

 ******************************************************************************************************/
 FUNCTION ldc_retornaobslego(nmpaorden NUMBER) RETURN VARCHAR2;
 FUNCTION ldc_fncconsorsicosingar RETURN pkConstante.tyRefCursor;
 PROCEDURE ldc_prcapruorchelegaot(
                                 isbcodigo    IN VARCHAR2
                                ,inucurrent   IN NUMBER
                                ,inutotal     IN NUMBER
                                ,onuerrorcode OUT ge_error_log.message_id%TYPE
                                ,osberrormess OUT ge_error_log.description%TYPE
                                );
 PROCEDURE ldc_prccrearegaproleg(
                                 nmpanro_orden        ldc_otscobleg.nro_orden%TYPE
                                ,nmpatipo_trab_adic   ldc_otscobleg.tipo_trab_adic%TYPE
                                ,sbpagdc_oca_dano     ldc_otscobleg.gdc_oca_dano%TYPE
                                ,sbpasin_cobr_aut_gdc ldc_otscobleg.sin_cobr_aut_gdc%TYPE
                                ,nmpacodeerror        OUT NUMBER
                                ,sbpamensaerr         OUT VARCHAR2
                                );
END ldc_pkgotssincobsingar;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkgotssincobsingar IS
 /*****************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-17
    caso        : CA-672
    Descripcion : CA-672 - Paquete para los procesos de ordenes sin cobro y sin garant?a
 ******************************************************************************************************
 
 
   Fecha           IDEntrega           Modificacion
  ============    ================    ============================================
  15-05-2024	 	JSOTO			   OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo
**********************************************************************************************************/

--------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ldc_retornaobslego(nmpaorden NUMBER) RETURN VARCHAR2 IS
/********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-17
    caso        : CA-672
    Descripcion : CA-672 - Retornamos la observaci?n de LEGO

    Parametros Entrada
     nmpaorden NUMBER Numero de la orden de trabajo

    Parametros de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
**********************************************************************************************************/
 sbcommentot ldc_otlegalizar.order_comment%TYPE;
 CURSOR cuordenes(nmcuorder NUMBER) IS
  SELECT h.mensaje_legalizado
    FROM ldc_otlegalizar h
   WHERE h.order_id = nmcuorder
   ORDER BY h.fecha_registro;
BEGIN
 FOR i IN cuordenes(nmpaorden) LOOP
  sbcommentot := i.mensaje_legalizado;
 END LOOP;
 RETURN sbcommentot;
EXCEPTION
 WHEN OTHERS THEN
  sbcommentot := SQLCODE||' - '||SQLERRM;
  RETURN sbcommentot;
END ldc_retornaobslego;
--------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ldc_fncconsorsicosingar RETURN pkConstante.tyRefCursor IS
 /************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-17
    caso        : CA-672
    Descripcion : CA-672 - Retornamos las ordenes sin cobro y sin garant?a, que van a ser aprobadas o rechazas
                           para legalizaco?n por la persona autorizada.

    Parametros Entrada

    Parametros de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*************************************************************************************************************************/
 rfcursor  pkConstante.tyRefCursor;
 sbconsulta   ge_boutilities.stystatement; -- se almacena la consulta
BEGIN
 sbconsulta := 'SELECT c.codigo codigo,
                       c.nro_orden nro_orden
                      ,a.subscription_id||'' - ''||(SELECT e.subscriber_name||'' - ''||e.subs_last_name FROM ge_subscriber e WHERE e.subscriber_id = a.subscriber_id) contrato
                      ,ldc_pkgotssincobsingar.ldc_retornaobslego(c.nro_orden) Observacion_lego
                      ,c.tipo_trab_adic||'' - ''||(SELECT t.description FROM or_task_type t WHERE t.task_type_id = c.tipo_trab_adic) tipo_trabajo_adicional
                      ,c.gdc_oca_dano "GDC. ocasiono da�o"
                      ,c.sin_cobr_aut_gdc "Sin cobro aut. GDC.?"
                      ,c.estado
                      ,(SELECT p.operating_unit_id||'' - ''||p.name FROM or_operating_unit p WHERE p.operating_unit_id = u.operating_unit_id) Unidad_operativa
                  FROM ldc_otscobleg c,or_order u, or_order_activity a
                 WHERE c.nro_orden = u.order_id
                   AND u.order_id  = a.order_id
                   and u.order_status_id not in (8,12)
                   and c.estado not in (''RECHAZADA'')';
 OPEN rfcursor FOR sbconsulta;
  RETURN rfcursor;
END ldc_fncconsorsicosingar;
--------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ldc_prcapruorchelegaot(
                                 isbcodigo    IN VARCHAR2
                                ,inucurrent   IN NUMBER
                                ,inutotal     IN NUMBER
                                ,onuerrorcode OUT ge_error_log.message_id%TYPE
                                ,osberrormess OUT ge_error_log.description%TYPE
                                ) IS
 /************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-18
    caso        : CA-672
    Descripcion : CA-672 - Proceso que aprueba o rechaza ordenes para legalizaci?n, en caso de que la orden se apruebe,
                           se procede a enviar correo al contratista que tenga asignada la orden de trabajo.

    Parametros Entrada

     isbcodigo    IN VARCHAR2
     inucurrent   IN NUMBER
     inutotal     IN NUMBER

    Parametros de salida
     onuerrorcode OUT ge_error_log.message_id%TYPE
     osberrormess OUT ge_error_log.description%TYPE

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*************************************************************************************************************************/

 nuCodigo         ldc_otscobleg.codigo%TYPE;
 nuOrden          or_order.order_id%type;
 nuTTAdic         or_task_type.task_type_id%type;
 nmestado          NUMBER(2);
 sbestado          VARCHAR2(20);
 sbcommacre        ldc_otscobleg.obser%TYPE;
 cnunull_attribute CONSTANT NUMBER := 2126;
 nmunidadoper      or_operating_unit.operating_unit_id%TYPE;
 sbemail           or_operating_unit.e_mail%TYPE;
 sbcorreos         VARCHAR2(4000);
 sender            VARCHAR2(1000);
 sbmensaje  	       VARCHAR2(1000);
 NOMBRE_BD	         varchar2(4000);
 sbAsunto            varchar2(4000);

 CURSOR cucorreosconf(sbcorreos VARCHAR2) IS
  SELECT TRIM(column_value) correo
    FROM TABLE(ldc_boutilities.splitstrings(sbcorreos,','));
BEGIN
 -- Obtenemos el correo de salida
 sender := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
 -- Obtenemos el valor del campo nro_orden
 nuCodigo := to_number(isbcodigo);

 -- Obtenemos el valor del campo estado
 nmestado  := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_UNIT','SUBSCRIBER_ID');
 -- Validamos que el estado sea diferente de NULL
 IF (nmestado IS NULL) THEN
     errors.seterror (cnunull_attribute, '"Aprobar ? Rechazar Orden"');
     RAISE ex.controlled_error;
 END IF;
 -- Asignamos descripcion del estado
 IF nmestado = 1 THEN
  sbestado := 'APROBADA';
 ELSIF nmestado = 2 THEN
  sbestado := 'RECHAZADA';
 END IF;

 NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
 if NOMBRE_BD != 'P' THEN
   NOMBRE_BD :='Base de datos de pruebas';
 else
   NOMBRE_BD :=null;
 End if;

 -- Obtenemos el valor del campo observaci?n de aprueba o rechazado
 sbcommacre :=  ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_COMMENT', 'ORDER_COMMENT');
 -- Validamos que la observaci?n de aprueba o rechazado sea diferente a NULL
 IF (sbcommacre IS NULL) THEN
     errors.seterror (cnunull_attribute, '"Observacion aprueba o rechaza legalizacion de ord?n"');
     RAISE ex.controlled_error;
 END IF;
 -- Obtenemos la unidad operativa de la orden.
 BEGIN
  SELECT u.e_mail,u.operating_unit_id, o.order_id, c.tipo_trab_adic INTO sbemail,nmunidadoper, nuOrden , nuTTAdic
    FROM or_order o,or_operating_unit u, ldc_otscobleg c
   WHERE o.order_id          = c.nro_orden
     AND o.operating_unit_id = u.operating_unit_id
     and c.codigo = nuCodigo ;
 EXCEPTION
  WHEN OTHERS THEN
   sbemail      := NULL;
   nmunidadoper := NULL;
 END;
 -- Validamos que el contratista tenga correos configurados
 IF TRIM(sbemail) IS NULL THEN
   errors.seterror (cnunull_attribute, 'El contratista de la orden no tiene correos configurados.');
   RAISE ex.controlled_error;
 END IF;
 -- Actualizamos el estado de la orden para legalizar o no
 UPDATE ldc_otscobleg t
    SET estado = TRIM(sbestado),obser = sbcommacre,usuario = USER,fecha = SYSDATE
  WHERE t.codigo = nuCodigo;


 -- Enviamos correo siempre y cuando se haya Aprobado la legalizaci?n de la orden
 IF sbestado = 'APROBADA' THEN
   sbAsunto :='Orden aprobada para ser legalizada';
   sbmensaje := 'Se aprueba la orden : '||to_char(nuOrden)||' con trabajo adicional '||nuTTAdic||'-'||daor_task_type.fsbgetdescription(nuTTAdic, null)||' con el comentario: '||sbcommacre||', puede proceder con la legalizacion.';
 ELSE
   sbAsunto :='Orden rechazada';
   sbmensaje := 'Se rechaza la orden : '||to_char(nuOrden)||' con trabajo adicional '||nuTTAdic||'-'||daor_task_type.fsbgetdescription(nuTTAdic, null)||' con el comentario: '||sbcommacre||', corregir la legalizacion.';
 END IF;
  sbCorreos := '';
  FOR i IN cucorreosconf(TRIM(sbemail)) LOOP
   sbcorreos := TRIM(sbCorreos) || i.correo ||';';
  END LOOP;
  -- Enviamos correo
  IF(sbcorreos IS NOT NULL OR sbcorreos <> '') THEN

	  pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sender,
								isbDestinatarios    => sbcorreos,
								isbAsunto           => sbAsunto,
								isbMensaje          => sbMensaje
							);
  END IF;

EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE ex.controlled_error;
 WHEN OTHERS THEN
  ROLLBACK;
  errors.seterror;
  RAISE ex.controlled_error;
END ldc_prcapruorchelegaot;
--------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE ldc_prccrearegaproleg(
                                 nmpanro_orden        ldc_otscobleg.nro_orden%TYPE
                                ,nmpatipo_trab_adic   ldc_otscobleg.tipo_trab_adic%TYPE
                                ,sbpagdc_oca_dano     ldc_otscobleg.gdc_oca_dano%TYPE
                                ,sbpasin_cobr_aut_gdc ldc_otscobleg.sin_cobr_aut_gdc%TYPE
                                ,nmpacodeerror        OUT NUMBER
                                ,sbpamensaerr         OUT VARCHAR2
                                ) IS
 /************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-09-18
    caso        : CA-672
    Descripcion : CA-672 - Proceso que crea registro en la tabla ldc_otscobleg.

    Parametros Entrada

     nmpanro_orden        Orden de trabajo
     nmpatipo_trab_adic   Tipo de trabajo adicional
     sbpagdc_oca_dano     Gdc ocasion? da?o
     sbpasin_cobr_aut_gdc Sin cobro autorizado por GDC

    Parametros de salida

     nmpacodeerror        Codigo de error
     sbpamensaerr         mensaje de error


   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*************************************************************************************************************************/
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 nmpacodeerror := 0;
 sbpamensaerr  := NULL;

   INSERT INTO ldc_otscobleg(
                             codigo
                            ,nro_orden
                            ,tipo_trab_adic
                            ,gdc_oca_dano
                            ,sin_cobr_aut_gdc
                            ,estado
                            ,nro_intento
                            )
                      VALUES(
                             seq_ldc_otscobleg.nextval
                            ,nmpanro_orden
                            ,nmpatipo_trab_adic
                            ,sbpagdc_oca_dano
                            ,sbpasin_cobr_aut_gdc
                            ,'PENDIENTE APROBACION'
                            ,1
                            );
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;
   nmpacodeerror := -1;
   sbpamensaerr  := 'ERROR EN LDC_PKGOTSSINCOBSINGAR.LDC_PRCCREAREGAPROLEG : '||SQLERRM;
 END ldc_prccrearegaproleg;
 --------------------------------------------------------------------------------------------------------------------------------------------
END ldc_pkgotssincobsingar;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGOTSSINCOBSINGAR
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGOTSSINCOBSINGAR', 'ADM_PERSON');
END;
/