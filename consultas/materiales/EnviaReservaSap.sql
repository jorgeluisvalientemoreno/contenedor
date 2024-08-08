declare
	 /*
	 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

	FUNCION : proNotificaReservas
	AUTOR : MAURICIO FERNANDO ORTIZ
	FECHA : 10/12/2012
	RICEF      : I005
	DESCRIPCION : Procedimiento general par ala notificacion de reservas

	 Parametros de Entrada

	 Parametros de Salida

	 Historia de Modificaciones

	 Autor        Fecha       Descripcion.
	*/
				Inuopeuniterp_Id   NUMBER(15);
				Osbrequestsregs    VARCHAR2(32000);
				Onuerrorcode       NUMBER(15);
				OSBERRORMESSAGE    ge_error_log.description%TYPE;
				doc                DBMS_XMLDOM.DOMDocument;
				ndoc               DBMS_XMLDOM.DOMNode;
				docelem            DBMS_XMLDOM.DOMElement;
				node               DBMS_XMLDOM.DOMNode;
				childnode          DBMS_XMLDOM.DOMNode;
				Nodelist           Dbms_Xmldom.Domnodelist;
				Buf                Varchar2(32000);
				ITEMS_DOCUMENTO_ID number(15);
				Contador           Number(10);
				Osbrequest         Varchar2(32000);
				Nuoperunitid       Number;
				Nuerpoperunitid    Number;
				--Dtdate             date;
				Docitem            Dbms_Xmldom.Domdocument;
				Ndocitem           Dbms_Xmldom.Domnode;
				Docelemitem        Dbms_Xmldom.Domelement;
				Nodeitem           Dbms_Xmldom.Domnode;
				Nuitemid           Number(15);
				Sbitemcode         Varchar2(60);
				Sbitemdesc         Varchar2(100);
				Nuitemcant         number;
				Nuitemcosto        Number;
				Nuclassitem        Number;
				sbFlagHta          varchar2(1);
				oclXMLItemsData    CLOB;
				Nodelistitem       Dbms_Xmldom.Domnodelist;
				Bufitem            Varchar2(32767);
				contadorItem       Number(10);
				Nodelisteleitem    Dbms_Xmldom.Domnodelist;
				nodedummy          Dbms_Xmldom.Domnode;
				onuProcCodi        NUMBER;
				icbProcPara        CLOB;
  -- Carga variables globales
  sbInputMsgType  LDCI_CARASEWE.CASEVALO%type;
  sbNameSpace     LDCI_CARASEWE.CASEVALO%type;
  sbUrlWS         LDCI_CARASEWE.CASEVALO%type;
  sbUrlDesti      LDCI_CARASEWE.CASEVALO%type;
  sbSoapActi      LDCI_CARASEWE.CASEVALO%type;
  sbProtocol      LDCI_CARASEWE.CASEVALO%type;
  sbHost          LDCI_CARASEWE.CASEVALO%type;
  sbPuerto        LDCI_CARASEWE.CASEVALO%type;
  sbClasSolMat    LDCI_CARASEWE.CASEVALO%type;
  sbClasDevMat    LDCI_CARASEWE.CASEVALO%type;
  sbClasSolHer    LDCI_CARASEWE.CASEVALO%type;
  sbClasDevHer    LDCI_CARASEWE.CASEVALO%type;
  sbPrefijoLDC    LDCI_CARASEWE.CASEVALO%type;
  sbDefiSewe      LDCI_DEFISEWE.DESECODI%type;
  sbClasSolMatAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_3429_1
  sbClasDevMatAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_3429_1
  sbLstCentSolInv LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de inventario
  sbLstCentSolAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de activos
  errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada
  
				-- definicion de cursores
				-- cursor de las unidades operativas
				cursor cuUnidadOperativa Is
								Select OPERATING_UNIT_ID, OPER_UNIT_CODE
										From OR_OPERATING_UNIT
										Where OPER_UNIT_CLASSIF_ID = 11;

				reUnidadOperativa cuUnidadOperativa%rowtype;
