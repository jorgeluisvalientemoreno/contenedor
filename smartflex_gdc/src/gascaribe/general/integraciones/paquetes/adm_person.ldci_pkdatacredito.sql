CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKDATACREDITO AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKDATACREDITO
   AUTOR         : OLSoftware / Mauricio Fernando Ortiz
   FECHA         : 17/04/2013
   REQUERIMIENTO : PETI-SMARTFLEX
   DESCRIPCION: Paquete que tiene el procedimiento para realizar consultas al sistema datacredito.

  Historia de Modificaciones
  Autor   Fecha      Descripcion.
*/
  PROCEDURE PROCONSULTADATACREDITO(ISBTIIDENT                     IN     VARCHAR2,
                                                                           ISBIDENTIFICACION      IN     VARCHAR2,
                                                                           ISBAPELLIDO                  IN     VARCHAR2,
                                                                           OSBRESPUESTA             OUT  CLOB,
                                                                           onuErrorCode               OUT  GE_ERROR_LOG.ERROR_LOG_ID%type,
                                                                           osbErrorMessage        OUT  GE_ERROR_LOG.DESCRIPTION%type);
FUNCTION fnuValidaSoapFault(iClResponse IN CLOB) RETURN NUMBER;

END LDCI_PKDATACREDITO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKDATACREDITO AS

/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : fnuValidaSoapFault
                  AUTOR : Hector Fabio Dominguez
                   FECHA : 02/010/2013

 DESCRIPCION : Procedimiento validar si es un mensaje de error.

 Parametros de Entrada

    iClResponse                IN  CLOB

 Parametros de Salida

    nuValida           OUT NUMBER


 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
FUNCTION fnuValidaSoapFault(iClResponse IN CLOB) RETURN NUMBER  IS

nuValida number;
BEGIN

    SELECT INSTR(iClResponse,'<faultcode>') INTO nuValida FROM DUAL;

    IF nuValida <>0 THEN
      nuValida:=1;
    END IF;
    RETURN nuValida;
    EXCEPTION
    WHEN OTHERS THEN
    nuValida:=1;
END fnuValidaSoapFault ;

/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : PROCONSULTADATACREDITO
                  AUTOR : MAURICIO FERNANDO ORTIZ
                   FECHA : 17/04/2013

 DESCRIPCION : Procedimiento para consultar historia de datacredito

 Parametros de Entrada

    ISBTIIDENT                IN  VARCHAR2
    ISBIDENTIFICACION  IN  VARCHAR2
    ISBAPELLIDO              IN  VARCHAR2


 Parametros de Salida

    OSBRESPUESTA         OUT CLOB
    onuErrorCode           OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
  PROCEDURE PROCONSULTADATACREDITO(ISBTIIDENT                     IN     VARCHAR2,
                                                                           ISBIDENTIFICACION      IN     VARCHAR2,
                                                                           ISBAPELLIDO                  IN     VARCHAR2,
                                                                           OSBRESPUESTA             OUT  CLOB,
                                                                           onuErrorCode               OUT  GE_ERROR_LOG.ERROR_LOG_ID%type,
                                                                           osbErrorMessage        OUT  GE_ERROR_LOG.DESCRIPTION%type) AS

    sbNameSpace  LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS            LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti        LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi       LDCI_CARASEWE.CASEVALO%type;
    sbProtocol        LDCI_CARASEWE.CASEVALO%type;
    sbHost              LDCI_CARASEWE.CASEVALO%type;
    sbPuerto           LDCI_CARASEWE.CASEVALO%type;


   --Variables mensajes SOAP
   L_Payload     clob;


   qryCtx        DBMS_XMLGEN.ctxHandle;

   errorPara01	                    EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada
   Excepnoprocesoregi	    EXCEPTION; 	-- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP	  EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP
Begin
     LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'NAMESPACE', sbNameSpace, osbErrorMessage);
    if(osbErrorMessage != '0') then
         RAISE errorPara01;
    end if;--if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'WSURL', sbUrlWS, osbErrorMessage);
    if(osbErrorMessage != '0') then
         RAISE errorPara01;
    end if;--if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'SOAPACTION', sbSoapActi, osbErrorMessage);
    if(osbErrorMessage != '0') then
         RAISE errorPara01;
    end if;--if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'PROTOCOLO', sbProtocol, osbErrorMessage);
    if(osbErrorMessage != '0') then
         RAISE errorPara01;
    end if;--if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'PUERTO', sbPuerto, osbErrorMessage);
    if(osbErrorMessage != '0') then
         RAISE errorPara01;
    end if;--if(sbMens != '0') then
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_DATACREDITO', 'HOST', sbHost, osbErrorMessage);
    if(osbErrorMessage != '0') then
         Raise Errorpara01;
    end if;

    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;
    sbUrlDesti := trim(sbUrlDesti);

    L_Payload := '<tipoDoc>' || ISBTIIDENT || '</tipoDoc>
         <numDoc>' || ISBIDENTIFICACION || '</numDoc>
         <priApell>' || ISBAPELLIDO ||'</priApell>';

    L_Payload := '<urn:CnsltaHistoriaCreditoRequest>' || L_Payload || '</urn:CnsltaHistoriaCreditoRequest>';
    L_Payload := Trim(L_Payload);


    --Hace el consumo del servicio Web
     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);
     OSBRESPUESTA := LDCI_PKSOAPAPI.fsbSoapSegmentedCallSync(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

      /*
       * Validamos si existe un problema SOAP FAULT para capturar la excepcion
       */
       IF fnuValidaSoapFault(OSBRESPUESTA)=1 or LDCI_PKSOAPAPI.boolHttpError THEN
           OSBRESPUESTA:=' <?xml version="1.0"?>
                                    <SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
                                      <SOAP:Header/>
                                      <SOAP:Body>
                                        <ns1:CnsltaHistoriaCreditoResponse xmlns:ns1="urn:gaseras.com:srvemp:base">
                                          <consulta>
                                            <feConsulta>1380750972552</feConsulta>
                                            <respuesta>99</respuesta>
                                            <version>1.1</version>
                                          </consulta>
                                        </ns1:CnsltaHistoriaCreditoResponse>
                                      </SOAP:Body>
                                    </SOAP:Envelope>';

       END IF;

    --Valida el proceso de peticion SOAP.
     If (LDCI_PKSOAPAPI.Boolsoaperror) Then
        Raise Excepnoprocesosoap;
     end if;

    onuErrorCode := 0;

Exception
  When Errorpara01 then
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR PARAMETROS: <Consulta Datacredito>: ' || Dbms_Utility.Format_Error_Backtrace;
   -- Dbms_Output.Put_Line(osbErrorMessage);
  WHEN excepNoProcesoRegi THEN
      onuErrorCode := -1;
        --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkReservaMateriales.proEnviaReservaSAP>: La consulta no ha arrojo registros');
        osbErrorMessage := 'ERROR: <Consulta Datacredito>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
      --  Dbms_Output.Put_Line(osbErrorMessage);

  	WHEN excepNoProcesoSOAP THEN
      onuErrorCode := -1;
        --DBMS_OUTPUT.PUT_LINE('ERROR: <ldc_pkPedidoVentaMaterial.proEnviaPedidoSAP>: La consulta no ha arrojo registros');
        osbErrorMessage := 'ERROR: <Consulta Datacredito>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
        -- Dbms_Output.Put_Line(osbErrorMessage);
  WHEN OTHERS THEN
     onuErrorCode := -1;
      osbErrorMessage := 'ERROR: <Consulta Datacredito>: ' || Dbms_Utility.Format_Error_Backtrace;
      --   Dbms_Output.Put_Line(osbErrorMessage);
  END PROCONSULTADATACREDITO;

END LDCI_PKDATACREDITO;
/

PROMPT Asignación de permisos para el paquete LDCI_PKDATACREDITO
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKDATACREDITO', 'ADM_PERSON');
end;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKDATACREDITO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKDATACREDITO to INTEGRADESA;
/
