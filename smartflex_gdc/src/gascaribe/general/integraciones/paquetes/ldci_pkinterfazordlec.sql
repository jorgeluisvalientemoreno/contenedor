CREATE OR REPLACE PACKAGE LDCI_PKINTERFAZORDLEC AS

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor       Fecha           Descripcion
    jpinedc     14/05/2024      OSF-2603: Se ajusta NOTIFICARPROCESOORDENES

  */

procedure PROSETFILEAT(inuActivity     in  NUMBER,

																						isbFileName     in  VARCHAR2,

																						isbObservation  in  VARCHAR2,

																						icbFileSrc      in  CLOB,

																						onuErrorCode		  Out NUMBER,

																						osbErrorMessage Out VARCHAR2) ;



 procedure PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId   In NUMBER,

																																								inuGeograLocationId  In NUMBER,

																																								inuConsCycleId       In NUMBER,

																																								Inuoperatingsectorid In NUMBER,

																																								inuRouteId           In NUMBER,

																																								Idtinitialdate       In Date,

																																								Idtfinaldata         In Date,

																																								Inutasktypeid        In Number,

																																								inuOrderStatusId     In NUMBER,

																																								Onuerrorcode        Out Number,

																																								Osberrormsg         Out Varchar2);



procedure PROLEGALIZARORDEN(ISBDATAORDER  in varchar2 ,

                           IDTINITDATE   in date ,

                           IDTFINALDATE  in date,

																											IDTCHANGEDATE in date,

																											Resultado    out Number,

																											Msj          out Varchar2) ;



procedure proLegalizaLoteOrdenes(iclXMLOrdenes  in CLOB,

                                orfMensProc    out LDCI_PKREPODATATYPE.tyRefcursor);





 procedure NOTIFICARPROCESOORDENES(nuestaproc in LDCI_ESTAPROC.PROCCODI%type);



procedure PROCESOORDENES;



/*

 * NC:        Validacion si una orden esta o no

 *            legalizada, retorna 0 si no esta legalizada

 *            retorna 1 si esta legalizada, y -1 si termino errores

 * FECHA:     15-01-2013

 *

 * Autor:     Hector Fabio Dominguez

 *

 */



function fnuValidaOrdLega(isbIdOrden IN VARCHAR2,osbMensaje OUT VARCHAR2) RETURN NUMBER;









END LDCI_PKINTERFAZORDLEC;

/

CREATE OR REPLACE Package Body Ldci_Pkinterfazordlec As

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT || '.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;  

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

    F.Castro 15-01-2017  PC_200-988 Se agrega NOTIFICARPROCESOORDENES en la declaracion

                         del paquete para que pueda ser usado por otro objeto y se envia

                         correo al que se encuentra en el parametro en vez del correo

                         del funcionario que ejecuta el proceso, ya que este ya no sera

                         por PBPIO sino un job

  */



function fnuValidaOrdLega(isbIdOrden IN VARCHAR2,osbMensaje OUT VARCHAR2) RETURN NUMBER IS



/*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.fnuValidaOrdLega

     AUTOR      : Hector Dominguez

     FECHA      : 18-12-2013

     RICEF      : I015

     DESCRIPCION: Funcion para validar si una orden esta legalizada

                  retorna -1 si termino con error y osbmensaje con la descripcion

                  retorna 0 si no esta legalizada osbmensaje OK

                  retorna 1 si esta legazliada y osbmensaje OK

     NC:          Validacion si una orden es legalizada



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */



/*

 * Valirable de control

 * 0= no legalizada 1= legalizada

 */

nuOrdenLega NUMBER;

 /*

  * Cursor     : cuConsultaOrden

  * Descripcion: Cursor encargado de validar si la orden

  *              fue legalizada

  */



CURSOR cuConsultaOrden IS

SELECT COUNT(*) FROM OR_ORDER

WHERE ORDER_STATUS_ID=8 AND

      ORDER_ID=TO_NUMBER(isbIdOrden);



BEGIN

osbMensaje:='OK';

/*

 * Se ejecuta la consulta de validacion

 */

OPEN cuConsultaOrden;

FETCH cuConsultaOrden INTO nuOrdenLega;

CLOSE cuConsultaOrden;



RETURN nuOrdenLega;



EXCEPTION

WHEN OTHERS THEN

  osbMensaje:='Error consultando la orden '||DBMS_UTILITY.format_error_backtrace;

  RETURN -1;



END fnuValidaOrdLega;



Procedure ENVIARORDENES As



  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.ENVIARORDENES

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

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

   L_Payload     clob;



   l_response    CLOB;

   qryCtx        DBMS_XMLGEN.ctxHandle;



   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada

   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta

   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP

Begin

   LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NAMESPACE', sbNameSpace, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'WSURL', sbUrlWS, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'SOAPACTION', sbSoapActi, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PROTOCOLO', sbProtocol, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PUERTO', sbPuerto, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'HOST', sbHost, sbMens);

    if(sbMens != '0') then

         Raise Errorpara01;

    end if;



    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;

    sbUrlDesti := trim(sbUrlDesti);



     -- Genera el mensaje XML

        Qryctx :=  Dbms_Xmlgen.Newcontext ('Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",

    Address_Id as "idDireccion", Address as "direccion", Geogra_Location_Id as "idLocalidad",

    Neighborthood as "idBarrio", Oper_Sector_Id as "idSectorOper", Route_Id as "idRuta",

    Consecutive as "consPredio",Priority as "prioridad", to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",

    to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso", to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",

    to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec", to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",

    daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",

    Cursor (Select Order_Activity_Id as "idActividadOrden" ,Consecutive as "consecut",

            Activity_Id as "idActividad", Address_Id as "idDireccion",

            Address as "direccion", Subscriber_Name as "nombreSusc", Product_Id as "idProducto",

            Service_Number as "numServicio", Meter as "medidor", Product_Status_Id as "idEstadoProd",

            Subscription_Id as "idSuscripcion",Category_Id as "idCategoria", Subcategory_Id as "idSubcateg",

            Cons_Cycle_Id as "idCicloCons", Cons_Period_Id as "idPeriodoCons", Bill_Cycle_Id as "idCicloFact",

            Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",

            Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",

            Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",

            Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",

            to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",

            Observation_B as "observLec2", Observation_C as "observLec3"

            From LDCI_ACTIVIDADORDEN Act, Perifact Per

                      Where Ord.Order_Id = Act.Order_Id And

                      Act.Bill_Period_Id = per.PEFACODI) As actividades

      From LDCI_ORDEN Ord where rownum <= 30000');

    Dbms_Xmlgen.setNullHandling(qryCtx, 0);



    l_payload := dbms_xmlgen.getXML(qryCtx);



    --Valida si proceso registros

    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

         RAISE excepNoProcesoRegi;

    end if;



    dbms_xmlgen.closeContext(qryCtx);



     L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

    L_Payload := Replace(L_Payload, '<ROWSET',  '<ordenes');

    L_Payload := Replace(L_Payload, '</ROWSET>',  '</ordenes>');

    L_Payload := Replace(L_Payload, '<ROW>',  '<orden>');

    L_Payload := Replace(L_Payload, '</ROW>',  '</orden>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<actividades>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</actividades>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>',  '<actividad>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>',  '</actividad>');

    L_Payload := '<urn:NotificarOrdenesLectura>' || L_Payload || '</urn:NotificarOrdenesLectura>';

    L_Payload := Replace(L_Payload, '&',  '');

    L_Payload := Replace(L_Payload, '?',  'N');

    L_Payload := Replace(L_Payload, '?',  'n');

    L_Payload := Trim(L_Payload);



     --Hace el consumo del servicio Web

     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);


     l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    --Valida el proceso de peticion SOAP

     If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then


        Raise Excepnoprocesosoap;

     end if;

Exception

  When Errorpara01 then

        sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: Error en carga de parametros: ' || sbMens;

  WHEN excepNoProcesoRegi THEN

        sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;

  	WHEN excepNoProcesoSOAP THEN

        Sberrmens := 'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;

end ENVIARORDENES;



Procedure ENVIARORDENESTRANSAC(idTransac in number, lote in number, cantLotes in number) As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.ENVIARORDENESTRANSAC

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

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

   L_Payload     clob;

   sbXmlTransac VARCHAR2(200);



   l_response    CLOB;

   qryCtx        DBMS_XMLGEN.ctxHandle;



   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada

   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta

   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP

Begin

   LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NAMESPACE', sbNameSpace, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'WSURL', sbUrlWS, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'SOAPACTION', sbSoapActi, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PROTOCOLO', sbProtocol, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PUERTO', sbPuerto, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'HOST', sbHost, sbMens);

    if(sbMens != '0') then

         Raise Errorpara01;

    end if;



    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;

    sbUrlDesti := trim(sbUrlDesti);



     -- Genera el mensaje XML

        Qryctx :=  Dbms_Xmlgen.Newcontext ('Select Ord.Order_Id as "idOrden", Task_Type_Id as "idTipoTrab", Order_Status_Id  as "idEstado",

    Address_Id as "idDireccion", Address as "direccion", Geogra_Location_Id as "idLocalidad",

    Neighborthood as "idBarrio", Oper_Sector_Id as "idSectorOper", Route_Id as "idRuta",

    Consecutive as "consPredio",Priority as "prioridad", to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",

    to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso", to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",

    to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec", to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",

    daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",

    Cursor (Select Order_Activity_Id as "idActividadOrden" ,Consecutive as "consecut",

            Activity_Id as "idActividad", Address_Id as "idDireccion",

            Address as "direccion", Subscriber_Name as "nombreSusc", Product_Id as "idProducto",

            Service_Number as "numServicio", Meter as "medidor", Product_Status_Id as "idEstadoProd",

            Subscription_Id as "idSuscripcion",Category_Id as "idCategoria", Subcategory_Id as "idSubcateg",

            Cons_Cycle_Id as "idCicloCons", Cons_Period_Id as "idPeriodoCons", Bill_Cycle_Id as "idCicloFact",

            Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",

            Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",

            Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",

            Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",

            to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",

            Observation_B as "observLec2", Observation_C as "observLec3"

            From LDCI_ACTIVIDADORDEN Act, Perifact Per

                      Where Ord.Order_Id = Act.Order_Id And

                      Act.Bill_Period_Id = per.PEFACODI(+)) As actividades

From LDCI_ORDEN Ord where rownum <= 30000');

    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros

    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

         RAISE excepNoProcesoRegi;

    end if;



    dbms_xmlgen.closeContext(qryCtx);



     L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

    L_Payload := Replace(L_Payload, '<ROWSET',  '<ordenes');

    L_Payload := Replace(L_Payload, '</ROWSET>',  '</ordenes>');

    L_Payload := Replace(L_Payload, '<ROW>',  '<orden>');

    L_Payload := Replace(L_Payload, '</ROW>',  '</orden>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<actividades>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</actividades>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>',  '<actividad>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>',  '</actividad>');





    sbXmlTransac := '<transaccion>

            <transaccion>' || idTransac ||'</transaccion>

            <lote>' || lote || '</lote>

         </transaccion>';



    L_Payload := '<urn:NotificarOrdenesLectura>' || sbXmlTransac || L_Payload || '</urn:NotificarOrdenesLectura>';

    L_Payload := Replace(L_Payload, '&',  '');

    L_Payload := Replace(L_Payload, '?',  'N');

    L_Payload := Replace(L_Payload, '?',  'n');

    L_Payload := Trim(L_Payload);

    --Hace el consumo del servicio Web

     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

     l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);


    --Valida el proceso de peticion SOAP

     If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then

        Raise Excepnoprocesosoap;

     end if;


Exception

  When Errorpara01 then

    UT_TRACE.TRACE(Sbmens, 10);

  WHEN excepNoProcesoRegi THEN

        sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;

  	WHEN excepNoProcesoSOAP THEN

        Sberrmens := 'ERROR: <Notificartransaccion.Enviarordenes>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;

end ENVIARORDENESTRANSAC;



Procedure CONFIRMARORDENES(idTransac in number, cantLotes in number, cantOrds in number, cantActs in number) As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.CONFIRMARORDENES

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

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

   L_Payload     clob;

   sbXmlTransac VARCHAR2(200);



   l_response    CLOB;

   qryCtx        DBMS_XMLGEN.ctxHandle;



   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada

   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta

   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP

Begin

   LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NAMESPACE', sbNameSpace, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'WSURL', sbUrlWS, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'SOAPACTION', sbSoapActi, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PROTOCOLO', sbProtocol, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PUERTO', sbPuerto, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'HOST', sbHost, sbMens);

    if(sbMens != '0') then

         Raise Errorpara01;

    end if;



    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;

    sbUrlDesti := trim(sbUrlDesti);





    sbXmlTransac := '<idTransaccion>' || idTransac ||'</idTransaccion>

            <cantidadLotes>' || cantLotes || '</cantidadLotes>

            <cantidadOrdenes>' || cantOrds || '</cantidadOrdenes>

            <cantidadActs>' || cantActs || '</cantidadActs>';

    L_Payload := '<urn:ConfirmaTransacOrdRequest>' || sbXmlTransac  || '</urn:ConfirmaTransacOrdRequest>';

    L_Payload := Trim(L_Payload);

    --Hace el consumo del servicio Web

     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

     l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    --Valida el proceso de peticion SOAP

     If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then

        Raise Excepnoprocesosoap;

     end if;

Exception

  When Errorpara01 then

    UT_TRACE.TRACE(Sbmens, 10);

  WHEN excepNoProcesoRegi THEN

        sbErrMens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;

  	WHEN excepNoProcesoSOAP THEN

        Sberrmens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;

end CONFIRMARORDENES;





Procedure CANCELARORDENES(idTransac in number, lote in number) As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.CANCELARORDENES

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

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

   L_Payload     clob;

   sbXmlTransac VARCHAR2(200);



   l_response    CLOB;

   qryCtx        DBMS_XMLGEN.ctxHandle;



   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada

   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta

   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP

Begin

   LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NAMESPACE', sbNameSpace, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'WSURL', sbUrlWS, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'SOAPACTION', sbSoapActi, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PROTOCOLO', sbProtocol, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'PUERTO', sbPuerto, sbMens);

    if(sbMens != '0') then

         RAISE errorPara01;

    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'HOST', sbHost, sbMens);

    if(sbMens != '0') then

         Raise Errorpara01;

    end if;



    Sburldesti := Lower(Sbprotocol) || '://' || Sbhost || ':' || Sbpuerto || '/' || Sburlws;

    sbUrlDesti := trim(sbUrlDesti);

    sbXmlTransac := '<transaccion>' || idTransac ||'</transaccion>';

    L_Payload := '<urn:CancelaTransacOrdRequest>' || sbXmlTransac  || '</urn:CancelaTransacOrdRequest>';

    L_Payload := Trim(L_Payload);

    --Hace el consumo del servicio Web

     LDCI_PKSOAPAPI.Prosetprotocol(Sbprotocol);

     l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload, sbUrlDesti, sbSoapActi, sbNameSpace);

    --Valida el proceso de peticion SOAP

     If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then

        Raise Excepnoprocesosoap;

     end if;


Exception

  When Errorpara01 then

    UT_TRACE.TRACE(Sbmens, 10);

  WHEN excepNoProcesoRegi THEN

        sbErrMens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;

  	WHEN excepNoProcesoSOAP THEN

        Sberrmens := 'ERROR: <Notificartransaccion.CONFIRMARORDENES>: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;

end CANCELARORDENES;





PROCEDURE NOTIFICARPROCESAMIENTO(INUPROCODI IN LDCI_ESTAPROC.PROCCODI%TYPE, Onuerrorcode Out  Number,

                                Osberrormsg Out Varchar2 ) AS

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.NOTIFICARPROCESAMIENTO

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

  CURSOR CUESTAPROC IS SELECT * FROM   LDCI_ESTAPROC WHERE PROCCODI =  INUPROCODI;

  RECCUESTAPROC LDCI_ESTAPROC%ROWTYPE;



  CURSOR CUPERSON(SBUSER GE_PERSON.USER_ID%TYPE) IS SELECT * FROM GE_PERSON WHERE user_id = SBUSER;

  RECCUPERSON GE_PERSON%ROWTYPE;



  CURSOR CUMENSAJES IS SELECT * FROM LDCI_MESAPROC WHERE MESAPROC = INUPROCODI ;

  RECCUMENSAJES LDCI_ESTAPROC%ROWTYPE;

BEGIN

  OPEN CUESTAPROC;

  FETCH CUESTAPROC INTO RECCUESTAPROC;

END NOTIFICARPROCESAMIENTO;