--***************************************************************************************************************************************************
Procedure proEnviarSolicitud(reserva                in  VARCHAR2,
                             isbOperacion           in  VARCHAR2,
                             flagherramienta        in  VARCHAR,
                             inuProcCodi            in  NUMBER,
                             isbCLASS_ASSESSMENT_ID in  LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%type, --#OYM_CEV_3429_1
                             onuErrorCode           out ge_error_log.Error_log_id%TYPE,
                             osbErrorMessage        out ge_error_log.description%TYPE) As

	/*
	 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

	 PROCEDIMIENTO : proEnviarSolicitud
			 AUTOR : MAURICIO FERNANDO ORTIZ
			 FECHA : 10/12/2012
     RICEF         : I005; I006
	 DESCRIPCION    : Procedimiento para enviar la interfaz

	 Parametros de Entrada
	 reserva in varchar2
	 flagherramienta in varchar

	 Parametros de Salida
	   onuErrorCode out number
	   osbErrorMessage out varchar
	 Historia de Modificaciones

	 Autor        Fecha   Descripcion.
  carlosvl 17/09/2013  NC-622: Se ajusta la generacion de la etiqueta "ResFront" para enviarlo del modo
		                     [Letra(s) que identifican la empresa]-[Tipo de Movimiento]-[Numero de la Solicitud]/[Nombre del solicitante]
  carlosvl 25022015    NC-25022015: Se modifica el formato de '9999999999999.99' a '9999999999990.99'
	*/
 	cursor cuLDCI_RESERVAMAT(sbRESERVA VARCHAR2) is  --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
				select RESERVA, UNIDAD_OPE, NAME, CENTRO_COSTO
						from LDCI_RESERVAMAT, OR_OPERATING_UNIT
						where OPERATING_UNIT_ID = UNIDAD_OPE
								and RESERVA = sbRESERVA;
  -- variables
		sbErrMens      VARCHAR2(500);
		sbClasMov      LDCI_CARASEWE.CASEVALO%type;
		Sbmens         VARCHAR2(4000);
		onuMesacodi	   NUMBER;
		sbcondicionHta VARCHAR2(100);

		--Variables mensajes SOAP
		L_Payload     CLOB;
		l_response    CLOB;
		qryCtx        DBMS_XMLGEN.ctxHandle;
		reLDCI_RESERVAMAT cuLDCI_RESERVAMAT%rowtype; --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta

  -- excepciones
		errorPara01	           EXCEPTION;  -- Excepcion que verifica que ingresen los parametros de entrada
		Excepnoprocesoregi	    EXCEPTION; 	-- Excepcion que valida si proceso registros la consulta
		excepNoProcesoSOAP	    EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP
		exce_ValidaCentroCosto	EXCEPTION; 	--#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta

Begin
  -- valida si el campo de reserva esta lleno
  if (reserva is not null) then
		  if (flagherramienta = 'S') then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
						open cuLDCI_RESERVAMAT(reserva);
						fetch cuLDCI_RESERVAMAT into reLDCI_RESERVAMAT;
						close cuLDCI_RESERVAMAT;

						if (reLDCI_RESERVAMAT.CENTRO_COSTO is null or reLDCI_RESERVAMAT.CENTRO_COSTO = '' or reLDCI_RESERVAMAT.CENTRO_COSTO = '-1') then
						  raise exce_ValidaCentroCosto;
      end if; --if (reLDCI_RESERVAMAT.CENTRO_COSTO ...
				end if; --if (flagherramienta = 'S')

				-- Si es una Reserva
    if (isbOperacion = 'RES') then

				    if (isbCLASS_ASSESSMENT_ID = 'I') then --#OYM_CEV_3429_1: Valida la clase de valoracion INVENTARIO
										select decode(Flagherramienta, 'N', sbClasSolMat, 'S', sbClasSolHer, sbClasSolMat) into sbClasMov
												from dual;
								else
												if (isbCLASS_ASSESSMENT_ID = 'A') then --#OYM_CEV_3429_1: Valida la clase de valoracion ACTIVO
														select decode(Flagherramienta, 'N', sbClasSolMatAct, 'S', sbClasSolHer, sbClasSolMatAct) into sbClasMov
																from dual;
												end if;--if (isbCLASS_ASSESSMENT_ID = 'A')
				    end if;--if (isbCLASS_ASSESSMENT_ID = 'I') then
    else
				    if (isbCLASS_ASSESSMENT_ID = 'I') then --#OYM_CEV_3429_1: Valida la clase de valoracion INVENTARIO
										select decode(Flagherramienta, 'N', sbClasDevMat, 'S', sbClasDevHer, sbClasDevMat) into sbClasMov
												from dual;
								else
												if (isbCLASS_ASSESSMENT_ID = 'A') then --#OYM_CEV_3429_1: Valida la clase de valoracion ACTIVO
														select decode(Flagherramienta, 'N', sbClasDevMatAct, 'S', sbClasDevHer, sbClasDevMatAct) into sbClasMov
																from dual;
												end if;--if (isbCLASS_ASSESSMENT_ID = 'A') then
				    end if;--if (isbCLASS_ASSESSMENT_ID = 'I') then
    end if;--if (isbOperacion = 'RES') then
    -- Genera el mensaje XML
	  Qryctx :=  Dbms_Xmlgen.Newcontext ('Select ''' || sbClasMov || ''' As "ClasMov",
					Rs.UNIDAD_OPE As "AlmCont",
					substr(:sbPrefijoLDC || ''-'' || ''' || sbClasMov || ''' || ''-'' || Rs.RESERVA || ''/'' || Uo.OPERATING_UNIT_ID || '' '' || Uo.NAME,1,40) As "ResFront",
					decode(:flagHerramienta, ''N'', NULL, ''S'', Rs.Centro_Costo, NULL) "CenCosto",
					CURSOR (Select Dt.CODIGO_ITEM As "Material",
																			trim(to_char(NVL(Dt.CANTIDAD,0),''9999999999990.99'')) As "Cantidad",
																			Dt.CENTRO "CentroSAP",
																			case
																				 when Dt.COSTO_ERP <= 0 then NULL
																					 else	trim(to_char(NVL(Dt.COSTO_ERP, NULL),''9999999999990.99'')) end As "Costo"
														From LDCI_DET_RESERVAMAT Dt
													Where Rs.RESERVA = Dt.RESERVA
															and Dt.ES_HERRAMIENTA = ''' ||Flagherramienta || ''') As "Detalle"
			From LDCI_RESERVAMAT Rs, OR_OPERATING_UNIT Uo
			where Rs.RESERVA = ' || to_char(reserva) ||
			'and Rs.UNIDAD_OPE = Uo.OPERATING_UNIT_ID');

     -- Asigna el valor de la variable :flagHerramienta
    DBMS_XMLGEN.setBindvalue (qryCtx, 'flagHerramienta', flagHerramienta);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'sbPrefijoLDC', sbPrefijoLDC);

    Dbms_Xmlgen.setRowSetTag(Qryctx, sbInputMsgType);
    DBMS_XMLGEN.setRowTag(qryCtx, '');
    --Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    l_payload := replace(l_payload, '<Detalle>');
    l_payload := replace(l_payload, '</Detalle>');

    l_payload := replace(l_payload, '<Detalle_ROW>',  '<Detalle>');
    l_payload := replace(l_payload, '</Detalle_ROW>', '</Detalle>');
    --L_Payload := '<urn:NotificarOrdenesLectura>' || L_Payload || '</urn:NotificarOrdenesLectura>';
    L_Payload := Trim(L_Payload);
    --dbms_output.put_line('[ln395] proEnviarSolicitud L_Payload: ' || chr(13) || L_Payload);


    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);


    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
																																																						sbUrlDesti,
																																																						sbSoapActi,
																																																						sbNameSpace);


    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then

							LDCI_PKMESAWS.PROCREAMENSENVIO(IDTMESAFECH       => SYSDATE,
																																						ISBMESADEFI       => sbDefiSewe,
																																						INUMESAESTADO     => -1,
																																						INUMESAPROC       => inuProcCodi,
																																						ICBMESAXMLENV     => null,
																																						ICDMESAXMLPAYLOAD => L_Payload,
																																						INUMESATAMLOT     => 1,
																																						INUMESALOTACT     => 1,
																																						ONUMESACODI       => onuMesacodi,
																																						ONUERRORCODE      => onuErrorCode,
																																						OSBERRORMESSAGE   => osbErrorMessage);
       raise excepNoProcesoSOAP;
				else

								LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => inuProcCodi,
																																						IDTPROCFEFI     => sysdate,
																																						ISBPROCESTA     => 'F',
																																						ONUERRORCODE    => ONUERRORCODE,
																																						OSBERRORMESSAGE => OSBERRORMESSAGE);

								LDCI_PKMESAWS.PROCREAMENSENVIO(IDTMESAFECH       => SYSDATE,
																																							ISBMESADEFI       => sbDefiSewe,
																																							INUMESAESTADO     => 1,
																																							INUMESAPROC       => inuProcCodi,
																																							ICBMESAXMLENV     => null,
																																							ICDMESAXMLPAYLOAD => L_Payload,
																																							INUMESATAMLOT     => 1,
																																							INUMESALOTACT     => 1,
																																							ONUMESACODI       => onuMesacodi,
																																							ONUERRORCODE      => onuErrorCode,
																																							OSBERRORMESSAGE   => osbErrorMessage);
    end if; -- If (LDCI_PKSOAPAPI.Boolsoaperror ...
   end if;--if (reserva is not null) then
   onuErrorCode := 0;
Exception

  when exce_ValidaCentroCosto then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
	     onuErrorCode := -1;
	     osbErrorMessage := '[LDCI_PKRESERVAMATERIAL.proEnviarSolicitud] La unidad operativa (' || to_char(reLDCI_RESERVAMAT.UNIDAD_OPE) || reLDCI_RESERVAMAT.NAME   || ') no tiene configurado el Centro de Costo o esta configurado en el Centro de Costo -1. (Forma GEMCUO)';
      Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[691]' || osbErrorMessage);
      commit; --rollback;
						LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(reserva), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

  WHEN excepNoProcesoRegi THEN
        osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: La consulta no ha arrojo registros: ' || chr(13) || DBMS_UTILITY.format_error_backtrace;
        onuErrorCode:= -1;
        Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[698]' || osbErrorMessage);
        commit; --rollback;

  	WHEN excepNoProcesoSOAP THEN
        osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
        onuErrorCode:= -1;
        Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[706]' || osbErrorMessage);
        commit; --rollback;
  when others  then
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[712]' || osbErrorMessage);
        commit; --rollback;
End proEnviarSolicitud;
--***************************************************************************************************************************************************
Function fnuObtenerClasificacionItem(Itemid Number, itemcode varchar2)
	Return Number As
	/*
	 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

		   FUNCION : fnuObtenerClasificacionItem
			 AUTOR : MAURICIO FERNANDO ORTIZ
			 FECHA : 10/12/2012
     RICEF         : I005; I006
	 DESCRIPCION   : Procedimiento para enviar la interfaz

	 Parametros de Entrada
	  Itemid Number
	  itemcode varchar2

	 Parametros de Salida

	 Historia de Modificaciones

	 Autor        Fecha       Descripcion.
	*/
    doc       DBMS_XMLDOM.DOMDocument;
    ndoc      DBMS_XMLDOM.DOMNode;
    docelem   DBMS_XMLDOM.DOMElement;
    node      DBMS_XMLDOM.DOMNode;
    childnode DBMS_XMLDOM.DOMNode;
    Nodelist  Dbms_Xmldom.Domnodelist;
    Buf             Varchar2(2000);
    oclXMLItemsData CLOB;
    Onuerrorcode    ge_error_log.Error_log_id%TYPE;
    Osberrormessage ge_error_log.description%TYPE;
    resultado       number;
  Begin
     -- carga item
     OS_GET_ITEM(Itemid, itemcode, Oclxmlitemsdata, Onuerrorcode, Osberrormessage);
     If Onuerrorcode = 0 Then
       /* PROCESAR XML Y OBTENER CLASIFICACION*/
        -- Create DOMDocument handle
        doc     := DBMS_XMLDOM.newDOMDocument(Oclxmlitemsdata);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);

        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist  := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEM_CLASS');
        Node      := Dbms_Xmldom.Item(Nodelist, 0);
        Childnode := Dbms_Xmldom.Getfirstchild(Node);
        resultado := to_number(Dbms_Xmldom.Getnodevalue(Childnode));
     End If; -- If Onuerrorcode = 0 Then

	   -- retorna clasificacion de item
     Return Resultado;
  exception
  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end fnuObtenerClasificacionItem;
--***************************************************************************************************************************************************
  procedure proValidaClaseValoraProvLogis(inuIdProvLogistico    in NUMBER,
                                         sbCLASS_ASSESSMENT_ID out VARCHAR2,
                                         onuErrorCode          out NUMBER,
                                         osbErrorMessage       out VARCHAR2) as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKRESERVAMATERIAL.proValidaClaseValoraProvLogis
     AUTOR      : Carlos E. Virgen Londo?o <carlos.virgen@olsoftware.com>
     FECHA      : 14/11/2014
     RICEF      : OYM_CEV_5028_1
     DESCRIPCION: Valida la clase de valoracion del proveedor  logistico

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */

  begin
        --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
        onuErrorCode := 0;
        if (instr(sbLstCentSolInv, inuIdProvLogistico) <> 0
         and instr(sbLstCentSolAct, inuIdProvLogistico) <> 0) then
            onuErrorCode := -1;
            osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                               ') esta configurada como Inventario y Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';
        else
            if (instr(sbLstCentSolInv, inuIdProvLogistico) <> 0) then
               --Clase de valoracion Inventario
               sbCLASS_ASSESSMENT_ID := 'I';
            else
                if (instr(sbLstCentSolAct, inuIdProvLogistico) <> 0) then
                   --Clase de valoracion Activo
                   sbCLASS_ASSESSMENT_ID := 'A';
                else
                    onuErrorCode := -1;
                    osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                                       ') no esta configurada como Inventario o Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';


                end if;--if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) then
            end if;--if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) then
        end if; -- if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0 ...

  end proValidaClaseValoraProvLogis;
--***************************************************************************************************************************************************
Procedure proConfirmarReserva(Reserva       in  VARCHAR2,
																													inuProcCodi   in  NUMBER,
                             onuErrorCode out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
							                      osbErrorMessage Out ge_error_log.description%TYPE) As
/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

		FUNCION : proConfirmarReserva
		AUTOR : MAURICIO FERNANDO ORTIZ
		FECHA : 10/12/2012
		RICEF      : I005
		DESCRIPCION : Procedimiento para confirmar reservas en el sistema smartflex

 Parametros de Entrada
    Reserva In varchar2
 Parametros de Salida
   Nucodigo Out Number
   Sbmsj Out Varchar
 Historia de Modificaciones

 Autor                                       Fecha       Descripcion.
 carlos.virgen<carlos.virgen@olsfotware.com> 28-08-2014  #NC:1534 1535 1536: se coloca el codigo de homoloacion en la consulta GE_ITEMS.CODE
  */
 -- define variables
 L_Payload     clob;
 Qryctx        Dbms_Xmlgen.Ctxhandle;
 Sberrmens Varchar2(500);

 -- excepciones
 Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta
 exce_OS_SET_REQUEST_CONF exception;
Begin
   -- inicializa la variable de retorno
   onuErrorCode := 0;

   -- Genera el mensaje XML
			Qryctx :=  Dbms_Xmlgen.Newcontext ('Select RS.RESERVA    As "DOCUMENT_ID",
																																														RS.UNIDAD_OPE As "OPERATING_UNIT_ID",
																																														CURRENT_DATE as "DELIVERYDATE",
																																					Cursor (Select /*DT.ITEM_ID #NC:1534 1535 1536*/ ITEM.CODE as "ITEM_CODE",
																																																				DT.CANTIDAD As "QUANTITY",
																																																				DT.COSTO_OS as "COST"
																																													From LDCI_DET_RESERVAMAT Dt, GE_ITEMS ITEM
																																													Where RS.RESERVA = DT.RESERVA
																																													  and DT.ITEM_ID = ITEM.ITEMS_ID /*#NC:1534 1535 1536*/ ) As "ITEMS"
																																					From LDCI_RESERVAMAT Rs
																																					where RS.RESERVA = ' || reserva );

    Dbms_Xmlgen.Setrowsettag(Qryctx, 'REQUEST_CONF');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<ROW>', '<DOCUMENT>');
    L_Payload := Replace(L_Payload, '</DELIVERYDATE>', '</DELIVERYDATE>' ||chr(13) || '</DOCUMENT>');
    L_Payload := Replace(L_Payload, '</ROW>','');

    l_payload := replace(l_payload, '<ITEMS_ROW>',  '<ITEM>');
    l_payload := replace(l_payload, '</ITEMS_ROW>', '</ITEM>');
    L_Payload := Trim(L_Payload);

	   -- hace el llamado al API
    OS_SET_REQUEST_CONF(L_Payload, onuErrorCode , osbErrorMessage);
				--dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << L_Payload] ' || chr(13) || L_Payload);
				--dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF >> onuErrorCode] ' || onuErrorCode);
				--dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF >> osbErrorMessage] ' || osbErrorMessage);

				if (onuErrorCode <> 0) then
							raise exce_OS_SET_REQUEST_CONF;
				end if;--if (onuErrorCode <> 0) then

EXCEPTION
 WHEN exce_OS_SET_REQUEST_CONF THEN
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

 WHEN excepNoProcesoRegi THEN
       onuErrorCode := -1;
       osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proConfirmarReserva]: La consulta no ha arrojo registros' || Dbms_Utility.Format_Error_Backtrace;
       Errors.seterror (onuErrorCode, osbErrorMessage);
       --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage1] ' || chr(13) || osbErrorMessage);
       commit; --rollback;

 when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage2] ' || chr(13) || osbErrorMessage);
      commit; --rollback;

end proConfirmarReserva;
--***************************************************************************************************************************************************
Procedure proProcesaReserva (Items_Documento_Id  in VARCHAR2,
                              inuProcCodi         in NUMBER,
                              onuErrorCode       out GE_ERROR_LOG.ERROR_LOG_ID%type,
                              osbErrorMessage    out GE_ERROR_LOG.DESCRIPTION%type) As

 /*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

		FUNCION : proProcesaReserva
		AUTOR : MAURICIO FERNANDO ORTIZ
		FECHA : 10/12/2012
		RICEF      : I005
		DESCRIPCION : Procedimiento para procesar una reserva pendiente de notificacion al ERP

 Parametros de Entrada
    Items_Documento_Id varchar2
 Parametros de Salida
   onuErrorCode Out Number
   osbErrorMessage Out Varchar2
 Historia de Modificaciones

 Autor                                         Fecha       Descripcion.
	carlos.virgen <carlos.virgen@olsoftware.com>  20-08-2014 #NC:1456,1457,1458: Mejora Validaci??n del centro de costo, solicitud de herramienta
  carlos.virgen<carlos.virgen@olsoftware.com>   13-11-2014 #OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
*/

  Osbrequest Varchar2(32000);
  Nuoperunitid Number;
  Nuerpoperunitid Number;
  --Dtdate date;

  Docitem       Dbms_Xmldom.Domdocument;
  Ndocitem      Dbms_Xmldom.Domnode;
  Docelemitem   Dbms_Xmldom.Domelement;
  Nodeitem      Dbms_Xmldom.Domnode;

  Nuitemid    number(15);
  Sbitemcode  varchar2(60);
  Sbitemdesc  varchar2(100);
  Nuitemcant  number;
  Nuitemcosto number;
  Nuclassitem number;
  nuCantMate  number := 0;
  nuCantHerr  number := 0;

  sbFlagHta varchar2(1);

  oclXMLItemsData CLOB;

  Nodelistitem  Dbms_Xmldom.Domnodelist;
  Bufitem       Varchar2(32767);

  contadorItem Number(10);
  Nodelisteleitem  Dbms_Xmldom.Domnodelist;
  nodedummy Dbms_Xmldom.Domnode;

  sbOPER_UNIT_CODE OR_OPERATING_UNIT.OPER_UNIT_CODE%type;
  sbCECOCODI       LDCI_CECOUNIOPER.CECOCODI%type;
  sbCLASS_ASSESSMENT_ID LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%type; --#OYM_CEV_3429_1

  -- cursor de la unidad operativa
  Cursor cuUnidadOperativa(inuOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%type) Is
      Select OPER_UNIT_CODE
        From OR_OPERATING_UNIT
        Where OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

  -- cursor del centro de costo
  cursor cuLDCI_CECOUNIOPER(isbCECOCODI LDCI_CECOUNIOPER.CECOCODI%type) is
    select CECOCODI
						from LDCI_CECOUNIOPER
					where OPERATING_UNIT_ID = isbCECOCODI;

		--#OYM_CEV_3429_1: Cursor de la clase de valoracion por unidad operativa
  cursor cuLDCI_CLVAUNOP(inuOPERATING_UNIT_ID LDCI_CLVAUNOP.OPERATING_UNIT_ID%type) is  --#OYM_CEV_3429_1
    select CLASS_ASSESSMENT_ID
      from LDCI_CLVAUNOP
     where OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

  exce_proEnviarSolicitud    exception;
  exce_proConfirmarReserva   exception;
  exce_OS_GET_REQUEST        exception;
  exce_ValidaCentroCosto     exception;
  exce_ValidaClaseValoracion exception;		--#OYM_CEV_3429_1
Begin
--	  dbms_output.put_line("Procesa reserva : "||Items_Documento_Id);
	  -- inicializa variable de salida
	  onuErrorcode := 0;
	  -- llamado original al API de OPEN
	  OS_GET_REQUEST(to_number(Items_Documento_Id), Osbrequest,
                            Onuerrorcode, Osberrormessage);
				-- Create DOMDocument handle
			Docitem     := Dbms_Xmldom.Newdomdocument(Osbrequest);
			ndocitem    := DBMS_XMLDOM.makeNode(docitem);
			Dbms_Xmldom.Writetobuffer(Ndocitem, Bufitem);
			docelemitem := DBMS_XMLDOM.getDocumentElement(docitem);

			-- Access element
			Nodelistitem    := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'OPERATING_UNIT_ID');
			Nodedummy       := Dbms_Xmldom.Item(Nodelistitem, 0);
			Nuoperunitid    := To_Number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy)));
			Nodelistitem    := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'OPER_UNIT_ERP_ID');
			Nodedummy       := Dbms_Xmldom.Item(Nodelistitem, 0);
			nuerpoperunitid := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

			-- determina el codigo del centro de distribucion
			open cuUnidadOperativa(nuerpoperunitid);
			fetch cuUnidadOperativa into sbOPER_UNIT_CODE;
			close cuUnidadOperativa;

			-- carga la informacion del centro de costo
			open cuLDCI_CECOUNIOPER(Nuoperunitid);
			fetch cuLDCI_CECOUNIOPER into sbCECOCODI;
			close cuLDCI_CECOUNIOPER;

      /*#OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
			open cuLDCI_CLVAUNOP(Nuoperunitid); --#OYM_CEV_3429_1: Carga el valor de la clase de valoracion
			fetch cuLDCI_CLVAUNOP into sbCLASS_ASSESSMENT_ID;
			close cuLDCI_CLVAUNOP;*/

			Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'DATE');
			Nodedummy := Dbms_Xmldom.Item(Nodelistitem, 0);
			--dtdate  := to_date(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)), 'DD/MM/YYYY');

      --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
      proValidaClaseValoraProvLogis(nuERPOperUnitId,
                                    sbCLASS_ASSESSMENT_ID,
                                    onuErrorCode,
                                    osbErrorMessage);
      if (onuErrorCode <> 0) then
          raise exce_ValidaClaseValoracion;
      end if; --if (onuErrorCode <> 0) then

			/*#OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
      if (sbCLASS_ASSESSMENT_ID is null or sbCLASS_ASSESSMENT_ID = '') then --#OYM_CEV_3429_1: Valida la clase de valoracion
					raise exce_ValidaClaseValoracion;
			end if;--if (sbCLASS_ASSESSMENT_ID is not null or sbCLASS_ASSESSMENT_ID <> '') then*/

   -- valida que la unidad operativa tenga configurado el centro de costo
	  --if (sbCECOCODI is not null or sbCECOCODI <> '') then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Se comenta la validacion anteriro
			  /*GUARDAR CABECERA DE LA RESERVA*/
			insert into LDCI_RESERVAMAT (RESERVA, UNIDAD_OPE, ALMACEN_CON, CLASE_MOV, CENTRO_COSTO, FECHA_ENTREGA)
			     	values (Items_Documento_Id, Nuoperunitid, nuerpoperunitid, 'PRU', sbCECOCODI, CURRENT_DATE);

			Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'ITEM');
			nuCantMate := 0;
			nuCantHerr := 0;
												-- recorre los items
			For Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) Loop
						Nodeitem := Dbms_Xmldom.Item(Nodelistitem, Contadoritem - 1);
						/*OBTENGO ELMENTOS DE ITEM*/
						Nodelisteleitem := Dbms_Xmldom.Getchildnodes(Nodeitem);


						Nodedummy := Dbms_Xmldom.Item(Nodelisteleitem, 0);
						nuitemid  := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

						/* ejecutar os_get_item*/
						/* para saber si es una herramienta la clasificacion del item es 3 */
						Nuclassitem := fnuObtenerClasificacionItem(Nuitemid, null);
						--os_get_item(nuitemid, null, oclXMLItemsData, Onuerrorcode, Osberrormessage);

						If Nuclassitem = 3 Then
								/* ES UNA HERRAMIENTA*/
								Sbflaghta := 'S';
								nuCantHerr := nuCantHerr + 1;
						Else
									nuCantMate := nuCantMate + 1;
						End If; -- If Nuclassitem = 3 Then

						Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 1);
						sbitemcode  := Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy));
						Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 2);
						sbitemdesc  := Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy));
						Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 4);
						nuitemcant  := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy)));
						Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 5);
						nuitemcosto := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

						insert into LDCI_DET_RESERVAMAT (Reserva, Item_Id, Codigo_Item, Cantidad, Costo_Os, Costo_Erp, Centro, Es_Herramienta)
							values (Items_Documento_Id, nuitemid, sbitemcode, nuitemcant, nuitemcosto, null, sbOPER_UNIT_CODE, decode(Nuclassitem, 3, 'S', 'N'));
			end loop;--For Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) Loop
			DBMS_XMLDOM.freeDocument(docitem);

			If Onuerrorcode = 0 Then
								-- valida si la solicitud tiene mezcla de materiales y herramientas
								if (nuCantMate <> 0 and nuCantHerr <> 0) then
												-- solicitud de herramintas
												--dbms_lock.sleep(15);
												proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
												If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
															raise exce_proEnviarSolicitud;
												End If; -- If (Onuerrorcode) = 0 Then;

												-- solicitu de materiales
												proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
												If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
															raise exce_proEnviarSolicitud;
												End If; -- If (Onuerrorcode) = 0 Then;
								end if; -- if (nuCantMate <> 0 and nuCantHerr <> 0) then

								-- solicitud de solo materiales
								if (nuCantMate <> 0 and nuCantHerr = 0) then
												proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
												If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
															raise exce_proEnviarSolicitud;
												End If; -- If (Onuerrorcode) = 0 Then;
								end if;--if (nuCantMate <> 0 and nuCantHerr = 0) then

								-- solicitud de solo herramientas
								if (nuCantMate = 0 and nuCantHerr <> 0) then
												proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi , sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);

												If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
															raise exce_proEnviarSolicitud;
												End If; -- If (Onuerrorcode) = 0 Then;
								end if;--if (nuCantMate = 0 and nuCantHerr <> 0) then

								If (Onuerrorcode) = 0 Then
											-- hace la confirmacion de la solicitud llamado al API OS_SET_REQUEST_CONF
											proConfirmarReserva(Items_Documento_Id, inuProcCodi, Onuerrorcode, Osberrormessage);
											If (Onuerrorcode) = 0 Then
												commit;
											Else
												-- guarda la excepcion
												raise exce_proConfirmarReserva ;
											End If; -- If (Onuerrorcode) = 0 Then;
								Else
											-- guarda la excepcion
											raise exce_proEnviarSolicitud;
								End If; -- If (Onuerrorcode) = 0 Then;
		 Else
						-- guarda la excepcion
						raise exce_OS_GET_REQUEST;
		 End If; -- If Onuerrorcode = 0 Then;

   --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Se comenta la validacion anteriro
		 --#NC:1456,1457,1458 else
				 -- guarda la excepcion
			--#NC:1456,1457,1458	 raise exce_ValidaCentroCosto;
	  --#NC:1456,1457,1458 end if;--if (sbCECOCODI is not null or sbCECOCODI <> '') then
	--  dbms_output.put_line("Finaliza reserva : "||Items_Documento_Id);
  Exception
    When exce_proConfirmarReserva THEN
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

    When exce_proEnviarSolicitud THEN

      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

    When exce_OS_GET_REQUEST THEN
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

    When exce_ValidaClaseValoracion THEN --#OYM_CEV_3429_1
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
			LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

    When exce_ValidaCentroCosto THEN
  	   onuErrorCode := -1;
	     osbErrorMessage := '[proNotificaReservas] La unidad operativa (' || to_char(Nuoperunitid)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
						LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

    When Others THEN
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  END proProcesaReserva;
--***************************************************************************************************************************************************

				
  Begin
      --proCargaVarGlobal('WS_RESERVA_MATERIALES');
	  -- carga las variables requeridas para las solicitudes
	   sbInputMsgType  := null;
      sbNameSpace     := null;
      sbUrlWS         := null;
      sbUrlDesti      := null;
      sbSoapActi      := null;
      sbProtocol      := null;
      sbHost          := null;
      sbPuerto        := null;
      sbClasSolMat    := null;
      sbClasDevMat    := null;
      sbClasSolMatAct := null; --#OYM_CEV_3429_1
      sbClasDevMatAct := null; --#OYM_CEV_3429_1
      sbLstCentSolInv := null; --#OYM_CEV_5028_1: #ifrs #471
      sbLstCentSolAct := null; --#OYM_CEV_5028_1: #ifrs #471
      sbClasSolHer    := null;
      sbClasDevHer    := null;
      sbPrefijoLDC    := null;
      sbDefiSewe			 := null;


      sbDefiSewe := 'WS_RESERVA_MATERIALES';
      -- carga los parametos de la interfaz
      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'INPUT_MESSAGE_TYPE', sbInputMsgType, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'NAMESPACE', sbNameSpace, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'WSURL', sbUrlWS, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'SOAPACTION', sbSoapActi, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'PROTOCOLO', sbProtocol, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'PUERTO', sbPuerto, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'HOST', sbHost, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLS_MOVI_MATERIAL', sbClasSolMat, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLS_MOVI_DEVOLUCION_MAT', sbClasDevMat, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLS_MOVI_HERRAMIENTA', sbClasSolHer, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLS_MOVI_DEVOLUCION_HER', sbClasDevHer, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'PREFIJO_LDC', sbPrefijoLDC, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;


      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLSM_SOLI_ACT', sbClasSolMatAct, osbErrorMessage); --#OYM_CEV_3429_1
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'CLSM_DEVO_ACT', sbClasDevMatAct, osbErrorMessage); --#OYM_CEV_3429_1
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;


      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'LST_CENTROS_SOL_INV', sbLstCentSolInv, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'LST_CENTROS_SOL_ACT', sbLstCentSolAct, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;
      sbUrlDesti := trim(sbUrlDesti);
    --proCargaVarGlobal('WS_RESERVA_MATERIALES');


    -- recorre las unidades operativas de tipo 17 - CUARDILLA
    for reUnidadOperativa in cuUnidadOperativa loop
        -- carga las solicitudes
        OS_GET_REQUESTS_REG(reUnidadOperativa.OPERATING_UNIT_ID,
                            OSBREQUESTSREGS,
                            ONUERRORCODE,
                            OSBERRORMESSAGE);

        -- Create DOMDocument handle
        doc     := DBMS_XMLDOM.newDOMDocument(Osbrequestsregs);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);
        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEMS_DOCUMENTO_ID');

        -- recorre el listado de las reservas pendientes
        For Contador In 1..Dbms_Xmldom.Getlength(Nodelist) Loop

          -- extrae el codigo de la reserva a procesar
          Node               := Dbms_Xmldom.Item(Nodelist, Contador - 1);
          Childnode          := Dbms_Xmldom.Getfirstchild(Node);
          Items_Documento_Id := to_number(Dbms_Xmldom.Getnodevalue(Childnode));

				      icbProcPara:= '<PARAMETROS>
																										<PARAMETRO>
																												<NOMBRE>ITEMS_DOCUMENTO_ID</NOMBRE>
																												<VALOR>' || Items_Documento_Id ||'</VALOR>
																										</PARAMETRO>
																										<PARAMETRO>
																												<NOMBRE>OPERATING_UNIT_ID</NOMBRE>
																												<VALOR>' || reUnidadOperativa.OPERATING_UNIT_ID ||'</VALOR>
																										</PARAMETRO>
																								</PARAMETROS>';


									 -- crea el identificado de proceso para la interfaz
										LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => 'WS_RESERVA_MATERIALES',
																																								ICBPROCPARA     => icbProcPara,
																																								IDTPROCFEIN     => SYSDATE,
																																								ISBPROCESTA     => 'P',
																																								ISBPROCUSUA     => null,
																																								ISBPROCTERM     => null,
																																								ISBPROCPROG     => null,
																																								ONUPROCCODI     => onuProcCodi,
																																								ONUERRORCODE    => ONUERRORCODE,
																																								OSBERRORMESSAGE => OSBERRORMESSAGE);

          /*Procesar reserva, carga maestro, detalle, confirmar items y enviar*/
          proProcesaReserva(Items_Documento_Id, onuProcCodi, Onuerrorcode, Osberrormessage );

          /*si hay herramientas enviar y confirmar herramientas*/
        End Loop;-- For Contador In 1..Dbms_Xmldom.Getlength(Nodelist) Loop

    end loop; -- for reUnidadOperativa in cuUnidadOperativa loop

	-- elimina los registros de la tabla de procesamiento
    delete from LDCI_DET_RESERVAMAT;
    delete from LDCI_RESERVAMAT;
	   commit;
				-- libera el archivo XML
    DBMS_XMLDOM.freeDocument(doc);
  exception
    When Errorpara01 then
      Errors.seterror (-1, 'ERROR: [proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage);
	  dbms_output.put_line(sqlerrm);
      commit; --rollback;
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
	  dbms_output.put_line(sqlerrm);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  END;
