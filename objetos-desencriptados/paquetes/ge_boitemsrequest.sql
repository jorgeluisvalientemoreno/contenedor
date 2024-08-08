CREATE OR REPLACE PACKAGE BODY OPEN.GE_BOItemsRequest
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         :  GE_BOItemsRequest
Descripcion    :  Objeto de Negocio para manejo de las solicitudes de ítems
                  realizadas por sistemas externos.
Autor          : Cristian Solano
Fecha          : 14-Feb-2011


Historia de Modificaciones
Fecha       Autor                   Modificacion
=========== ======================= ====================
10-10-2014  eurbano.SAO277000       Se modifica <<RegisterRequest>>
28-08-2014  carizaSAO259291         Se modifica <<RegisterRequest>>
10-01-2013  ARojas.SAO199082        Se modifica «confirmRequest»
28-12-2012  ARojas.SAO198736        Se modifica «confirmRequest»
28-08-2012  jgarcia.SAO189710       Se adicionan los siguientes metodos:
                                            <<GetTransitItems>>
27-08-2012  jgutierrez.SAO186228    Se publica <<fclParseRefCursorToXML>>
                                    Se crea el método <<GetDischargeItems>>
24/07/2012  JGarcia.SAO186231       Se modifica el metodo: <<CreateAutomaticRequest>>
29-Jun-2012 JgutierrezSAO185172     Modificación <<UpdReqAcceptedAmount>>
13-Abr-2011 llopezSAO146040         Se modifica CreateAutomaticRequest
04-Abr-2011 amendezSAO144737        Se modifica método ProcesaXML
14-Feb-2011 csolanoSAO119476        Creación
******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    CSBVERSION               CONSTANT VARCHAR2(10) := 'SAO277000';

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------

    --Maximo valor float (32 bits)
    cnuMaxValue              constant float := 4294967296;

    -- Etiqueta XML a nivel de tabla de items rechazados
    csbTAG_ITEMS_REJECTED    constant styTagName := 'ITEMS_REJECTED';
    -- Etiqueta XML a nivel de fila de items rechazados
    csbTAG_ITEM_REJECTED     constant styTagName := 'ITEM';

    -- Nombre del parámetro operativo que configura la regla de validación
    -- de límite de crédito
    csbRULE_VAL_LIM_CRE      constant varchar2(20) := 'RULE_VAL_LIM_CRE';

    -- La unidad de trabajo que solicita items es nula
    cnuContractorUnitNull    CONSTANT ge_message.message_id%type := 5235;

    -- La unidad Proveedora de items es nula
    cnuProvOperUnitNull      CONSTANT ge_message.message_id%type := 6097;

    --El atributo %s1 no puede ser nulo
    cnuVALUENULL             CONSTANT ge_message.message_id%type := 1184;

    -- Mensaje del sistema: "Solicitud Automática"
    cnuMESS_COMMENT_AU_REQ   constant number(10) := 5823;

    -- Nombre de la variable que corresponde al identificador de solicitud
    -- para sistema de notificación de regla de validación fallida
    csbNU_ID_ITEMS_DOCUMENTO constant styTagName := 'NU_ID_ITEMS_DOCUMENTO';

    -- Nombre de la variable que corresponde al mensaje del error
    -- para sistema de notificación de regla de validación fallida
    csbSB_ERROR_MESSAGE      constant styTagName := 'SB_ERROR_MESSAGE';

    -- Variable para notificación que contiene el identificador de la unidad
    -- de trabajo solicitante.
    csbNU_UNIT_REQUEST       constant styTagName := 'NU_UNIT_REQUEST';

    -- Identificador de notificación a unidad de trabajo solicitante
    -- para fallos en regla de validación de límite de crédito
    csbNOTIF_REQ_IT_ERROR    constant styTagName := 'NOTIF_REQ_IT_ERROR';

    -- Codigo de error en generación de solicitud 0= Solicitud creada exitosamente
    csbNU_ERROR_MESSAGE      constant styTagName := 'NU_ERROR_MESSAGE';

    -- Error en regla de validación de límite de crédito : %s1
    cnuValidationError       CONSTANT ge_message.message_id%type := 5924;

    -- La unidad de trabajo que solicita items (%s1) es la misma unidad de trabajo que provee los items
    cnuRequestSameProv       CONSTANT ge_message.message_id%type := 6402;

    -- Tipo de configuración para reglas de validación de items.
    cnu_VAL_ITEM_CONF_TYPE   constant number(4) := 200;

    -- Clase de notificación para confirmación de requisiciones.
    cnuConfirmRequest        constant ge_notification_class.notification_class_id%type := 100;

    -- Clase de notificación para aceptación y rechazo de requisiciones.
    cnuRejOrAccRequest       constant ge_notification_class.notification_class_id%type := 101;

    -- Valor negativo del campo
    cnuNegativeError         CONSTANT ge_message.message_id%type := 9722;

    -- Etiquetas del XML de Requisiciones
    csbSOLICITUD            constant styTagName := 'SOLICITUD';
    csbITEM                 constant styTagName := 'ITEM';
    csbUDTSOLICITANTE       constant styTagName := 'UDTSOLICITANTE';
    csbUDTPROVEEDORA        constant styTagName := 'UDTPROVEEDORA';
    csbDOCEXTERNO           constant styTagName := 'DOCEXTERNO';
    csbCOMENTARIO           constant styTagName := 'COMENTARIO';
    csbID                   constant styTagName := 'ID';
    csbA_SOLICITAR          constant styTagName := 'A_SOLICITAR';
    csbCOSTO_UNIT           constant styTagName := 'COSTO_UNIT';
    csbQUANTITY             constant styTagName := 'QUANTITY';
    csbCOST                 constant styTagName := 'COST';
    csbITEM_CODE            constant styTagName := 'ITEM_CODE';

    csbDecimalCharacter     constant varchar2(1):= '.';

    -- Tipo de Causales
    cnuTrasIteTypCaus       constant  ge_causal_type.causal_type_id%type := 56;

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    -- Variables globales requeridas para poder ejecutar
    -- regla de validación de límite de crédito
    gnuItemsDocumento       ge_items_documento.id_items_documento%type;
    gnuProvOperUnitId       OR_operating_unit.operating_unit_id%type;
    gnuRequestOperUnitId    OR_operating_unit.operating_unit_id%type;
    gsbDocumentoExterno     ge_items_documento.documento_externo%type;
    gsbComentario           ge_items_documento.comentario%type;
    gtbDetailRequest        ge_bcitemsrequest.tytbRequestDetail;
    gnuIdxDetailReq         binary_integer;
    /*
    Se obtiene el identificador de la notificación configurada para
    éxito ó errores en el registro de solicitud y ejecución de
    la regla de validación (parámetro del sistema NOTIF_REQ_IT_ERROR).
    */
    gnuNotifyId         number;
    gnuNotificationId   number;
    gblCargue           boolean := FALSE;

    /* Identificador de la entidad GE_ITEMS_DOCUMENTO */
    nuENTITY_ITEMS_DOC ge_entity.entity_id%type := 1679;

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: fnuGetCurrentContract
    Descripcion	: Obtiene el contrato activo de la unidad de trabajo
                  que solicita items dada como parámetro.
                  Si no es contratista, retorna nulo.
                  Eleva excepción si:
                    - La unidad es nula o no existe
                    - Tiene definido contratista y no tiene contrato activo

    retorna	:           Descripcion
    Contrato activo

    Parametros       	: Descripcion
    inuRequestOperUnitId  Identificador de Unidad de trabajo que solicita items

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    15-02-2011    amendezSAO140554
    Creación
    *****************************************************************/
    FUNCTION fnuGetCurrentContract
    (
        inuRequestOperUnitId  in OR_operating_unit.operating_unit_id%type
    )
    return ge_contrato.id_contrato%type
    IS
        nuContract     ge_contrato.id_contrato%type;
        nuContractorId ge_contratista.id_contratista%type;
    BEGIN
    --{
        ut_trace.trace('Inicio GE_BOItemsRequest.fnuGetCurrentContract',8);
        -- Valida que la unidad de trabajo no sea nula
        if inuRequestOperUnitId IS null then
            -- Unidad de Trabajo que solicita ítems es nula
            errors.SetError(cnuContractorUnitNull);
            raise ex.CONTROLLED_ERROR;
        END if;

        -- Valida que la unidad de Trabajo exista y obtiene el contratista
        nuContractorId := daor_operating_unit.fnugetcontractor_id( inuRequestOperUnitId );

        ut_trace.trace('Current Contractor=>'||nuContractorId,8);

        -- Si la unidad es contratista
        IF nuContractorId IS not null  then
            -- Obtiene el contrato vigente del contratista
            -- Puede elevar execpción El contratista %s1 no tiene contrato activo
            nuContract := ge_bccontrato.fnuObtContratoActivo( nuContractorId );
        END if;

        ut_trace.trace('Fin GE_BOItemsRequest.fnuGetCurrentContract=>'||nuContract,8);
        return nuContract;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetCurrentContract;

    /*****************************************************************
    Método      : ProcesaXML
    Descripcion	: Procesa el XML y verifica que tipo de nodo es, para asignar
                  los datos en las tablas PL.

    Autor       : Luis Alberto López Agudelo
    Fecha       : 28-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        indNodo                     Nodo XML
        indNodoPad                  Nodo XML padre


    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    07-Abr-2011 amendezSAO144737        Se ajusta los datos que contienen
                                        números decimales, reemplazando "," por
                                        "."
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    28-Feb-2011 llopezSAO131745         Creación
    ******************************************************************/
    PROCEDURE ProcesaXML
    (
        indNodo     in      xmldom.DomNode,
        indNodoPad  in      xmldom.DomNode default null
    )
    IS
        -- Nombre del nodo
        sbNombNodo      VARCHAR2(100);
    BEGIN

        if (indNodo.id = -1) then
            return;
        end if;

        -- Captura el nombre del nodo
        sbNombNodo := xmldom.GetNodeName(indNodo);

        -- Evalua el valor del nodo y determina el procedimiento para asignar
        -- los datos del documento de caja
        if (upper(sbNombNodo) = csbSOLICITUD) then
                -- Procesa hijos
                ProcesaXML(xmlDom.getFirstChild(indNodo), indNodo);
                return;

        elsif (upper(sbNombNodo) = csbITEM) then
                -- Incrementa el indice
                gnuIdxDetailReq := gnuIdxDetailReq + 1;
                -- Procesa hijos
                ProcesaXML(xmlDom.getFirstChild(indNodo), indNodo);

        elsif (upper(sbNombNodo) = csbUDTSOLICITANTE) then
                -- Obtiene el valor de la Unidad de Trabajo Solicitante
                gnuRequestOperUnitId := substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 15);

        elsif (upper(sbNombNodo) = csbUDTPROVEEDORA) then
                -- Obtiene el valor de la Unidad de Trabajo Proveedora
                gnuProvOperUnitId := substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 15);

        elsif (upper(sbNombNodo) = csbDOCEXTERNO) then
                -- Obtiene el documento externo
                gsbDocumentoExterno := substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 30);

        elsif (upper(sbNombNodo) = csbCOMENTARIO) then
                -- Obtiene el comentario
                gsbComentario := substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 2000);

        elsif (upper(sbNombNodo) = csbID) then
                -- Obtiene el ID
                gtbDetailRequest(gnuIdxDetailReq).item := substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 15);

        elsif (upper(sbNombNodo) = csbA_SOLICITAR) then
                -- Obtiene cantidad a solicitar
                gtbDetailRequest(gnuIdxDetailReq).a_solicitar := replace(substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 11),
                                                                         ge_boConstants.csbCOLON,csbDecimalCharacter);
        elsif (upper(sbNombNodo) = csbCOSTO_UNIT) then
                -- Obtiene el costo unitario
                gtbDetailRequest(gnuIdxDetailReq).costo_unit :=  replace(substr(mo_boDom.fsbGetValTag(indNodoPad, sbNombNodo),1, 14),
                                                                         ge_boConstants.csbCOLON,csbDecimalCharacter);
        end if;

        ProcesaXML(xmlDom.getNextSibling(indNodo), indNodoPad);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ProcesaXML;

    /*****************************************************************
    Método      : CreateReqByORSIP
    Descripcion	: Método para crear Solicitud exclusivo de ORSIP.

    Autor       : Luis Alberto López Agudelo
    Fecha       : 28-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        iclXMLItems                 XML con los ítems de la solicitud
    Salida:
        onuItemsDocumento           Identificador de la solicitud creada


    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    28-Feb-2011 llopezSAO131745         Creación
    ******************************************************************/
    PROCEDURE CreateReqByORSIP(
        iclXMLItems             in  clob,
        onuItemsDocumento       out nocopy ge_items_documento.id_items_documento%type
    )
    IS
        -- Documento
        dmDocumento     xmldom.domdocument;
        -- Nodo principal
        ndNodoPrin      xmldom.DomNode;

        PROCEDURE CleanMemory
        IS
        BEGIN
            gnuIdxDetailReq := 0;
            gnuProvOperUnitId := null;
            gnuRequestOperUnitId := null;
            gsbDocumentoExterno := null;
            gsbComentario := null;
            gtbDetailRequest.delete;
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END CleanMemory;
    BEGIN

        CleanMemory();

        --Se hacer parse del documento XML
        dmDocumento := UT_XMLPARSE.parse(iclXMLItems);

        --Se recorre el nodo de la Solicitud XML
        ndNodoPrin.id := dmDocumento.id;
        ndNodoPrin := xmldom.getFirstChild(ndNodoPrin);

        --Procesa XML
        ProcesaXML(ndNodoPrin);

        GE_BOItemsRequest.RegisterRequest(
            gnuProvOperUnitId,
            gnuRequestOperUnitId,
            gsbDocumentoExterno,
            gsbComentario,
            gtbDetailRequest,
            onuItemsDocumento
        );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END CreateReqByORSIP;

    /*****************************************************************
    Método      : AddItemRequest
    Descripcion	: Adiciona un ítem a la solicitud de ítems

    Autor       : Luis Alberto López Agudelo
    Fecha       : 15-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumento           Identificador de la solicitud creada
        inuOperatingUnitId          Unidad de trabajo Solicitante
        inuItemsId                  Identificador del ítem solicitado
        inuRequestAmount            Cantidad solicitada
        inuUnitaryCost              Costo Unitario

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 llopezSAO131745         Creación
    ******************************************************************/
    PROCEDURE AddItemRequest(
        inuItemsDocumento       in  ge_items_request.id_items_documento%type,
        inuOperatingUnitId      in  ge_items_documento.operating_unit_id%type,
        inuItemsId              in  ge_items_request.items_id%type,
        inuRequestAmount        in  ge_items_request.request_amount%type,
        inuUnitaryCost          in  ge_items_request.unitary_cost%type
    )
    IS
        rcItemRequest           dage_items_request.styGE_items_request;
    BEGIN

        -- Arma el registro para inserter en GE_ITEMS_REQUEST:
        rcItemRequest.items_request_id := ge_bosequence.fnuNextGE_ITEMS_REQUES_108608;
        rcItemRequest.id_items_documento := inuItemsDocumento;
        rcItemRequest.items_id := inuItemsId;
        rcItemRequest.request_amount := inuRequestAmount;
        rcItemRequest.unitary_cost := inuUnitaryCost;

        -- Inserta el registro en la tabla GE_ITEMS_REQUEST:
        DAGE_Items_Request.InsRecord(rcItemRequest);

        -- Actualiza la cuota ocasional del ítem en la Unidad de Trabajo a cero:
        OR_BOOpeUniItemBala.resetOccacionalQuota(
            inuItemsId,
            inuOperatingUnitId
        );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AddItemRequest;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: GetPendRejectedItems
    Descripcion	: Método que retorna texto en formato XML, con la información de
                  items rechazados por la Unidad de Trabajo que solicita Items
                  y aún no aceptados por la Unidad de Trabajo Proveedora

    Parametros       	  :  Descripcion

    Entrada:
        InuProvOperUnitId   Identificador de Unidad Proveedora
    Salida
        oclXML              Clob XML con items rechazados y aún
                            no  aceptados
    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación
    15-02-2011    amendezSAO140554
    Creación
    *****************************************************************/
    PROCEDURE GetPendRejectedItems
    (
        InuProvOperUnitId   IN            OR_operating_unit.operating_unit_id%TYPE,
        IoclXML             IN OUT nocopy clob
    )
    IS
        rfQuery    SYS_REFCURSOR;
        ctxquery   dbms_xmlgen.ctxHandle;
    BEGIN

        ut_trace.trace('Inicio GE_BOItemsRequest.GetPendRejectedItems('||inuProvOperUnitId||')',8);

        -- Valida que la unidad proveedora de items no sea nula
        if inuProvOperUnitId IS null then
            -- La unidad Proveedora de items es nula
            errors.seterror(cnuProvOperUnitNull);
            raise ex.controlled_error;
        END if;

        -- Valida que la unidad proveedora de items exista
        daor_operating_unit.AccKey(inuProvOperUnitId);

        -- Obtieen CURSOR referenciado con items rechazados aún no aceptados
        rfQuery := ge_bcitemsrequest.frfGetPendRejectItems( InuProvOperUnitId );
        -- Crea variable de referencia para manejo de XML
        ctxquery := DBMS_XMLGEN.newContext(rfQuery);
        -- Establece la etiqueta XML a nivel de tabla de items rechazados
        dbms_xmlgen.setRowSetTag(ctxquery,csbTAG_ITEMS_REJECTED);
        -- Establece la etiqueta XML a nivel de fila de items rechazados
        dbms_xmlgen.setRowTag(ctxquery,csbTAG_ITEM_REJECTED);
        -- Inicializa CLOB
        dbms_lob.createtemporary(IoclXML, TRUE);
        -- Arma XML
        dbms_xmlgen.getXML(ctxquery, ioclXML, DBMS_XMLGEN.NONE);
        -- Libera recursos
        dbms_xmlgen.closeContext(ctxquery);
        close rfQuery;

        ut_trace.trace('Fin GE_BOItemsRequest.GetPendRejectedItems',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if rfQuery%ISOPEN then close rfQuery; END if;
            dbms_xmlgen.closeContext(ctxquery);
            raise;
        when OTHERS then
            errors.SetError;
            if rfQuery%ISOPEN then close rfQuery; END if;
            dbms_xmlgen.closeContext(ctxquery);
            raise ex.CONTROLLED_ERROR;

    END GetPendRejectedItems;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: SetItemRejectedOk
    Descripcion	: Ejecuta la aceptación del rechazo de un(os) item(s)
                  que fueron enviados por la unidad de trabajo proveedora
                  y fueron rechazados por la unidad de trabajo solicitante.

    Autor       :  Arturo Méndez zambrano
    Fecha       :  14-02-2011
    Parametros  :
    Entrada:                Descripción:
        inuItemRejected_Id  Identificador del movimiento de item(s) rechazado(s)
                            no aceptado(s)

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    14-02-2011    amendezSAO140554
    Creación
    *****************************************************************/
    PROCEDURE SetItemRejectedOk
    (
        inuItemRejected_Id  IN ge_check_reje_move.uni_item_bala_mov_id%TYPE
    )
    IS
        sbOldValue  ge_check_reje_move.checked%type;
        cnuLockByPk constant number(1) := 1;
    BEGIN

        ut_trace.trace('Inicio GE_BOItemsRequest.SetItemRejectedOk('||inuItemRejected_Id||')',8);

        sbOldValue := dage_check_reje_move.fsbGetChecked( inuItemRejected_Id );

        IF sbOldValue||'a' <> ge_boConstants.csbYES||'a' then
            dage_check_reje_move.updChecked( inuItemRejected_id, NULL, cnuLockByPk );
        END if;

        ut_trace.trace('Fin GE_BOItemsRequest.SetItemRejectedOk',8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END SetItemRejectedOk;

    /***************************************************************************
    Método      : UpdReqAcceptedAmount
    Descripcion	: Actualiza la cantidad de ítems aceptados para un documento e
                  ítem dado.

    Autor       : Luis Alberto López Agudelo
    Fecha       : 15-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador de la solicitud
        inuItemsId                  Identificador del ítem
        inuAmount                   Cantidad aceptada

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    29-Jun-2012 JgutierrezSAO185172     Se cambia el cierre del CURSOR ref dacadavid
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    15-Feb-2011 llopezSAO131745         Creación
    ****************************************************************************/
    PROCEDURE UpdReqAcceptedAmount(
        inuItemsDocumentId      in  ge_items_documento.id_items_documento%type,
        inuOperatingUnitId      in  or_operating_unit.operating_unit_id%type,
        inuItemsId              in  ge_items_request.items_id%type,
        inuAmount               in  ge_items_request.accepted_amount%type
    )
    IS
        tbRequestDocumentsId    dage_items_documento.tytbId_items_documento;
        nuIdx                   binary_integer;
        rfItemsRequestId        constants.tyRefCursor;
        rcItemRequest           dage_items_request.styGE_items_request;
        nuTmpAmount             ge_items_request.accepted_amount%type;
        nuMaxIncAmount          ge_items_request.accepted_amount%type;
    BEGIN

        -- Obtiene solicitudes asociadas a la factura
        tbRequestDocumentsId := ge_bcitemsdocumento.ftbGetDocsCompra(inuItemsDocumentId,
                                                                     inuOperatingUnitId);
        nuIdx := tbRequestDocumentsId.first;

        nuTmpAmount := inuAmount;

        while ((nuIdx is not null) AND (nuTmpAmount > 0)) loop

            -- Obtiene el ítem por solicitud, dado el documento y el ítem:
            rfItemsRequestId := GE_BCItemsRequest.frfGetItReqByDocAndIt(tbRequestDocumentsId(nuIdx),
                                                                        inuItemsId);

            fetch rfItemsRequestId into rcItemRequest;

            -- Si obtuvo ítem por solicitud se le adiciona la cantidad que pasa por parámetro:
            If (rfItemsRequestId%found) then
                nuMaxIncAmount := rcItemRequest.Request_Amount - nvl(rcItemRequest.Accepted_amount,0);
                if ((nuTmpAmount > nuMaxIncAmount) AND (nuIdx <> tbRequestDocumentsId.last)) then
                    rcItemRequest.Accepted_amount := nvl(rcItemRequest.Accepted_amount,0) + nuMaxIncAmount;
                    nuTmpAmount := nuTmpAmount - nuMaxIncAmount;
                else
                    rcItemRequest.Accepted_amount := nvl(rcItemRequest.Accepted_amount,0) + nuTmpAmount;
                    nuTmpAmount := 0;
                end if;

                dage_items_request.updRecord(rcItemRequest);
            end if;

            -- Se cierra el cursor
            close rfItemsRequestId;

            nuIdx := tbRequestDocumentsId.next(nuIdx);
        end loop;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            raise ex.CONTROLLED_ERROR;
    END UpdReqAcceptedAmount;

    /*****************************************************************
    Método      : UpdReqRejectedAmount
    Descripcion	: Actualiza la cantidad de ítems aceptados para un documento e
                  ítem dado.

    Autor       : Luis Alberto López Agudelo
    Fecha       : 15-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador de la solicitud
        inuItemsId                  Identificador del ítem
        inuAmount                   Cantidad aceptada

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    15-Feb-2011 llopezSAO131745         Creación
    ******************************************************************/
    PROCEDURE UpdReqRejectedAmount(
        inuItemsDocumentId      in  ge_items_documento.id_items_documento%type,
        inuOperatingUnitId      in  or_operating_unit.operating_unit_id%type,
        inuItemsId              in  ge_items_request.items_id%type,
        inuAmount               in  ge_items_request.accepted_amount%type
    )
    IS
        tbRequestDocumentsId    dage_items_documento.tytbId_items_documento;
        nuIdx                   binary_integer;
        rfItemsRequestId        constants.tyRefCursor;
        rcItemRequest           dage_items_request.styGE_items_request;
        nuTmpAmount             ge_items_request.accepted_amount%type;
        nuMaxIncAmount          ge_items_request.accepted_amount%type;
    BEGIN

        -- Obtiene solicitudes asociadas a la factura
        tbRequestDocumentsId := ge_bcitemsdocumento.ftbGetDocsAbiertos(inuItemsDocumentId,
                                                                       inuOperatingUnitId);

        nuIdx := tbRequestDocumentsId.first;

        nuTmpAmount := inuAmount;

        while ((nuIdx is not null) AND (nuTmpAmount > 0)) loop
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            -- Obtiene el ítem por solicitud, dado el documento y el ítem:
            rfItemsRequestId := GE_BCItemsRequest.frfGetItReqByDocAndIt(tbRequestDocumentsId(nuIdx),
                                                                        inuItemsId);
            fetch rfItemsRequestId into rcItemRequest;

            -- Si obtuvo ítem por solicitud se le adiciona la cantidad que pasa por parámetro:
            If (rfItemsRequestId%found) then
                nuMaxIncAmount := rcItemRequest.Request_Amount - (nvl(rcItemRequest.Accepted_amount,0) + nvl(rcItemRequest.Rejected_amount,0));
                if ((nuTmpAmount > nuMaxIncAmount) AND (nuIdx <> tbRequestDocumentsId.last)) then
                    rcItemRequest.Rejected_amount := nvl(rcItemRequest.Rejected_amount,0) + nuMaxIncAmount;
                    nuTmpAmount := nuTmpAmount - nuMaxIncAmount;
                else
                    rcItemRequest.Rejected_amount := nvl(rcItemRequest.Rejected_amount,0) + nuTmpAmount;
                    nuTmpAmount := 0;
                end if;

                dage_items_request.updRecord(rcItemRequest);
            end if;
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            nuIdx := tbRequestDocumentsId.next(nuIdx);
        end loop;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ge_bogeneralutil.Close_RefCursor(rfItemsRequestId);
            raise ex.CONTROLLED_ERROR;
    END UpdReqRejectedAmount;

    /*****************************************************************
    Método      : ftbSuggestedItems
    Descripcion	: Obtiene items sugeridos para unidad solicitante

    Autor       : Arturo Méndez Zambrano
    Fecha       : 21-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuRequestOperUnit          Unidad de trabajo Solicitante
    Salida:

    Retorna:
        Tabla pl/sql con detalle de items sugeridos

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    21-Feb-2011 amendezSAO140554        Creación
    ******************************************************************/
    FUNCTION ftbSuggestedItems
    (
        inuRequestOperUnit      in  or_operating_unit.operating_unit_id%type
    )
    return ge_bcitemsrequest.tytbRequestDetail
    IS
        cuSuggestedItems constants.tyRefCursor;
        tbSuggestedItems ge_bcitemsrequest.tytbRequestDetail;
    BEGIN

        ut_trace.trace('Inicio GE_BOItemsRequest.ftbSuggestedItems('||
                       'inuRequestOperUnit='||inuRequestOperUnit||')',8);

        cuSuggestedItems := ge_bcitemsrequest.frfGetSuggestedItems( inuRequestOperUnit );

        fetch cuSuggestedItems bulk collect INTO tbSuggestedItems;

        close cuSuggestedItems;

        ut_trace.trace('Fin GE_BOItemsRequest.ftbSuggestedItems ITEMS='||tbSuggestedItems.COUNT,8);

        return tbSuggestedItems;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuSuggestedItems%isopen then close cuSuggestedItems; END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if cuSuggestedItems%isopen then close cuSuggestedItems; END if;
            raise ex.CONTROLLED_ERROR;

    END ftbSuggestedItems;

    /*****************************************************************
    Método      : frfSuggestedQ
    Descripcion	: Obtiene items sugeridos para unidad solicitante

    Autor       : Luis Alberto López Agudelo
    Fecha       : 02-Mar-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuRequestOperUnit          Unidad de trabajo Solicitante
        inuItemId                   Identificador del ítem

    Salida:
        Tabla pl/sql con detalle de items sugeridos

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    02-Mar-2011 llopezSAO140554         Creación
    ******************************************************************/
    FUNCTION frfSuggestedQ
    (
        inuRequestOperUnit   in  or_operating_unit.operating_unit_id%type,
        inuItemId            in ge_items_request.items_id%type
    )
    return constants.tyRefCursor
    IS
        orfCursor   constants.tyRefCursor;
    BEGIN

        if (daor_ope_uni_item_bala.fblExist(inuItemId, inuRequestOperUnit)) then
            orfCursor := ge_bcitemsrequest.frfGetSuggestedItems( inuRequestOperUnit, inuItemId );
        else
            orfCursor := ge_bcitemsrequest.frfGetSuggNoBalanceQ( inuRequestOperUnit, inuItemId );
        end if;

        return orfCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(orfCursor);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ge_bogeneralutil.Close_RefCursor(orfCursor);
            raise ex.CONTROLLED_ERROR;

    END frfSuggestedQ;


    /*****************************************************************
    Método      : RegisterRequest
    Descripcion	: Registra solicitud de items con su detalle
                  Ejecuta regla de validación de límite de crédito

    Autor       : Arturo Méndez Zambrano
    Fecha       : 21-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuProvOperUnitId           Unidad de trabajo Proveedora
        inuRequestOperUnitId        Unidad de trabajo Solicitante
        isbDocumentoExterno         Documento externo
        isbComentario               Observaciones
        iotbDetailRequest           Tabla pl con el detalle de items
    Salida:
        onuItemsDocumento           Identificador de la solicitud creada

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    10-10-2014  eurbano.SAO277000       Se modifica para bloquear el registro a
                                        actualizar.
    28-Ago-2014 carizaSAO259291         Se modifica para controlar las solicitudes simultaneas
                                        de items cuando se tiene la misma unidad de trabajo solicitante.
    21-Feb-2011 amendezSAO140554        Creación
    ******************************************************************/
    PROCEDURE RegisterRequest
    (
        inuProvOperUnitId       in  ge_items_documento.operating_unit_id%type,
        inuRequestOperUnitId    in  ge_items_documento.destino_oper_uni_id%type,
        isbDocumentoExterno     in  ge_items_documento.documento_externo%type,
        isbComentario           in  ge_items_documento.comentario%type,
        iotbDetailRequest       in out nocopy ge_bcitemsrequest.tytbRequestDetail,
        onuItemsDocumento       out nocopy ge_items_documento.id_items_documento%type
    )
    IS
        blFirstItem                 boolean;
        nuIndex                     number;
        nuContract                  ge_contrato.id_contrato%type;
        nuDocRelation               ge_items_doc_rel.id_items_doc_relacion%type;
        rfCursor                    constants.tyRefCursor;
        tbSuggestedItems            ge_bcitemsrequest.tytbRequestDetail;
        nuItemValue                 ge_items_request.request_amount%type;
        rcOR_ope_uni_item_bala      daor_ope_uni_item_bala.styOR_ope_uni_item_bala;
    BEGIN

        ut_trace.trace('Inicio GE_BOItemsRequest.RegisterRequest',8);

        -- Valida que la unidad que solicita items no sea nula
        IF inuRequestOperUnitId IS null then
            -- Unidad Operativa que solicita items es nula
            errors.SetError(cnuContractorUnitNull);
            raise ex.CONTROLLED_ERROR;
        END IF;

        -- Valida que la unidad proveedora no sea nula
        IF inuProvOperUnitId IS null then
            -- La unidad Proveedora de items es nula
            errors.SetError(cnuProvOperUnitNull);
            raise ex.CONTROLLED_ERROR;
        END IF;

        -- Valida que la unidad proveedora sea diferente de la unidad que
        -- solicita items
        if inuRequestOperUnitId = inuProvOperUnitId then
            -- La unidad de trabajo que solicita items (%s1) es la misma unidad de trabajo que provee los items
            errors.SetError (cnuRequestSameProv,inuRequestOperUnitId||'-'||daor_operating_unit.fsbGetName(inuRequestOperUnitId));
            raise ex.controlled_error;
        END if;

        IF iotbDetailRequest.count = 0 then
            ut_trace.trace('No hay items para registrar solicitud',8);
            ut_trace.trace('Fin GE_BOItemsRequest.RegisterRequest',8);
            return;
        END if;

        blFirstItem := TRUE;
        -- Obtiene el inventario de items y las cuotas de la unidad de trabajo solicitante
        nuIndex := iotbDetailRequest.first;

        LOOP
            exit when nuIndex IS null;

            -- Para el primer item sugerido crea la solicitud
            IF blFirstItem THEN
                -- Registra la solicitud (orden de compra) con documento externo nulo
                GE_BOITemsDocumento.RegistrarDocumento
                (
                    ge_boitemsconstants.cnuTipoOrdenCompra,
                    inuRequestOperUnitId,
                    inuProvOperUnitId,
                    ut_date.fdtsysdate,
                    isbDocumentoExterno,
                    ge_boitemsconstants.csbEstadoRegistrado,
                    isbComentario,
                    onuItemsDocumento
                );

                -- Se crea una relación del documento consigo mismo, con el fin de
                -- Unificar la búsqueda en aceptación de ítems:
                GE_BOITemsDocumento.RelacionarDocumento
                (
                    onuItemsDocumento,
                    onuItemsDocumento,
                    nuDocRelation
                );

                blFirstItem := FALSE;

            END IF;

            /*Bloquear el registro que será actualizado*/
            GE_BcItemsRequest.LockBalbyOperUnit
            (
              iotbDetailRequest(nuIndex).item,
              inuRequestOperUnitId,
		      rcOR_ope_uni_item_bala
            );


            rfCursor := GE_BCItemsRequest.frfGetSuggestedItems(inuRequestOperUnitId, rcOR_ope_uni_item_bala.items_id);

            fetch rfCursor bulk collect INTO tbSuggestedItems;
            close rfCursor;

            nuItemValue := tbSuggestedItems(1).a_solicitar;
            ut_trace.trace('nuItemValue:'||nuItemValue,8);

            IF nuItemValue >= iotbDetailRequest(nuIndex).a_solicitar THEN
                -- Si la solicitud fue creada registra los items individuales
                IF onuItemsDocumento IS not null then
                     GE_BOItemsRequest.AddItemRequest
                     (
                         onuItemsDocumento,
                         rcOR_ope_uni_item_bala.Operating_Unit_Id,
                         rcOR_ope_uni_item_bala.items_id,
                         iotbDetailRequest(nuIndex).a_solicitar,
                         iotbDetailRequest(nuIndex).costo_unit
                     );
                    -- Deja la cuota ocasional del item en la unidad de trabajo en cero.
                    OR_BOOpeUniItemBala.resetOccacionalQuota(
                        rcOR_ope_uni_item_bala.items_id,
                        rcOR_ope_uni_item_bala.Operating_Unit_Id
                    );
                END IF;
            ELSE
                -- La cantidad de items sugeridos es menor a la cantidad solicitada
                ge_boerrors.seterrorcodeargument(7762,iotbDetailRequest(nuIndex).a_solicitar||'|'||iotbDetailRequest(nuIndex).item);
                raise ex.controlled_error;
            END if;

            nuIndex := iotbDetailRequest.next(nuIndex);
        END LOOP;

        ut_trace.trace('Se creó solicitud de items=>'||onuItemsDocumento,8);
        ut_trace.trace('Fin GE_BOItemsRequest.RegisterRequest',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END RegisterRequest;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: CreAutomaticRequestProc
    Descripcion	: Proceso que verifica el inventario de la unidad solicitante
                  y crea solicitud a la unidad proveedora para completar
                  el cupo total para cada item
                  Ejecuta regla de validación de límite de crédito

                  Para que la solicitud sea creada, se ejecuta regla de
                  validación de límite de crédito en caso de estar configurada,
                  si la regla de validación existe y no supera la validación,
                  se notifica a la unidad de trabajo solicitante, utilizando
                  para ello el identificador de notificación configurado
                  en el parámetro operativo NOTIF_REQ_IT_ERROR.
                  Si la regla no esta configurada no hace nada.
                  Esta notificación deberá ser configurada por el operador
                  del sistema.
                  Lo anterior permitirá que la unidad operativa solicitante
                  sea informada del fallo ocurrido en la regla de validación
                  cuando se intentó crear la solicitud automática.
                  También se enviará notificación cuando la solicitud sea
                  exitosa.

                  Como input para la notificación se envía:
                   NU_ID_ITEMS_DOCUMENTO=valor (Solicitud)
                   NU_UNIT_REQUEST=valor       (Unidad de T. q solicita items)
                   NU_ERROR_MESSAGE=valor      (Identificador de error
                                                0=solicitud creada exitosamente)
                   SB_ERROR_MESSAGE=valor      (Mensaje del error)

                  Por medio de la configuración de notificación, es posible
                  obtener por medio de sentencias los datos relacionados
                  con la solicitud que falló, las sentencias y plantilla XML
                  deberán ser configuradas por el operador del sistema.

                  Para el caso de notificación por e-mail, el asunto y remitente
                  dependen de la configuración en el sistema de notificaciones
                  por correo, actualmente el asunto es
                  "Notificación Automatica de alertas",
                  y el remitente el configurado en el parámetro NOTIF_MAIL_FROM

    Parametros       	  :  Descripcion
    Entrada:
        inuProvOperUnitId        Identificador unidad operativa proveedora
        inuRequestOperUnitId     Identificador unidad operativa solicitante
    Salida:
        osbErrMessage            Error en ejecución de regla de validación

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    07-04-2011  csolanoSAO145406        Se modifica la fomra de obtener el
                                        identificador de la notificación
    15-02-2011    amendezSAO140554
    Creación
    *****************************************************************/
    PROCEDURE CreAutomaticRequestProc
    (
        inuProvOperUnitId    in OR_operating_unit.operating_unit_id%type,
        inuRequestOperUnitId in OR_operating_unit.operating_unit_id%type
    )
    IS
        nuItemsDocumento      ge_items_documento.id_items_documento%type;
        sbComment             ge_items_documento.comentario%type;
        tbSuggestedItems      GE_BCItemsRequest.tytbRequestDetail;

        -- Variables para notificación
        nuNotifica_log        ge_notification_log.notification_log_id%type;
        nuErrorNotify         number;
        sbErrorNotify         varchar2(32767);

        nuerrMessage          number;
        sbErrMessage          varchar2(32767);

        nuNotificationId    ge_notification.notification_id%type;
    BEGIN

        ut_trace.trace('Inicio GE_BOItemsRequest.CreAutomaticRequestProc('||
                       'inuProvOperUnitId='||inuProvOperUnitId||','||
                       'inuRequestOperUnitId='||inuRequestOperUnitId||')',8);

        -- Valida que la unidad de trabajo solicitante no sea nula
        if inuRequestOperUnitId IS null then
            -- Unidad de Trabajo que solicita ítems es nula
            errors.SetError(cnuContractorUnitNull);
            raise ex.CONTROLLED_ERROR;
        END if;
        daor_operating_unit.AccKey( inuRequestOperUnitId);

        -- Calcula comentario de la solicitud a crear
        -- "Solicitud Automática"
        sbComment := dage_message.fsbgetdescription( cnuMESS_COMMENT_AU_REQ );

        -- Obtiene tabla pl de items sugeridos
        tbSuggestedItems := ge_boitemsrequest.ftbSuggestedItems(inuRequestOperUnitId);

        -- Se inicializan las variables de salida
        ge_boutilities.InitializeOutput(nuerrMessage, sbErrMessage);
        BEGIN

            -- Crea la solicitud y ejecuta regla de validación de límite de crédito
            RegisterRequest
            (
                inuProvOperUnitId,
                inuRequestOperUnitId,
                null,
                sbComment,
                tbSuggestedItems,
                nuItemsDocumento
            );
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ERRORS.GetError(nuerrMessage,sbErrMessage);
                raise;
            when OTHERS then
                errors.SetError;
                ERRORS.GetError(nuerrMessage,sbErrMessage);
                raise ex.CONTROLLED_ERROR;
        END;

        -- Notifica a la unidad de trabajo que solicita items
        -- exito o falla en la creación de la solicitud.

        -- Elimina en el mensaje la ocurrencia de ";" o "="
        -- porque son caracteres para delimitar el input de la notificación
        sbErrMessage := replace( sbErrMessage,ge_boconstants.csbEQUAL,' ');
        sbErrMessage := replace( sbErrMessage,ge_boconstants.csbSEMICOLON,' ');

        nuNotificationId := ge_bcitemsrequest.fnuGetNotification(cnuRejOrAccRequest);

        --Se envía esta notificación de éxito ó falla, especificando como criterio para
        --las sentencias de la misma, el identificador de la solicitud
        --unidad solicitante, codigo de error y mensaje de error.
        --Codigo de error=0 solicitud creada exitosamente
        ut_trace.trace('Id de la notificación:'||gnuNotifyId);
        ut_trace.trace('Notificando para solicitud =>'||nuItemsDocumento||'=>'||sbErrMessage,8);
        ut_trace.trace(csbNU_ID_ITEMS_DOCUMENTO||ge_boconstants.csbEQUAL||nuItemsDocumento||ge_boconstants.csbSEMICOLON||
                       csbNU_ERROR_MESSAGE||ge_boconstants.csbEQUAL||nuerrMessage||ge_boconstants.csbSEMICOLON||
                       csbSB_ERROR_MESSAGE||ge_boconstants.csbEQUAL||sbErrMessage||ge_boconstants.csbSEMICOLON||
                       csbNU_UNIT_REQUEST||ge_boconstants.csbEQUAL||inuRequestOperUnitId);
        if (dage_notification.fblexist(nuNotificationId)) then
            ge_bonotification.SendNotify
                            (
                                nuNotificationId,
                                1,
                                csbNU_ID_ITEMS_DOCUMENTO||ge_boconstants.csbEQUAL||nuItemsDocumento||ge_boconstants.csbSEMICOLON||
                                  csbNU_ERROR_MESSAGE||ge_boconstants.csbEQUAL||nuerrMessage||ge_boconstants.csbSEMICOLON||
                                  csbSB_ERROR_MESSAGE||ge_boconstants.csbEQUAL||sbErrMessage||ge_boconstants.csbSEMICOLON||
                                  csbNU_UNIT_REQUEST||ge_boconstants.csbEQUAL||inuRequestOperUnitId,
                                nuItemsDocumento,   -- Identificador externo
                                nuNotifica_log,
                                nuErrorNotify,
                                sbErrorNotify
                            );
        end if;

        ut_trace.trace('Fin GE_BOItemsRequest.CreAutomaticRequestProc',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END CreAutomaticRequestProc;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: CreateAutomaticRequest
    Descripcion	: Proceso que verifica el inventario de la unidad solicitante
                  y crea solicitud a la unidad proveedora para completar
                  el cupo total para cada item.

                  Debe ser publicado como objeto para ser ejecutado
                  periódicamente según programación de JOBS mediante GEMPS

    Parametros       	  :  Descripcion
    inuProvOperUnitId        Identificador unidad operativa proveedora

    Historia de Modificaciones
    Fecha       ID Entrega              Modificación
    24/07/2012  JGarcia.SAO186231       Se adiciona verificacion de Proveedor Logístico,
                                        que la unidad operativa proveedora y la unidad de
                                        trabajo que hara la requisicion sean de la misma
                                        base administrativa.
    13-Abr-2011 llopezSAO146040         Se corrige error que no actualizaba el registro
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    15-02-2011  amendezSAO140554        Creación
    *****************************************************************/
    PROCEDURE CreateAutomaticRequest
    (
        inuProvOperUnitId   in  or_operating_unit.operating_unit_id%type
    )
    IS
 	    /* PRAGMA para implementacion de transacciones autonomas */
        PRAGMA AUTONOMOUS_TRANSACTION;

        osbErrMessage       varchar2(32767);
        nuRequestOperUnitId OR_operating_unit.operating_unit_id%type;
        rfOperUnits         constants.tyRefCursor;
        rcOperUnit          daor_operating_unit.styOR_operating_unit;
        dtSysdate           date;
        rcProvOperUnit      daor_operating_unit.styOR_operating_unit;

    BEGIN

        dtSysdate := trunc(ut_date.fdtSysdate);
        ge_bogeneralutil.Close_RefCursor(rfOperUnits);

       --Carga los datos de la unidad perativa proovedora
        DAOR_operating_unit.getRecord(inuProvOperUnitId, rcProvOperUnit);

        --Validar que la unidad de trabajo proveedora sea de clasificación "Proveedor Logístico".
        if ( rcProvOperUnit.Oper_Unit_Classif_Id <> or_boconstants.fnuGetLogistProvidClassif ) then

            ge_boerrors.SetErrorCode(901487); --La unidad de trabajo proveedora debe ser de clasificación "Proveedor Logístico"

        END if;

        -- obtener las Unidades de trabajo a las que se les vencio la fecha de requisición
        rfOperUnits := GE_BCItemsRequest.frfReqOperUnits(dtSysdate);

        loop
            fetch rfOperUnits into rcOperUnit;
        exit when rfOperUnits%notfound;

            --Validar que la unidad de trabajo que hará la requisición sea de la
            -- misma base administrativa de la unidad de trabajo proveedora, esto
            -- quiere decir que una requisición solo se puede realizar entre unidades
            -- de la misma base administrativa
            if ( rcProvOperUnit.ADMIN_BASE_ID = rcOperUnit.ADMIN_BASE_ID ) then

                if (rcOperUnit.ITEM_REQ_FRECUENCY is not null) then
                    rcOperUnit.NEXT_ITEM_REQUEST :=
                        ge_boschedule.fdtGetJobNextExeDate(
                            nvl(rcOperUnit.NEXT_ITEM_REQUEST,dtSysdate),
                            rcOperUnit.ITEM_REQ_FRECUENCY
                        );
                else
                    rcOperUnit.NEXT_ITEM_REQUEST := null;
                end if;
                daor_operating_unit.UpdRecord(rcOperUnit);
                CreAutomaticRequestProc
                (
                    inuProvOperUnitId,
                    rcOperUnit.operating_unit_id
                );
                pkgeneralservices.CommitTransaction;

            END if;
        end loop;

        ge_bogeneralutil.Close_RefCursor(rfOperUnits);

        ut_trace.trace('Fin GE_BOItemsRequest.CreateAutomaticRequest',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            -- Deshace la transacción
            rollback;
            ge_bogeneralutil.Close_RefCursor(rfOperUnits);
            raise;
        when OTHERS then
            errors.SetError;
            -- Deshace la transacción
            rollback;
            ge_bogeneralutil.Close_RefCursor(rfOperUnits);
            raise ex.CONTROLLED_ERROR;
    END CreateAutomaticRequest;

    /*****************************************************************
    Método      : confirmRequest
    Descripcion	: Confirma una solicitud.

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
        isbRequestConfirm       Texto XML con la confirmación de la solicitud.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    10-01-2013  Arojas.SAO199082        Se reversa cambios SAO198736
    28-12-2012  ARojas.SAO198736        Se agrega la posibilidad de insertar fecha diferente a la del sistema.
    12-12-2012  cburbano.SAO197913      Se modifica para cambiar el llamada al método de
                                        notificación por el nuevo método para versión 7.7
    04-12-2012  llopezSAO197413         Se modifica para que reciba el item_code
                                        y no el item_id
    29-11-2012  AEcheverrysAO196606     Se modifica para cerrar el documento
                                        cuando no hay items pendientes, se crea
                                        el servicio tryCloseDocument
    19-04-2011  csolanoSAO146724        Se agregan validaciones.
    14-04-2011  csolanoSAO146148        Se corrige error en el envío de
                                        notificación.
    13-04-2011  csolanoSAO145880        Se corrige error de lectura de xml
    07-04-2011  csolanoSAO145406        Se modifica la fomra de obtener el
                                        identificador de la notificación
    25-Mar-2011 llopezSAO143023         Modificaciones Revisión de pares
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    PROCEDURE confirmRequest
    (
        iclRequestConfirm   in out CLOB
    )
    IS
        dmDocument      xmldom.domdocument;
        ndNode          xmldom.DomNode;
        ndPrev          xmldom.DomNode;
     --   ndItemNode      xmldom.DomNode;
      --  ndPrevItemNode  xmldom.DomNode;
        ndItemsNode     xmldom.DOMNode;
        ndDocumentNode  xmldom.DOMNode;
        sbNodeName      styTagName;

        --Variables de notificación
        sbInput             Varchar2(32767);
        nuNotifica_log      ge_notification_log.notification_log_id%type;
        nuErrorCode         ge_message.message_id%type;
        sbErrorText         ge_message.description%type;

        nuDocumentId        ge_items_request.id_items_documento%type;
        nuOperatingUnitId   or_operating_unit.operating_unit_id%type;
        nuDeliveryDate      ge_items_documento.delivery_date%type;

        nuNotificationId    ge_notification.notification_id%type;

        sbNotifSends        ge_boutilities.styStatementAttribute;
        sbLogNotif          ge_boutilities.styStatementAttribute;


        PROCEDURE acceptItems
        IS
            nuItemsId   ge_items_request.items_id%type;
            nuAmount    ge_items_request.confirmed_amount%type;
            nuCost      ge_items_request.confirmed_cost%type;
        BEGIN

            ndNode := xmldom.getFirstChild (ndItemsNode);

            while ndNode.id != -1 loop

                nuItemsId   := GE_BOItems.fnuGetItemsId(ut_xpath.valueOf(ndNode, csbITEM_CODE));

                nuAmount    := to_number(ut_xpath.valueOf(ndNode, csbQUANTITY));
                IF nuAmount < 0 THEN
                    errors.SetError (cnuNegativeError, csbQUANTITY);
                    raise ex.CONTROLLED_ERROR;
                END IF;

                nuCost      := to_number(ut_xpath.valueOf(ndNode, csbCOST));
                IF nuCost < 0 THEN
                    errors.SetError (cnuNegativeError, csbCOST);
                    raise ex.CONTROLLED_ERROR;
                END IF;

                -- Actualizamos la cantidad aceptada del ítem
                GE_BCItemsRequest.updAcceptedItemAmount(nuDocumentId, nuItemsId, nuAmount, nuCost);
                ndNode := xmldom.getNextSibling (ndNode);

            END loop;

        EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;

        END acceptItems;

        -- INTENTA CERRAR EL DOCUMENTO, SI NO HAY ITEMS PENDIENTES POR CONFIRMAR REf. JCASSO
        PROCEDURE tryCloseDocument
        IS
        BEGIN
            if (ge_bcitemsrequest.fsbHavePendItemRequ(nuDocumentId) = ge_boconstants.GetNO)
            then
                dage_items_documento.updEstado(nuDocumentId, ge_boitemsconstants.csbEstadoCerrado);
            END if;
        EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
        END tryCloseDocument;

    BEGIN
        -- Validamos y formateamos la entrada.
        ge_boitemscargue.decupXML(iclRequestConfirm);

        -- Se parsea el código XML
        dmDocument := ut_xmlparse.parse(iclRequestConfirm);
        ndNode.id := dmDocument.id;

        ndNode := xmldom.getFirstChild (ndNode); --Request_Config
        ndNode := xmldom.getFirstChild (ndNode); --either items OR document

        while ndNode.id != -1 loop
            --Guardamos el nodo que estamos cargando
                ndPrev := ndNode;

                -- Obtenemos el nombre de la etiqueta xml
                sbNodeName := upper(xmldom.getNodeName(ndNode));

                if sbNodeName = 'DOCUMENT' then
                    --Guardamos el nodo con los los datos del documento
                    ndDocumentNode := ndNode;
                elsif sbNodeName = 'ITEMS' then
                    --Guardamos el nodo con los los datos del documento
                    ndItemsNode := ndNode;
                else
                    null;
                END if;
                ndNode := xmldom.getNextSibling (ndPrev);
        END loop;

        -- Obtenemos los datos del documento.
        nuDocumentId := to_number(ut_xpath.valueOf(ndDocumentNode, 'DOCUMENT_ID'));

        dage_items_documento.AccKey(nuDocumentId);

        nuOperatingUnitId := to_number(ut_xpath.valueOf(ndDocumentNode, 'OPERATING_UNIT_ID'));
        nuDeliveryDate := to_date(ut_xpath.valueOf(ndDocumentNode, 'DELIVERYDATE'));

        dage_items_documento.updDelivery_Date(nuDocumentId, nuDeliveryDate);

        GE_BCItemsRequest.initRequestConfirm(nuDocumentId);

        acceptItems;

        tryCloseDocument;

        ut_trace.trace('Id de la notificación['||gnuNotificationId||']OPERATING_UNIT_ID='||nuOperatingUnitId, 15);

        ge_boalertmessageparam.VerAndSendNotif
        (
            nuENTITY_ITEMS_DOC,  -- SELECT * FROM ge_entity WHERE name_ = 'GE_ITEMS_REQUEST'
            nuDocumentId,
            NULL,
            NULL,
            sbNotifSends,
            sbLogNotif
        );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END confirmRequest;

    /*****************************************************************
    Método      : fclParseRefCursorToXML
    Descripcion	: Convierte los resultados de CURSOR referenciado a formato a
                  formato XML.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        irfQuery                    CURSOR referenciado (No es responsabilidad
                                    de esta función cerrarlo).
        isbEntityLabel              Nombre de la etiqueta agrupadora de filas.
        isbRowLabel                 Nombre de la etiqueta de cada fila (Usar
                                    null si solo se consulta un campo por fila).

    Salida:
        IoclXML                     Código XML con las solicitudes en estado
                                    (R)egistradas.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    22-Feb-2011 csolanoSAO144737X        Creación
    ******************************************************************/
    FUNCTION fclParseRefCursorToXML
    (
        irfQuery         in  SYS_REFCURSOR,
        isbEntityLabel   in  ge_entity.name_%type,
        isbRowLabel      in  ge_entity_attributes.tag_element%type
    )
    return CLOB
    IS
        ctxquery   dbms_xmlgen.ctxHandle;
        clXML      CLOB;
    BEGIN

        -- Crea variable de referencia para manejo de XML
        ctxquery := DBMS_XMLGEN.newContext(irfQuery);

        dbms_xmlgen.setRowSetTag(ctxquery,isbEntityLabel);
        -- Establece la etiqueta XML a nivel de fila de items rechazados
        dbms_xmlgen.setRowTag(ctxquery,isbRowLabel);
        -- Inicializa CLOB
        dbms_lob.createtemporary(clXML, TRUE);
        -- Arma XML
        dbms_xmlgen.getXML(ctxquery, clXML, DBMS_XMLGEN.NONE);
        -- Libera recursos
        dbms_xmlgen.closeContext(ctxquery);

        return clXML;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            dbms_xmlgen.closeContext(ctxquery);
            raise;
        when OTHERS then
            errors.SetError;
            dbms_xmlgen.closeContext(ctxquery);
            raise ex.CONTROLLED_ERROR;

    END fclParseRefCursorToXML;

    /*****************************************************************
    Método      : getRegisteredRequests
    Descripcion	: Obtiene las solicitudes registradas para un proveedor.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuProvOperUnitId           Identificador del proveedor

    Salida:
        IoclXML                     Código XML con las solicitudes en estado
                                    (R)egistradas.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    22-Feb-2011 csolanoSAO144737X        Creación
    ******************************************************************/
    PROCEDURE getRegisteredRequests
    (
        inuProvOperUnitId   IN            OR_operating_unit.operating_unit_id%type,
        ioclXML             IN OUT nocopy clob
    )
    IS
        rfQuery    SYS_REFCURSOR;
        ctxquery   dbms_xmlgen.ctxHandle;
    BEGIN

        -- Valida que la unidad proveedora de items no sea nula
        if inuProvOperUnitId IS null then
            errors.seterror(cnuProvOperUnitNull);
            raise ex.controlled_error;
        END if;

        -- Valida que la unidad proveedora de items exista
        daor_operating_unit.AccKey(inuProvOperUnitId);

        -- Obtenemos CURSOR referenciado con items rechazados aún no aceptados
        rfQuery := ge_bcitemsrequest.frfGetRegisteredRequests( inuProvOperUnitId );

        -- Parseamos la consulta a XML
        ioclXML := fclParseRefCursorToXML(rfQuery, 'REQUESTS_REG', null);


/*
        -- Crea variable de referencia para manejo de XML
        ctxquery := DBMS_XMLGEN.newContext(rfQuery);

        dbms_xmlgen.setRowSetTag(ctxquery,'REQUESTS_REG');
        -- Establece la etiqueta XML a nivel de fila de items rechazados
        dbms_xmlgen.setRowTag(ctxquery,null);
        -- Inicializa CLOB
        dbms_lob.createtemporary(IoclXML, TRUE);
        -- Arma XML
        dbms_xmlgen.getXML(ctxquery, ioclXML, DBMS_XMLGEN.NONE);
        -- Libera recursos
        dbms_xmlgen.closeContext(ctxquery);                              */
        close rfQuery;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if rfQuery%ISOPEN then close rfQuery; END if;
            dbms_xmlgen.closeContext(ctxquery);
            raise;
        when OTHERS then
            errors.SetError;
            if rfQuery%ISOPEN then close rfQuery; END if;
            dbms_xmlgen.closeContext(ctxquery);
            raise ex.CONTROLLED_ERROR;

    END getRegisteredRequests;

    /*****************************************************************
    Método      : getRequestData
    Descripcion	: Obtiene las solicitudes registradas para un proveedor.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador del documento asociado.

    Salida:
        ioclXML                     Código XML con las solicitudes en estado
                                    (R)egistradas.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    22-Feb-2011 csolanoSAO144737X        Creación
    ******************************************************************/
    PROCEDURE getRequestData
    (
        inuItemsDocumentId  in  ge_items_request.id_items_documento%type,
        ioclXML             IN OUT nocopy clob
    )
    IS
        rfQuery         SYS_REFCURSOR;
        ctxquery        dbms_xmlgen.ctxHandle;
        clItems         CLOB;

        nuInsertPoint   Number;

        /*
        ndXMLAddAtts    xmldom.DomNode;
        dmDocument      xmldom.domdocument;
        ndNode          xmldom.DomNode;
        ndPrev          xmldom.DomNode;
        */
    BEGIN


        -- Valida que la unidad proveedora de items exista
        dage_items_documento.AccKey(inuItemsDocumentId);

        -- Obtiene CURSOR referenciado con los datos de la solicitud
        rfQuery := ge_bcitemsrequest.frcGetRequestData( inuItemsDocumentId );

        -- Parseamos la consulta a XML
        ioclXML := fclParseRefCursorToXML(rfQuery, 'REQUEST', 'DOCUMENT');

        close rfQuery;

        -- Obtiene CURSOR referenciado con los items de una solicitud
        rfQuery := ge_bcitemsrequest.frcGetDocItemsXML( inuItemsDocumentId );

        -- Parseamos la consulta a XML
        clItems := fclParseRefCursorToXML(rfQuery, 'ITEMS', 'ITEM');

        close rfQuery;

        --Fusionamos los dos xmls

        ge_boitemscargue.decupXML(clItems);

        ioclXML := replace(ioclXML, '</DOCUMENT>'||chr(10),'</DOCUMENT>'||clItems);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(rfQuery);
            dbms_xmlgen.closeContext(ctxquery);
            raise;
        when OTHERS then
            errors.SetError;
            ge_bogeneralutil.Close_RefCursor(rfQuery);
            dbms_xmlgen.closeContext(ctxquery);
            raise ex.CONTROLLED_ERROR;

    END getRequestData;


    /*****************************************************************
    Método      : ExtString
    Descripcion	: Divide una cadena según una subcadena

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
      isbString    Cadena a dividir
      isbDelimiter Subcadena de separación

    Salida:
      otbString     Tabla de cadenas separadas.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    PROCEDURE ExtString
    (
      isbString    IN clob,
      isbDelimiter IN clob,
      otbString    IN OUT NOCOPY UT_String.TyTB_String
    )
    IS
      nuLPos      PLS_INTEGER;
      nuPos       PLS_INTEGER := 0;
      nuCrt       PLS_INTEGER := 1;
    BEGIN
        If NVL(Length(isbDelimiter), 0) = 0 or NVL(Length(isbString), 0) = 0 then
         Return;
        end if;

        Loop

            if nuLPos <> 0 then
                nuLPos := nuPos + Length(isbDelimiter);
            else
                nuLPos := 1;
            END if;

            nuPos  := INSTR (isbString, isbDelimiter, nuLPos);

            --Si es el último
            if nuLPos > 0 AND nuPos = 0 then
                otbString (nuCrt) := SubStr (isbString, nuLPos, Length(isbString));
            END if;

            Exit when nuPos = 0;

            otbString (nuCrt) := SubStr (isbString, nuLPos, nuPos - nuLPos);

            if nuPos = Length (isbString) then
                otbString (nuCrt + 1) := NULL;
            END if;

            nuCrt := nuCrt + 1;
        End Loop;
    EXCEPTION
      when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ExtString;

    /*****************************************************************
    Método      : fsbGetOpeningLabel
    Descripcion	: Convierte el nombre de una etiqueta a formatoXML

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
      isbString                 Nombre de la etiqueta

    Salida:
      otbString                 Etiqueta en formato XML

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    Function fsbGetOpeningLabel
    (
        isbString    IN clob
    ) return clob
    IS
    BEGIN
        return '<'||isbString||'>';
    EXCEPTION
      when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetOpeningLabel;

    /*****************************************************************
    Método      : fsbGetClosureLabel
    Descripcion	: Convierte el nombre de una etiqueta a formatoXML (cierre)

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
      isbString                 Nombre de la etiqueta

    Salida:
      otbString                 Etiqueta en formato XML

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    Function fsbGetClosureLabel
    (
      isbString    IN clob
    ) return clob
    IS
    BEGIN
        return '</'||isbString||'>';
    EXCEPTION
      when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetClosureLabel;

   /*****************************************************************
    Método      : fsbGetLabelValue
    Descripcion	: Obtiene el valor de una etiqueta xml

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
      isbXMLString              Texto XML
      isbLabel                  Etiqueta a buscar
      inuOccurrence             Ocurrencia de la etiqueta apartir de la cual
                                se buscará el valor.
    Salida:
      otbString                 Etiqueta en formato XML

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    Function fsbGetLabelValue
    (
      isbXMLString    IN clob,
      isbLabel        IN clob,
      inuOccurrence   in number default 1
    ) return clob
    IS
        sbOpening clob;
        sbClosure clob;
        nuStartSearchPos number;
        nuStart number;
        nuEnd   number;
    BEGIN
        sbOpening := fsbGetOpeningLabel(isbLabel);
        sbClosure := fsbGetClosureLabel(isbLabel);

        --Faltan validaciones

        if inuOccurrence = 1 then
            nuStartSearchPos := 1;
        else
            nuStartSearchPos := INSTR(isbXMLString, sbClosure, 1, inuOccurrence - 1);
        END if;

        nuStart := INSTR(isbXMLString, sbOpening, nuStartSearchPos)+ length(sbOpening);

        if nuStart = length(sbOpening) then
            return '';
        END if;

        nuEnd := INSTR(isbXMLString, sbClosure, nuStart)-nuStart;

        return substr(isbXMLString, nuStart, nuEnd);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetLabelValue;

    /*****************************************************************
    Método      : fsbGetLabelName
    Descripcion	: Obtiene el nombre de la enésima etiqueta xml

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
      isbXMLString              Texto XML
      inuLabelNumber            Etiqueta a buscar

    Salida:
      otbString                 Nombre de la enésima etiqueta.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creación
    ******************************************************************/
    Function fsbGetLabelName
    (
      isbXMLString    IN clob,
      inuLabelNumber  in number default 1
    ) return clob
    IS
        nuStart number;
        nuEnd   number;

    BEGIN
        nuStart   := INSTR(isbXMLString, '</', 1,inuLabelNumber)+2;

        if nuStart = 2 then
            return '';
        END if;

        nuEnd := INSTR(isbXMLString, '>', nuStart)-nuStart;

        return substr(isbXMLString, nuStart, nuEnd);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetLabelName;

    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : GetDischargeItems
    Descripción : Consultar ítems rechazados
    Autor       : Juan Alexander Gutíerrez
    Fecha       : 27-08-2012
    Parametros  :
      Entrada:
        iclXMLIn   Información de entreda.
      Salida:
        oclXMLOut  Ítems dados de baja

    Historia de Modificaciones
    Fecha       Autor                  Modificación
    ==========  ====================   ===================================
    27-08-2012  jgutierrez.SAO186228   Creación.
    ***************************************************************************/
    PROCEDURE GetDischargeItems
    (
        iclXMLIn  IN  CLOB,
        oclXMLOut OUT CLOB
    )
    IS
        clXMLIn         CLOB;
        dmDocument      xmldom.domdocument;
        ndNode          xmldom.DomNode;
        sbNodeName      VARCHAR2(100);
        sbNodeValue     VARCHAR2(100);

        sbOperatingUnit VARCHAR2(100);
        sbInitialDate   VARCHAR2(100);
        sbFinalDate     VARCHAR2(100);

        nuOperatingUnit or_operating_unit.operating_unit_id%type;
        dtInitialDate   or_uni_item_bala_mov.move_date%type;
        dtFinalDate     or_uni_item_bala_mov.move_date%type;
        rfQuery         Constants.tyRefCursor;
    BEGIN
        ut_trace.trace('INICIO GE_BOItemsRequest.GetDischargeItems', 2);

        --Validar encabezado del XML
        clXMLIn := iclXMLIn;
        GE_BOItemsCargue.decupXML(clXMLIn);

        --Se hacer parse del documento XML para poder obtener los valores internos
        dmDocument := UT_XMLPARSE.parse(clXMLIn);

        --Se recorre el nodo del XML de entrada
        ndNode.id := dmDocument.id;

        --No obtuvo nada en el parse del documento XML
        IF (ndNode.id = -1) THEN

            --Error en el procesamiento del XML
            ge_boerrors.SetErrorCode(6213);
        END IF;

        --Obtiene el nodo de inicio IN
        ndNode := xmldom.getFirstChild(ndNode);

        -- Captura el nombre del nodo de inicio
        sbNodeName := xmldom.GetNodeName(ndNode);

        --se verifica que sea igual a IN
        IF(upper(sbNodeName) <> 'IN') THEN

            --Error en el procesamiento del XML
            ge_boerrors.SetErrorCode(6213);
        END IF;

        --Se obtiene el valor que contenga OPERATING_UNIT
        sbOperatingUnit := mo_boDom.fsbGetValTag(ndNode, 'OPERATING_UNIT_ID');
        nuOperatingUnit := to_number(sbOperatingUnit);
        ut_trace.trace('OPERATING_UNIT_ID = '||sbOperatingUnit, 3);

        --Se obtiene el valor que contenga INITIAL_DATE
        sbInitialDate := mo_boDom.fsbGetValTag(ndNode, 'INITIAL_DATE');
        dtInitialDate := UT_Date.fdtDateWithFormat(sbInitialDate);
        ut_trace.trace('dtInitialDate = '||sbInitialDate, 3);

        --Se obtiene el valor que contenga INITIAL_DATE
        sbFinalDate := mo_boDom.fsbGetValTag(ndNode, 'FINAL_DATE');
        dtFinalDate := UT_Date.fdtDateWithFormat(sbFinalDate);
        ut_trace.trace('dtFinalDate = '||sbFinalDate, 3);

        IF nuOperatingUnit IS NULL THEN
            GE_BOErrors.SetErrorCodeArgument(cnuVALUENULL, 'Unidad Operativa');
        ELSE
            DAOR_operating_unit.AccKey(nuOperatingUnit);
        END IF;

        IF dtInitialDate IS NULL THEN
            GE_BOErrors.SetErrorCodeArgument(cnuVALUENULL, 'Fecha Inicial');
        END IF;

        IF dtFinalDate IS NULL THEN
            GE_BOErrors.SetErrorCodeArgument(cnuVALUENULL, 'Fecha Final');
        END IF;

        IF dtInitialDate > dtFinalDate THEN
            GE_BOErrors.SetErrorCodeArgument(427, sbInitialDate||'|'||sbFinalDate);
        END IF;

        IF MONTHS_BETWEEN(dtFinalDate, dtInitialDate) > 12 THEN
            GE_BOErrors.SetErrorCode(900426);
        END IF;


        rfQuery := GE_BCItemsRequest.frfGetDischargeItems(nuOperatingUnit, dtInitialDate, dtFinalDate);

        oclXMLOut := GE_BOItemsRequest.fclParseRefCursorToXML(rfQuery, 'OUT', 'ITEM');

        IF rfQuery%ISOPEN THEN
            CLOSE rfQuery;
        END IF;

        ut_trace.trace('FIN GE_BOItemsRequest.GetDischargeItems', 2);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
       		ut_trace.trace('EXCEPTION CONTROLLED_ERROR GE_BOItemsRequest.GetDischargeItems', 2);
       		IF rfQuery%ISOPEN THEN
                CLOSE rfQuery;
            END IF;
            RAISE ex.CONTROLLED_ERROR;
    	WHEN OTHERS THEN
            ut_trace.trace('EXCEPTION OTHERS ERROR GE_BOItemsRequest.GetDischargeItems', 2);
            IF rfQuery%ISOPEN THEN
                CLOSE rfQuery;
            END IF;
            Errors.setError;
    		RAISE ex.CONTROLLED_ERROR;
    END GetDischargeItems;

    /*****************************************************************
    Método      : GetTransitItems
    Descripcion	: Obtiene los ítems en transito de una unidad de trabajo

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        iclXMLSearchTransit     Texto XML con la información para consultar ítems
                                en transito

    Salida
        oclXMLTransitItems      Texto XML con la información de los ítems en
                                transito.

    Historia de Modificaciones
    Fecha        Autor                   Modificacion
    ===========  ======================= ====================
    21-08-2012   jgarciaSAO189710        Creación
    ******************************************************************/
    PROCEDURE GetTransitItems
    (
        iclXMLSearchTransit in          clob,
        oclXMLTransitItems  out nocopy  clob
    )
    IS
        --Variables para el manejo del XML
        clXMLSearchTransit  clob;
        dmDocument          xmldom.domdocument;
        ndNode              xmldom.DomNode;
        sbNodeName          VARCHAR2(100);
        sbNodeValue         VARCHAR2(100);

        sbWhere             VARCHAR2(2000);
        rfQuery             SYS_REFCURSOR;

        --Variables que se extraen del XML de entrada
        nuOperUnitId        or_operating_unit.operating_unit_id%type;
        nuCausal            ge_causal.causal_id%type;
        sbSuppoDocu         varchar2(30);

        PROCEDURE CleanMemory
        IS
        BEGIN
            UT_TRACE.TRACE('Inicio - GE_BOItemsRequest.GetTransitItems.CleanMemory',10);

            nuOperUnitId := null;
            nuCausal     := null;
            sbSuppoDocu  := null;

            UT_TRACE.TRACE('FIN - GE_BOItemsRequest.GetTransitItems.CleanMemory',10);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END CleanMemory;

    BEGIN
        UT_TRACE.TRACE('Inicio - GE_BOItemsRequest.GetTransitItems',5);

        CleanMemory();

        --Validar encabezado del XML
        clXMLSearchTransit := iclXMLSearchTransit;
        GE_BOItemsCargue.decupXML(clXMLSearchTransit);

        --Se hacer parse del documento XML para poder obtener los valores internos
        dmDocument := UT_XMLPARSE.parse(clXMLSearchTransit);
        UT_TRACE.TRACE('dmDocument.id = '||dmDocument.id,10);

        --Se recorre el nodo del XML de entrada
        ndNode.id := dmDocument.id;

        --No obtuvo nada en el parse del documento XML
        if (ndNode.id = -1) then

            --Error en el procesamiento del XML
            ge_boerrors.SetErrorCode(6213);

        end if;

        /* se espera que la estructura del XML de entrada SEA
            <SEARCH_TRANSIT_ITEM>
                <OPERATING_UNIT></OPERATING_UNIT>
                <CAUSAL></CAUSAL>
                <SUPPORT_DOCUMENT></SUPPORT_DOCUMENT>
            </SEARCH_TRANSIT_ITEM>
        */
        --Obtiene el nodo de inicio
        ndNode := xmldom.getFirstChild(ndNode);

        -- Captura el nombre del nodo de inicio
        sbNodeName := xmldom.GetNodeName(ndNode);
        UT_TRACE.TRACE('sbNodeName = '||sbNodeName,10);

        --se verifica que sea igual a SEARCH_TRANSIT_ITEM
        if(upper(sbNodeName) <> 'SEARCH_TRANSIT_ITEM') then
            --Error en el procesamiento del XML
            ge_boerrors.SetErrorCode(6213);
        END if;

        --Se obtiene el valor que contenga OPERATING_UNIT
        sbNodeValue := mo_boDom.fsbGetValTag(ndNode, 'OPERATING_UNIT');
        nuOperUnitId := to_number(sbNodeValue);
        UT_TRACE.TRACE('OPERATING_UNIT = ' || nuOperUnitId, 10);

        --Se obtiene el valor que contenga CAUSAL
        sbNodeValue := mo_boDom.fsbGetValTag(ndNode, 'CAUSAL');
        nuCausal :=  to_number(sbNodeValue);
        UT_TRACE.TRACE('CAUSAL = ' || nuCausal, 10);

        --Se obtiene el valor que contenga SUPPORT_DOCUMENT
        sbSuppoDocu := mo_boDom.fsbGetValTag(ndNode, 'SUPPORT_DOCUMENT');
        UT_TRACE.TRACE('SUPPORT_DOCUMENT = ' || sbSuppoDocu, 10);

        -- Verificar que la unidad operativa tenga valor y exista
        daor_operating_unit.AccKey( nuOperUnitId );

        --Si la causal tiene valor verificar que exista y que sea de clase
        --"causales para traslado de ítems".
        if ( nuCausal IS not null ) then

            dage_causal.AccKey(nuCausal);
            if  (  dage_causal.fnuGetCausal_Type_Id(nuCausal, 0) <> cnuTrasIteTypCaus ) then

                --Error en el procesamiento del XML
                ge_boerrors.SetErrorCode(6213);

            END if;
        END if;

        --Genera el WHERE dinamico para realizar la consulta
        nuCausal   := NVL(nuCausal, CC_BOConstants.cnuAPPLICATIONNULL );
        UT_TRACE.TRACE('nuCausal: '||nuCausal, 15);

        --Verifica si viene el codigo del item
        if ( nuCausal <> CC_BOConstants.cnuAPPLICATIONNULL) then

            sbWhere := CHR(10)||'AND     docmov.causal_id = :nuCausal'||CHR(10);

        else

            sbWhere := CHR(10)||'AND     :nuCausal = '||  nuCausal ||CHR(10);

        END if;

        UT_TRACE.TRACE('sbWhere: '||sbWhere, 15);

        sbSuppoDocu  := TRIM (UPPER (NVL (sbSuppoDocu, cc_boConstants.csbNULLSTRING)));
        UT_TRACE.TRACE('sbSuppoDocu: '||sbSuppoDocu, 15);

        --Verifica si la descripcion del item
        if ( sbSuppoDocu <> cc_boConstants.csbNULLSTRING) then

            sbWhere := sbWhere || 'AND     upper(docmov.documento_externo) LIKE '
                       ||CHR(39)||'%'||CHR(39)||'||:sbSuppoDocu||'||CHR(39)||'%'||CHR(39)||CHR(10);

        else

            sbWhere := sbWhere || 'AND     :sbSuppoDocu = '||  sbSuppoDocu ||CHR(10);

        END if;

        UT_TRACE.TRACE('sbWhere: '||sbWhere, 15);

        --Llamar el método GE_BCItemsRequest.frfGetTransitItems que devuelve la
        --información de los ítems en transito.
        rfQuery := GE_BCItemsRequest.frfGetTransitItems( nuOperUnitId,
                                                         nuCausal,
                                                         sbSuppoDocu,
                                                         sbWhere );

        oclXMLTransitItems := fclParseRefCursorToXML(rfQuery, 'TRANSIT_ITEMS', 'ITEMS');

        if rfQuery%ISOPEN then
            close rfQuery;
        END if;

        CleanMemory();


        UT_TRACE.TRACE('Inicio - GE_BOItemsRequest.GetTransitItems',5);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if rfQuery%ISOPEN then
                close rfQuery;
            END if;
            raise;
        when OTHERS then
            errors.SetError;
            if rfQuery%ISOPEN then
                close rfQuery;
            END if;
            raise ex.CONTROLLED_ERROR;

    END GetTransitItems;


END GE_BOItemsRequest;
/