Procedure PROCESOACTIVIDADESORDEN(Orden              In LDCI_ACTIVIDADORDEN.Order_Id%Type,

                                 cantAtcs          out number,

																																	nuTransac          in number,

																																	OnuFLAFPROCESO in out number) As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.PROCESOACTIVIDADESORDEN

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */

       TYPE refRegistros is REF CURSOR ;

      Resultado Number(18) := -1;

      Msj Varchar2(200) := '';

      Recregistros Refregistros;

      reg LDCI_ACTIVIDADORDEN%Rowtype;





      Nuorder_Activity_Id Ldci_Actividadorden.Order_Activity_Id%Type;

      Nuconsecutive       Ldci_Actividadorden.Consecutive%Type;

      Nuactivity_Id       Ldci_Actividadorden.Activity_Id%Type;

      Nuaddress_Id        Ldci_Actividadorden.Address_Id%Type;

      Sbaddress           Ldci_Actividadorden.Address%Type;

      Sbsubscriber_Name   Ldci_Actividadorden.Subscriber_Name%Type;

      Nuproduct_Id        Ldci_Actividadorden.Product_Id%Type;

      Sbservice_Number    Ldci_Actividadorden.Service_Number%Type;

      Sbmeter             Ldci_Actividadorden.Meter%Type;

      Nuproduct_Status_Id Ldci_Actividadorden.Product_Status_Id%Type;

      Nusubscription_Id   Ldci_Actividadorden.Subscription_Id%Type;

      Nucategory_Id       Ldci_Actividadorden.Category_Id%Type;

      Nusubcategory_Id    Ldci_Actividadorden.Subcategory_Id%Type;

      Nucons_Cycle_Id     Ldci_Actividadorden.Cons_Cycle_Id%Type;

      Nucons_Period_Id    Ldci_Actividadorden.Cons_Period_Id%Type;

      Nubill_Cycle_Id     Ldci_Actividadorden.Bill_Cycle_Id%Type;

      Nubill_Period_Id    Ldci_Actividadorden.Bill_Period_Id%Type;

      Nuparent_Product_Id Ldci_Actividadorden.Parent_Product_Id%Type;

      Sbparent_Address_Id Ldci_Actividadorden.Parent_Address_Id%Type;

      Sbparent_Address    Ldci_Actividadorden.Parent_Address%Type;

      Sbcausal            Ldci_Actividadorden.Causal%Type;

      Nucons_Type_Id      Ldci_Actividadorden.Cons_Type_Id%Type;

      Numeter_Location    Ldci_Actividadorden.Meter_Location%Type;

      Nudigit_Quantity    Ldci_Actividadorden.Digit_Quantity%Type;

      Nulimit             Ldci_Actividadorden.Limit%Type;

      Sbretry             Ldci_Actividadorden.Retry%Type;

      Nuaverage           Ldci_Actividadorden.Average%Type;

      Nulast_Read         Ldci_Actividadorden.Last_Read%Type;

      Dtlast_Read_Date    Ldci_Actividadorden.Last_Read_Date%Type;

      Nuobservation_A     Ldci_Actividadorden.Observation_A%Type;

      Nuobservation_B     Ldci_Actividadorden.Observation_B%Type;

      NUObservation_C     Ldci_Actividadorden.Observation_C%TYPE;





      nuMesacodi LDCI_MESAPROC.MESACODI%TYPE;

      nuFlagValida Number := 0;

Begin

      cantAtcs :=0;

      /* CARGAR ACTIVIDADES DE LA ORDEN */

      OS_GETORDERACTIVITIES(Orden, Recregistros, Resultado, Msj);

       --evaluar el resultado antes de recorrer el cursor

      If Resultado = 0 Then

         Loop

         Fetch  Recregistros  Into Nuorder_Activity_Id, Nuconsecutive, Nuactivity_Id, Nuaddress_Id, Sbaddress,

                                  Sbsubscriber_Name, Nuproduct_Id, Sbservice_Number, Sbmeter, Nuproduct_Status_Id, Nusubscription_Id,

                                  Nucategory_Id, Nusubcategory_Id, Nucons_Cycle_Id, Nucons_Period_Id, Nubill_Cycle_Id, Nubill_Period_Id,

                                  Nuparent_Product_Id, Sbparent_Address_Id, Sbparent_Address, Sbcausal, Nucons_Type_Id, Numeter_Location,

                                  Nudigit_Quantity, Nulimit, Sbretry, Nuaverage, Nulast_Read, Dtlast_Read_Date,

                                  NUObservation_A, NUObservation_B, NUObservation_C;

          EXIT WHEN Recregistros%notfound;

          cantAtcs := cantAtcs + 1;



          LDCI_PKVALIDASIGELEC.PROVALIDAACTIVIDAD(Orden,

										                                        Nuorder_Activity_Id,

																																																		Nuconsecutive,

																																																		Nuactivity_Id,

																																																		Nuaddress_Id,

																																																		Sbaddress,

																																																		Sbsubscriber_Name,

																																																		Nuproduct_Id,

																																																		Sbservice_Number,

																																																		Sbmeter,

																																																		Nuproduct_Status_Id,

																																																		Nusubscription_Id,

																																																		Nucategory_Id,

																																																		Nusubcategory_Id,

																																																		Nucons_Cycle_Id,

																																																		Nucons_Period_Id,

																																																		Nubill_Cycle_Id,

																																																		Nubill_Period_Id,

																																																		Nuparent_Product_Id,

																																																		Sbparent_Address_Id,

																																																		Sbparent_Address,

																																																		Sbcausal,

																																																		Nucons_Type_Id,

																																																		Numeter_Location,

																																																		Nudigit_Quantity,

																																																		Nulimit,

																																																		Sbretry,

																																																		Nuaverage,

																																																		Nulast_Read,

																																																		Dtlast_Read_Date,

																																																		Nuobservation_A,

																																																		Nuobservation_B,

																																																		NUObservation_C,

																																																		nuTransac,

																																																		nuFlagValida );





          IF nuFlagValida = 0 THEN

             /* PERSISTIR ACTIVIDADES */

            insert into LDCI_ACTIVIDADORDEN (ORDER_ID,

												                                ORDER_ACTIVITY_ID,

																																												CONSECUTIVE,

																																												ACTIVITY_ID,

																																												ADDRESS_ID,

																																												ADDRESS,

                                            SUBSCRIBER_NAME,

																																												PRODUCT_ID,

																																												SERVICE_NUMBER,

																																												METER,

																																												PRODUCT_STATUS_ID,

																																												SUBSCRIPTION_ID,

                                            CATEGORY_ID,

																																												SUBCATEGORY_ID,

																																												CONS_CYCLE_ID,

																																												CONS_PERIOD_ID,

																																												BILL_CYCLE_ID,

																																												BILL_PERIOD_ID,

                                            PARENT_PRODUCT_ID,

																																												PARENT_ADDRESS_ID,

																																												PARENT_ADDRESS,

																																												CAUSAL,

																																												CONS_TYPE_ID,

																																												METER_LOCATION,

                                            Digit_Quantity,

																																												Limit,

																																												Retry,

																																												Average,

																																												Last_Read,

																																												Last_Read_Date,

                                            Observation_A,

																																												Observation_B,

																																												Observation_C)

																																								Values

																																												(Orden,

																																												 Nuorder_Activity_Id,

																																													Nuconsecutive,

																																													Nuactivity_Id,

																																													Nuaddress_Id,

																																													Sbaddress,

																																												 Sbsubscriber_Name,

																																													Nuproduct_Id,

																																													Sbservice_Number,

																																													Sbmeter,

																																													Nuproduct_Status_Id,

																																													Nusubscription_Id,

																																												 Nucategory_Id,

																																													Nusubcategory_Id,

																																													Nucons_Cycle_Id,

																																													Nucons_Period_Id,

																																													Nubill_Cycle_Id,

																																													Nubill_Period_Id,

																																												 Nuparent_Product_Id,

																																													Sbparent_Address_Id,

																																													Sbparent_Address,

																																													Sbcausal,

																																													Nucons_Type_Id,

																																													Numeter_Location,

																																												 Nudigit_Quantity,

																																													Nulimit,

																																													Sbretry,

																																													Nuaverage,

																																													Nulast_Read,

																																													Dtlast_Read_Date,

																																												 NUObservation_A,

																																													NUObservation_B,

																																													NUObservation_C);



          else

            OnuFLAFPROCESO := 1 ;

												exit;

          END IF; 

        End Loop; 

      Else

        /*CREAR MENSAJE DE ERROR*/

        LDCI_PKMESAWS.proCreaMensProc(nuTransac, Msj, 'E', CURRENT_DATE, nuMesacodi,  Resultado ,Msj);

      end if; 

      Close Recregistros;

Exception

	When Others Then

			/*CREAR MENSAJE DE ERROR*/

			OnuFLAFPROCESO := 1;

			LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'ERROR: '|| SQLERRM || '. TRACE:'|| DBMS_UTILITY.format_error_backtrace, 'E', CURRENT_DATE, nuMesacodi,  Resultado ,Msj);

