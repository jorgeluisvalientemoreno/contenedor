CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKREASIGNAORDEN AS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Paquete de integracion de SIGELECT

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

-- funcion que retorna el periodo de facturacion segun un ciclo
function fnObtenesPeriodoCiclo return Constants.tyRefCursor;

-- procedimiento que carga las ordenes a reasignar
procedure proObtenerOrdenesAReasignar(isbCICLCICO             IN  VARCHAR2,
																																					isbOPERATING_UNIT_ID    IN  VARCHAR2,
																																					isbTASK_TYPE_ID         IN  VARCHAR2,
																																					isbASSIGNED_DATE        IN  VARCHAR2,
																																					isbEXECUTION_FINAL_DATE IN  VARCHAR2,
																																					isbperiodofac           in  VARCHAR2 ,
																																					orfCursor               OUT Constants.tyRefCursor);

-- procedimiento invocado en el proceso en batch PBRDO
procedure PROCESO;


END LDCI_PKREASIGNAORDEN;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKREASIGNAORDEN AS

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Paquete de integracion de SIGELECT

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

cnuORDER_STAT_ASSIGNED OR_order.order_status_id%type := 5;
csbASSIGN_CAPACITY or_operating_unit.assign_type%type := 'N';

PROCEDURE proReasignaOrdenes
(
        inuORDER_ID          in NUMBER,
        inuOPERATING_UNIT_ID in NUMBER,
        onuErrorCode        out NUMBER,
        osbErrorMessage     out VARCHAR2
)
AS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     procedimiento : LDCI_PKREASIGNAORDEN.proReasignaOrdenes
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Procedimiento que encapsula el llamado a  OR_BOPROCESSORDER.PROCESSREASSINGORDER

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */
BEGIN

    -- Inicializa las variables de salida del servicio
    onuErrorCode := 0;
    osbErrorMessage := NULL;

      --Llamado al proceso de reasignacion OR_BOPROCESSORDER.PROCESSREASSINGORDER( xxxx, yyyy, zzzz );
						OR_BOPROCESSORDER.PROCESSREASSINGORDER(inuORDER_ID,
																																												 inuOPERATING_UNIT_ID,
																																												null);

EXCEPTION
	when ex.CONTROLLED_ERROR then
		Errors.getError(onuErrorCode, osbErrorMessage);
	when others then
		Errors.setError;
		Errors.getError(onuErrorCode, osbErrorMessage);
END proReasignaOrdenes;

function fnObtenesPeriodoCiclo return Constants.tyRefCursor as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN.fnObtenesPeriodoCiclo
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Funcion que retorna el o los peridos de facturacion dependiento de un ciclo de facturacion

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */
	sbSQL      VARCHAR2(500);
	rfQuery    Constants.tyRefCursor;
	sbCICLCICO Ge_BOInstanceControl.stysbName;
	sbInstance ge_boInstanceControl.stysbName;
begin
 -- carga las variables de la instancia del proceso en batch
 ge_boInstanceControl.GetCurrentInstance(sbInstance);
 sbCICLCICO := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCICO');

 --  fila la sentencia SQL
	sbSQL := 'select pefacodi id, pefadesc description  from perifact
              where  pefaactu = ''S'' and pefacicl = ' || sbCICLCICO ;

 -- abre cursor
 OPEN rfQuery FOR sbSQL;

	return rfQuery;
end fnObtenesPeriodoCiclo;


