CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI AS
/*
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
   PAQUETE       : LDCI_PKFACTELECTRONICA_EMI
   AUTOR         : Jose Donado
   FECHA         : 03/09/2020
   GLPI     : 458
   DESCRIPCION: Paquete que tiene la logica del proceso de emisi?n de facturaci?n electr?nica

  Historia de Modificaciones
  Autor   Fecha      Descripcion.
  JOSDON  11/12/2023 INT-404: Creacion de procedimiento PROSELFACTESOLARENVIAR para seleccion de facturacion electronica de energia solar a enviar
                              Creacion de procedimiento PROENVIAENERGIASOLAR para envio de facturacion electronica de energia solar
  Jpinedc 04/06/2025 OSF-4290: Creacion funciones fsbObtOficinaVentaSAP , fsbObtClasePedidoSAP y fsbObtCentroSAP
*/
  PROCEDURE PROSELECCIONACACTASENVIAR;
  PROCEDURE PROSELFACTESOLARENVIAR;
  PROCEDURE PROENVIACOMISIONBRILLA(inuActaId IN GE_ACTA.ID_ACTA%TYPE,onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROENVIANOTACRBRILLA(inuActaId IN GE_ACTA.ID_ACTA%TYPE,onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROENVIAENERGIASOLAR(inuSucripc IN NUMBER, inuConsFact IN NUMBER, icbXMLFac IN CLOB, ocbResponse OUT CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT CLOB);
  PROCEDURE PROREGISTRAENVIO(inuActaId IN GE_ACTA.ID_ACTA%TYPE, iclXML IN CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2);
  PROCEDURE PROREGISTRAENVIONC(inuActaId IN GE_ACTA.ID_ACTA%TYPE, iclXML IN CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2);
  FUNCTION fnuValidaSoapFault(iClResponse IN CLOB) RETURN NUMBER;
  --Obtiene la oficina de venta SAP asociada a la empresa
  FUNCTION fsbObtOficinaVentaSAP( isbEmpresa empresa.codigo%type)
  RETURN VARCHAR2;
  --Obtiene la clase de pedido SAP asociado a la empresa y el proceso
  FUNCTION fsbObtClasePedidoSAP(isbEmpresa empresa.codigo%type, isbProceso VARCHAR2) 
  RETURN VARCHAR2;
  --Obtiene el centro SAP asociado a la empresa
  FUNCTION fsbObtCentroSAP(isbEmpresa empresa.codigo%type) 
  RETURN VARCHAR2;
END LDCI_PKFACTELECTRONICA_EMI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : fnuValidaSoapFault
                  AUTOR : Jose Donado
                   FECHA : 03/09/2020

 DESCRIPCION : Procedimiento validar si es un mensaje de error.

 Parametros de Entrada

    iClResponse                IN  CLOB

 Parametros de Salida

    nuValida           OUT NUMBER


 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 EDMLAR     19/04/2021    Se modifica los procedimientos
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
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 FUNCION : IsXML
           AUTOR : Jose Donado
           FECHA : 12/12/2023

 DESCRIPCION : Funcion que permite verificar si la estructura de un CLOB corresponde a un XML valido

 Parametros de Entrada
 inXML:  CLOB a validar estructura de XML

 Salida
 0: Estructura valida de XML
 1: Estructura no corresponde a XML valido

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
FUNCTION  IsXML(inXML CLOB) RETURN BOOLEAN AS
  xmldata XMLTYPE;

  BEGIN
    xmldata := XMLTYPE(inXML);
    return TRUE;
  Exception
    WHEN OTHERS THEN
      RETURN FALSE;
END IsXML;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROSELECCIONACACTASENVIAR
                  AUTOR : Jose Donado
                   FECHA : 04/09/2020

 DESCRIPCION : Procedimiento para seleccionar las actas de comisiones de Brilla para enviar a facturacion electronica

 Parametros de Entrada

 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/

 PROCEDURE PROSELECCIONACACTASENVIAR IS
  --Define variables
  nuTrsmCodi NUMBER;
  nuTrsmDocu NUMBER;
  sbErrMens  VARCHAR2(2000);
  sbEstado   VARCHAR2(1) := 'C';--ESTADO CERRADA
  nuTipoAct  GE_ACTA.ID_TIPO_ACTA%TYPE := 2;-- TIPO DE ACTA DE FACTURACI??N
  sbFechaInicio LDCI_CARASEWE.CASEVALO%TYPE;

  nuError       NUMBER;
  sbError       VARCHAR2(4000);
  sbMens        varchar2(4000);

  errorPara01  EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada

 -- cursor de actas de comisiones brilla cerradas pendientes por enviar
  cursor cuLDCI_ACTAS_PEND(isbEstado IN VARCHAR2, inuTipoAct IN NUMBER,isbFechaInicio IN VARCHAR2) is
    SELECT A.*, (select sum(da.valor_total)
                   from ge_detalle_acta da
                         ,ge_items gi
                   WHERE da.id_acta = A.ID_ACTA
                     AND da.id_items = gi.items_id
                     AND gi.item_classif_id <> 23
                     and da.valor_total < 0) NOTA_CR
      FROM ge_acta A
     WHERE A.ID_TIPO_ACTA = inuTipoAct
       AND A.FECHA_CIERRE >= TO_DATE(isbFechaInicio,'DD/MM/YYYY')--'10/05/2020'
       AND A.ESTADO = isbEstado
       AND A.NUMERO_FISCAL IS NOT NULL
       --  and A.ID_ACTA = 84265
       AND A.ID_ACTA NOT IN(SELECT FA.FACEAEIDACTA FROM LDCI_FACTEACTASENV FA
                             where fa.faceaeidacta = A.ID_ACTA);


 BEGIN

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_FE_INICIO', sbFechaInicio, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    for reLDCI_ACTAS_PEND in cuLDCI_ACTAS_PEND(sbEstado,nuTipoAct,sbFechaInicio) loop
        -- Factura comision.
        LDCI_PKFACTELECTRONICA_EMI.PROENVIACOMISIONBRILLA(reLDCI_ACTAS_PEND.Id_Acta,nuError,sbError);
        if (nuError = 0)   then
          -- Nota Credito
          If nvl(reLDCI_ACTAS_PEND.Nota_CR, 0) < 0 then
             LDCI_PKFACTELECTRONICA_EMI.PROENVIANOTACRBRILLA(reLDCI_ACTAS_PEND.Id_Acta,nuError,sbError);
          end if;

          if (nuError = 0)   then
           commit;
          else
            rollback;
          end if;
        else
            rollback;
        end if;

    end loop;

 EXCEPTION
    WHEN Errorpara01 THEN
        ROLLBACK;
        ldci_pkWebServUtils.Procrearerrorlogint('PROSELECCIONACACTASENVIAR', '2', 'ERROR DE PARAMETRIZACION <LDCI_PKFACTELECTRONICA_EMI.PROSELECCIONACACTASENVIAR>: ' || Dbms_Utility.Format_Error_Backtrace, null);
    WHEN OTHERS THEN
        ROLLBACK;
        ldci_pkWebServUtils.Procrearerrorlogint('PROSELECCIONACACTASENVIAR', '2', 'ERROR no controlado <LDCI_PKFACTELECTRONICA_EMI.PROSELECCIONACACTASENVIAR>: ' || SQLERRM, null);
 END PROSELECCIONACACTASENVIAR;


 /*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROSELFACTESOLARENVIAR
                  AUTOR : Jose Donado
                  FECHA : 14/12/2023

 DESCRIPCION : Procedimiento para seleccionar los documentos de energia solar para enviar a facturacion electronica

 Parametros de Entrada

 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/

 PROCEDURE PROSELFACTESOLARENVIAR IS
  --Define variables
  sbErrMens     VARCHAR2(2000);
  sbEstados     LDCI_CARASEWE.CASEVALO%TYPE;--ESTADOS DE REENVIO
  nuMaxInt      LDCI_CARASEWE.CASEVALO%TYPE;-- NUMERO MAXIMO DE REINTENTOS
  sbEstExito    LDCI_CARASEWE.CASEVALO%TYPE;-- ESTADOS EXITO DIAN
  sbEstFalla    LDCI_CARASEWE.CASEVALO%TYPE;-- ESTADOS FALLA DIAN
  sbResMainTag  LDCI_CARASEWE.CASEVALO%TYPE;-- TAG PRINCIPAL DE RESPUESTA
  sbIntermit    LDCI_CARASEWE.CASEVALO%TYPE;-- TEXTO INTERMITENCIA DIAN
  blExito       NUMBER;
  cuFacturas    SYS_REFCURSOR;
  nuContrato    NUMBER(15);
  nuConsecut    NUMBER(15);
  nuFactura     NUMBER(15);
  nuEstado      NUMBER(1);
  nuIntento     NUMBER(4);
  dtFechaReg    DATE;
  dtFechaEnv    DATE;
  dtFechaRes    DATE;
  cbFactura     CLOB;
  cbRespuesta   CLOB;
  sbMensaje     CLOB;

  nuError       NUMBER;
  sbError       VARCHAR2(4000);
  clError       CLOB;
  sbMens        varchar2(4000);

  nuEstadoProceso	NUMBER;
  nuDescProceso   VARCHAR2(4000);
  cbListaMensaje  CLOB;

  errorPara01  EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada
  errorQuery   EXCEPTION;        -- Excepcion que maneja los errores en el proceso de consulta de facturas pendientes por env?o

  CURSOR cuValidaExito(inuEstado NUMBER, isbListaEstados LDCI_CARASEWE.CASEVALO%TYPE) IS
    SELECT 1
    FROM DUAL
    WHERE inuEstado IN(select regexp_substr(isbListaEstados,'[^,]+', 1, level)
    from dual
    connect by regexp_substr(isbListaEstados, '[^,]+', 1, level) is not null);


 BEGIN

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'ESTADOS_ENVIO', sbEstados, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'MAX_INTENTOS', nuMaxInt, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'CODIGOS_EXITO_DIAN', sbEstExito, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'CODIGOS_FALLA_DIAN', sbEstFalla, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'TEXTO_INTERMITENCIA_DIAN', sbIntermit, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    --se buscan las facturas pendientes por envio o en estado de reenvio
    cuFacturas := PKG_FACTURA_ELECTRONICA.frcGetInfoFactElec(-1,sbEstados,nuMaxInt,nuError,sbError);
    if(nuError != '0') then
         RAISE errorQuery;
    end if;

    LOOP
      blExito := 0;
      nuEstadoProceso := 0;
      nuDescProceso := '';
      cbListaMensaje := '';

      FETCH cuFacturas INTO nuContrato,nuConsecut,nuFactura,nuEstado,nuIntento,dtFechaReg,dtFechaEnv,dtFechaRes,cbFactura,cbRespuesta,sbMensaje;
      EXIT WHEN cuFacturas%NOTFOUND;

      dtFechaEnv := SYSDATE;

      PROENVIAENERGIASOLAR(nuContrato,nuConsecut,cbFactura,cbRespuesta,nuError,clError);

      nuIntento := nuIntento + 1;
      dtFechaRes := SYSDATE;
      sbMensaje := clError;

      --Se verifica si ocurrio error tecnico en el servicio, para marcar el mensaje con estado de reintento
      IF (nuError < 0) THEN
        nuEstado := 2;--error en envio de mensaje
        PKG_FACTURA_ELECTRONICA.prActualizaFactElec(nuConsecut,nuContrato,dtFechaEnv,dtFechaRes,cbFactura,cbRespuesta,clError,nuIntento, nuEstado, nuError, sbError);

        IF (nuError = 0) THEN
          COMMIT;
        ELSE
	        ROLLBACK;
        END IF;
        CONTINUE;
      END IF;

      --procesa XML de respuesta recibida por el PT
      BEGIN

        SELECT RESPCONSULTAFACRECEP.*
        INTO nuEstadoProceso, nuDescProceso, cbListaMensaje
        FROM xmltable(xmlnamespaces(
                                 'http://wsenviardocumento.webservice.dispapeles.com/' as "ns1"
                              ),  --XPath to specific node
                        '//ns1:enviarDocumentoResponse/return'   passing
                         XMLType(cbRespuesta)
                         columns
                              IDERROR          NUMBER          PATH 'estadoProceso',
                              SBRESPUESTA      VARCHAR2(4000)  PATH 'descripcionProceso',
                              CBLISTAMENSAJE   CLOB            PATH 'listaMensajesProceso'
                        ) RESPCONSULTAFACRECEP;

        OPEN cuValidaExito(nuEstadoProceso,sbEstExito);
        FETCH cuValidaExito INTO blExito;
        CLOSE cuValidaExito;

        IF (blExito = 1) THEN
          nuEstado := 6;--exito
        ELSE
          nuEstado := 4;--rechazado por PT o DIAN
          IF (INSTR(UPPER(nuDescProceso),UPPER(sbIntermit)) > 0) THEN
            nuEstado := 2;--Intermitencia de la DIAN
          END IF;
        END IF;

        nuDescProceso := nuDescProceso || cbListaMensaje;

      EXCEPTION
          WHEN OTHERS THEN
            ldci_pkWebServUtils.Procrearerrorlogint('PROSELFACTESOLARENVIAR', '2', 'Error procesando XML de respuesta: ' || SQLERRM, null);
            nuEstado := 2;--falla en procesamiento de XML
            nuDescProceso := 'Error procesando XML de respuesta: ' || SQLERRM;
      END;

      PKG_FACTURA_ELECTRONICA.prActualizaFactElec(nuConsecut,nuContrato,dtFechaEnv,dtFechaRes,cbFactura,cbRespuesta,nuDescProceso,nuIntento,nuEstado,nuError,sbError);
      IF (nuError = 0) THEN
        COMMIT;
      ELSE
        ROLLBACK;
      END IF;

    END LOOP;

 EXCEPTION
    WHEN Errorpara01 THEN
        ldci_pkWebServUtils.Procrearerrorlogint('PROSELFACTESOLARENVIAR', '2', 'ERROR DE PARAMETRIZACION <LDCI_PKFACTELECTRONICA_EMI.PROSELFACTESOLARENVIAR>: ' || sbMens, null);
    WHEN errorQuery THEN
        ldci_pkWebServUtils.Procrearerrorlogint('PROSELFACTESOLARENVIAR', '2', 'ERROR EN PKG_FACTURA_ELECTRONICA.frcGetInfoFactElec <LDCI_PKFACTELECTRONICA_EMI.PROSELFACTESOLARENVIAR>: ' || sbError, null);
    WHEN OTHERS THEN
        ROLLBACK;
        ldci_pkWebServUtils.Procrearerrorlogint('PROSELFACTESOLARENVIAR', '2', 'ERROR no controlado <LDCI_PKFACTELECTRONICA_EMI.PROSELFACTESOLARENVIAR>: ' || SQLERRM, null);
 END PROSELFACTESOLARENVIAR;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROENVIACOMISIONBRILLA
                  AUTOR : Jose Donado
                   FECHA : 03/09/2020

 DESCRIPCION : Procedimiento para enviar las comisiones de Brilla para facturacion electronica

 Parametros de Entrada

 Parametros de Salida

    onuErrorCode       OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

Autor       Fecha       Descripcion.
Jpinedc     04/06/2025  OSF-4290: Se usan pkg_empresa.fsbObtOrganizacionVenta,fsbObtOficinaVentaSAP,fsbObtClasePedidoSAP y fsbObtCentroSAP
*/
PROCEDURE PROENVIACOMISIONBRILLA(inuActaId IN GE_ACTA.ID_ACTA%TYPE, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2) AS

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROENVIACOMISIONBRILLA';
    nuError     NUMBER;
    sbError     VARCHAR2(4000);
    
    --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
    sbProtocol     LDCI_CARASEWE.CASEVALO%type;
    sbHost         LDCI_CARASEWE.CASEVALO%type;
    sbPuerto       LDCI_CARASEWE.CASEVALO%type;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    nuCodMaterial  LDCI_CARASEWE.CASEVALO%type;
    nuCodCentro    LDCI_CARASEWE.CASEVALO%type;
    sbMens        varchar2(4000);

    --Parametros de logica de negocio para generar los pedidos
    sbClasPed    LDCI_CARASEWE.CASEVALO%type;
    sbSociedad   LDCI_CARASEWE.CASEVALO%type;
    sbOrgVent    LDCI_CARASEWE.CASEVALO%type;
    sbCanal      LDCI_CARASEWE.CASEVALO%type;
    sbSector     LDCI_CARASEWE.CASEVALO%type;
	sbOfiVent    LDCI_CARASEWE.CASEVALO%type;
    sbGrVen      LDCI_CARASEWE.CASEVALO%type;
    sbMotivo     LDCI_CARASEWE.CASEVALO%type;
    sbEmpresa LDCI_CARASEWE.CASEVALO%type;

    --Variables mensajes SOAP
    l_payload     CLOB;
    l_response    CLOB;
    qryCtx        DBMS_XMLGEN.ctxHandle;
    rfMensaje     Constants.tyRefCursor;

    errorPara01  EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada
    excepNoProcesoRegi  EXCEPTION;   -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP  EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP

    nuContrato  ge_contrato.id_contrato%TYPE;

Begin

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
    onuErrorCode := 0;
    nuContrato      :=  pkg_ge_Acta.fnuObtID_CONTRATO( inuActaId );
    
    pkg_traza.trace('nuContrato|' || nuContrato , csbNivelTraza );
        
    sbEmpresa    :=  pkg_BOConsultaEmpresa.fsbObtEmpresaGe_Contrato( nuContrato );

    pkg_traza.trace('sbEmpresa|' || sbEmpresa , csbNivelTraza );
    
    sbClasPed   := fsbObtClasePedidoSAP( sbEmpresa, 'COMISION' );

    pkg_traza.trace('sbClasPed|' || sbClasPed , csbNivelTraza );
    
	sbOrgVent := pkg_empresa.fsbObtOrganizacionVenta( sbEmpresa );

    pkg_traza.trace('sbOrgVent|' || sbOrgVent , csbNivelTraza );
    
    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CANAL_DIST', sbCanal, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_SECTOR', sbSector, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    sbOfiVent := fsbObtOficinaVentaSAP( sbEmpresa );

    pkg_traza.trace('sbOfiVent|' || sbOfiVent , csbNivelTraza );
    
    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_GRU_VENDEDOR', sbGrVen, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_SOCIEDAD', sbSociedad, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_MOTIVO_PEDIDO', sbMotivo, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_COD_MAT', nuCodMaterial, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    nuCodCentro := fsbObtCentroSAP(sbEmpresa);

    --PAR?METROS DE CONEXION HACIA EL SERVICIO
    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'NAMESPACE', sbNameSpace, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SOAPACTION', sbSoapActi, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'PROTOCOLO', sbProtocol, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'INPUT_MESSAGE_TYPE', sbInputMsgType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    --arma la URL del servicio donde se enviar? la interfaz
    sbUrlDesti := lower(sbProtocol) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    sbUrlDesti := trim(sbUrlDesti);

    --Cursor para obtener los datos de las comisiones de Brilla
  open rfMensaje for
            select  sbClasPed as "ClasPed",
                    sbOrgVent as "OrgVent",
                    sbCanal as "Canal",
                    sbSector as "Sector",
                    sbOfiVent as "OfiVenta",
                    sbGrVen as "GrVen",
                    (SELECT  cl.identification nit
                    FROM  ge_acta ga,ge_contrato co,ge_contratista oc,ge_subscriber cl
                    WHERE ga.id_acta = inuActaId
                    AND ga.id_contrato = co.id_contrato
                    AND co.id_contratista = oc.id_contratista
                    AND oc.subscriber_id = cl.subscriber_id)  as "Cliente",
                    sbEmpresa || '-' || inuActaId as "PedCli",
                    sbMotivo as "Motivo",
                    cursor (SELECT
                              --<< CA-680
                              --nuCodMaterial "Material"
                              (SELECT IA.ITMAIDSAP
                                 FROM LDCI_ITEMACTA IA
                                WHERE IA.ITMAIDACT = da.id_items)  "Material"
                              -->>
                             ,da.cantidad "Cantidad"
                             ,nuCodCentro "Centro" --
                             ,sum(nvl(da.valor_total,0)) "Importe"
                             ,Decode((SELECT IA.ITMADESCR || '-' || substr(lo.description, 1,19)
                                     FROM LDCI_ITEMACTA IA
                                     WHERE IA.ITMAIDACT = da.id_items),
                                     NULL,
                                     to_char(da.id_items) || '-' || substr(lo.description, 1,19),
                                      (SELECT IA.ITMADESCR || '-' || substr(lo.description, 1,19)
                                       FROM LDCI_ITEMACTA IA
                                       WHERE IA.ITMAIDACT = da.id_items))"Denom"
                             ,Decode((select cb.celocebe
                                       from ldci_centbenelocal cb
                                       where cb.celoloca = lo.geograp_location_id),
                                     NULL,
                                     to_char(nuCodCentro),
                                     (select cb.celocebe
                                     from ldci_centbenelocal cb
                                     where cb.celoloca = lo.geograp_location_id)) "CenBen"
                    FROM ge_detalle_acta da
                        ,ge_items gi
                        ,or_order ot
                        ,ge_geogra_location lo
                    WHERE da.id_acta = inuActaId
                       AND gi.item_classif_id <> 23
                       AND da.id_items = gi.items_id
                       AND da.id_orden = ot.order_id
                       AND lo.geograp_location_id(+) = da.geograp_location_id
                       AND nvl(da.valor_total,0) > 0 -- Cobro Comision
                       AND EXISTS(SELECT 'X' FROM GE_ACTA A
                             WHERE A.ID_ACTA = da.ID_ACTA
                             AND A.ID_TIPO_ACTA = 2)
                     GROUP BY da.id_items, lo.description, da.cantidad, lo.geograp_location_id
                     ORDER By da.id_items) as "Detalles"
            from DUAL;

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


    ldci_pksoapapi.proSetProtocol(sbProtocol);

    --Hace el consumo del servicio Web
    l_response := ldci_pksoapapi.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    --Valida el proceso de peticion SOAP
    if (ldci_pksoapapi.boolSoapError OR ldci_pksoapapi.boolHttpError) then

      ldci_pkWebServUtils.Procrearerrorlogint('WS_FACELEC_EMI_COMIBRILLA',
                                               2,
                                               'Error enviando acta de comision de Brilla: ' || ldci_pksoapapi.sbMensaje,
                                               l_payload,
                                               NULL);

        RAISE excepNoProcesoSOAP;
    end if;

   LDCI_PKFACTELECTRONICA_EMI.PROREGISTRAENVIO(inuActaId,l_payload,onuErrorCode,osbErrorMessage);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
Exception
  When Errorpara01 then
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR PARAMETROS: <Emision Fact Electronica - PROENVIACOMISIONBRILLA>: ' || Dbms_Utility.Format_Error_Backtrace;
  When pkg_Error.CONTROLLED_ERROR then
    onuErrorCode := -1;
    pkg_Error.getError(nuError, sbError );
    osbErrorMessage := 'ERROR PARAMETROS: <Emision Fact Electronica - PROENVIACOMISIONBRILLA>: ' || sbError;
  WHEN excepNoProcesoRegi THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR- excepNoProcesoRegi: <Emision Fact Electronica - PROENVIACOMISIONBRILLA>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
  WHEN excepNoProcesoSOAP THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR - excepNoProcesoSOAP: <Emision Fact Electronica - PROENVIACOMISIONBRILLA>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Emision Fact Electronica - PROENVIACOMISIONBRILLA>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
  END PROENVIACOMISIONBRILLA;

/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROENVIANOTACRBRILLA
                 AUTOR : Jose Donado
                 FECHA : 26/09/2020

 DESCRIPCION : Procedimiento para enviar las notas credito de Brilla para facturacion electronica

 Parametros de Entrada

 Parametros de Salida

    onuErrorCode       OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

Autor       Fecha       Descripcion.
Jpinedc     04/06/2025  OSF-4290: Se usan pkg_empresa.fsbObtOrganizacionVenta,fsbObtOficinaVentaSAP,fsbObtClasePedidoSAP y fsbObtCentroSAP
*/
  PROCEDURE PROENVIANOTACRBRILLA(inuActaId IN GE_ACTA.ID_ACTA%TYPE, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2) AS

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROENVIANOTACRBRILLA';
    nuError         NUMBER;
    sbError         VARCHAR2(4000); 
        
    --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
    sbProtocol     LDCI_CARASEWE.CASEVALO%type;
    sbHost         LDCI_CARASEWE.CASEVALO%type;
    sbPuerto       LDCI_CARASEWE.CASEVALO%type;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    nuCodMaterial  LDCI_CARASEWE.CASEVALO%type;
    nuCodCentro    LDCI_CARASEWE.CASEVALO%type;
    sbMens         varchar2(4000);

    --Parametros de logica de negocio para generar los pedidos
    sbClasPed      LDCI_CARASEWE.CASEVALO%type;
    sbSociedad     LDCI_CARASEWE.CASEVALO%type;
    sbOrgVent      LDCI_CARASEWE.CASEVALO%type;
    sbCanal        LDCI_CARASEWE.CASEVALO%type;
    sbSector       LDCI_CARASEWE.CASEVALO%type;
    sbOfiVent        LDCI_CARASEWE.CASEVALO%type;
    sbGrVen        LDCI_CARASEWE.CASEVALO%type;
    sbMotivo       LDCI_CARASEWE.CASEVALO%type;
    sbEmpresa       LDCI_CARASEWE.CASEVALO%type;

   --Variables mensajes SOAP
   l_payload       CLOB;
   l_response      CLOB;
   qryCtx          DBMS_XMLGEN.ctxHandle;
   rfMensaje       Constants.tyRefCursor;

   errorPara01         EXCEPTION;   -- Excepcion que verifica que ingresen los parametros de entrada
   excepNoProcesoRegi  EXCEPTION;   -- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP  EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP

    nuContrato  ge_contrato.id_contrato%TYPE;
    nuError     NUMBER;
    sbError     VARCHAR2(4000);

Begin

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
    onuErrorCode := 0;

    nuContrato      :=  pkg_ge_Acta.fnuObtID_CONTRATO( inuActaId );
        
    sbEmpresa    :=  pkg_BOConsultaEmpresa.fsbObtEmpresaGe_Contrato( nuContrato );
    
    sbClasPed    := fsbObtClasePedidoSAP( sbEmpresa, 'NOTA' );

	sbOrgVent := pkg_empresa.fsbObtOrganizacionVenta( sbEmpresa );

    pkg_traza.trace('sbOrgVent|' || sbOrgVent , csbNivelTraza );
    
  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CANAL_DIST', sbCanal, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_SECTOR', sbSector, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    sbOfiVent := fsbObtOficinaVentaSAP( sbEmpresa );
    

  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_GRU_VENDEDOR', sbGrVen, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_SOCIEDAD', sbSociedad, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_MOTIVO_PEDIDO', sbMotivo, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_COD_MAT', nuCodMaterial, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    nuCodCentro := fsbObtCentroSAP(sbEmpresa);

    --PAR?METROS DE CONEXION HACIA EL SERVICIO
  ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'NAMESPACE', sbNameSpace, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SOAPACTION', sbSoapActi, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'PROTOCOLO', sbProtocol, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'INPUT_MESSAGE_TYPE', sbInputMsgType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    --arma la URL del servicio donde se enviar? la interfaz
    sbUrlDesti := lower(sbProtocol) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    sbUrlDesti := trim(sbUrlDesti);

    --Cursor para obtener los datos de las comisiones de Brilla
  open rfMensaje for
            select  sbClasPed as "ClasPed",
                    sbOrgVent as "OrgVent",
                    sbCanal as "Canal",
                    sbSector as "Sector",
                    sbOfiVent as "OfiVenta",
                    sbGrVen as "GrVen",
                    (SELECT  cl.identification nit
                    FROM  ge_acta ga,ge_contrato co,ge_contratista oc,ge_subscriber cl
                    WHERE ga.id_acta = inuActaId
                    AND ga.id_contrato = co.id_contrato
                    AND co.id_contratista = oc.id_contratista
                    AND oc.subscriber_id = cl.subscriber_id)  as "Cliente",
                    sbEmpresa || '-' || inuActaId as "PedCli",
                    sbMotivo as "Motivo",
                    cursor (SELECT
                              --<< CA-680
                              --nuCodMaterial "Material"
                              (SELECT IA.ITMAIDSAP
                                 FROM LDCI_ITEMACTA IA
                                WHERE IA.ITMAIDACT = da.id_items)  "Material"
                              -->>
                             ,da.cantidad "Cantidad"
                             ,nuCodCentro "Centro" --
                             ,abs(sum(nvl(da.valor_total,0))) "Importe"
                             ,Decode((SELECT IA.ITMADESCR || '-' || substr(lo.description, 1,19)
                                     FROM LDCI_ITEMACTA IA
                                     WHERE IA.ITMAIDACT = da.id_items),
                                     NULL,
                                     to_char(da.id_items) || '-' || substr(lo.description, 1,19),
                                      (SELECT IA.ITMADESCR || '-' || substr(lo.description, 1,19)
                                       FROM LDCI_ITEMACTA IA
                                       WHERE IA.ITMAIDACT = da.id_items))"Denom"
                             ,Decode((select cb.celocebe
                                       from ldci_centbenelocal cb
                                       where cb.celoloca = lo.geograp_location_id),
                                     NULL,
                                     to_char(nuCodCentro),
                                     (select cb.celocebe
                                     from ldci_centbenelocal cb
                                     where cb.celoloca = lo.geograp_location_id)) "CenBen"
                    FROM ge_detalle_acta da
                        ,ge_items gi
                        ,or_order ot
                        ,ge_geogra_location lo
                    WHERE da.id_acta = inuActaId
                       AND gi.item_classif_id <> 23
                       AND da.id_items = gi.items_id
                       AND da.id_orden = ot.order_id
                       AND lo.geograp_location_id(+) = da.geograp_location_id
                       AND nvl(da.valor_total,0) < 0 -- Devolucion Comision Cobrada
                       AND EXISTS(SELECT 'X' FROM GE_ACTA A
                             WHERE A.ID_ACTA = da.ID_ACTA
                             AND A.ID_TIPO_ACTA = 2)
                     GROUP BY da.id_items, lo.description, da.cantidad, lo.geograp_location_id
                     ORDER By da.id_items) as "Detalles"
            from DUAL;

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


    ldci_pksoapapi.proSetProtocol(sbProtocol);

    --Hace el consumo del servicio Web
    l_response := ldci_pksoapapi.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    --Valida el proceso de peticion SOAP
    if (ldci_pksoapapi.boolSoapError OR ldci_pksoapapi.boolHttpError) then
      ldci_pkWebServUtils.Procrearerrorlogint('WS_FACELEC_EMI_COMIBRILLA',
                                               2,
                                               'Error enviando Nota Credito de acta de comision Brilla: ' || ldci_pksoapapi.sbMensaje,
                                               l_payload,
                                               NULL);

        RAISE excepNoProcesoSOAP;
    end if;

  LDCI_PKFACTELECTRONICA_EMI.PROREGISTRAENVIONC(inuActaId,l_payload,onuErrorCode,osbErrorMessage);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
Exception
  When Errorpara01 then
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR PARAMETROS: <Emision Fact Electronica - PROENVIANOTACRBRILLA>: ' || Dbms_Utility.Format_Error_Backtrace;
  WHEN excepNoProcesoRegi THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR- excepNoProcesoRegi: <Emision Fact Electronica - PROENVIANOTACRBRILLA>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
  WHEN excepNoProcesoSOAP THEN
    onuErrorCode := -1;
    osbErrorMessage := 'ERROR - excepNoProcesoSOAP: <Emision Fact Electronica - PROENVIANOTACRBRILLA>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Emision Fact Electronica - PROENVIANOTACRBRILLA>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
  END PROENVIANOTACRBRILLA;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROENVIAENERGIASOLAR
                 AUTOR : Jose Donado
                 FECHA : 11/12/2023

 DESCRIPCION : Procedimiento para enviar documentos de energia solar

 Parametros de Entrada
 inuSucripc:  Id de Contrato
 inuConsFact: Consutivo de Facturacion Electronica
 icbXMLFac:   XML con datos de la factura a enviar

 Parametros de Salida

    onuErrorCode       OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
  PROCEDURE PROENVIAENERGIASOLAR(inuSucripc IN NUMBER, inuConsFact IN NUMBER, icbXMLFac IN CLOB, ocbResponse OUT CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT CLOB) AS

      --Define variables
    sbNameSpace    LDCI_CARASEWE.CASEVALO%type;
    sbUrlWS        LDCI_CARASEWE.CASEVALO%type;
    sbUrlDesti     LDCI_CARASEWE.CASEVALO%type;
    sbSoapActi     LDCI_CARASEWE.CASEVALO%type;
    sbProtocol     LDCI_CARASEWE.CASEVALO%type;
    sbHost         LDCI_CARASEWE.CASEVALO%type;
    sbPuerto       LDCI_CARASEWE.CASEVALO%type;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    sbMens         varchar2(4000);

    --Parametros de logica de negocio
    nuError        NUMBER;
    sbRespuesta    VARCHAR2(4000);
    clXMLFact      CLOB;
    blXMLValid     BOOLEAN;

    --Variables mensajes SOAP
    l_payload       CLOB;
    l_response      CLOB;

    errorPara01         EXCEPTION;   -- Excepcion que verifica que ingresen los parametros de entrada
    excepNoProcesoSOAP  EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP
    excepXMLInvalid     EXCEPTION;   -- Excepcion que valida estructura del XML de entrada

  Begin
    onuErrorCode := 0;
    --PARAMETROS DE CONEXION HACIA EL SERVICIO
    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'NAMESPACE', sbNameSpace, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'WSURL', sbUrlWS, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'SOAPACTION', sbSoapActi, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'PROTOCOLO', sbProtocol, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'PUERTO', sbPuerto, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'HOST', sbHost, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_ENERSOLAR', 'INPUT_MESSAGE_TYPE', sbInputMsgType, sbMens);
    if(sbMens != '0') then
         RAISE errorPara01;
    end if;

    --arma la URL del servicio donde se enviara la interfaz
    sbUrlDesti := lower(sbProtocol) || '://' || sbHost || ':' || sbPuerto || '/' || sbUrlWS;
    sbUrlDesti := trim(sbUrlDesti);

    --verifica si el dato es un XML valido
    l_payload := icbXMLFac;
    l_payload := replace(l_payload, 'ns1:enviarDocumento', 'enviarDocumento');
    blXMLValid := IsXML(l_payload);
    l_payload := replace(l_payload, 'enviarDocumento', 'ns1:enviarDocumento');

    IF (NOT blXMLValid) THEN
      RAISE excepXMLInvalid;
    END IF;

    l_payload := replace(l_payload, '<?xml version="1.0" encoding="UTF-8"?>');
    l_payload := trim(l_payload);

    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);
    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCallSyncExt('WS_FACELEC_EMI_ENERSOLAR',l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    IF (LDCI_PKSOAPAPI.boolHttpError OR LDCI_PKSOAPAPI.Boolsoaperror) THEN
      Raise excepNoProcesoSOAP;
    END IF;

    ocbResponse := l_response;
    onuErrorCode := 0;
    osbErrorMessage := nuError || ' - ' || sbRespuesta || ' - ' || clXMLFact;


  Exception
    When Errorpara01 then
      onuErrorCode := -1;
      osbErrorMessage := 'ERROR PARAMETROS: <Emision Fact Electronica - PROENVIAENERGIASOLAR>: ' || Dbms_Utility.Format_Error_Backtrace;
    When excepXMLInvalid then
      onuErrorCode := -2;
      osbErrorMessage := 'ERROR ESTRUCTURA XML: <Emision Fact Electronica - PROENVIAENERGIASOLAR>: ';
    WHEN excepNoProcesoSOAP THEN
      onuErrorCode := -3;
      --dbms_output.put_line(l_response);
      osbErrorMessage := 'ERROR - excepNoProcesoSOAP: <Emision Fact Electronica - PROENVIAENERGIASOLAR>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace || ' - '|| l_response;
    WHEN OTHERS THEN
      onuErrorCode := -4;
      osbErrorMessage := SQLCODE || ' - ' || SQLERRM;
      osbErrorMessage := 'ERROR - OTHERS: <Emision Fact Electronica - PROENVIAENERGIASOLAR>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || osbErrorMessage;
  END PROENVIAENERGIASOLAR;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROREGISTRAENVIO
                  AUTOR : Jose Donado
                   FECHA : 04/09/2020

 DESCRIPCION : Procedimiento para enviar las comisiones de Brilla para facturacion electronica

 Parametros de Entrada

 inuActaId IN GE_ACTA.ID_ACTA%TYPE -> Id de Acta enviada
 iclXML    IN CLOB -> XML donde se env?-a el acta

 Parametros de Salida

    onuErrorCode       OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROREGISTRAENVIO(inuActaId IN GE_ACTA.ID_ACTA%TYPE, iclXML IN CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2) AS
BEGIN

  INSERT INTO LDCI_FACTEACTASENV(FACEAEID,FACEAEIDACTA,FACEAEFECHEN,FACEAEXML,FACEAEXMLNC,FACEAEFEENNC)
  VALUES(LDCI_SEQFACTEACTASENV.NEXTVAL,inuActaId,SYSDATE,iclXML,NULL,NULL);

  onuErrorCode := 0;
  osbErrorMessage := '';

EXCEPTION
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Emision Fact Electronica - PROREGISTRAENVIO>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
  END PROREGISTRAENVIO;


/*
 PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

 PROCEDIMIENTO : PROREGISTRAENVIONC
                  AUTOR : Jose Donado
                   FECHA : 28/09/2020

 DESCRIPCION : Procedimiento para enviar las notas credito de comisiones Brilla para facturacion electronica

 Parametros de Entrada

 inuActaId IN GE_ACTA.ID_ACTA%TYPE -> Id de Acta enviada
 iclXML    IN CLOB -> XML donde se env?-a el acta

 Parametros de Salida

    onuErrorCode       OUT GE_ERROR_LOG.ERROR_LOG_ID%type
    osbErrorMessage    OUT GE_ERROR_LOG.DESCRIPTION%type

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
*/
PROCEDURE PROREGISTRAENVIONC(inuActaId IN GE_ACTA.ID_ACTA%TYPE, iclXML IN CLOB, onuErrorCode OUT NUMBER,osbErrorMessage OUT VARCHAR2) AS
BEGIN

  UPDATE LDCI_FACTEACTASENV F
  SET F.FACEAEXMLNC = iclXML,
      F.FACEAEFEENNC = SYSDATE
  WHERE F.FACEAEIDACTA = inuActaId;

  onuErrorCode := 0;
  osbErrorMessage := '';

EXCEPTION
  WHEN OTHERS THEN
    onuErrorCode := SQLCODE;
    osbErrorMessage := SQLERRM;
    osbErrorMessage := 'ERROR - OTHERS: <Emision Fact Electronica - PROREGISTRAENVIONC>: ' || Dbms_Utility.Format_Error_Backtrace || ' - ' || onuErrorCode || ' - ' || osbErrorMessage;
  END PROREGISTRAENVIONC;

    /*
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

        PROCEDIMIENTO   : fsbObtOficinaVentaSAP
        AUTOR           : Lubin Pineda
        FECHA           : 04/06/2025
        DESCRIPCION     : Obtiene la oficina de venta SAP para la empresa

        Parametros de Entrada
            isbEmpresa empresa.codigo%type -> GDCA, GDGU

        Historia de Modificaciones

        Autor        Fecha       Descripcion.
    */  
    FUNCTION fsbObtOficinaVentaSAP( isbEmpresa empresa.codigo%type) 
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtOficinaVentaSAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        sbOficinaVenta  ldci_oficvent.ofvecodi%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        IF isbEmpresa  = 'GDCA' THEN 
            ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_OFI_VENTAS', sbOficinaVenta, sbError);
            if(sbError != '0') then
                pkg_error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            end if;
        ELSIF isbEmpresa  = 'GDGU' THEN         
            ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_OFI_VENTAS_GDGU', sbOficinaVenta, sbError);
            if(sbError != '0') then
                pkg_error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            end if;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
        RETURN sbOficinaVenta;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fsbObtOficinaVentaSAP;

    /*
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

        PROCEDIMIENTO   :   fsbObtClasePedidoSAP
        AUTOR           :   Lubin Pineda
        FECHA           :   04/06/2025
        DESCRIPCION     :   Obtiene la clase de pedido SAP para la empresa y el
                            proceso

        Parametros de Entrada
            isbEmpresa  :   Valores permitidos GDCA, GDGU
            isbProceso  :   Valores permitidos COMISION, NOTA            

        Historia de Modificaciones

        Autor        Fecha       Descripcion.
    */  
    FUNCTION fsbObtClasePedidoSAP(isbEmpresa empresa.codigo%type, isbProceso VARCHAR2) 
    RETURN VARCHAR2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtClasePedidoSAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        sbClasePedido           ldci_oficvent.ofvecodi%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        IF isbEmpresa  = 'GDCA' THEN         
            IF isbProceso = 'COMISION' THEN        
                ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CLASE_PEDI', sbClasePedido, sbError);
                if(sbError != '0') then
                    pkg_error.setError;
                    RAISE pkg_Error.CONTROLLED_ERROR;
                end if;
            ELSIF isbProceso = 'NOTA' THEN
                ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CLASE_NCR_PEDI', sbClasePedido, sbError);
                if(sbError != '0') then
                    pkg_error.setError;
                    RAISE pkg_Error.CONTROLLED_ERROR;
                end if;
            END IF;            
        ELSIF isbEmpresa  = 'GDGU' THEN 
            IF isbProceso = 'COMISION' THEN   
                ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CLASE_PEDI_GDGU', sbClasePedido, sbError);
                if(sbError != '0') then
                    pkg_error.setError;
                    RAISE pkg_Error.CONTROLLED_ERROR;
                end if;                
            ELSIF isbProceso = 'NOTA' THEN
                ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_CLASE_NCR_PEDI_GDGU', sbClasePedido, sbError);
                if(sbError != '0') then
                    pkg_error.setError;
                    RAISE pkg_Error.CONTROLLED_ERROR;
                end if;                
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbClasePedido;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fsbObtClasePedidoSAP;
    
    /*
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

        PROCEDIMIENTO   : fsbObtCentroSAP
        AUTOR           : Lubin Pineda
        FECHA           : 11/06/2025
        DESCRIPCION     : Obtiene el centro SAP para la empresa

        Parametros de Entrada
            isbEmpresa empresa.codigo%type -> GDCA, GDGU

        Historia de Modificaciones

        Autor        Fecha       Descripcion.
    */  
    FUNCTION fsbObtCentroSAP( isbEmpresa empresa.codigo%type) 
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtCentroSAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        sbCentro  ldci_oficvent.ofvecodi%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        IF isbEmpresa  = 'GDCA' THEN 
            ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_COD_CENTRO', sbCentro, sbError);
            if(sbError != '0') then
                pkg_error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            end if;
        ELSIF isbEmpresa  = 'GDGU' THEN         
            ldci_pkWebServUtils.proCaraServWeb('WS_FACELEC_EMI_COMIBRILLA', 'SAP_PVM_COD_CENTRO_GDGU', sbCentro, sbError);
            if(sbError != '0') then
                pkg_error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
            end if;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
        RETURN sbCentro;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fsbObtCentroSAP;    
      
END LDCI_PKFACTELECTRONICA_EMI;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to PERSONALIZACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to HOMOLOGACION;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTELECTRONICA_EMI to MULTIEMPRESA;
/