End PROCESOACTIVIDADESORDEN;


   PROCEDURE PROPROCESARRORDEN(nuTransac IN LDCI_ORDEN.TRANSAC_ID%TYPE,Nuorder_Id IN LDCI_ORDEN.Order_Id%TYPE,

                          Nutask_Type_Id IN LDCI_ORDEN.Task_Type_Id%TYPE, Nuorder_Status_Id IN LDCI_ORDEN.Address_Id%TYPE,

                          Nuaddress_Id IN LDCI_ORDEN.Address_Id%TYPE, Sbaddress IN LDCI_ORDEN.Address%TYPE,

                          Nugeogra_Location_Id IN LDCI_ORDEN.Geogra_Location_Id%TYPE, Nuneighborthood IN LDCI_ORDEN.Neighborthood%TYPE,

                          Nuoper_Sector_Id IN LDCI_ORDEN.Oper_Sector_Id%TYPE, Nuroute_Id IN LDCI_ORDEN.Route_Id%TYPE,

                          Nuconsecutive IN LDCI_ORDEN.Consecutive%TYPE, Nupriority IN LDCI_ORDEN.Priority%TYPE,

                          Dtassigned_Date IN LDCI_ORDEN.Assigned_Date%TYPE, Dtarrange_Hour IN LDCI_ORDEN.Arrange_Hour%TYPE,

                          Dtcreated_Date IN LDCI_ORDEN.Created_Date%TYPE, Dtexec_Estimate_Date IN LDCI_ORDEN.Exec_Estimate_Date%TYPE,

                          dtMax_Date_To_Legalize IN LDCI_ORDEN.Max_Date_To_Legalize%TYPE,OnuFLAFPROCESO IN Out Number) AS

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.PROPROCESARRORDEN

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */



  BEGIN

    null;

  EXCEPTION

    WHEN OTHERS THEN

      OnuFLAFPROCESO := 1;

  END PROPROCESARRORDEN;



   PROCEDURE PROGENERARPAYLOADSORDENES(nuTransac in NUMBER, nuLote in number, nuLotes in number,Onuerrorcode Out  Number,

                                Osberrormsg Out Varchar2 ) AS



  sbErrMens varchar2(2000);

  Sbmens      Varchar2(4000);



  nuMesacodi LDCI_MESAENVWS.MESACODI%TYPE;





   --Variables mensajes SOAP

   L_Payload     clob;

   sbXmlTransac VARCHAR2(500);





   qryCtx        DBMS_XMLGEN.ctxHandle;



   errorPara01	EXCEPTION;      	-- Excepcion que verifica que ingresen los parametros de entrada

   Excepnoprocesoregi	Exception; 	-- Excepcion que valida si proceso registros la consulta

   excepNoProcesoSOAP	EXCEPTION; 	-- Excepcion que valida si proceso peticion SOAP



			--#NC-INTERNA: Conteo de cantidad de ordenes

			-- conteo de ordenes por lote

   cursor cuContordenes is

			 SELECT COUNT(ORD.ORDER_ID) ORDENES

     FROM LDCI_ORDEN ORD

    WHERE ORD.LOTE = nuLote;



			-- conteo de actividades por lote

   cursor cuContAvtividades is

			 SELECT COUNT(ACT.ACTIVITY_ID) ACTIVIDADES

     FROM LDCI_ORDEN ORD, LDCI_ACTIVIDADORDEN ACT

    WHERE ORD.ORDER_ID = ACT.ORDER_ID

				  AND ORD.LOTE = nuLote;



  nuCantOrds number := 0;

  nuCantActs number := 0;

Begin



    --#NC-INTERNA: Conteo de cantidad de ordenes

    open  cuContordenes;

    fetch cuContordenes into nuCantOrds;

    close cuContordenes;



    open  cuContAvtividades;

    fetch cuContAvtividades into nuCantActs ;

    close cuContAvtividades;



     -- Genera el mensaje XML

        Qryctx :=  Dbms_Xmlgen.Newcontext ('Select Ord.Order_Id as "idOrden",

								                                                Task_Type_Id as "idTipoTrab",

																																																	 Order_Status_Id  as "idEstado",

                                                         Address_Id as "idDireccion",

																																																	 Address as "direccion",

																																																	 Geogra_Location_Id as "idLocalidad",

                                                         Neighborthood as "idBarrio",

																																																	 Oper_Sector_Id as "idSectorOper",

																																																	 Route_Id as "idRuta",

                                                         Consecutive as "consPredio",

																																																	 Priority as "prioridad",

																																																		to_char(Assigned_Date, ''YYYY-MM-DD'') as "fechaAsig",

                                                         to_char(Arrange_Hour, ''YYYY-MM-DD'') as "fechaCompromiso",

																																																		to_char(Created_Date, ''YYYY-MM-DD'') as "fechaCreacion",

                                                         to_char(Exec_Estimate_Date, ''YYYY-MM-DD'') as "fechaPlanEjec",

																																																		to_char(Max_Date_To_Legalize, ''YYYY-MM-DD'') as "fechaMaxLeg",

                                                         daor_order.fnugetoperating_unit_id(Ord.Order_Id) as "idUnidadOper",

																																																		Cursor (Select Order_Activity_Id as "idActividadOrden",

																																																		               Consecutive as "consecut",

																																																										      Activity_Id as "idActividad",

																																																															Address_Id as "idDireccion",

																																																										      Address as "direccion",

																																																															Subscriber_Name as "nombreSusc",

																																																															Product_Id as "idProducto",

																																																										      Service_Number as "numServicio",

																																																															Meter as "medidor",

																																																															Product_Status_Id as "idEstadoProd",

																																																										      Subscription_Id as "idSuscripcion",

																																																															Category_Id as "idCategoria",

																																																															Subcategory_Id as "idSubcateg",

																																																										      Cons_Cycle_Id as "idCicloCons",

																																																															Cons_Period_Id as "idPeriodoCons",

																																																															Bill_Cycle_Id as "idCicloFact",

																																																										Bill_Period_Id as "idPeriodoFact", PEFAANO as "anoFact", PEFAMES as "mesFact", Parent_Product_Id as "idProdPadre",

																																																										Parent_Address_Id as "idDirPadre", Parent_Address as "dirPadre", Causal as "causal",

																																																										Cons_Type_Id as "idTipoCons", Meter_Location as "idUbicMedidor", Digit_Quantity as "digitosMed",

																																																										Limit as "limiteMed", Retry as "relectura",Average as "consumoProm",Last_Read as "lecturaAnt",

																																																										to_char(Last_Read_Date, ''YYYY-MM-DD'') as "fechaUltLec", Observation_A as "observLec1",

																																																										Observation_B as "observLec2", Observation_C as "observLec3"

																																																								From LDCI_ACTIVIDADORDEN Act, Perifact Per

																																																																		Where Ord.Order_Id = Act.Order_Id And

																																																																		Act.Bill_Period_Id = per.PEFACODI(+)) As actividades

From LDCI_ORDEN Ord where Ord.LOTE = ' || nuLote);

    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros

    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

         RAISE excepNoProcesoRegi;

    end if;

    dbms_xmlgen.closeContext(qryCtx);



     L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

    L_Payload := Replace(L_Payload, '<ROWSET',  '<ordenes');

    L_Payload := Replace(L_Payload, '</ROWSET>',  '</ordenes>');

    L_Payload := Replace(L_Payload, '<ROW>',  '<orden>');

    L_Payload := Replace(L_Payload, '</ROW>',  '</orden>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<actividades>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</actividades>');

    L_Payload := Replace(L_Payload, '<ACTIVIDADES_ROW>',  '<actividad>');

    L_Payload := Replace(L_Payload, '</ACTIVIDADES_ROW>',  '</actividad>');





    sbXmlTransac := '<transaccion>

            <proceso>' || nuTransac ||'</proceso>

            <lote>' || nuLote || '</lote>

            <cantidadLotes>' || nuLotes || '</cantidadLotes>

            <cantOrdenes>' || nuCantOrds || '</cantOrdenes>

            <cantActividades>' || nuCantActs || '</cantActividades>

         </transaccion>';

    L_Payload := '<urn:NotificarOrdenesLectura>' || sbXmlTransac || L_Payload || '</urn:NotificarOrdenesLectura>';

    L_Payload := Trim(L_Payload);

     LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,'WS_ENVIO_ORDENES',

																										-1,

																										nuTransac,

																										null,

																										L_Payload,

																										nuLote,

																										nuLotes,

																										nuMesacodi,

																				 					Onuerrorcode,

																					 				sbErrMens);

