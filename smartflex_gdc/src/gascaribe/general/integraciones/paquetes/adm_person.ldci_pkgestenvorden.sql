CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKGESTENVORDEN AS
  /*
  * Propiedad Intelectual Gases de Occidente SA ESP
  *
  * Script  : LDCI_PKGESTENVORDEN.sql
  * RICEF   :
  * Autor   : AAcuna / Adolfo Acuña
  * Fecha   : 11-05-2016
  * Descripcion : Paquete de integracion con los sistemas moviles

  **/

  procedure proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%type);

  FUNCTION fsbCalComent(inuActivi in NUMBER) RETURN VARCHAR2;

  Procedure proNotificaOrdenesENVIO(isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type);

  procedure proGeneMensNotificaOT(isbSistema       in  VARCHAR2,
                              inuTASK_TYPE_ID  in  NUMBER,
                              inuTransac       in  NUMBER,
                              inuLote          in  NUMBER,
                              inuLotes         in  NUMBER,
                              onuErrorCode     out NUMBER,
                              osbErrorMessage  out VARCHAR2);

                              procedure proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                 inuLOTE          in NUMBER,
                                 isbEstado        in VARCHAR2,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2);


procedure proActuEstaAnulOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                     inuLOTE          in NUMBER,
                                     isbEstadoAnulado in VARCHAR2,
                                     onuErrorCode    out NUMBER,
                                     osbErrorMessage out VARCHAR2);
END LDCI_PKGESTENVORDEN;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKGESTENVORDEN AS
  -- Carga variables globales
  sbInputMsgType  LDCI_CARASEWE.CASEVALO%type;
  sbNameSpace     LDCI_CARASEWE.CASEVALO%type;
  sbUrlWS         LDCI_CARASEWE.CASEVALO%type;
  sbUrlDesti      LDCI_CARASEWE.CASEVALO%type;
  sbSoapActi      LDCI_CARASEWE.CASEVALO%type;
  sbProtocol      LDCI_CARASEWE.CASEVALO%type;
  sbHost          LDCI_CARASEWE.CASEVALO%type;
  sbPuerto        LDCI_CARASEWE.CASEVALO%type;
  sbPrefijoLDC    LDCI_CARASEWE.CASEVALO%type;
  sbDefiSewe      LDCI_DEFISEWE.DESECODI%type;

  procedure proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%type) as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     Procedimiento : LDCI_PKGESTNOTIORDEN.proCargaVarGlobal
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 25/02/2012
     RICEF      : REQ007-I062
     DESCRIPCION: Limpia y carga las variables globales

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */
    onuErrorCode      ge_error_log.Error_log_id%TYPE;
    osbErrorMessage   ge_error_log.description%TYPE;
    errorPara01 EXCEPTION;       -- Excepcion que verifica que ingresen los parametros de entrada

begin
      LDCI_PKGESTENVORDEN.sbInputMsgType  := null;
      LDCI_PKGESTENVORDEN.sbNameSpace     := null;
      LDCI_PKGESTENVORDEN.sbUrlWS         := null;
      LDCI_PKGESTENVORDEN.sbUrlDesti      := null;
      LDCI_PKGESTENVORDEN.sbSoapActi      := null;
      LDCI_PKGESTENVORDEN.sbProtocol      := null;
      LDCI_PKGESTENVORDEN.sbHost          := null;
      LDCI_PKGESTENVORDEN.sbPuerto        := null;
      LDCI_PKGESTENVORDEN.sbPrefijoLDC    := null;
      LDCI_PKGESTENVORDEN.sbDefiSewe      := null;


      LDCI_PKGESTENVORDEN.sbDefiSewe := isbCASECODI;
      -- carga los parametos de la interfaz
      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'INPUT_MESSAGE_TYPE', LDCI_PKGESTENVORDEN.sbInputMsgType, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'NAMESPACE', LDCI_PKGESTENVORDEN.sbNameSpace, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'WSURL', LDCI_PKGESTENVORDEN.sbUrlWS, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'SOAPACTION', LDCI_PKGESTENVORDEN.sbSoapActi, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PROTOCOLO', LDCI_PKGESTENVORDEN.sbProtocol, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PUERTO', LDCI_PKGESTENVORDEN.sbPuerto, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'HOST', LDCI_PKGESTENVORDEN.sbHost, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      /*LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PREFIJO_LDC', LDCI_PKGESTNOTIORDEN.sbPrefijoLDC, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if; */

      LDCI_PKGESTENVORDEN.Sburldesti := Lower(LDCI_PKGESTENVORDEN.Sbprotocol) || '://' || LDCI_PKGESTENVORDEN.Sbhost || ':' || LDCI_PKGESTENVORDEN.Sbpuerto || '/' || LDCI_PKGESTENVORDEN.Sburlws;
      LDCI_PKGESTENVORDEN.sbUrlDesti := trim(LDCI_PKGESTENVORDEN.sbUrlDesti);