Procedure ENVIARCONFIRMACION(inuidUnidadOperativa in Varchar2,
                            inuIdCiclo           in Varchar2,
                            inuIdPeriodoFact     in Varchar2,
                            inuidTipoTrabajo     in Varchar2,
                            inuIdNuevaUnidadOper in Varchar2,
                            Onuerrorcode        Out  Number,
                            Osberrormsg         Out Varchar2) As
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN.ENVIARCONFIRMACION
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Hace consumo de servicio Web para envio a SIGELECT

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

				-- definicion de cursores
				/* Cursor que procesa el mensaje de respuesta del servicio Web
				<?xml version="1.0" encoding="UTF-8"?>
			<SOAP:Envelope xmlns:SOAP='http://schemas.xmlsoap.org/soap/envelope/'>
				<SOAP:Header/>
				<SOAP:Body>
					<ns1:ReasignaOrdenResponse xmlns:ns1='urn:gaseras.com:smflex:base'>
						<codError>1</codError>
						<descError>Exception: org.hibernate.TransactionException: JDBC rollback failed</descError>
					</ns1:ReasignaOrdenResponse>
				</SOAP:Body>
			</SOAP:Envelope>*/
				cursor cuWebServiceResponse(clXML CLOB) is
							select codError onuErrorCode, descError osbErrorMessage
							from
								(SELECT EXTRACTVALUE(XMLTYPE(clXML), '//codError', 'xmlns:ns1="urn:gaseras.com:smflex:base"')  as codError
									FROM dual),
								(SELECT EXTRACTVALUE(XMLTYPE(clXML), '//descError', 'xmlns:ns1="urn:gaseras.com:smflex:base"')  as descError
									FROM dual)
							dual;


    reWebServiceResponse cuWebServiceResponse%rowtype;


    --  definicion de variables para parametros de interfaz
    sbErrMens varchar2(2000);
    sbNameSpace LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS     LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti  LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi  LDCI_CARASEWE.CASEVALO%type;
    sbProtocol  LDCI_CARASEWE.CASEVALO%type;
    sbHost      LDCI_CARASEWE.CASEVALO%type;
    sbPuerto    LDCI_CARASEWE.CASEVALO%type;
     Sbmens      Varchar2(4000);


   --Variables mensajes SOAP
   L_Payload    clob;
   sbXmlTransac clob;

   l_response    CLOB;
   qryCtx        DBMS_XMLGEN.ctxHandle;

   errorPara01	EXCEPTION;      	  -- Excepcion que verifica que ingresen los parametros de entrada
   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP
Begin

   -- carga los paraemetros de la interfaz
   LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'NAMESPACE', sbNameSpace, Osberrormsg);
    if(Osberrormsg != '0') then
         RAISE errorPara01;
    end if;--if(Osberrormsg != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'WSURL', sbUrlWS, Osberrormsg);
    if(Osberrormsg != '0') then
         RAISE errorPara01;
    end if;--if(Osberrormsg != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'SOAPACTION', sbSoapActi, Osberrormsg);
    if(Osberrormsg != '0') then
         RAISE errorPara01;
    end if;--if(Osberrormsg != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'PROTOCOLO', sbProtocol, Osberrormsg);
    if(Osberrormsg != '0') then
         RAISE errorPara01;
    end if;--if(Osberrormsg != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'PUERTO', sbPuerto, Osberrormsg);
    if(Osberrormsg != '0') then
         RAISE errorPara01;
    end if;--if(Osberrormsg != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_REASIGNA_ORDENES', 'HOST', sbHost, Osberrormsg);
    if(Osberrormsg != '0') then
         Raise Errorpara01;
    end if;


				-- genera endpoint
    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    -- genera el XML para el procesamiento
    sbXmlTransac := '<idUnidadOperativa>' || inuidunidadoperativa ||'</idUnidadOperativa>
            <IdCiclo>' || inuidciclo || '</IdCiclo>
            <idNuevaUnidadOperativa>' || inuidnuevaunidadoper || '</idNuevaUnidadOperativa>
            <idPeriodoFacturacion>' || inuidperiodofact || '</idPeriodoFacturacion>
            <idTipoTrabajo>' || inuidtipotrabajo || '</idTipoTrabajo>';

    L_Payload := '<urn:ReasignaOrdenRequest>' || sbXmlTransac  || '</urn:ReasignaOrdenRequest>';

    L_Payload := Trim(L_Payload);

    Dbms_Output.Put_Line(L_Payload);
    --Hace el consumo del servicio Web
     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);


     Dbms_Output.Put_Line('Enviando :' || to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));
     l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCallSync(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    Dbms_Output.Put_Line('Response: ' || l_response || ' ' || to_char(current_date, 'DD/MM/YYYY HH:MI:SS'));



    --Valida el proceso de peticion SOAP
     If (LDCI_PKSOAPAPI.Boolhttperror) Then
        Raise Excepnoprocesosoap;
					else
								-- asigna el mensaje de respuesta del sistema SIGELECT
								open cuWebServiceResponse(L_Response)	;
								fetch cuWebServiceResponse into reWebServiceResponse;
								Onuerrorcode := reWebServiceResponse.onuErrorCode;
								Osberrormsg  := reWebServiceResponse.osbErrorMessage;
								close cuWebServiceResponse;
     end if; -- If (LDCI_PKSOAPAPI.Boolhttperror) Then
Exception
  When Errorpara01 then
						Onuerrorcode := -1;
      Osberrormsg  := 'ERROR: <[LDCI_PKREASIGNAORDEN.ENVIARCONFIRMACION]>: Cargando el parametro :' || Osberrormsg;

  WHEN excepNoProcesoRegi THEN
								Onuerrorcode := -1;
        Osberrormsg := 'ERROR: <LDCI_PKREASIGNAORDEN.ENVIARCONFIRMACION>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;


  	WHEN excepNoProcesoSOAP THEN
								Onuerrorcode := -1;
        Osberrormsg := 'ERROR: <LDCI_PKREASIGNAORDEN.ENVIARCONFIRMACION>: Ocurrio un error en procesamiento SOAP.' || l_response || chr(13) || Dbms_Utility.Format_Error_Backtrace;
end ENVIARCONFIRMACION;

PROCEDURE valOrderRevoke (idtRangeDateIni in  date,
                    					idtRangeDateEnd in  date)
	IS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN.valOrderRevoke
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Valida el proceso de revocar orden

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

BEGIN
					ut_trace.trace('Inicia CT_BOOrderRevoke.valOrderRevoke',15);

					if (idtRangeDateIni > idtRangeDateEnd) then
									ge_boerrors.SetErrorCode(1584);
					end if;

					if ((idtRangeDateIni IS null AND idtRangeDateEnd IS not null)
									OR (idtRangeDateIni IS not null AND idtRangeDateEnd IS null)) then
									ge_boerrors.SetErrorCodeArgument(114646, 'Fecha Inicial de Asignación y Fecha de Final de Asignación');
					end if;

					ut_trace.trace('Finaliza CT_BOOrderRevoke.valOrderRevoke',15);
EXCEPTION
    when ex.CONTROLLED_ERROR then
				    rollback;
        raise;

    when OTHERS then
				    rollback;
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END valOrderRevoke;

PROCEDURE proObtenerOrdenesAReasignar(isbCICLCICO             IN  VARCHAR2,
                                     isbOPERATING_UNIT_ID    IN  VARCHAR2,
																																					isbTASK_TYPE_ID         IN  VARCHAR2,
                                     isbASSIGNED_DATE        IN  VARCHAR2,
																																					isbEXECUTION_FINAL_DATE IN  VARCHAR2,
                                     isbperiodofac           IN  VARCHAR2,
																																					orfCursor               OUT Constants.tyRefCursor) AS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREASIGNAORDEN.proObtenerOrdenesAReasignar
     AUTOR      : Mauricio Ortiz
     FECHA      : 15-01-2013
     RICEF      : I054
     DESCRIPCION: Carga las ordenes a reasignar

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */
        sbSQL VARCHAR2(2000);
        sbparamero parametr.pamechar%type;
BEGIN
        ut_trace.trace('Inicia LDCI_PKREASIGNAORDEN.proObtenerOrdenesAReasignar',15);


							-- genera las sentencias SQL
       sbSQL :=
        ' SELECT  distinct OR_order.order_id,
                OR_ORDER.ASSIGNED_DATE ASSIGN_DATE
        FROM    or_operating_unit,
                OR_order,
                or_task_type,
                or_order_activity,
                ab_address,
                ge_geogra_location,
                or_operating_sector,
                servsusc,
                LECTELME
        WHERE   or_operating_sector.operating_sector_id = OR_order.operating_sector_id
        AND     ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
        AND     ab_address.address_id = or_order_activity.address_id
        AND     OR_order.order_status_id = ' || cnuORDER_STAT_ASSIGNED ||'
        AND     or_order_activity.order_id = OR_order.order_id
        AND     or_task_type.task_type_id = OR_order.task_type_id
        AND     OR_order.operating_unit_id = or_operating_unit.operating_unit_id
        AND     or_order_activity.product_id = servsusc.sesunuse
        AND     or_order_activity.ORDER_ACTIVITY_ID = LECTELME.leemdocu
        AND     LECTELME.LEEMPEFA = ' || isbperiodofac ;

        SELECT pamechar INTO sbparamero FROM parametr WHERE pamecodi='SIGELEC_ASSIGN_TYPE';

        IF sbparamero='S' THEN
          sbSQL := sbSQL ||' AND or_operating_unit.assign_type = ''' || csbASSIGN_CAPACITY || '''';
        END IF;

        if (isbCICLCICO IS not null) then
            sbSQL := sbSQL ||' AND     servsusc.SESUCICL = '||isbCICLCICO;
        end if;



        if (isbOPERATING_UNIT_ID IS not null) then
            sbSQL := sbSQL ||' AND     or_operating_unit.operating_unit_id = nvl ('||isbOPERATING_UNIT_ID||', or_operating_unit.operating_unit_id) ';
        end if;


        if (isbASSIGNED_DATE IS not null) then
            sbSQL := sbSQL || ' AND OR_order.assigned_date between to_date('''||isbASSIGNED_DATE||''', ut_date.fsbDATE_FORMAT) and to_date('''||isbEXECUTION_FINAL_DATE||''', ut_date.fsbDATE_FORMAT)';
        end if;


        if (isbTASK_TYPE_ID IS not null) then
            sbSQL := sbSQL || ' AND OR_order.task_type_id = '||isbTASK_TYPE_ID||' ';
        end if;



        ut_trace.trace('sbSQL ['||sbSQL||']',15);

								-- ejecuta las sentencia SQL
        open orfCursor for sbSQL;

        ut_trace.trace('Finaliza LDCI_PKREASIGNAORDEN.proObtenerOrdenesAReasignar',15);

EXCEPTION
    when ex.CONTROLLED_ERROR then
				    rollback;
        raise;

    when OTHERS then
				    rollback;
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END proObtenerOrdenesAReasignar;


     /* PROCEDURE ProcessPBRDO
    (
        inuOrderId      IN  OR_order.order_id%type,
        inuCurrent      IN  NUMBER,
        inuTotal        IN  NUMBER,
        onuErrorCode    out ge_error_log.message_id%type,
        osbErrorMess    out ge_error_log.description%type
    )
    IS

        --nuOrderId       OR_order.order_id%type;
         sbNEWOPERATING_UNIT_ID ge_boInstanceControl.stysbValue;
    BEGIN
        ut_trace.trace('Inicia LDCI_PKREASIGNAORDEN.ProcessPBRDO',15);
       sbNEWOPERATING_UNIT_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'OPERATING_UNIT_ID');

        or_boprocessorder.ProcessReassingOrder(inuOrderId,
                                                to_number(sbNEWOPERATING_UNIT_ID),
                                                null);

        ut_trace.trace('Finaliza CT_BOOrderRevoke.ProcessCTROR',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            errors.GetError(onuErrorCode, osbErrorMess);

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            errors.GetError(onuErrorCode, osbErrorMess);
    END ProcessPBRDO;*/

PROCEDURE PROREASIGNAORDENES(isbCICLCICO             IN VARCHAR2,
																												isbOPERATING_UNIT_ID    IN VARCHAR2,
																												isbTASK_TYPE_ID         IN VARCHAR2,
																												isbASSIGNED_DATE        IN VARCHAR2,
																												isbEXECUTION_FINAL_DATE IN VARCHAR2,
																												inuNuevo_oper_unit_id   in number,
																												onuErrorCode out ge_error_log.message_id%type,
																												osbErrorMess out ge_error_log.description%type) AS
/*
	PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
	FUNCION    : LDCI_PKREASIGNAORDEN.PROREASIGNAORDENES
	AUTOR      : Mauricio Ortiz
	FECHA      : 15-01-2013
	RICEF      : I054
	DESCRIPCION: Carga las ordenes a reasignar

Historia de Modificaciones
Autor   Fecha   Descripcion
*/
BEGIN
		NULL;
END PROREASIGNAORDENES;

PROCEDURE PROCESO AS

	/*
		PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
		FUNCION    : LDCI_PKREASIGNAORDEN.PROCESO
		AUTOR      : Mauricio Ortiz
		FECHA      : 15-01-2013
		RICEF      : I054
		DESCRIPCION: Procedimiento que ejecuta el API de reasignacion e invoca el consumo del servicio Web SIGELECT

	Historia de Modificaciones
	Autor   Fecha   Descripcion
	*/

	-- definicion de tipos
	rfCursor Constants.tyRefCursor;

	-- variables para el manejo de la intancia del proceso en Batch PBRDO
	cnuNULL_ATTRIBUTE constant number := 2126;
	sbCICLCICO             ge_boInstanceControl.stysbValue;
	sbOPERATING_UNIT_ID    ge_boInstanceControl.stysbValue;
	sbTASK_TYPE_ID         ge_boInstanceControl.stysbValue;
	sbASSIGNED_DATE        ge_boInstanceControl.stysbValue;
	sbEXECUTION_FINAL_DATE ge_boInstanceControl.stysbValue;
	sbNEWOPERATING_UNIT_ID ge_boInstanceControl.stysbValue;
	sbPEFACODI             ge_boInstanceControl.stysbValue;


	sbSQL        VARCHAR2(4000);
	sbInstance   ge_boInstanceControl.stysbName;
	nuIndex      ge_boInstanceControl.stynuIndex;
	onuErrorCode GE_ERROR_LOG.MESSAGE_ID%type;
	osbErrorMess GE_ERROR_LOG.DESCRIPTION%type;
	order_id     OR_ORDER.ORDER_ID%type;
	ASSIGN_DATE  OR_ORDER.ASSIGNED_DATE%type;

	-- excepticiones
	excep_ENVIARCONFIRMACION exception;
	excep_PROREASIGNAORDENES exception;
BEGIN
		ut_trace.trace('Inicia LDCI_PKREASIGNAORDEN.PROREASIGNAORDENES',15);

		-- carga las variables del proceso en batch
		ge_boInstanceControl.GetCurrentInstance(sbInstance);
		sbCICLCICO             := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCICO');
		sbOPERATING_UNIT_ID    := ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT', 'OPERATING_UNIT_ID');
		sbTASK_TYPE_ID         := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'TASK_TYPE_ID');
		--sbASSIGNED_DATE        := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ASSIGNED_DATE');
		--sbEXECUTION_FINAL_DATE := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'EXECUTION_FINAL_DATE');
		sbPEFACODI             := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACODI');
		sbNEWOPERATING_UNIT_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'OPERATING_UNIT_ID');


		------------------------------------------------
		-- Required Attributes
		------------------------------------------------

		if (sbCICLCICO is null) then
						Errors.SetError (cnuNULL_ATTRIBUTE, 'Ciclo De Consumo');
						raise ex.CONTROLLED_ERROR;
		end if;

		if (sbOPERATING_UNIT_ID is null) then
						Errors.SetError (cnuNULL_ATTRIBUTE, 'Código De Identificación De La Unidad Operativa');
						raise ex.CONTROLLED_ERROR;
		end if;

		if (sbTASK_TYPE_ID is null) then
						Errors.SetError (cnuNULL_ATTRIBUTE, 'Código Del Tipo De Trabajo');
						raise ex.CONTROLLED_ERROR;
		end if;

		if (sbOPERATING_UNIT_ID is null) then
						Errors.SetError (cnuNULL_ATTRIBUTE, 'Código De La Unidad Operativa A La Cual Fue Asignada La Orden De Trabajo');
						raise ex.CONTROLLED_ERROR;
		end if;

		if (sbNEWOPERATING_UNIT_ID is null) then
						Errors.SetError (cnuNULL_ATTRIBUTE, 'Código De La Unidad Operativa A La Cual Fue Asignada La Orden De Trabajo');
						raise ex.CONTROLLED_ERROR;
		end if;


		-- carga el cursor de las ordenes a reasignar
		proObtenerOrdenesAReasignar(sbCICLCICO ,
																														sbOPERATING_UNIT_ID,
																														sbTASK_TYPE_ID,
																														sbASSIGNED_DATE,
																														sbEXECUTION_FINAL_DATE,
																														sbPEFACODI,
																														rfCursor);

		-- recorre las ordenes y ejecuta el API de reasignacion de ordenes
		Loop Fetch  rfCursor Into order_id, ASSIGN_DATE;

		    if (rfCursor%ROWCOUNT = 0) then
						  onuErrorCode := -1;
						  osbErrorMess := 'La consulta no arrojo registros.';
								raise excep_PROREASIGNAORDENES;
		    end if;--if (rfCursor%ROWCOUNT = 0) then

						EXIT WHEN rfCursor%notfound;
	     --ejecucion del API de reasignacion de ordenes
						proReasignaOrdenes(order_id,
																									to_number(sbNEWOPERATING_UNIT_ID),
																									onuErrorCode,
																									osbErrorMess);



						-- condifirma la operacion
						if (onuErrorCode <> 0)	 then
								raise excep_PROREASIGNAORDENES;
						end if;--	if (onuErrorCode = 0)	 then
	END LOOP; -- Loop Fetch  rfCursor Into order_id, ASSIGN_DATE;

	-- envia la informacion al sistema SIGELETC
 ENVIARCONFIRMACION(sbOPERATING_UNIT_ID,
																				sbCICLCICO,
																				sbPEFACODI,
																				sbTASK_TYPE_ID,
																				sbNEWOPERATING_UNIT_ID,
																				onuErrorCode,
																			 osbErrorMess);

	-- condifirma la operacion
 if (onuErrorCode = 0)	 then
	  commit;
	else
			raise excep_ENVIARCONFIRMACION;
 end if;--	if (onuErrorCode = 0)	 then


	ut_trace.trace('Finaliza LDCI_PKREASIGNAORDEN.PROREASIGNAORDENES',15);
EXCEPTION
    when excep_PROREASIGNAORDENES then
        Errors.seterror(-1, 'Excepción Smartflex en la reasignación de las ordenes : ' || chr(13) || onuErrorCode || ' - ' || osbErrorMess);
        raise ex.CONTROLLED_ERROR;

    when excep_ENVIARCONFIRMACION then
        Errors.seterror(-1, 'Excepción sistema externo: ' || chr(13) || onuErrorCode || ' - ' || osbErrorMess);
        raise ex.CONTROLLED_ERROR;

    when ex.CONTROLLED_ERROR then
				    rollback;
        raise;

    when OTHERS then
				    rollback;
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END PROCESO;

END LDCI_PKREASIGNAORDEN;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKREASIGNAORDEN
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKREASIGNAORDEN','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKREASIGNAORDEN to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKREASIGNAORDEN to INTEGRADESA;
/