Exception

  WHEN excepNoProcesoRegi THEN

        sbErrMens := 'ERROR: <Notificartransaccion.Enviarordenes>: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;

  	WHEN OTHERS THEN

        Sberrmens := 'ERROR ALMACENANDO PAYLOAD. ' || SQLERRM || '. ' || Dbms_Utility.Format_Error_Backtrace;

  END PROGENERARPAYLOADSORDENES;



  procedure NOTIFICARPROCESOORDENES(nuestaproc in LDCI_ESTAPROC.PROCCODI%type) AS

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.NOTIFICARPROCESOORDENES

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */
  

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'NOTIFICARPROCESOORDENES';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);     
    
    sbMensaje VARCHAR2(30000);

    sbMail    VARCHAR2(200);

    --definicion de cursores

    -- cursor del estado de proceso

    cursor cuLDCI_ESTAPROC is

      select *

        from LDCI_ESTAPROC

       where PROCCODI = nuestaproc;

    --cursor del mensaje de procesamiento

    cursor cuMesaproc is

      select *

        from LDCI_MESAPROC

        where MESAPROC = nuestaproc;



    -- cursor del XML de parametros

    cursor cuPARAMETROS(clXML in VARCHAR2) is

              SELECT PARAMETROS.*

                  FROM XMLTable('/PARAMETROS/PARAMETRO' PASSING XMLType(clXML)

                      COLUMNS row_num for ordinality,

                              "NOMBRE" VARCHAR2(300) PATH 'NOMBRE',

                              "VALOR"  VARCHAR2(300) PATH 'VALOR') AS PARAMETROS;



    --variables tipo registro

    reMesaProc      LDCI_MESAPROC%rowtype;

    reLDCI_ESTAPROC cuLDCI_ESTAPROC%rowtype;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
    sbMensCorreo    VARCHAR2(4000);

  begin
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
 
    /*

      OBTENER CORREO ELECTRONICO

    */

    sbMail  :=  pkg_BCLD_Parameter.fsbObtieneValorCadena('MAIL_LOG_ERR_SIGELEC');

    sbMensaje := 'Finalizo el procesamiento de ordenes de lectura para el ciclo.';

    /*

      OBTENER MENSAJES

    */

    open cuLDCI_ESTAPROC;

    fetch cuLDCI_ESTAPROC into reLDCI_ESTAPROC;

    close cuLDCI_ESTAPROC;

    /*

      ENVIAR CORREO

    */

        if (sbMail is not null ) then

              -- envio de correo con formato HTML (Genera la conexion SMTP)


              -- genera el cuerpo del correo

              sbMensCorreo := sbMensCorreo  ||  '<html><body>';

              sbMensCorreo := sbMensCorreo  ||  '<table  border="1px" width="100%">';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><h1>Estado del proceso<h1></td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Identificador</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || reLDCI_ESTAPROC.PROCCODI || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Fecha inicio</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || to_char(reLDCI_ESTAPROC.PROCFEIN, 'DD/MM/YYYY HH:MM:SS') || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Fecha final</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || to_char(reLDCI_ESTAPROC.PROCFEFI, 'DD/MM/YYYY HH:MM:SS') || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Usuario</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || reLDCI_ESTAPROC.PROCUSUA || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Terminal</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || reLDCI_ESTAPROC.PROCTERM || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Programa</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || reLDCI_ESTAPROC.PROCPROG || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Estado [R=Registrado P=procesando, F=Finalizado]</b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td>' || reLDCI_ESTAPROC.PROCESTA || '</td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '</table>';



              -- lee los datos de consulta

              sbMensCorreo := sbMensCorreo  ||  '<table  border="1px" width="100%">';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><h2>Datos de procesamiento<h2></td>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Parametro<b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Valor<b></td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '</body></html>';



              -- recorre el XML de parametros

              for rePARAMETROS in cuPARAMETROS(reLDCI_ESTAPROC.PROCPARA)  loop

                sbMensCorreo := sbMensCorreo  ||  '<tr>';

                sbMensCorreo := sbMensCorreo  ||  '<td>' || rePARAMETROS.NOMBRE || '</td>';

                sbMensCorreo := sbMensCorreo  ||  '<td>' || rePARAMETROS.VALOR || '</td>';

                sbMensCorreo := sbMensCorreo  ||  '</tr>';

              end loop;

              sbMensCorreo := sbMensCorreo  ||  '</table>';



              -- lee los mensajes del proceso

              sbMensCorreo := sbMensCorreo  ||  '<table  border="1px" width="100%">';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td colspan="3"><h2>Mensajes de procesamiento<h2></td>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Consecutivo del mensaje<b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Mensaje<b></td>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Tipo [E Error, I Informacion, W Advertencia, S Satisfactorio]<b></td>';

              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '</body></html>';



              -- recorre los mensajes

              for reMesaProc in cuMesaproc  loop

                sbMensCorreo := sbMensCorreo  ||  '<tr>';

                sbMensCorreo := sbMensCorreo  ||  '<td>' || reMesaProc.MESACODI || '</td>';

                sbMensCorreo := sbMensCorreo  ||  '<td>' || reMesaProc.MESADESC || '</td>';

                sbMensCorreo := sbMensCorreo  ||  '<td>' || reMesaProc.MESATIPO || '</td>';

                sbMensCorreo := sbMensCorreo  ||  '</tr>';

              end loop; 

              sbMensCorreo := sbMensCorreo  ||  '</table>';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbMail,
                isbAsunto           => 'Notificacion de envio de ordenes a sistema externo',
                isbMensaje          => sbMensCorreo
            );

        else

          sbMensaje := 'No se encontro correo configurado para notificar Errores';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => sbMensaje,
                isbMensaje          => sbMensCorreo
            );

        end if;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
  end NOTIFICARPROCESOORDENES;



  PROCEDURE PROLIMPIARTEMPORALES AS

  BEGIN

    Delete From LDCI_ACTIVIDADORDEN;

    Delete From LDCI_ORDEN;

  END PROLIMPIARTEMPORALES;





  Procedure PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId  In NUMBER,

																																									inuGeograLocationId In NUMBER,

																																									inuConsCycleId In NUMBER,

																																									Inuoperatingsectorid In NUMBER,

																																									inuRouteId In NUMBER,

																																									Idtinitialdate In Date,

																																									Idtfinaldata In Date,

																																									Inutasktypeid In Number,

																																									inuOrderStatusId In NUMBER,

																																									Onuerrorcode Out  Number,

																																									Osberrormsg Out Varchar2) As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.PROCESARORDENESLECTURATRANSAC

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura



    Historia de Modificaciones

    Autor                                   Fecha      Descripcion

			 carlosvl<carlos.virgen@olsoftware.com> 07-02-2014 #NC-87252: Manejo del numero de registros por lote mediante un parametro del sistema

  */

    -- variables para la asignacion del cursor

    TYPE refRegistros is REF CURSOR ;

    Recregistros Refregistros;

    -- atributos del cursor de ordenes

    Nuorder_Id             Ldci_Orden.Order_Id%Type;

    Nutask_Type_Id         Ldci_Orden.Task_Type_Id%Type;

    Nuorder_Status_Id      Ldci_Orden.Order_Status_Id%Type;

    Nuaddress_Id           Ldci_Orden.Address_Id%Type;

    Sbaddress              Ldci_Orden.Address%Type;

    Nugeogra_Location_Id   Ldci_Orden.Geogra_Location_Id%Type;

    Nuneighborthood        Ldci_Orden.Neighborthood%Type;

    Nuoper_Sector_Id       Ldci_Orden.Oper_Sector_Id%Type;

    Nuroute_Id             Ldci_Orden.Route_Id%Type;

    Nuconsecutive          Ldci_Orden.Consecutive%Type;

    Nupriority             Ldci_Orden.Priority%Type;

    Dtassigned_Date        Ldci_Orden.Assigned_Date%Type;

    Dtarrange_Hour         Ldci_Orden.Arrange_Hour%Type;

    Dtcreated_Date         Ldci_Orden.Created_Date%Type;

    Dtexec_Estimate_Date   Ldci_Orden.Exec_Estimate_Date%Type;

    dtMax_Date_To_Legalize LDCI_ORDEN.Max_Date_To_Legalize%type;



    -- variables para el manejo del procesameinto

    nuLotes         number(4) := 0;

    nuRegistrosLote number(4) := 0;                  --#NC-87252: carlosvl: 07-02-2014: Se inicializa en cero la variable. (Valor anterior 3200)

	   sbRegistrosLote LDCI_CARASEWE.CASEDESE%type;	--#NC-87252: carlosvl: 07-02-2014: Variable que almacena el numero de registros por lote

    nuContadorRows  number(4) :=0;

    nuLote          number    := 1;

    nuTransac       number    :=0;

    cantOrds        number    :=0;

    cantActs        number    :=0;

    nuCantActs      number    :=0;

    OnuFLAFPROCESO  number :=0;

    nuMesacodi      LDCI_MESAPROC.MESACODI%TYPE;

    isbParametros   VARCHAR2(2000);

    nuUserID        SA_USER.USER_ID%TYPE;

    nuPersonID      ge_person.person_id%type;

    sbSubnetmask    sa_user.mask%type;

    sbCorreo        VARCHAR2(250);

    nuFlagGeneral   number :=0;



    errorPara01	EXCEPTION;      	-- #NC-87252: carlosvl: 07-02-2014: Se define la excepcion para validar la carga del parametro

  Begin





    isbParametros := '<Parametros>

                        <parametro>

                            <nombre>OperatingUnitId</nombre>

                            <valor>' || inuOperatingUnitId || '</valor>

                        </parametro>

                        <parametro>

                            <nombre>GeograLocationId</nombre>

                            <valor>' || inuGeograLocationId ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>ConsCycleId</nombre>

                            <valor>' || inuConsCycleId ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>operatingsectorid</nombre>

                            <valor>' || Inuoperatingsectorid ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>RouteId</nombre>

                            <valor>' || inuRouteId ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>initialdate</nombre>

                            <valor>' || Idtinitialdate ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>finaldata</nombre>

                            <valor>' || Idtfinaldata ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>tasktypeid</nombre>

                            <valor>' || Inutasktypeid ||'</valor>

                        </parametro>

                        <parametro>

                            <nombre>OrderStatusId</nombre>

                            <valor>' || inuOrderStatusId ||'</valor>

                        </parametro>

                    </Parametros>

                    ';

    /* CREAR TRANSACCION  */

    LDCI_PKMESAWS.proCreaEstaProc('WS_ENVIO_ORDENES',

																									isbParametros,

																									CURRENT_DATE,

																									'P',

																									sys_context('USERENV', 'CURRENT_USER'),

																									null,

																									null,

																									nuTransac,

																									Onuerrorcode,

																									Osberrormsg);



    --#NC-87252: carlosvl: 07-02-2014: Se inicializa la variable nuRegistrosLote con el valor del parametro WS_ENVIO_ORDENES -> NRO_REG_LOTE

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NRO_REG_LOTE', sbRegistrosLote, OSBERRORMSG);

    if(OSBERRORMSG != '0') then

         RAISE errorPara01;

				else

						nuRegistrosLote := to_number(sbRegistrosLote);

    end if;



    IF Onuerrorcode = 0 THEN

       /* CARGAR ORDENES */

      OS_GETWORKORDERS(Inuoperatingunitid,

						                 Inugeogralocationid,

																							Inuconscycleid,

                       Inuoperatingsectorid,

																							inuRouteId,

																							Idtinitialdate,

                       Idtfinaldata,

																							Inutasktypeid,

																							Inuorderstatusid,

                       Recregistros,

																							Onuerrorcode,

																							Osberrormsg);





      IF Onuerrorcode = 0  then



        /* CARGAR PERSISTIR ORDEN */

        loop

            Fetch  Recregistros Into Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,

                                    Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id, Nuroute_Id,

                                    Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour, Dtcreated_Date,

                                    Dtexec_Estimate_Date, dtMax_Date_To_Legalize;



            EXIT WHEN Recregistros%notfound;



            LDCI_PKVALIDASIGELEC.PROVALIDAORDEN(nuTransac, Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,

                                                Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id, Nuroute_Id,

                                                Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour, Dtcreated_Date,

                                                Dtexec_Estimate_Date, dtMax_Date_To_Legalize,OnuFLAFPROCESO);





            IF OnuFLAFPROCESO = 0 THEN

              Insert Into LDCI_ORDEN (Order_Id, Task_Type_Id, Order_Status_Id, Address_Id, Address, Geogra_Location_Id, Neighborthood, Oper_Sector_Id,

                                Route_Id , Consecutive, Priority, Assigned_Date,  Arrange_Hour, Created_Date, Exec_Estimate_Date, Max_Date_To_Legalize,

                                TRANSAC_ID, LOTE, PAQUETES)

                                Values

                                (Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,

                                Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id,

                                Nuroute_Id, Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour,

                                dtCreated_Date, dtExec_Estimate_Date, dtMax_Date_To_Legalize, nuTransac, nuLote, nuLotes);

              cantOrds := cantOrds + 1;



              /* CARGAR ACTIVIDADES DE LA ORDEN */

              PROCESOACTIVIDADESORDEN(nuOrder_Id, nuCantActs, nuTransac, OnuFLAFPROCESO);



              if OnuFLAFPROCESO = 0  then

                cantActs := cantActs + nuCantActs;

                nuContadorRows := nuContadorRows + 1;



                if nuContadorRows = nuRegistrosLote then

                  nuContadorRows := 0;

                  nuLote := nuLote + 1;

                end if;

              else

                nuFlagGeneral := 1;

                LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'No se validaron satisfacotiriamente las actividades de la orden: ' || nuOrder_Id , 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

              end if; 



            END IF;

            COMMIT;



        end loop; 



        if nuFlagGeneral = 0 then

          /*Definir cuantos paquetes se generaron*/

          nuLotes :=  ceil(Recregistros%rowcount / nuRegistrosLote);



          ut_trace.trace(nuTransac || ' ' ||nuLotes  ||  ' ' || cantOrds || ' ' || cantacts ,15);

          LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'Cantidad de Lotes: ' || nuLotes,

										                              'I',

																																								CURRENT_DATE,

																																								nuMesacodi,

																																								ONUERRORCODE,

																																								OSBERRORMSG);



          LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'Cantidad de Ordenes: ' || cantOrds,

										                              'I',

																																								CURRENT_DATE,

																																								nuMesacodi,

																																								ONUERRORCODE,

																																								OSBERRORMSG);



          LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'Cantidad Actividades: ' || cantacts,

										                              'I',

																																								CURRENT_DATE,

																																								nuMesacodi,

																																								ONUERRORCODE,

																																								OSBERRORMSG);

          Close Recregistros;



									 if nuLotes > 0 then

            for contador in 1 .. nuLotes loop

              /*

                GENERAR PAYLOADS POR LOTE

              */

              ut_trace.trace('Creando payload lote : ' ||  contador || ' de ' || nuLotes,15);

              PROGENERARPAYLOADSORDENES(nuTransac,

														                          contador,

																																								nuLotes,

																																								Onuerrorcode	,

                                        Osberrormsg );



              if Onuerrorcode != 0 then

                 LDCI_PKMESAWS.proCreaMensProc(nuTransac, Osberrormsg, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

              end if;

            end loop; 

												-- actualiza el proceso

            LDCI_PKMESAWS.PROACTUESTAPROC(nuTransac, CURRENT_DATE, 'R', Onuerrorcode ,Osberrormsg);

          else

										  -- crea un mensaje de excepcion

            LDCI_PKMESAWS.PROCREAMENSPROC(nuTransac, 'La cantidad de lotes no es valida ', 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

          end if; 



        else

          Osberrormsg := 'No puede generar payloads. ';

          LDCI_PKMESAWS.proCreaMensProc(nuTransac, Osberrormsg, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

        end if;



        Osberrormsg := 'Finalizo el procesamiento de ordenes. ';

        LDCI_PKMESAWS.proCreaMensProc(nuTransac, Osberrormsg, 'I', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

        commit;

        /*

          ENVIAR NOTIFICACION

        */

        NOTIFICARPROCESOORDENES(nuTransac);

        LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'Se envio correo electronico', 'I', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

        /*

          LIMPIAR TABLA TEMPORAL

        */

        PROLIMPIARTEMPORALES;

        COMMIT;



      ELSE

        /*

          GUARDAR MENSAJE

        */

        LDCI_PKMESAWS.proCreaMensProc(nuTransac, Osberrormsg, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);



        /*

          ENVIAR NOTIFICACION

         */

        ut_trace.trace('Antes de enviar correo: ' ,15);

        NOTIFICARPROCESOORDENES(nuTransac);

        ut_trace.trace('despues de enviar correo: ' ,15);

      end IF;



    ELSE

      /*

        NO CREO EL PROCESO

      */

      PKG_ERROR.seterrormessage( isbMsgErrr =>Osberrormsg);      

    END IF;



  EXCEPTION



  When Errorpara01 then --#NC-87252: carlosvl: 07-02-2014: Se registra la excepcion generada

		    ONUERRORCODE := -1;

      OSBERRORMSG  := 'ERROR: <LDCI_PKINTERFAZORDLEC.PROCESARORDENESLECTURATRANSAC>: Error en carga de parametros: ' || OSBERRORMSG;

      LDCI_PKMESAWS.proCreaMensProc(nuTransac, OSBERRORMSG, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

      PROLIMPIARTEMPORALES;

      COMMIT;

    WHEN OTHERS THEN

      LDCI_PKMESAWS.proCreaMensProc(nuTransac, 'ERROR: ' || SQLERRM || '. ' || Dbms_Utility.Format_Error_Backtrace, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Osberrormsg);

      PROLIMPIARTEMPORALES;

      COMMIT;

  END PROCESARORDENESLECTURATRANSAC;



  procedure PROLEGALIZARORDEN( ISBDATAORDER  in varchar2 ,IDTINITDATE in date ,

  IDTFINALDATE in date,IDTCHANGEDATE  in date,  Resultado out Number,  Msj out Varchar2) AS

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.PROLEGALIZARORDEN

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Paquete de integracion de ordenes de lectura, permite legalizar ordenes de lectura



    Historia de Modificaciones

    Autor              Fecha         Descripcion
    Jorge Valiente     15-08-2013    OSF-1390: Reemplazar API OPEN llamado OS_LEGALIZEORDERS por el API PERSONALIZACIONES.API_LEGALIZEORDERS
  */

  BEGIN

     API_LEGALIZEORDERS(ISBDATAORDER, IDTINITDATE, IDTFINALDATE, IDTCHANGEDATE, Resultado, Msj);

     if Resultado = 0 then

      commit;

      Msj := 'Legalizo correctamente';

    else

      rollback;

    end if;

  EXCEPTION

    WHEN OTHERS THEN

      rollback;

  end PROLEGALIZARORDEN;





  Procedure PROCESOORDENES As

  /*

     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

     FUNCION    : LDCI_PKINTERFAZORDLEC.PROCESOORDENES

     AUTOR      : Mauricio Ortiz

     FECHA      : 15-01-2013

     RICEF      : I015

     DESCRIPCION: Procedimeinto usado en el proceso en BATCH PBPIO



    Historia de Modificaciones

    Autor   Fecha   Descripcion

  */



    cnuNULL_ATTRIBUTE    constant number := 2126;

				inuOperatingUnitId   NUMBER := -1;

				inuGeograLocationId  NUMBER := -1;

				inuConsCycleId       NUMBER;

				Inuoperatingsectorid NUMBER := -1;

				inuRouteId           NUMBER := -1;

				Idtinitialdate       Date;

				Idtfinaldata         Date;

				Inutasktypeid        Number := -1;

				inuOrderStatusId     NUMBER := 5;

				Onuerrorcode         Number;

				Osberrormsg          Varchar2(2000);

				sbParametros         VARCHAR2(200);

				sbOPERATING_UNIT_ID  ge_boInstanceControl.stysbValue;

				sbCOCICICL           ge_boInstanceControl.stysbValue;

				sbTASK_TYPE_ID       ge_boInstanceControl.stysbValue; --#NC-87453

				nuUserID             SA_USER.USER_ID%TYPE;

				nuPersonID           ge_person.person_id%type;

				sbSubnetmask         sa_user.mask%type;



  BEGIN



				sbOPERATING_UNIT_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT', 'OPERATING_UNIT_ID');

				sbCOCICICL          := ge_boInstanceControl.fsbGetFieldValue ('CONCCICL', 'COCICICL');

    sbTASK_TYPE_ID      := ge_boInstanceControl.fsbGetFieldValue ('OR_TASK_TYPES_ITEMS', 'TASK_TYPE_ID');	--#NC-87453



    ------------------------------------------------

    -- Required Attributes

    ------------------------------------------------

    --#NC-87453

    if (sbTASK_TYPE_ID is null) then

        PKG_ERROR.seterrormessage( cnuNULL_ATTRIBUTE, 'Tipo de Trabajo');

    end if;





				inuOperatingUnitId := nvl(to_number(sbOPERATING_UNIT_ID), 0);

				inuConsCycleId     := nvl(to_number(sbCOCICICL), 0);

				Inutasktypeid      := nvl(to_number(sbTASK_TYPE_ID), 0);		--#NC-87453



				nuUserID   := sa_bouser.fnuGetUserId(ut_session.getuser);

				nuPersonID := GE_BCPerson.fnuGetFirstPersonByUserId( nuUserID);



				ut_trace.trace('Inicia PROCESARORDENESLECTURATRANSAC ' || ut_session.getuser ,15);

				ut_trace.trace('USER ID ' ||nuUserID ,15);

				ut_trace.trace('PERSON ID ' || nuPersonID ,15);





				PROCESARORDENESLECTURATRANSAC(inuOperatingUnitId,

																																	 inuGeograLocationId,

																																	 inuConsCycleId,

																																	 Inuoperatingsectorid,

																																	 inuRouteId,

																																	 Idtinitialdate,

																																	 Idtfinaldata,

																																	 Inutasktypeid,

																																	 inuOrderStatusId,

																																	 Onuerrorcode,

																																	 Osberrormsg);

				ut_trace.trace('Finaliza PROCESARORDENESLECTURATRANSAC. ' || Onuerrorcode || ' - ' || Osberrormsg,15);

  EXCEPTION

    when PKG_ERROR.CONTROLLED_ERROR then

        raise;

    when OTHERS then

        PKG_ERROR.SETERROR;

        raise PKG_ERROR.CONTROLLED_ERROR;



  END PROCESOORDENES;





procedure PROSETFILEAT(inuActivity     in  NUMBER,

																						isbFileName     in  VARCHAR2,

																						isbObservation  in  VARCHAR2,

																						icbFileSrc      in  CLOB,

																						onuErrorCode		  Out NUMBER,

																						osbErrorMessage Out VARCHAR2) as

    -- define variables

	ibbFileSrc   BLOB := EMPTY_BLOB();



    -- excepciones

	exce_OS_LOADFILETOREADING EXCEPTION;	-- manejo de excepciones del API OS_LOADFILETOREADING



	function fcbClobToBlob (p_clob_in in clob) return blob is

		v_blob blob;

		v_offset integer;

		v_buffer_varchar varchar2(32000);

		v_buffer_raw raw(32000);

		v_buffer_size binary_integer := 32000;

	begin

	  if p_clob_in is null then

		return null;

	  end if;

	  dbms_lob.createtemporary(v_blob, TRUE);

	  v_offset := 1;

	  for i in 1..ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size)

	  loop

							dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);

							v_buffer_raw := hextoraw(v_buffer_varchar);

							dbms_lob.writeappend(v_blob, utl_raw.length(v_buffer_raw), v_buffer_raw);

							v_offset := v_offset + v_buffer_size;

	  end loop; 

	  return v_blob;

	end fcbClobToBlob;



begin

	-- convierte el texto HEX en BLOB

	ibbFileSrc := fcbClobToBlob(icbFileSrc);



	-- hace el llamado al API icbFileSrc

	OS_LOADFILETOREADING(inuActivity, isbFileName, isbObservation, ibbFileSrc, onuErrorCode, osbErrorMessage);





	if (onuErrorCode <> 0) then

	  raise 	exce_OS_LOADFILETOREADING;

	else

	  -- libera el espacio temporal

   dbms_lob.freetemporary(ibbFileSrc);

	  commit;

	end if;



Exception

    When exce_OS_LOADFILETOREADING then

	     rollback;

    when others  then

      rollback;

						onuErrorCode    :=  SQLCODE;

						osbErrorMessage := 'ERROR: [PROSETFILEAT.Exception.others]: Error no controlado : ' || chr(13) || SQLERRM || ' | ' || Dbms_Utility.Format_Error_Backtrace;

end PROSETFILEAT;



procedure proLegalizaLoteOrdenes(iclXMLOrdenes  in CLOB,

                                orfMensProc    out LDCI_PKREPODATATYPE.tyRefcursor)

as

/*

 * Propiedad Intelectual Gases de Occidente SA ESP

 *

 * Script  : LDCI_PKINTERFAZORDLEC.proLegalizaLoteOrdenes

 * Tiquete : I058 Provision de consumo

 * Autor   : OLSoftware / Carlos E. Virgen Londono

 * Fecha   : 24/06/2013

 * Descripcion : Registra la informacion de la provision de consumo en la tabla IC_MOVIMIEN

 *

 * Parametros:

	* IN: iclXMLOrdenes: Codigo del elemento de medicion

 * OUT: orfMensProc: Codigo del mensaje de respuesta

	*

	*

 * Autor              Fecha         Descripcion

 * carlosvl           09-04-2013    Creacion del procedimiento

 * Jorge Valiente     15-08-2013    OSF-1390: Reemplazar API OPEN llamado OS_LEGALIZEORDERS por el API PERSONALIZACIONES.API_LEGALIZEORDERS

**/

 -- definicion de variables

	onuMessageCode     NUMBER;

	osbMessageText     VARCHAR2(2000);

	boExcepcion        BOOLEAN;



	sbCASECODI         LDCI_CARASEWE.CASEDESE%type := 'WS_ENVIO_ORDENES';



	-- variables para el manejo del proceso LDCI_ESTAPROC

	sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;

	cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;

	dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;

	sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;

	nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;

 sbORDEN    LDCI_MESAPROC.MESAVAL1%type;

 -- variables para la creacion de los mensajes LDCI_MESAENVWS

 nuMESACODI LDCI_MESAENVWS.MESACODI%type;



 -- definicion de cursores

 --cursor que extrae la informacion del XML de entrada

 cursor cuLISTA_ORDENES(clXML in CLOB) is

					SELECT ORDENES.*

							FROM XMLTable('LISTA_ORDENES/ORDEN' PASSING XMLType(clXML)

																						COLUMNS

																						"ISBDATAORDER"    VARCHAR2(4000) PATH 'ISBDATAORDER',

																						"IDTINITDATE"     VARCHAR2(21) PATH 'IDTINITDATE',

																						"IDTFINALDATE"    VARCHAR2(21) PATH 'IDTFINALDATE',

																						"IDTCHANGEDATE"   VARCHAR2(21) PATH  'IDTCHANGEDATE') AS ORDENES;









 -- definicion de variables tipo registro

 reIC_DOCUGENE      IC_DOCUGENE%rowtype;



 -- excepciones

 excep_PROCARASERVWEB exception;

 excep_ESTAPROC       exception;



/*

 * NC:    Validacion de ordenes ya legalizada

 * Autor: Hector Fabio Dominguez

 * Fecha: 18-12-2013

 */



 sbMensajeValidaOrd VARCHAR2(1000);

begin

 -- inicializa el mensaje de salida

	onuMessageCode := 0;

	osbMessageText := null;

	boExcepcion    := false;



	-- realiza la creacion del proceso

	cbPROCPARA:= '	<PARAMETROS>

																<PARAMETRO>

																		<NOMBRE>iclXMLOrdenes</NOMBRE>

																		<VALOR>iclXMLOrdenes</VALOR>

																</PARAMETRO>

															</PARAMETROS>';



		LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,

																																ICBPROCPARA     => cbProcPara,

																																IDTPROCFEIN     => SYSDATE,

																																ISBPROCESTA     => 'P',

																																ISBPROCUSUA     => null,

																																ISBPROCTERM     => null,

																																ISBPROCPROG     => null,

																																ONUPROCCODI     => nuPROCCODI,

																																ONUERRORCODE    => onuMessageCode,

																																OSBERRORMESSAGE => osbMessageText);

 if (onuMessageCode <> 0) then

	   RAISE excep_ESTAPROC;

	end if;



 -- Recorre el listado de ordenes a legalziar

 for reLISTA_ORDENES in cuLISTA_ORDENES(iclXMLOrdenes) loop

	   onuMessageCode := 0;

	   osbMessageText := null;

    sbORDEN	       := substr(reLISTA_ORDENES.ISBDATAORDER,1, instr(reLISTA_ORDENES.ISBDATAORDER, '|') -1);

				-- Llama el API de lagalizacion de Ordenes

				API_LEGALIZEORDERS(reLISTA_ORDENES.ISBDATAORDER,

																						to_date(reLISTA_ORDENES.IDTINITDATE, 'YYYY-MM-DD HH24:MI:SS'),

																						to_date(reLISTA_ORDENES.IDTFINALDATE, 'YYYY-MM-DD HH24:MI:SS'),

																						to_date(reLISTA_ORDENES.IDTCHANGEDATE, 'YYYY-MM-DD HH24:MI:SS'),

																						onuMessageCode,

																						osbMessageText);



    /*

     * NC:    Validacion de ordenes ya legalizadas

     * Autor: Hector Fabio Dominguez

     * Fecha: 18-12-2013

     */



     /*

      * Validamos si el api retorno un codigo no exitoso relaciona con el estado de la orden

      */



      IF (onuMessageCode = 2582) THEN



         /*

          * Validamos Si la orden se encuentra legalizada

          */

         IF LDCI_PKINTERFAZORDLEC.fnuValidaOrdLega(sbORDEN,sbMensajeValidaOrd)=1 THEN

            /*

             * Si la orden se encuentra legalizada

             * entonces reasignamos a 0 para que el mensaje

             * sea considerado como exitoso

             */

            onuMessageCode:=0;

            osbMessageText:='ORDEN LEGALIZADA PREVIAMENTE'||osbMessageText;

         ELSE

           /*

            * En caso de que no este legalizada, agregamos la traza al mensaje

            * para que se guarde posteriormente

            */

            osbMessageText:=osbMessageText||' '||sbMensajeValidaOrd;

         END IF;



     END IF;



    --valida el mensaje de salida de la orden

				if (onuMessageCode = 0) then

									LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC => nuPROCCODI,

																																										ISBMESATIPO => 'I',

																																										INUERROR_LOG_ID => onuMessageCode,

																																										ISBMESADESC => 'LA ORDEN SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,

																																										ISBMESAVAL1 => sbORDEN,

																																										ISBMESAVAL2 => null,

																																										ISBMESAVAL3 => null,

																																										ISBMESAVAL4 => null,

																																										IDTMESAFECH => sysdate,

																																										ONUMESACODI => nuMESACODI,

																																										ONUERRORCODE => onuMessageCode,

																																										OSBERRORMESSAGE => osbMessageText);

         commit;

			else

	        boExcepcion    := true;

									LDCI_PKMESAWS.PROCREAMENSAJEPROC(INUMESAPROC => nuPROCCODI,

																																										ISBMESATIPO => 'E',

																																										INUERROR_LOG_ID => onuMessageCode,

																																										ISBMESADESC => 'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> ' || osbMessageText,

																																										ISBMESAVAL1 => sbORDEN,

																																										ISBMESAVAL2 => null,

																																										ISBMESAVAL3 => null,

																																										ISBMESAVAL4 => null,

																																										IDTMESAFECH => sysdate,

																																										ONUMESACODI => nuMESACODI,

																																										ONUERRORCODE => onuMessageCode,

																																										OSBERRORMESSAGE => osbMessageText);

         rollback;

			end if;



 end loop;



	-- finaliza el procesamiento

	LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,

																															IDTPROCFEFI     => sysdate,

																															ISBPROCESTA     => 'F',

																															ONUERRORCODE    => onuMessageCode,

																															OSBERRORMESSAGE => osbMessageText);

	if (boExcepcion = false) then

			LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC => nuPROCCODI,

																																	ISBMESADESC => 'Proceso ha terminado satisfactoriamente.',

																																	ISBMESATIPO => 'S',

																																	IDTMESAFECH => sysdate,

																																	ONUMESACODI => nuMESACODI,

																																	ONUERRORCODE => onuMessageCode,

																																	OSBERRORMESSAGE => osbMessageText);

 end if;







  -- retorna la pila de mensajes

		open orfMensProc for

			select ERROR_LOG_ID CODIGO, MESAVAL1 ORDEN, MESADESC MENSAJE

				from LDCI_MESAPROC

			where MESAPROC = nuPROCCODI;

