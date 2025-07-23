CREATE OR REPLACE PACKAGE LDCI_PKPEDIDOVENTAMATERIAL AS
/*
 * Propiedad Intelectual Gases del Caribe SA ESP
 *
 * Script  : LDCI_PKPEDIDOVENTAMATERIAL.pks
 * Tiquete : PETI-ROLLOUT
 * Autor   : OLSoftware / Carlos Virgen
 * Fecha   : 12/12/2011
 * Descripcion : Realiza las operaciones necesarias para enviar una pedido a SAP
 *
 * Historia de Modificaciones
 * Autor    Fecha      Descripcion
 * carlosvl 21/12/2011 Version inicial
 * Eceron   05/07/2019 Se crea csbENTREGA200_2321
                       Se modifica proNotificaSolicitudesERP
 * jpinedc  23/04/2025 OSF-4259: Se modifican proEnviaPedidoSAP, proEnviaDevoVentaSAP
**/

    csbENTREGA200_2321 CONSTANT varchar2(100) := 'OSS_CON_EEC_200_2321_GDC_10';
	--Recorre los resigstros pendientes para notificarlos
	procedure proNotificaSolicitudesERP;

	-- Procedimeinto que hace el envio a SAP
	PROCEDURE proEnviaPedidoSAP(vTrsmCodi NUMBER, vTrsmDocu NUMBER, sbErrMens out VARCHAR2);

	-- Procedimiento que hace el envio de una devolucion
	PROCEDURE proEnviaDevoVentaSAP(vTrsmCodi NUMBER, vTrsmDocu NUMBER, sbErrMens out VARCHAR2);

	function fsbGetMarca(sbSERINUME VARCHAR2) return VARCHAR2;

	function fsbGetSerialSAP(sbSERINUME VARCHAR2) return VARCHAR2;