exception
    When Errorpara01 then
      Errors.seterror (-1, 'ERROR: [LDCI_PKGESTNOTIORDEN.proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage);
      commit; --rollback;
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
end proCargaVarGlobal;


FUNCTION fsbCalComent(inuActivi  in NUMBER) RETURN VARCHAR2 AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbCalComent
 * Tiquete :
 * Autor   : Arquitecsoft / hectord <hectord@arqs.co>
 * Fecha   : 14-05-2014
 * Descripcion : Calcula comentarios de una actrividad
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
**/

INUCOMMENT NUMBER;
SBCOMMENTACT  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;
SBCOMMENTOR  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;

	/*
	* CURSOR       CUACTIVIDAD
	*
	* DESCRIPCION:
	* FECHA:       16-12-2014
	* TIQUETE:     ROLLOUT
	*
	*/

CURSOR CUACTIVIDAD is

SELECT ORDER_ID, COMMENT_
FROM  OR_ORDER_ACTIVITY OA
WHERE ORDER_ACTIVITY_ID =INUACTIVI;



	/*
	* CURSOR       CUORDERCOM
	*
	* DESCRIPCION:
	* FECHA:       16-12-2014
	* TIQUETE:     ROLLOUT
	*
	*/


CURSOR CUORDERCOM(INUORDEN NUMBER) IS
SELECT  ORDER_COMMENT
FROM    OR_ORDER_COMMENT OC
WHERE   OC.ORDER_ID = INUORDEN  AND
        ORDER_COMMENT_ID = (SELECT MIN(ORDER_COMMENT_ID)
                            FROM OR_ORDER_COMMENT WHERE ORDER_ID =INUORDEN );

BEGIN

OPEN CUACTIVIDAD;
FETCH CUACTIVIDAD INTO INUCOMMENT,SBCOMMENTACT;
CLOSE CUACTIVIDAD;

OPEN CUORDERCOM(INUCOMMENT);
FETCH CUORDERCOM INTO SBCOMMENTOR;
CLOSE CUORDERCOM;

RETURN ge_boemergencyorders.fsbvalidatecharactersxml(SBCOMMENTACT||' '||SBCOMMENTOR); --#8335: KarBaq: Se agrega el llamado ala funci?n de caracteres especiales

EXCEPTION
WHEN OTHERS THEN
    LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('LDCI_PKGESTNOTIORDEN.fsbRefinancia',1,'Fallo definiendo flag refinanciar: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, NULL, NULL);
    RETURN 'ERROR CONSULTANDO COMENTARIOS ';
END fsbCalComent;

procedure proGeneMensNotificaOT(isbSistema       in  VARCHAR2,
                              inuTASK_TYPE_ID  in  NUMBER,
                              inuTransac       in  NUMBER,
                              inuLote          in  NUMBER,
                              inuLotes         in  NUMBER,
                              onuErrorCode     out NUMBER,
                              osbErrorMessage  out VARCHAR2) AS

/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Uso de DBMS_XMLGEN
 *
 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlos.virgen           15-05-2014    Version inicial
 * JESUS VIVERO (LUDYCOM)  19-05-2015    #7171-20150519: jesviv: Se agregan campos al XML de notificacion de ordenes
 *Karem Baquero(sincecomp) 24-07-2015    #8335 : Se modifica la forma en la que se obtiene la suscripci?n
 *                                       ya no se hace desde la orden, si no desde el producto.
 *Karem Baquero(sincecomp) 11-08-2015    # se modifica el cursor con el que se obtiene la informaci?n
                                         a enviar desde el xml, para los datos del suscriptor<<proGeneMensNotificaOT>>
**/

   --#NC-INTERNA: Conteo de cantidad de ordenes
   -- conteo de ordenes por lote
   cursor cuContordenes(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
     SELECT COUNT(ORDE.ORDER_ID) ORDENES
      FROM LDCI_ORDENMOVILES ORDE
     WHERE ORDE.LOTE = nuLote
       and ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
       AND ORDE.ESTADO_ENVIO = 'P'
       and ORDE.ESTADO_ENVIO_ANULA is null;

   -- conteo de actividades por lote
   cursor cuContAvtividades(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
    SELECT COUNT(ACTI.ACTIVITY_ID) ACTIVIDADES
     FROM LDCI_ORDENMOVILES ORDE, OR_ORDER_ACTIVITY ACTI
    WHERE ORDE.ORDER_ID = ACTI.ORDER_ID
      AND ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ACTI.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ORDE.LOTE = nuLote
      AND ORDE.ESTADO_ENVIO = 'P'
      AND ORDE.ESTADO_ENVIO_ANULA is null;

   -- cursor de la configuracion de sistema movil por tipo de trabajo
   cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type,
                                   inuTASK_TYPE_ID LDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID%type)  is
    select SISTEMA_ID,TASK_TYPE_ID,
           OP_UNITS,
           REQUIERE_INFO_SUSC,
           REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART,
           REQUIERE_INFO_PRED,
           REQUIERE_INFO_LECT,
           REQUIERE_INFO_CTAC
    from   LDCI_SISTMOVILTIPOTRAB
    where  SISTEMA_ID = isbSISTEMA_ID
    and    TASK_TYPE_ID = inuTASK_TYPE_ID;

   rfConsulta Constants.tyRefCursor;

   nuCantOrds         NUMBER := 0;
   nuCantActs         NUMBER := 0;
   nuMesacodi         LDCI_MESAENVWS.MESACODI%TYPE;
   L_Payload          CLOB;
   sbXmlTransac       VARCHAR2(500);
   sbESTADO_ENVIO LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
   qryCtx             DBMS_XMLGEN.ctxHandle;
   reLDCI_SISTMOVILTIPOTRAB cuLDCI_SISTMOVILTIPOTRAB%rowtype;
   errorPara01        EXCEPTION;       -- Excepcion que verifica que ingresen los parametros de entrada
   Excepnoprocesoregi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin

    proCargaVarGlobal(isbSistema);
    dbms_output.put_line('[proGeneMensNotificaOT] ini ');

    --Carga la configuracion para el tipo de trabajo
    open cuLDCI_SISTMOVILTIPOTRAB(isbSistema, inuTASK_TYPE_ID);
    fetch cuLDCI_SISTMOVILTIPOTRAB into reLDCI_SISTMOVILTIPOTRAB;
    close cuLDCI_SISTMOVILTIPOTRAB;
    dbms_output.put_line('[proGeneMensNotificaOT] ini 397');
    --#NC-INTERNA: Conteo de cantidad de ordenes
    open  cuContordenes(inuLote, inuTASK_TYPE_ID);
    fetch cuContordenes into nuCantOrds;
    close cuContordenes;
    dbms_output.put_line('[proGeneMensNotificaOT] ini 401');
    open  cuContAvtividades(inuLote, inuTASK_TYPE_ID);
    fetch cuContAvtividades into nuCantActs ;
    close cuContAvtividades;
    dbms_output.put_line('[proGeneMensNotificaOT] ini 406');

    open rfConsulta for
       select ORDE.ORDER_ID as "idOrden",
              ORDE.TASK_TYPE_ID as "idTipoTrab",
              ORDE.ORDER_STATUS_ID  as "idEstado",
              ORDE.ADDRESS_ID as "idDireccion",
              ORDE.ADDRESS as "direccion",
              ORDE.GEOGRA_LOCATION_ID as "idLocalidad",
              (Select d.Description From Ge_Geogra_Location d Where d.Geograp_Location_Id = Orde.Geogra_Location_Id) As "descLocalidad", --#7171-20150519: jesviv: Se agrega descripcion de localidad
              ORDE.NEIGHBORTHOOD as "idBarrio",
              ORDE.OPER_SECTOR_ID as "idSectorOper",
              (Select d.Description From Or_Operating_Sector d Where d.Operating_Sector_Id = Orde.Oper_Sector_Id) As "descSectorOper", --#7171-20150519: jesviv: Se agrega descripcion del sector operativo
              ORDE.ROUTE_ID as "idRuta",
              ORDE.CONSECUTIVE as "consPredio",
              ORDE.PRIORITY as "prioridad",
              to_char(ORDE.ASSIGNED_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaAsig",
              to_char(ORDE.ARRANGE_HOUR, 'YYYY-MM-DD HH24:MI:SS') as "fechaCompromiso",
              to_char(ORDE.CREATED_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaCreacion",
              to_char(ORDE.EXEC_ESTIMATE_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaPlanEjec",
              to_char(ORDE.MAX_DATE_TO_LEGALIZE, 'YYYY-MM-DD HH24:MI:SS') as "fechaMaxLeg",
              ORDE.OPERATING_UNIT_ID as "idUnidadOper",
              cursor
              (
                select ORDER_ACTIVITY_ID as "idOrdenActividad",
                      ORDER_ITEM_ID as "idItem",
                      ORDER_ID as "idOrdenTrabajo",
                      STATUS as "idEstadoActividad",
                      TASK_TYPE_ID as "idTipoTrabAct",
                      --PACKAGE_ID ,
                      --MOTIVE_ID,
                      --COMPONENT_ID,
                      --INSTANCE_ID,
                      ADDRESS_ID as "idDireccion",
                      --ELEMENT_ID,
                      ----8335 - 8490 : Karbaq 12/08/2015 Se cambia para obtener el cliente del contrato si este viene en blaco
                       decode(SUBSCRIBER_ID,null,pktblsuscripc.fnugetsuscclie(dapr_product.fnugetsubscription_id(PRODUCT_ID)),SUBSCRIBER_ID) as "idCliente",
                     --SUBSCRIBER_ID as "idCliente",
                      --SUBSCRIPTION_ID as "idContrato",
                      ----8335 - 8490 : Karbaq 12/08/2015 --Se cambia para obtener el contrato del producto, si el
                       decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID) as "idContrato",
                      --dapr_product.fnugetsubscription_id(PRODUCT_ID) as "idContrato",
                      PRODUCT_ID as "idProducto",
                      ------8335 - 8490 : Karbaq 12/08/2015 Se cambia para obtener el contrato del producto
                      (Select s.Susccicl From Suscripc s Where s.Susccodi =  decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*Acti.Subscription_Id*/) As "idCicloFacturacion", --#7171-20150519: jesviv: Se agrega ciclo de facturacion
                      OPERATING_SECTOR_ID as "idSectorOperativo",
                      EXEC_ESTIMATE_DATE as "fechaEstimada",
                      OPERATING_UNIT_ID AS "idUnidadOperativa",
                      fsbCalComent(ORDER_ACTIVITY_ID) as "observaciones",
                      --PROCESS_ID,
                      ACTIVITY_ID as "idActividad",
                      --ORIGIN_ACTIVITY_ID,
                      --ACTIVITY_GROUP_ID,
                      --SEQUENCE_,
                      REGISTER_DATE as "fechaRegistro",
                      --FINAL_DATE,
                      --VALUE1,
                      --VALUE2,
                      --VALUE3,
                      --VALUE4,
                      --COMPENSATED,
                      --ORDER_TEMPLATE_ID,
                      nvl(CONSECUTIVE,0) as "consecutivo",
                      --SERIAL_ITEMS_ID,
                      LEGALIZE_TRY_TIMES as "nroIntentos",
                      --WF_TAG_NAME,
                      --VALUE_REFERENCE,
                      --ACTION_ID,
                      CASE CONF.REQUIERE_INFO_SUSC
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener suscriptor
                        WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SUSCRIPC(decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*ACTI.SUBSCRIPTION_ID*/, ACTI.ORDER_ID)
                        WHEN 'N' THEN NULL
                      END as "Contratos",
                      CASE CONF.REQUIERE_INFO_SESU
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SERVSUSC(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Servicios",
                      CASE CONF.REQUIERE_INFO_CART
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener suscriptor
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_CARTERA(decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*ACTI.SUBSCRIPTION_ID*/,ACTI.PRODUCT_ID, ACTI.ORDER_ID)
                       WHEN 'N' THEN NULL
                      END as "Carteras",
                      CASE CONF.REQUIERE_INFO_PRED
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_PREDIO(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Predios",
                      CASE CONF.REQUIERE_INFO_LECT
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Lecturas",
                       CASE CONF.REQUIERE_INFO_SOLI
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SOLICITUD(ACTI.PACKAGE_ID, ACTI.MOTIVE_ID)
                       WHEN 'N' THEN NULL
                      END as "Solicitudes",
                      CASE CONF.REQUIERE_INFO_CTAC
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener cliente
                        WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_CONTACTOS(decode(SUBSCRIBER_ID,null,pktblsuscripc.fnugetsuscclie(dapr_product.fnugetsubscription_id(PRODUCT_ID)),SUBSCRIBER_ID)/*ACTI.SUBSCRIBER_ID*/, ACTI.PRODUCT_ID)
                        WHEN 'N' THEN NULL
                      END as "Contactos"
                 from OR_ORDER_ACTIVITY ACTI
                where ACTI.ORDER_ID = ORDE.ORDER_ID
                  and ACTI.TASK_TYPE_ID = ORDE.TASK_TYPE_ID
              ) as "Actividades"
        from LDCI_ORDENMOVILES ORDE, LDCI_SISTMOVILTIPOTRAB CONF
       where ORDE.TASK_TYPE_ID = inuTASK_TYPE_ID
         and ORDE.LOTE = inuLote
         and ORDE.ESTADO_ENVIO = sbESTADO_ENVIO
         and CONF.SISTEMA_ID  = isbSistema
         and CONF.TASK_TYPE_ID = ORDE.TASK_TYPE_ID
         and ORDE.ESTADO_ENVIO_ANULA is null;
    -- Genera el mensaje XML
    Qryctx :=  Dbms_Xmlgen.Newcontext (rfConsulta);

    -- Asigna el valor de la variable
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'inuLote', inuLote);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'inuTASK_TYPE_ID', inuTASK_TYPE_ID);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'isbESTADO_ENVIO', sbESTADO_ENVIO);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSistema', isbSistema);

      --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, false);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);
    dbms_output.put_line('[proGeneMensNotificaOT] ini 520');
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET',  '<Ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>',  '</Ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>',  '<Orden>');
    L_Payload := Replace(L_Payload, '</ROW>',  '</Orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<Actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</Actividades>');
    L_Payload := Replace(L_Payload, '<Actividades_ROW>',  '<Actividad>');
    L_Payload := Replace(L_Payload, '</Actividades_ROW>',  '</Actividad>');

    sbXmlTransac := '<sistema>' || isbSistema || '</sistema>
                       <transaccion>
                       <proceso>' || inuTransac ||'</proceso>
                       <lote>' || inuLote || '</lote>
                       <cantidadLotes>' || inuLotes || '</cantidadLotes>
                       <cantOrdenes>' || nuCantOrds || '</cantOrdenes>
                       <cantActividades>' || nuCantActs || '</cantActividades>
                    </transaccion>';

    L_Payload := '<' || LDCI_PKGESTENVORDEN.sbInputMsgType || '>' || sbXmlTransac || L_Payload || '</' || LDCI_PKGESTENVORDEN.sbInputMsgType || '>';
    L_Payload := Trim(L_Payload);
    --dbms_output.put_line('[proGeneMensNotificaOT 594 L_Payload ]' || chr(13) || L_Payload);

       -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   isbSistema,  -- Sistema configurado en LDCI_CARASEWE
                                   -1,
                                   inuTransac,
                                   null,
                                   L_Payload,
                                   inuLote,
                                   inuLotes,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

dbms_output.put_line('[626.proGeneMensNotificaOT 594 onuErrorCode ]' || onuErrorCode);

exception
  when excepNoProcesoRegi then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
dbms_output.put_line('[proGeneMensNotificaOT.excepNoProcesoRegi] osbErrorMessage ' || osbErrorMessage);
   when others then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT.others]:' || SQLERRM;
dbms_output.put_line('[proGeneMensNotificaOT.others] osbErrorMessage ' || osbErrorMessage);
dbms_output.put_line('[proGeneMensNotificaOT.others] format_error_backtrace ' || DBMS_UTILITY.format_error_backtrace);

end proGeneMensNotificaOT;

procedure proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                 inuLOTE          in NUMBER,
                                 isbEstado        in VARCHAR2,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles
 * Tiquete : I062
 * Autor   : OLSoftware / Carlos E. Virgen Londo?o
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
 * Parametros:
 IN: inuTASK_TYPE_ID: Id del tipo de trabajo
 IN: inuLOTE: Lote
 IN: isbEstado: Estado de env?: P[pendiente] E[enviado] G[Gestionada]
 OUT:onuErrorCode: C?digo de error
 OUT:osbErrorMessage: Mensaje de excepci?n

 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlosvl                17/04/2013    Creacion del paquete
 * JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega actualizacion de fecha de envio de orden a caja gris
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- excepciones
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
 onuErrorCode := 0;

dbms_output.put_line('[proActuEstaNotiOrdenMoviles] isbEstado ' || isbEstado);
dbms_output.put_line('[proActuEstaNotiOrdenMoviles] inuTASK_TYPE_ID ' || inuTASK_TYPE_ID);
dbms_output.put_line('[proActuEstaNotiOrdenMoviles] inuLOTE ' || inuLOTE);
  -- Notficicacion de ordenes asignadas
  Update Ldci_Ordenmoviles
  Set    Estado_Envio = isbEstado,
         Fecha_Envio  = Decode(isbEstado, 'E', Sysdate, Fecha_Envio) --#20150212: jesusv: Se agrega campo fecha de envio para anulacion
  Where  Task_Type_Id = inuTask_Type_Id
  And    Lote = inuLote;

 if (SQL%notfound)  then
    raise EXCEP_UPDATE_CHECK;
 end if;--if (SQL%notfound)  then

 commit;

exception
 when EXCEP_UPDATE_CHECK then
   rollback;
   onuErrorCode := -1;
   osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
                      'No se encuentra el mensaje  TASK_TYPE ' || inuTASK_TYPE_ID ||' Lote ' || inuLOTE;
   LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaNotiOrdenMoviles',1,osbErrorMessage, null, null);
 when others then
   rollback;
   onuErrorCode:= -1;
   osbErrorMessage:= '[LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles.others] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
end proActuEstaNotiOrdenMoviles;

procedure proActuEstaAnulOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                     inuLOTE          in NUMBER,
                                     isbEstadoAnulado in VARCHAR2,
                                     onuErrorCode    out NUMBER,
                                     osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles
 * Tiquete : I062
 * Autor   : OLSoftware / Carlos E. Virgen Londono
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
 * Parametros:
 IN: inuTASK_TYPE_ID: Id del tipo de trabajo
 IN: inuLOTE: Lote
 IN: isbEstado: Estado de env?: P[pendiente] E[enviado] G[Gestionada]
 OUT:onuErrorCode: C?digo de error
 OUT:osbErrorMessage: Mensaje de excepci?n

 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlosvl                17/04/2013    Creacion del paquete
 * JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega actualizacion de fecha de envio de anulacion de orden a caja gris
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- excepciones
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
 onuErrorCode := 0;

  -- realia la inserci?n en la tabla LDCI_ESTAPROC
  Update Ldci_Ordenmoviles
  Set    Estado_Envio_Anula = isbEstadoAnulado,
         Fecha_Envio_Anula  = Decode(isbEstadoAnulado, 'E', Sysdate, Fecha_Envio_Anula) --#20150212: jesusv: Se agrega campo fecha de envio para anulacion
  Where  Task_Type_Id = inuTask_Type_Id
  And    Lote_Anula = inuLote;

 if (SQL%notfound)  then
    raise EXCEP_UPDATE_CHECK;
 end if;--if (SQL%notfound)  then

 commit;

exception
 when EXCEP_UPDATE_CHECK then
   rollback;
   onuErrorCode := -1;
   osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
                      'No se encuentra el mensaje  TASK_TYPE ' || inuTASK_TYPE_ID ||' Lote ' || inuLOTE;
   LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaAnulOrdenMoviles',1,osbErrorMessage, null, null);
 when others then
   rollback;
   onuErrorCode:= -1;
   osbErrorMessage:= '[LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles.others] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
end proActuEstaAnulOrdenMoviles;

  Procedure proNotificaOrdenesENVIO(isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type) As
    /*
    * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
    *
    * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesENVIO
    * Ricef       :
    * Autor       : JM / AAcuna <AAcuna>
    * Fecha       : 10-05-2016
    * Descripcion : Metodo generico para la notificacion de ordenes
    *
    * Historia de Modificaciones
    * Autor          Fecha       Descripcion
    * AAcuna         10-05-2016  Version inicial
    **/

    -- Cursor de la configuracion de sistema movil por tipo de trabajo
    Cursor cuLdci_SistMovilTipoTrab(isbSistema_IdMovil Ldci_SistMovilTipoTrab.Sistema_Id%Type) Is
      Select Sistema_Id,
             Task_Type_Id,
             Op_Units,
             Requiere_Info_Susc,
             Requiere_Info_Sesu,
             Requiere_Info_Cart,
             Requiere_Info_Pred,
             Requiere_Info_Lect
        From Ldci_SistMovilTipoTrab
       Where Sistema_Id = isbSistema_IdMovil;

    -- Cursor de las ordenes seleccionadas y pendientes por notificar
    Cursor cuLdci_OrdenMoviles(inuTask_Type_Id Ldci_OrdenMoviles.Task_Type_Id%Type) Is
      Select Distinct Lote
        From Ldci_OrdenMoviles
       Where Task_Type_Id = inuTask_Type_Id
         And Estado_Envio = 'P'
         And ESTADO_ENVIO_ANULA is null;

    -- Cursor numero de lotes por tipo de trabajo
    Cursor cuMax_Lote(inuTask_Type_Id LDCI_OrdenMoviles.Task_Type_Id%Type) Is
      Select Max(Lote) Lotes
        From Ldci_OrdenMoviles
       Where Task_Type_Id = inuTask_Type_Id
         And Estado_Envio = 'P'
         and ESTADO_ENVIO_ANULA is null;

    nuErrorCode    Number(15);
    sbErrorMessage Ge_Error_Log.Description%Type;
    nuProcCodi     Number;
    cbProcPara     Clob;

    reMax_Lote cuMax_Lote%RowType;
    excepCreaEstaProc Exception; -- Excepcion que valida si proceso peticion SOAP

  Begin

    -- Recorre la configuracion de tipo de trabajo por sistema movil
    For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(isbSistema_Id) Loop
      -- determina el numero de lotes por tipo de trabajo
      Open cuMax_Lote(reLdci_SistMovilTipoTrab.Task_Type_Id);
      Fetch cuMax_Lote
        Into reMax_Lote;
      Close cuMax_Lote;

      -- determina y recorre el listado de lotes pendientes por tipo de trabajo
      For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

        -- Inicializa proceso del sistema
        cbProcPara := '<PARAMETROS>
                     <PARAMETRO>
                      <NOMBRE>SISTEMA</NOMBRE>
                      <VALOR>' || isbSistema_Id ||
                      '</VALOR>
                     </PARAMETRO>
                    </PARAMETROS>';

        -- Crea el identificado de proceso para la interfaz
        Ldci_PkMesaWS.ProcReaEstaProc(isbProcDefi     => isbSistema_Id,
                                      icbProcPara     => cbProcPara,
                                      idtProcFeIn     => Sysdate,
                                      isbProcEsta     => 'P',
                                      isbProcUsua     => Null,
                                      isbProcTerm     => Null,
                                      isbProcProg     => Null,
                                      onuProcCodi     => nuProcCodi,
                                      onuErrorCode    => nuErrorCode,
                                      osbErrorMessage => sbErrorMessage);

        -- Valida si el ESTAPROC se creo satisfactoriamente
        If (nuErrorCode <> 0) Then
          Raise excepCreaEstaProc;
        End If; --If (nuErrorCode <> 0) Then

        -- Genera el mensaje para ser notificado al sistema externo
        proGeneMensNotificaOT(isbSistema      => isbSistema_Id,
                                                   inuTask_Type_Id => reLdci_SistMovilTipoTrab.Task_Type_Id,
                                                   inuTransac      => nuProcCodi,
                                                   inuLote         => reLdci_OrdenMoviles.Lote,
                                                   inuLotes        => reMax_Lote.Lotes,
                                                   onuErrorCode    => nuErrorCode,
                                                   osbErrorMessage => sbErrorMessage);

        nuErrorCode := Nvl(nuErrorCode, 0);

        If nuErrorCode = 0 Then

          -- Cambia el estado de las ordenes
          proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                      inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                      isbEstado       => 'E',
                                      onuErrorCode    => nuErrorCode,
                                      osbErrorMessage => sbErrorMessage);

        Else

          Ldci_PkWebServUtils.ProCrearErrorLoginT('proNotificaOrdenesSIFUVE',
                                                  1,
                                                  sbErrorMessage,
                                                  Null,
                                                  Null);

        End If; --If onuErrorCode = 0 Then

      End Loop; --For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

    End Loop; --For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop

  Exception
    When excepCreaEstaProc Then
      Errors.SetError;
      Errors.GetError(nuErrorCode, sbErrorMessage);

    When Others Then
      pkErrors.NotifyError(pkErrors.fsbLastObject, SqlErrM, sbErrorMessage);
      Errors.SetError;
      Errors.GetError(nuErrorCode, sbErrorMessage);
      RollBack;
  End proNotificaOrdenesENVIO;
  /**/

End LDCI_PKGESTENVORDEN;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKGESTENVORDEN
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKGESTENVORDEN','ADM_PERSON');
END;
/