exception

  when excep_ESTAPROC then

				 open orfMensProc for

					  select onuMessageCode CODIGO, '-1' ORDEN, osbMessageText MENSAJE from dual;

  when others then

		  --registra los mensajes de error

				LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC => nuPROCCODI,

																																		ISBMESADESC => 'SQLCODE: ' || SQLCODE  || ' : ' || SQLERRM,

																																		ISBMESATIPO => 'E',

																																		IDTMESAFECH => sysdate,

																																		ONUMESACODI => nuMESACODI,

																																		ONUERRORCODE => onuMessageCode,

																																		OSBERRORMESSAGE => osbMessageText);



		  --registra los mensajes de error

				LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC => nuPROCCODI,

																																		ISBMESADESC => 'TRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,

																																		ISBMESATIPO => 'E',

																																		IDTMESAFECH => sysdate,

																																		ONUMESACODI => nuMESACODI,

																																		ONUERRORCODE => onuMessageCode,

																																		OSBERRORMESSAGE => osbMessageText);

				-- retorna la pila de mensajes

		  open orfMensProc for

					select ERROR_LOG_ID CODIGO, MESAVAL1 ORDEN, MESADESC MENSAJE

							from LDCI_MESAPROC

						where MESAPROC = nuPROCCODI;

		  rollback;



end proLegalizaLoteOrdenes;



END LDCI_PKINTERFAZORDLEC;

/