END LDCI_PKPEDIDOVENTAMATERIAL;
/
CREATE OR REPLACE PACKAGE BODY      LDCI_PKPEDIDOVENTAMATERIAL AS  -- body

	function fsbGetMarca(sbSERINUME VARCHAR2) return VARCHAR2 is

	/*
		* Propiedad Intelectual Gases del Caribe SA ESP
		*
		* Script  : LDCI_PKPEDIDOVENTAMATERIAL.fsbGetMarca
		* Tiquete : PETI-ROLLOUT
		* Autor   : OLSoftware / Carlos Virgen
		* Fecha   : 12/12/2011
		* Descripcion : Consulta la marca del serial a devolver
		*
		* Historia de Modificaciones
		* Autor    Fecha      Descripcion
		* carlosvl 21/12/2011 Version inicial
		*/
	  sbMarca LDCI_DMITMMIT.DMITMARC%type;
	begin

        select DETA.DMITMARC as "Marca" into sbMarca
                    from LDCI_INTEMMIT MOVI ,LDCI_DMITMMIT DETA, LDCI_SERIDMIT SERI
                where MOVI.MMITCODI = MOVI.MMITCODI
                        and MOVI.MMITCODI = DETA.DMITMMIT
                        and MOVI.MMITCODI = SERI.SERIMMIT
                        and DETA.DMITCODI = SERI.SERIDMIT
                        and SERI.SERINUME = sbSERINUME
                        and ROWNUM <= 1	;

            return sbMarca;
	end fsbGetMarca;

	function fsbGetSerialSAP(sbSERINUME VARCHAR2) return VARCHAR2 is
	/*
		* Propiedad Intelectual Gases del Caribe SA ESP
		*
		* Script  : LDCI_PKPEDIDOVENTAMATERIAL.fsbGetSerialSAP
		* Tiquete : PETI-ROLLOUT
		* Autor   : OLSoftware / Carlos Virgen
		* Fecha   : 12/12/2011
		* Descripcion : Consulta la estructura del serial SAP del serial a devolver
		*
		* Historia de Modificaciones
		* Autor    Fecha      Descripcion
		* carlosvl 21/12/2011 Version inicial
		*/
	  sbSerialSAP LDCI_SERIDMIT.SERIESTR%type;
	begin

        select SERI.SERIESTR as "Serial" into sbSerialSAP
                    from LDCI_INTEMMIT MOVI ,LDCI_DMITMMIT DETA, LDCI_SERIDMIT SERI
                where MOVI.MMITCODI = MOVI.MMITCODI
                        and MOVI.MMITCODI = DETA.DMITMMIT
                        and MOVI.MMITCODI = SERI.SERIMMIT
                        and DETA.DMITCODI = SERI.SERIDMIT
                        and SERI.SERINUME = sbSERINUME
                        and ROWNUM <= 1	;

            return sbSerialSAP;
	end fsbGetSerialSAP;

 PROCEDURE proActuEstaLDCI_TRANSOMA(inuTRSMCODI in NUMBER) IS
    /*
     * Propiedad Intelectual Gases del Caribe SA ESP
     *
     * Script  : LDCI_PKPEDIDOVENTAMATERIAL.proActuEstaLDCI_TRANSOMA
     * Tiquete : PETI-ROLLOUT
     * Autor   : OLSoftware / Carlos Virgen
     * Fecha   : 21/12/2011
     * Descripcion : Hace el procesamiento para mandar a SAP la informacion de un Pedido de Material
     *
     * Historia de Modificaciones
     * Autor    Fecha      Descripcion
    **/
    --Define variables

 BEGIN
    dbms_output.put_line('[109:step ] proActuEstaLDCI_TRANSOMA');
    --#11-11-2014: carlos.virgen: Se adiciona linea para activar la tabla LDCI_TRANSOMA
    ldc_bomaterialrequest.ActivateTable(inuTRSMCODI);

    update LDCI_TRANSOMA set TRSMESTA = 2 -- ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devoluci??n
			where TRSMCODI = inuTRSMCODI;

    --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
    ldc_bomaterialrequest.CloseTable(inuTRSMCODI);
    dbms_output.put_line('[109:stepout ] proActuEstaLDCI_TRANSOMA');
 EXCEPTION
	  WHEN OTHERS THEN
  		  ROLLBACK;
        dbms_output.put_line('[122:step ] SQLERRM ' || SQLERRM);
        ldci_pkWebServUtils.Procrearerrorlogint('proActuEstaLDCI_TRANSOMA', '2', 'ERROR no controlado <LDCI_PKPEDIDOVENTAMATERIAL.proActuEstaLDCI_TRANSOMA>: ' || SQLERRM, null);
 END proActuEstaLDCI_TRANSOMA;

 PROCEDURE proNotificaSolicitudesERP IS
    /*
     * Propiedad Intelectual Gases del Caribe SA ESP
     *
     * Script  : LDCI_PKPEDIDOVENTAMATERIAL.proNotificaSolicitudesERP
     * Tiquete : PETI-ROLLOUT
     * Autor   : OLSoftware / Carlos Virgen
     * Fecha   : 21/12/2011
     * Descripcion : Hace el procesamiento para mandar a SAP la informacion de un Pedido de Material
     *
     * Historia de Modificaciones
     * Autor    Fecha      Descripcion
     * Eceron   05/07/2019 Se adiciona validaciÃ³n con la constante csbENTREGA200_2321,
                           para saber si la entrega 200-2321 aplica.
                           Se adiciona variable de entrada al cursor cuLDCI_TRANSOMA_PED
                           Se ajusta para que si la entrega aplica, tenga en cuenta los pedidos
                           en estado 6 - APROBADO para ser procesados
    **/
    --Define variables
    nuTrsmCodi NUMBER;
    nuTrsmDocu NUMBER;
    sbErrMens  VARCHAR2(2000);
    nuEstado   NUMBER := 1;

    -- cursor de las soliciudes de venta pendientes
    cursor cuLDCI_TRANSOMA_PED(inuEstado IN LDCI_TRANSOMA.trsmesta%type) is
							select *
									from LDCI_TRANSOMA
								where TRSMTIPO = 1  -- 1 Solicitud
										and TRSMESTA = inuEstado
										and TRSMACTI = 'S'; -- ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devoluci??n

				-- cursor de las devoluciones de venta pendientes
    cursor cuLDCI_TRANSOMA_DEV is
							select *
									from LDCI_TRANSOMA
								where TRSMTIPO = 2  -- 2 Devolucion
										and TRSMESTA = 1
										and TRSMACTI = 	'S';	 -- ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devoluci??n
 BEGIN

    IF fblaplicaentrega(csbENTREGA200_2321) THEN

        nuEstado := 6;

    END IF;

    for reLDCI_TRANSOMA_PED in cuLDCI_TRANSOMA_PED(nuEstado) loop
        dbms_output.put_line('[161:step ]: reLDCI_TRANSOMA_PED.TRSMCODI ' || reLDCI_TRANSOMA_PED.TRSMCODI);
        LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP(vTrsmCodi => reLDCI_TRANSOMA_PED.TRSMCODI, vTrsmDocu => nuTrsmDocu, sbErrMens => sbErrMens);
            if (sbErrMens = '0')	 then
                commit;
            end if;
        end loop;

  for reLDCI_TRANSOMA_DEV in cuLDCI_TRANSOMA_DEV loop
    LDCI_PKPEDIDOVENTAMATERIAL.proEnviaDevoVentaSAP(vTrsmCodi => reLDCI_TRANSOMA_DEV.TRSMCODI, vTrsmDocu => nuTrsmDocu, sbErrMens => sbErrMens);
    if (sbErrMens = '0')	 then
      commit;
    end if;
  end loop;

 EXCEPTION
	  WHEN OTHERS THEN
  		  ROLLBACK;
        ldci_pkWebServUtils.Procrearerrorlogint('proNotificaSolicitudesERP', '2', 'ERROR no controlado <LDCI_PKPEDIDOVENTAMATERIAL.proNotificaSolicitudesERP>: ' || SQLERRM, null);
 END proNotificaSolicitudesERP;

 PROCEDURE proEnviaPedidoSAP(vTrsmCodi NUMBER, vTrsmDocu NUMBER, sbErrMens out VARCHAR2) IS
    /*
     * Propiedad Intelectual Gases del Caribe SA ESP
     *
     * Script  : LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP
     * Tiquete : PETI-ROLLOUT
     * Autor   : OLSoftware / Carlos Virgen
     * Fecha   : 21/12/2011
     * Descripcion : Hace el procesamiento para mandar a SAP la informacion de un Pedido de Material
     *
     * Historia de Modificaciones
     * Autor    Fecha      Caso     Descripcion
     * jpinedc  23/04/2025 OSF-4259 * Se borra sbOrgVent
     * jpinedc  23/04/2025 OSF-4259 * Se borra LDCI_CARASEWE c
     * jpinedc  23/04/2025 OSF-4259 * Se reemplaza c.CASEVALO por pkg_empresa.fsbObtOrganizacionVenta
     * jpinedc  23/04/2025 OSF-4259 * Se borra sbPrefijoLDC y se reemplaza por
                                    pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont)
    **/
    --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
    sbProtocol     LDCI_CARASEWE.CASEVALO%type;
    sbHost         LDCI_CARASEWE.CASEVALO%type;
    sbPuerto       LDCI_CARASEWE.CASEVALO%type;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    sbMens      varchar2(4000);

    --Parametros de logica de negocio para generar los pedidos
    sbClasPed    LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_CLASE_PEDI';
    sbSociedad   LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_SOCIEDAD';
    sbCanal      LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_CANAL_DIST';
    sbSector     LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_SECTOR';
    sbGrVen      LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_GRU_VENDEDOR';
    sbWsNomb     LDCI_CARASEWE.CASEDESE%type := 'WS_PEDIDO_MATERIALES';
    sbMotivo     LDCI_CARASEWE.CASEDESE%type := 'SAP_PVM_MOTIVO_PEDIDO';

   --Variables mensajes SOAP
   l_payload     CLOB;
   l_response    CLOB;
   qryCtx        DBMS_XMLGEN.ctxHandle;
   rfMensaje     Constants.tyRefCursor;

   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada
   excepNoProcesoRegi	EXCEPTION; 	-- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP
 BEGIN
    DBMS_OUTPUT.PUT_LINE('LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP ...');

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'NAMESPACE', sbNameSpace, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'SOAPACTION', sbSoapActi, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'PROTOCOLO', sbProtocol, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_PEDIDO_MATERIALES', 'INPUT_MESSAGE_TYPE', sbInputMsgType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    sbUrlDesti := lower(sbProtocol) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    sbUrlDesti := trim(sbUrlDesti);
    --Genera XML
    open rfMensaje for
    select a.MOPECLDO as "ClasPed",
                                    pkg_empresa.fsbObtOrganizacionVenta( pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont)) as "OrgVent",
                                    d.CASEVALO as "Canal",
                                    e.CASEVALO as "Sector",
                                    m.TRSMOFVE as "OfiVenta",
                                    f.CASEVALO as "GrVen",
                                    su.IDENTIFICATION  as "Cliente",
                                    pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont) || '-' || m.TRSMCODI as "PedCli",
                                    m.TRSMMPDI as "Motivo",
                                    cursor (select i.CODE as "Material",
                                    replace(r.TSITCANT,',','.') as "Cantidad",
                                    cd.OPER_UNIT_CODE as "Centro",
                                    null       as "Importe",
                                    null       as "Denom",
                                    null       as "CenBen"
            from LDCI_TRSOITEM r, GE_ITEMS i
        where m.TRSMCODI = r.TSITSOMA
                and r.TSITITEM = i.ITEMS_ID) as "Detalles"
                from LDCI_CARASEWE d,
                                    LDCI_CARASEWE e, LDCI_CARASEWE f,
                                    LDCI_TRANSOMA m, OR_OPERATING_UNIT n, LDCI_MOTIPEDI a,
                                    GE_CONTRATISTA co, GE_SUBSCRIBER su, OR_OPERATING_UNIT cd
            where d.CASEDESE = sbWsNomb
            and a.MOPECODI = m.TRSMMPDI
                    and d.CASECODI = sbCanal
                    and e.CASECODI = sbSector
                    and f.CASECODI = sbGrVen
                    and d.CASEDESE = e.CASEDESE
                    and d.CASEDESE = f.CASEDESE
                    and m.TRSMCODI = vTrsmCodi
                    and m.TRSMUNOP = n.OPERATING_UNIT_ID
                    and co.ID_CONTRATISTA = n.CONTRACTOR_ID
                    and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
                    and cd.OPERATING_UNIT_ID = m.TRSMPROV;

    qryCtx :=  dbms_xmlgen.newContext(rfMensaje);

    DBMS_XMLGEN.setRowSetTag(qryCtx, sbInputMsgType);
    DBMS_XMLGEN.setRowTag(qryCtx, '');
    DBMS_XMLGEN.setNullHandling(qryCtx, dbms_xmlgen.EMPTY_TAG);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;

    dbms_xmlgen.closeContext(qryCtx);

    l_payload := replace(l_payload, '<?xml version="1.0"?>');
    l_payload := replace(l_payload, '<Detalles>');
    l_payload := replace(l_payload, '</Detalles>');

    l_payload := replace(l_payload, '<Detalles_ROW>',  '<Detalles>');
    l_payload := replace(l_payload, '</Detalles_ROW>', '</Detalles>');

    l_payload := replace(l_payload, '<Importe/>', '<Importe></Importe>');
    l_payload := replace(l_payload, '<Denom/>', '<Denom></Denom>');
    l_payload := replace(l_payload, '<CenBen/>', '<CenBen></CenBen>');

    l_payload := trim(l_payload);

    DBMS_OUTPUT.PUT_LINE('156 l_payload ' || l_payload);
    --DBMS_OUTPUT.PUT_LINE('157 sbUrlDesti ' || sbUrlDesti);

    --Hace el consumo del servicio Web
    ldci_pksoapapi.proSetProtocol(sbProtocol);

    l_response := ldci_pksoapapi.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);


    DBMS_OUTPUT.PUT_LINE('l_response ' || l_response);
    --Valida el proceso de peticion SOAP
    if (ldci_pksoapapi.boolSoapError OR ldci_pksoapapi.boolHttpError) then

        LDCI_PKMESAWS.proCreateMessageError(ldci_pksoapapi.sbSoapRequest,
                                           'WS_PEDIDO_MATERIALES',
                                           ldci_pksoapapi.sbErrorHttp,
                                           l_payload,
                                           l_response,
                                           ldci_pksoapapi.sbTraceError,
                                           ldci_pksoapapi.boolHttpError,
                                           ldci_pksoapapi.boolSoapError
                                           );
        RAISE excepNoProcesoSOAP;
    end if;

	proActuEstaLDCI_TRANSOMA(vTrsmCodi);
  sbErrMens := '0';
  DBMS_OUTPUT.PUT_LINE('LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP ...');
 EXCEPTION
   	WHEN errorPara01 THEN
        DBMS_OUTPUT.PUT_LINE(sbMens);
        sbErrMens := sbMens;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_PEDIDO_MATERIALES', '2', sbErrMens, l_payload);
  	WHEN excepNoProcesoRegi THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
        sbErrMens := 'ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_PEDIDO_MATERIALES', '2', sbErrMens, l_payload);

  	WHEN excepNoProcesoSOAP THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
        sbErrMens := 'ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: Ocurrio un error en procesamiento SOAP.' || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_PEDIDO_MATERIALES', '2', sbErrMens, l_payload);

	  WHEN OTHERS THEN
  		  ROLLBACK;
        sbErrMens := 'ERROR no controlado <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: ' || SQLERRM  || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_PEDIDO_MATERIALES', '2', sbErrMens, l_payload);
        --DBMS_OUTPUT.PUT_LINE('ERROR no controlado <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP>: ' || SQLERRM || DBMS_UTILITY.format_error_backtrace);
 END proEnviaPedidoSAP;

 PROCEDURE proEnviaDevoVentaSAP(vTrsmCodi NUMBER, vTrsmDocu NUMBER, sbErrMens out varchar2) IS
    /*
     * Propiedad Intelectual Gases del Caribe SA ESP
     *
     * Script  : LDCI_PKPEDIDOVENTAMATERIAL.proEnviaDevoVentaSAP
     * Tiquete : PETI-ROLLOUT
     * Autor   : OLSoftware / Carlos Virgen
     * Fecha   : 11/02/2012
     * Descripcion : Hace el procesamiento para mandar a SAP la informacion de una solicitud de devolucion
     *
     * Historia de Modificaciones
     * Autor    Fecha      CASO     Descripcion
     * carlosvl 14/01/2012          version inicial
     * jpinedc  23/04/2025 OSF-4259 * Se borra sbOrgVent
     * jpinedc  23/04/2025 OSF-4259 * Se borra LDCI_CARASEWE c
     * jpinedc  23/04/2025 OSF-4259 * Se reemplaza c.CASEVALO por pkg_empresa.fsbObtOrganizacionVenta  
     * jpinedc  23/04/2025 OSF-4259 * Se borra sbPrefijoLDC y se reemplaza por
                                    pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont)
    **/
    --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
    sbProtocol     LDCI_CARASEWE.CASEVALO%type;
    sbHost         LDCI_CARASEWE.CASEVALO%type;
    sbPuerto       LDCI_CARASEWE.CASEVALO%type;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;

    sbMens      varchar2(4000);

    --Parametros de logica de negocio para generar los pedidos
    sbClasPed   LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_CLASE_PEDI_DEV';
    sbSociedad  LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_SOCIEDAD';
    sbCanal     LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_CANAL_DIST';
    sbSector    LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_SECTOR';
    sbGrVen     LDCI_CARASEWE.CASEVALO%type := 'SAP_PVM_GRU_VENDEDOR';
    sbWsNomb    LDCI_CARASEWE.CASEDESE%type := 'WS_DEV_VENTA_MATERIALES';
    sbMotivo    LDCI_CARASEWE.CASEDESE%type := 'SAP_PVM_MOTIVO_PEDIDO';

   --Variables mensajes SOAP
   l_payload     CLOB;
   l_payload_encabezado            CLOB;
   l_payload_detalle_no_seriales   CLOB;
   l_payload_detalle_serializados  CLOB;
   l_response    CLOB;
   qryCtx        DBMS_XMLGEN.ctxHandle;
   rfMensaje     Constants.tyRefCursor;

   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada
   excepNoProcesoRegi	EXCEPTION; 	-- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP
 BEGIN
    --DBMS_OUTPUT.PUT_LINE('LDCI_PKPEDIDOVENTAMATERIAL.proEnviaPedidoSAP ...');

    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'NAMESPACE', sbNameSpace, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'SOAPACTION', sbSoapActi, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'PROTOCOLO', sbProtocol, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;
    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_DEV_VENTA_MATERIALES', 'INPUT_MESSAGE_TYPE', sbInputMsgType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    sbUrlDesti := lower(sbProtocol) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    sbUrlDesti := trim(sbUrlDesti);
    --Genera XML
    open rfMensaje for
                    select a.MDPECLDO as "ClasPed",
                                            pkg_empresa.fsbObtOrganizacionVenta( pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont)) as "OrgVent",
                                            d.CASEVALO as "Canal",
                                            e.CASEVALO as "Sector",
                                            m.TRSMOFVE as "OfiVenta",
                                            f.CASEVALO as "GrVen",
                                            su.IDENTIFICATION  as "Cliente",
                                            pkg_boConsultaEmpresa.fsbObtEmpresaContratista(m.trsmcont) || '-' || m.TRSMCODI as "PedCli",
                                            m.TRSMMDPE as "Motivo",
                                            m.TRSMDSRE as "Referencia"
                        from LDCI_CARASEWE d,
                                            LDCI_CARASEWE e, LDCI_CARASEWE f,
                                            LDCI_TRANSOMA m, OR_OPERATING_UNIT n, LDCI_MOTIDEPE a,
                                            GE_CONTRATISTA co, GE_SUBSCRIBER su, OR_OPERATING_UNIT cd
                    where d.CASEDESE = sbWsNomb
                    and a.MDPECODI = m.TRSMMDPE
                            and d.CASECODI = sbCanal
                            and e.CASECODI = sbSector
                            and f.CASECODI = sbGrVen
                            and d.CASEDESE = e.CASEDESE
                            and d.CASEDESE = f.CASEDESE
                            and m.TRSMCODI = vTrsmCodi
                            and m.TRSMUNOP = n.OPERATING_UNIT_ID
                            and co.ID_CONTRATISTA = n.CONTRACTOR_ID
                            and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
                            and cd.OPERATING_UNIT_ID = m.TRSMPROV;

    -- Genera el encabezado del pedido
    qryCtx :=  dbms_xmlgen.newContext (rfMensaje);

    DBMS_XMLGEN.setRowTag(qryCtx, '');
    DBMS_XMLGEN.setNullHandling(qryCtx, dbms_xmlgen.EMPTY_TAG);
    l_payload := '<urn:PedidoCrearRequest>';
    l_payload := l_payload || dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;
    dbms_xmlgen.closeContext(qryCtx);

    open rfMensaje for
    select cursor(select    i.CODE as "Material",
                            replace(r.TSITCANT,',','.') as "Cantidad",
                            cd.OPER_UNIT_CODE as "Centro",
                            null       as "Importe",
                            null       as "Denom",
                            null       as "CenBen",
                            r.TSITMDMA as "Motivo"
                    from LDCI_TRSOITEM r, GE_ITEMS i, LDCI_TRANSOMA m, OR_OPERATING_UNIT cd
                    where r.TSITSOMA = vTrsmCodi
                        and r.TSITITEM = i.ITEMS_ID
                        and i.ITEM_CLASSIF_ID in (8, 3)
                        and cd.OPERATING_UNIT_ID = m.TRSMPROV
                        and m.TRSMCODI = r.TSITSOMA) as "Detalles"
    from dual	;
    -- Genera detalle de materiales no serializados
    qryCtx :=  dbms_xmlgen.newContext (rfMensaje);

    DBMS_XMLGEN.setRowTag(qryCtx, '');
    DBMS_XMLGEN.setNullHandling(qryCtx, dbms_xmlgen.EMPTY_TAG);
    l_payload_detalle_no_seriales := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;
    dbms_xmlgen.closeContext(qryCtx);


    open rfMensaje for
    select cursor(  select  i.CODE as "Material",
                            replace(r.TSITCANT,',','.') as "Cantidad",
                            cd.OPER_UNIT_CODE as "Centro",
                            null       as "Importe",
                            null       as "Denom",
                            null       as "CenBen",
                            r.TSITMDMA as "Motivo",
                            cursor(	select  LDCI_PKPEDIDOVENTAMATERIAL.fsbGetMarca(POSI.SERINUME)     as "Marca",
                                            LDCI_PKPEDIDOVENTAMATERIAL.fsbGetSerialSAP(POSI.SERINUME) as "Serial"
                                    from LDCI_SERIPOSI POSI
                                    where POSI.SERISOMA = r.TSITSOMA
                                    and POSI.SERITSIT = i.ITEMS_ID
                            )  as "Seriales"
                    from LDCI_TRSOITEM r, GE_ITEMS i, LDCI_TRANSOMA m, OR_OPERATING_UNIT cd
                    where r.TSITSOMA = vTrsmCodi
                        and r.TSITITEM = i.ITEMS_ID
                        and i.ITEM_CLASSIF_ID in (21)
                        and cd.OPERATING_UNIT_ID = m.TRSMPROV
                        and m.TRSMCODI = r.TSITSOMA
                ) as "Detalles"
    from dual	;
    
    -- Genera detalle de materiales serializados
    qryCtx :=  dbms_xmlgen.newContext (rfMensaje);

    DBMS_XMLGEN.setRowTag(qryCtx, '');
    DBMS_XMLGEN.setNullHandling(qryCtx, dbms_xmlgen.EMPTY_TAG);
    l_payload_detalle_serializados := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;
    dbms_xmlgen.closeContext(qryCtx);

    l_payload := trim(l_payload) || trim(l_payload_detalle_no_seriales) || trim(l_payload_detalle_serializados);
    l_payload := l_payload || '</urn:PedidoCrearRequest>';
    l_payload := replace(l_payload, '<?xml version="1.0"?>');

    l_payload := replace(l_payload, '<ROWSET>');
    l_payload := replace(l_payload, '</ROWSET>');

    l_payload := replace(l_payload, '<Detalles>');
    l_payload := replace(l_payload, '</Detalles>');

    l_payload := replace(l_payload, '<Detalles_ROW>',  '<Detalles>');
    l_payload := replace(l_payload, '</Detalles_ROW>', '</Detalles>');

    l_payload := replace(l_payload, '<Seriales_ROW>',  '<Seri_ROW>');
    l_payload := replace(l_payload, '</Seriales_ROW>', '</Seri_ROW>');

    l_payload := replace(l_payload, '<Seriales>',  '');
    l_payload := replace(l_payload, '</Seriales>', '');

    l_payload := replace(l_payload, '<Seri_ROW>',  '<Seriales>');
    l_payload := replace(l_payload, '</Seri_ROW>', '</Seriales>');

    l_payload := replace(l_payload, '<Importe/>', '<Importe></Importe>');
    l_payload := replace(l_payload, '<Denom/>', '<Denom></Denom>');
    l_payload := replace(l_payload, '<CenBen/>', '<CenBen></CenBen>');

    l_payload := trim(l_payload);

    --DBMS_OUTPUT.PUT_LINE('DEVO: l_payload ' || l_payload);

    --Hace el consumo del servicio Web
    ldci_pksoapapi.proSetProtocol(sbProtocol);

    --<<154891 carlosvl se hace uso de la funcion "fsbSoapSegmentedCall" para el envio de mensajes de gran tamano
    l_response := ldci_pksoapapi.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);
    --154891>>

    --DBMS_OUTPUT.PUT_LINE('l_response ' || l_response);
    --Valida el proceso de peticion SOAP
    if (ldci_pksoapapi.boolSoapError OR ldci_pksoapapi.boolHttpError) then

        LDCI_PKMESAWS.proCreateMessageError(ldci_pksoapapi.sbSoapRequest,
                                           'WS_DEV_VENTA_MATERIALES',
                                           ldci_pksoapapi.sbErrorHttp,
                                           l_payload,
                                           l_response,
                                           ldci_pksoapapi.sbTraceError,
                                           ldci_pksoapapi.boolHttpError,
                                           ldci_pksoapapi.boolSoapError
                                           );
        RAISE excepNoProcesoSOAP;
    end if;
    proActuEstaLDCI_TRANSOMA(vTrsmCodi);
    sbErrMens := '0';
 EXCEPTION
   	WHEN errorPara01 THEN
        --DBMS_OUTPUT.PUT_LINE(sbMens);
        sbErrMens := sbMens;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_PEDIDO_MATERIALES', '2', sbErrMens, l_payload);

  	WHEN excepNoProcesoRegi THEN
        sbErrMens := 'ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaDevoVentaSAP>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_DEV_VENTA_MATERIALES', '2', sbErrMens, l_payload);

  	WHEN excepNoProcesoSOAP THEN
        sbErrMens := 'ERROR: <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaDevoVentaSAP>: Ocurrio un error en procesamiento SOAP.' || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_DEV_VENTA_MATERIALES', '2', sbErrMens, l_payload);

	  WHEN OTHERS THEN
  		  ROLLBACK;
        sbErrMens := 'ERROR no controlado <LDCI_PKPEDIDOVENTAMATERIAL.proEnviaDevoVentaSAP>: ' || SQLERRM  || DBMS_UTILITY.format_error_backtrace;
        ldci_pkWebServUtils.Procrearerrorlogint('WS_DEV_VENTA_MATERIALES', '2', sbErrMens, l_payload);
 END proEnviaDevoVentaSAP;
END LDCI_PKPEDIDOVENTAMATERIAL;
/
GRANT EXECUTE on LDCI_PKPEDIDOVENTAMATERIAL to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCI_PKPEDIDOVENTAMATERIAL to REXEOPEN;
GRANT EXECUTE on LDCI_PKPEDIDOVENTAMATERIAL to INTEGRACIONES;
GRANT EXECUTE on LDCI_PKPEDIDOVENTAMATERIAL to INTEGRADESA;
/
