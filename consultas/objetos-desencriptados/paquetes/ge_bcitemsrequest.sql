CREATE OR REPLACE PACKAGE BODY OPEN.GE_BCItemsRequest
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : GE_BCItemsRequest
Descripcion    : Componente de Negocio para manejo de las solicitudes de items
                 realizadas por sistemas externos.
Autor          : Cristian Solano Duque
Fecha          : 11-02-2011


Historia de Modificaciones
Fecha        Autor               Modificacion
=========    =========           ====================
10-10-2014  eurbano.SAO277000    Se adiciona el m�todo <LockBalbyOperUnit>
04-12-2012  llopezSAO197442      Se modifica tyrcRequestDetail
30-11-2012  llopezSAO197208      Se modifica fnuAmountRequestItem
29-11-2012  llopezSAO197128      se modifica frfGetRegisteredRequests
21-11-2012  llopezSAO195576      Se modifica
                                    frcGetRequestData
                                    frcGetDocItemsXML
                                    frfGetTransitItems
08-09-2012  jgarciaSAO190114     Se modifica el metodo
                                    <<frfGetTransItemByItem>>
07-09-2012  jgutierrez.SAO190191 Se modifica <<frfGetDischargeItems>>
30/08/2012   JGarcia.SAO189710   Se modifican los metodos:
                                    <<frcGetRequestData>>
                                    <<frcGetDocItemsXML>>
                                 Se adiciona el metodo
                                    <<frfGetTransitItems>>
                                    <<frfGetTransItemByItem>>
27-08-2012  jgutierrez.SAO186228 Se crea el m�todo <<frfGetDischargeItems>>
24/07/2012   JGarcia.SAO186231   Se modifican los metodos:
                                    <<frfGetSuggestedItems>>
                                    <<frfGetSuggNoBalanceQ>>
15-04-2011   csolanoSAO146235    Se modifica initRequestConfirm.
07-04-2011   csolanoSAO145406    Se adiciona fnuGetNotification.
11-02-2011   csolanoSAO197128    Creaci�n
******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO277000';

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    csbNotCheckedValue    constant ge_check_reje_move.checked%type  := ge_boconstants.csbNO;
    cnuMovCauseIngRecha   constant or_item_moveme_caus.item_moveme_caus_id%type := ge_boitemsconstants.cnuMovCauseIngRecha;
    csbIncreaseMoveType   constant ge_parameter.value%Type := or_boitemsmove.csbIncreaseMoveType;
    cnuMAX_999999_99      constant or_ope_uni_item_bala.balance%type := 999999.9999;

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END;

    /*****************************************************************
    Unidad      : fnuGetBillingOrderId
    Descripcion	: Consulta el identificador de una orden para una unidad de
                  trabajo con una actividad dada para el d�a actual.

    Parametros          Descripcion
    ============        ===================
    inuOperatingUnitId  Identificador de la Unidad de Trabajo.
    inuActivityId       Identificador del �tem de la actividad.


    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  =================   ==================================
    11-02-2011  csolanoSAO197128    Creaci�n.
    ******************************************************************/
    FUNCTION fnuGetBillingOrderId
    (
        inuOperatingUnitId  in  or_operating_unit.operating_unit_id%type,
        inuActivityId       in  ge_items.items_id%type
    ) return OR_order.order_id%type
    IS
        nuOrderId   OR_order.order_id%type;
        dtToday     date;

        CURSOR cuBillingOrder
        (
            idtDate date
        )
        IS
            SELECT OR_order.order_id
            FROM OR_order,
                 or_order_activity
            WHERE OR_order.order_id = or_order_activity.order_id
            AND or_order_activity.activity_id = inuActivityId
            AND trunc(or_order.created_date) = idtDate
            AND or_order.operating_unit_id = inuOperatingUnitId;

    BEGIN

        dtToday := trunc(sysdate);

        open cuBillingOrder(dtToday);
        fetch cuBillingOrder INTO nuOrderId;
        close cuBillingOrder;

        return nuOrderId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetBillingOrderId;


    /*****************************************************************
    Unidad      : frfGetPendRejectItems
    Descripcion	: Retorna cursor referenciado con los items rechazados
                  por la unidad que solicita los items y que estan pendientes
                  de ser aceptados por la unidad proveedora.

    Parametros          Descripcion
    ============        ===================
    inuProvOperUnitId   Identificador de Unidad Proveedora

    Retorna:

    CURSOR Referenciado con:
        ITEM_REJECTED_ID  Identificador �nico de mvmto de item rechazado
        DOCUMENT          Factura registrada por la U.proveedora cuando envi� los items
        ITEM_ID           Identificador del �tem
        ITEM_DESC         Descripci�n del �tem
        QUANTITY          Cantidad del item rechazado
        COST              Costo unitario confirmado seg�n unidad proveedora
        SERIE             Serie del �tem (cuando aplique)

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  =================   ==================================
    15-02-2011  amendezSAO140554    Creaci�n.
    ******************************************************************/
    FUNCTION frfGetPendRejectItems
    (
        inuProvOperUnitId   in  OR_operating_unit.operating_unit_id%type
    )
    return SYS_REFCURSOR
    IS
        rfQuery               SYS_REFCURSOR;

    BEGIN
        open rfQuery for
            SELECT
               -- Identificador �nico del movimiento de item rechazado ---------
               mov_items.uni_item_bala_mov_id            item_rejected_id,
               -- Factura ------------------------------------------------------
               (
                    SELECT documento_externo
                    FROM   ge_items_documento
                    WHERE  id_items_documento
                               = mov_items.fact_doc_id
               )                                         document,
               -- Identificador del �tem ---------------------------------------
               mov_items.items_id                        item_id,
               -- Descripci�n del �tem -----------------------------------------
               (
                    SELECT description
                    FROM   ge_items
                    WHERE  ge_items.items_id = mov_items.items_id
               )                                         item_desc,
               -- Cantidad -----------------------------------------------------
               round(mov_items.amount,2)                 quantity,
               -- Costo --------------------------------------------------------
               CASE
                 when mov_items.amount > 0.0 then
                      round(mov_items.total_value/mov_items.amount,2)
                 else 0.00
               END                                       cost,
               -- Serie --------------------------------------------------------
               CASE
                 when mov_items.id_items_seriado IS not null
                      then
                             ( SELECT serie
                               FROM   ge_items_seriado
                               WHERE  id_items_seriado = mov_items.id_items_seriado
                             )
                      else  null
               END                                       serie
               ---------------------------------------------------------------------
            FROM   (
                       SELECT
                             -- Calculo de la factura para c/movimiento ------------
                             (
                                SELECT fact.id_items_documento
                                FROM   ge_items_doc_rel, ge_items_documento fact
                                WHERE
                                   -- El origen es el documento de rechazo
                                   ge_items_doc_rel.id_items_doc_origen =
                                   or_uni_item_bala_mov.id_items_documento
                                   -- El destino es la factura
                                   AND ge_items_doc_rel.id_items_doc_destino =
                                           fact.id_items_documento
                                   AND fact.document_type_id =
                                           ge_boitemsconstants.cnuTipoFacturaCompra
                                   AND rownum = 1
                              ) fact_doc_id,
                              -- Datos del movimiento ------------------------------
                              ge_check_reje_move.uni_item_bala_mov_id,
                              or_uni_item_bala_mov.items_id,
                              or_uni_item_bala_mov.amount,
                              or_uni_item_bala_mov.id_items_seriado,
                              or_uni_item_bala_mov.total_value
                       FROM   ge_check_reje_move,
                              or_uni_item_bala_mov
                       WHERE  ge_check_reje_move.checked                  = csbNotCheckedValue
                              AND ge_check_reje_move.uni_item_bala_mov_id = OR_uni_item_bala_mov.uni_item_bala_mov_id
                              AND or_uni_item_bala_mov.Item_Moveme_Caus_Id  = cnuMovCauseIngRecha
                              AND or_uni_item_bala_mov.operating_unit_id   = inuProvOperUnitId
                              AND or_uni_item_bala_mov.movement_type       = csbIncreaseMoveType
                   ) mov_items
        ;

        return rfQuery;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if rfQuery%isopen then close rfQuery; END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if rfQuery%isopen then close rfQuery; END if;
            raise ex.CONTROLLED_ERROR;
    END frfGetPendRejectItems;


    /*****************************************************************
    M�todo      : frfGetItReqByDocAndIt
    Descripcion	: Obtiene el �tem por requisici�n, dado el documento y el �tem

    Autor       : Luis Alberto L�pez Agudelo
    Fecha       : 15-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador de la requisici�n
        inuItemsId                  Identificador del �tem

    Salida:
        Cursor referenciado con el �tem por requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 llopezSAO131745         Creaci�n
    ******************************************************************/
    FUNCTION frfGetItReqByDocAndIt (
        inuItemsDocumentId  in  ge_items_request.id_items_documento%type,
        inuItemsId          in  ge_items_request.items_id%type
    ) return constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        open rfCursor for
            SELECT ge_items_request.*,ge_items_request.rowid
              FROM ge_items_request
             WHERE id_items_documento = inuItemsDocumentId
               AND items_id = inuItemsId;

        return rfCursor;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetItReqByDocAndIt;


    /*****************************************************************
    M�todo      : frfGetSuggestedItems
    Descripcion	: Obtiene los �tems sugeridos para la requisici�n de �tems, seg�n
                  el balance de la Unidad solicitante.

    -- Nota de Dise�o, por performance y complejidad de la consulta
    -- se salta arquitectura SmartFlex BC invocando BO

    Autor       : Luis Alberto L�pez Agudelo
    Fecha       : 15-Feb-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuRequestOperUnit          Identificador de la UdT solicitante
        inuItemId                   Identificador del �tem

    Salida:
        Cursor referenciado con los �tem sugeridos para realizar la requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    24/07/2012  JGarcia.SAO186231       Se adiciona el campo de codigo externo
    15-Feb-2011 amendezSAO131745        Creaci�n
    ******************************************************************/
    FUNCTION frfGetSuggestedItems
    (
        inuRequestOperUnit      in  or_operating_unit.operating_unit_id%type,
        inuItemId               in  ge_items_request.items_id%type default null
    ) RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        IF (inuItemId IS NULL) THEN
            OPEN rfCursor FOR
                SELECT *
                FROM
                (
                    SELECT Item,
                           description,
                           Code,
                           Cuota,
                           Cuota_Ocacional,
                           Saldo,
                           Transito_Entrante,
                           Pendiente,
                           Cuota + Cuota_Ocacional - Saldo - Transito_Entrante - Pendiente A_Solicitar,
                           Costo_Unit,
                           Seriado
                    FROM
                    (
                        SELECT /*+index(or_ope_uni_item_bala IDX_OR_OPE_UNI_ITEM_BALA_01)
                                  index(ge_items PK_GE_ITEMS)
                                  index(ge_items_tipo PK_GE_ITEMS_TIPO)*/
                               or_ope_uni_item_bala.items_id Item,
                               ge_items.description description,
                               ge_items.code Code,
                               or_ope_uni_item_bala.quota Cuota,
                               or_ope_uni_item_bala.balance Saldo,
                               nvl(or_ope_uni_item_bala.occacional_quota,0) Cuota_Ocacional,
                               nvl(or_ope_uni_item_bala.transit_in,0) Transito_Entrante,
                               GE_BCItemsRequest.fnuAmountRequestItem  -- Solicitudes registradas que a�n no est�n en transito
                               (
                                 inuRequestOperUnit,
                                 or_ope_uni_item_bala.items_id
                               ) Pendiente,
                               OR_BOItemValue.fnuGetItemValue(
                                 or_ope_uni_item_bala.items_id,
                                 inuRequestOperUnit -- UdT solicitante
                               ) Costo_Unit,
                               nvl(ge_items_tipo.seriado,ge_boconstants.csbNO) seriado
                        FROM   or_ope_uni_item_bala,
                               ge_items,
                               ge_items_tipo
                        WHERE  or_ope_uni_item_bala.operating_unit_id = inuRequestOperUnit
                           AND or_ope_uni_item_bala.items_id = ge_items.items_id
                           AND ge_items.id_items_tipo = ge_items_tipo.id_items_tipo(+)
                    )
                )
                WHERE A_Solicitar > 0;
        ELSE
            OPEN rfCursor FOR
                SELECT Item,
                       description,
                       Code,
                       Cuota,
                       Cuota_Ocacional,
                       Saldo,
                       Transito_Entrante,
                       Pendiente,
                       Cuota + Cuota_Ocacional - Saldo - Transito_Entrante - Pendiente A_Solicitar,
                       Costo_Unit,
                       Seriado
                FROM
                (
                    SELECT /*+ordered
                              index(or_ope_uni_item_bala PKOR_OPE_UNI_ITEM_BALA)
                              index(ge_items PK_GE_ITEMS)
                              index(ge_items_tipo PK_GE_ITEMS_TIPO)*/
                           or_ope_uni_item_bala.items_id Item,
                           ge_items.description description,
                           ge_items.code Code,
                           or_ope_uni_item_bala.quota Cuota,
                           or_ope_uni_item_bala.balance Saldo,
                           nvl(or_ope_uni_item_bala.occacional_quota,0) Cuota_Ocacional,
                           nvl(or_ope_uni_item_bala.transit_in,0) Transito_Entrante,
                           GE_BCItemsRequest.fnuAmountRequestItem  -- Solicitudes registradas que a�n no est�n en transito
                           (
                             inuRequestOperUnit,
                             or_ope_uni_item_bala.items_id
                           ) Pendiente,
                           OR_BOItemValue.fnuGetItemValue(
                             or_ope_uni_item_bala.items_id,
                             inuRequestOperUnit -- UdT solicitante
                           ) Costo_Unit,
                           nvl(ge_items_tipo.seriado,ge_boconstants.csbNO) seriado
                     FROM  or_ope_uni_item_bala,
                           ge_items,
                           ge_items_tipo
                     WHERE or_ope_uni_item_bala.operating_unit_id = inuRequestOperUnit
                       AND or_ope_uni_item_bala.items_id = inuItemId
                       AND or_ope_uni_item_bala.items_id = ge_items.items_id
                       AND ge_items.id_items_tipo = ge_items_tipo.id_items_tipo(+)
                );
        END IF;

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetSuggestedItems;

    /*****************************************************************
    M�todo      : frfGetSuggNoBalanceQ
    Descripcion	: Obtiene la cantidad sugerida del �tem, cuando el item
                  no se encuentra en el balance de la Unidad solicitante.

    -- Nota de Dise�o, por performance y complejidad de la consulta
    -- se salta arquitectura SmartFlex BC invocando BO

    Autor       : Luis Alberto L�pez Agudelo
    Fecha       : 02-Mar-2011

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuRequestOperUnit          Identificador de la UdT solicitante
        inuItemId                   Identificador del �tem

    Salida:
        Cursor referenciado con los �tem sugeridos para realizar la requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    24/07/2012  JGarcia.SAO186231       Se adiciona el campo de codigo externo
    02-Mar-2011 amendezSAO131745        Creaci�n
    ******************************************************************/
    FUNCTION frfGetSuggNoBalanceQ (
        inuRequestOperUnit   in  or_operating_unit.operating_unit_id%type,
        inuItemId            in ge_items_request.items_id%type
    ) RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        OPEN rfCursor FOR
            SELECT Item,
                   description,
                   Code,
                   Cuota,
                   Cuota_Ocacional,
                   Saldo,
                   Transito_Entrante,
                   Pendiente,
                   Cuota - Pendiente A_Solicitar,
                   Costo_Unit,
                   Seriado
            FROM
            (
                SELECT /*+index(ge_items PK_GE_ITEMS)
                          index(ge_items_tipo PK_GE_ITEMS_TIPO)*/
                       ge_items.items_id Item,
                       ge_items.description description,
                       ge_items.code Code,
                       cnuMAX_999999_99 Cuota,
                       0.0 Saldo,
                       0.0 Cuota_Ocacional,
                       0.0 Transito_Entrante,
                       -- Solicitudes registradas que a�n no est�n en transito
                       GE_BCItemsRequest.fnuAmountRequestItem
                       (
                         inuRequestOperUnit,
                         ge_items.items_id
                       ) Pendiente,
                       OR_BOItemValue.fnuGetItemValue(
                         ge_items.items_id,
                         inuRequestOperUnit -- UdT solicitante
                       ) Costo_Unit,
                       nvl(ge_items_tipo.seriado,ge_boconstants.csbNO) seriado
                FROM   ge_items,
                       ge_items_tipo
                WHERE  ge_items.items_id = inuItemId
                   AND ge_items.id_items_tipo = ge_items_tipo.id_items_tipo(+)
            );

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetSuggNoBalanceQ;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: fnuAmountRequestItem
    Descripcion	: Obtiene la cantidad solicitada de un item en requisiciones
                  en estado registradas para una unidad que solicita items
                  indistintamente de que sea interna � externa+contratista

    retorna	:           Descripcion
    Cantidad de items en requisiciones registradas

    Parametros       	: Descripcion
    inuRequestOperUnitId  Identificador de unidad que solicita items
    inuItemId             Identificador del Item

    Historia de Modifiaciones
    Fecha       ID Entrega          Modificaci�n
    30-11-2012  llopezSAO197208     Se modifica para tener en cuenta la cantidad
                                    por entregar
    16-02-2011  amendezSAO140554    Creaci�n
    *****************************************************************/
    FUNCTION fnuAmountRequestItem
    (
        inuRequestOperUnitId in ge_items_documento.destino_oper_uni_id%type,
        inuItemId            in ge_items_request.items_id%type
    )
    return number
    IS
        nuQuantity  number;
    BEGIN
    --{
        for rc in
            -- Obtener el TOTAL SOLICITADO de un item en todas las
            -- requisiciones REGISTRADAS
            -- de una unidad hacia cualquier unidad proveedora
            (
                SELECT /*+ ordered
                       index(ge_items_documento IDX_GE_ITEMS_DOCUMENTO_02)
                       index(ge_items_request UX_GE_ITEMS_REQUEST02) */
                       sum(decode(delivery_date, null, request_amount, confirmed_amount)) q_solicitada
                  FROM ge_items_documento, ge_items_request
                 WHERE ge_items_request.id_items_documento = ge_items_documento.id_items_documento
                   AND ge_items_request.items_id = inuItemId
                   AND ge_items_documento.operating_unit_id = inuRequestOperUnitId
                   AND ge_items_documento.estado = ge_boitemsconstants.csbEstadoRegistrado
                   AND ge_items_documento.document_type_id = ge_boitemsconstants.cnuTipoOrdenCompra
            )
        LOOP
            nuQuantity := rc.q_solicitada;
        END loop;

        return nvl(nuQuantity,0);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
    --}
    END fnuAmountRequestItem;

    /*****************************************************************
    M�todo      : initRequestConfirm
    Descripcion	: Inicializa los datos de la requisici�n, dejando en 0 la cantidad
                  de items aceptados.

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
      inuItemsDocumentId        Identificador del documento asociado.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Abr-2011 csolanoSAO146235        Se inicializa en nulo el campo de
                                        cantidad confirmada.
    15-Feb-2011 csolanoSAO131745        Creaci�n
    ******************************************************************/
    PROCEDURE initRequestConfirm
    (
        inuItemsDocumentId  in  ge_items_documento.ID_ITEMS_DOCUMENTO%type
    )
    IS
    BEGIN
    --{
        Update GE_ITEMS_REQUEST
        set confirmed_amount = 0,
            confirmed_cost = null
        where id_items_documento = inuItemsDocumentId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
    --}
    END initRequestConfirm;

    /*****************************************************************
    M�todo      : updAcceptedItemAmount
    Descripcion	: Inicializa los datos de la requisici�n, dejando en 0 la cantidad
                  de items aceptados.

    Parametros          	    Descripcion
    ============	   	   	    ===================
    Entrada:
        inuItemsDocumentId      Identificador del documento asociado.
        inuItemId               Identificador del �tem.
        inuAmount               Cantidad aceptada del �tem.
        inuCost                 Costo unitario confirmado.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    15-Feb-2011 csolanoSAO131745        Creaci�n
    ******************************************************************/
    PROCEDURE updAcceptedItemAmount
    (
        inuItemsDocumentId  in  ge_items_documento.id_items_documento%type,
        inuItemsId          in  ge_items_request.items_id%type,
        inuAmount           in  ge_items_request.accepted_amount%type,
        inuCost             in  ge_items_request.confirmed_cost%type
    )
    IS
    BEGIN
    --{
        Update GE_ITEMS_REQUEST
        set confirmed_amount = inuAmount,
            confirmed_cost = inuCost
        where id_items_documento = inuItemsDocumentId
        AND items_id = inuItemsId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            errors.SetError;
            raise ex.CONTROLLED_ERROR;
    --}
    END updAcceptedItemAmount;

    /*****************************************************************
    M�todo      : frfGetRegisteredRequests
    Descripcion	: Obtiene las requisiciones registradas para un proveedor.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuRequestOperUnit          Identificador de la UdT solicitante

    Salida:
        Cursor referenciado con los �tem sugeridos para realizar la requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    29-11-2012  llopezSAO197128         Se modifica para solo obtener las
                                        requisiciones abiertas y ordenarlas
                                        por identificador
    22-Feb-2011 csolanoSAO197128        Creaci�n
    ******************************************************************/
    FUNCTION frfGetRegisteredRequests
    (
        inuOpeUnitErp_Id    in  ge_items_request.items_request_id%type
    )
    RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        OPEN rfCursor FOR
            SELECT /*+ index(ge_items_documento IDX_GE_ITEMS_DOCUMENTO05) */
                   ge_items_documento.id_items_documento items_documento_id
              FROM ge_items_documento
             WHERE ge_items_documento.destino_oper_uni_id = inuOpeUnitErp_Id
               AND ge_items_documento.estado = ge_boitemsconstants.csbDOCSTATUS_REGIST
               AND ge_items_documento.document_type_id = ge_boitemsconstants.cnuTipoOrdenCompra
               AND ge_items_documento.delivery_date is null
          ORDER BY ge_items_documento.id_items_documento;

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetRegisteredRequests;

    /*****************************************************************
    M�todo      : frcGetDocItemsXML
    Descripcion	: Obtiene el listado de items asociados a una requisici�n.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador del documento asociado.

    Salida:
        Cursor referenciado con los �tem sugeridos para realizar la requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    21-Nov-2012 llopezSAO195576         Se adiciona ITEM_CLASSIF_ID
    21-Ago-2012 JGarcia.SAO189710       Se adiciona ITEM_CODE
    23-Feb-2011 csolanoSAO197128        Creaci�n
    ******************************************************************/
    FUNCTION frcGetDocItemsXML
    (
        inuItemsDocumentId  in  ge_items_request.id_items_documento%type
    )
    RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        OPEN rfCursor FOR
            SELECT
                    /*+index(ge_items_documento PK_GE_ITEMS_DOCUMENTO)
                       index(ge_items PK_GE_ITEMS)
                       use_nl(ge_items_documento ge_items)
                       index(GE_ITEMS_REQUEST IDX_GE_ITEMS_REQUEST01)
                       use_nl(ge_items_documento ge_items_request)
                    */
                    ge_items.items_id ITEM_ID,
                    ge_items.code ITEM_CODE,
                    ge_items.description ITEMS_DESC,
                    ge_items.item_classif_id ITEM_CLASSIF_ID,
                    ge_items_request.request_amount QUANTITY,
                    ge_items_request.unitary_cost COST
            FROM ge_items_documento,
                 ge_items_request,
                 ge_items
            WHERE ge_items_documento.id_items_documento = ge_items_request.id_items_documento
            AND ge_items_request.items_id = ge_items.items_id
            AND ge_items_documento.id_items_documento = inuItemsDocumentId;

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frcGetDocItemsXML;

    /*****************************************************************
    M�todo      : frcGetRequestData
    Descripcion	: Obtiene la informaci�n de una requisici�n.

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuItemsDocumentId          Identificador del documento asociado.

    Salida:
        Cursor referenciado con los �tem sugeridos para realizar la requisici�n

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    26-Nov-2012 AEcheverrySAO196606     Se modifica para obtener correctamente el campo
                                        OPER_UNIT_ERP_ID.
    21-Nov-2012 llopezSAO195576         Se adiciona
                                            OPERATING_UNIT_NAME
                                            OPER_UNIT_ERP_NAME
    21-Ago-2012 JGarcia.SAO189710       Se adiciona OPER_UNIT_ERP_ID
    23-Feb-2011 csolanoSAO197128        Creaci�n
    ******************************************************************/
    FUNCTION frcGetRequestData
    (
        inuItemsDocumentId  in  ge_items_request.id_items_documento%type
    )
    RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        OPEN rfCursor FOR
            SELECT
                   /*+ index(ge_items_documento PK_GE_ITEMS_DOCUMENTO)
                       index(or_operating_unit PK_OR_OPERATING_UNIT)
                       use_nl(ge_items_documento or_operating_unit)
                       use_nl(ge_items_documento or_oper_unit_erp)
                       index(or_oper_unit_erp PK_OR_OPERATING_UNIT)
                   */
                   ge_items_documento.id_items_documento "ITEMS_DOCUMENTO_ID",
                   or_operating_unit.operating_unit_id "OPERATING_UNIT_ID",
                   or_operating_unit.NAME "OPERATING_UNIT_NAME",
                   ge_items_documento.destino_oper_uni_id "OPER_UNIT_ERP_ID",
                   or_oper_unit_erp.NAME "OPER_UNIT_ERP_NAME",
                   ge_items_documento.fecha "DATE",
                   ge_items_documento.documento_externo "REFERENCE",
                   ge_items_documento.comentario "COMMENT",
                   or_operating_unit.address "ADDRESS"
            FROM   ge_items_documento, or_operating_unit, or_operating_unit or_oper_unit_erp
            WHERE  ge_items_documento.id_items_documento = inuItemsDocumentId
            AND    or_operating_unit.operating_unit_id = ge_items_documento.operating_unit_id
            AND    or_oper_unit_erp.operating_unit_id = ge_items_documento.destino_oper_uni_id;


        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frcGetRequestData;

    /*****************************************************************
    M�todo      : frfReqOperUnits
    Descripcion	: Obtiene las Unidades de Trabajo que necesitan requisici�n

    Parametros          Descripcion
    ============	   	===================
    Entrada:
        idtDate         Fecha hasta la que obtener UdT

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    17-Mar-2011 llopezSAO131745         Creaci�n
    ******************************************************************/
    FUNCTION frfReqOperUnits(
        idtDate     in  or_operating_unit.NEXT_ITEM_REQUEST%type
    )
    RETURN constants.tyRefCursor
    IS
        rfCursor    constants.tyRefCursor;
    BEGIN

        OPEN rfCursor FOR
            SELECT or_operating_unit.*,or_operating_unit.rowid
              FROM or_operating_unit
             WHERE NEXT_ITEM_REQUEST <= idtDate;

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfReqOperUnits;

    /*****************************************************************
    Unidad      : fnuGetNotification
    Descripcion	: Consulta la notificaci�n (primera) configurada para una
                  clase de notificaci�n.

    Parametros          Descripcion
    ============        ===================
    inuNotClassId       Clase de la notificaci�n.


    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  =================   ==================================
    07-04-2011  csolanoSAO145406    Creaci�n.
    ******************************************************************/
    FUNCTION fnuGetNotification
    (
        inuNotClassId   in  ge_notification_class.notification_class_id%type
    )
    return ge_notification.notification_id%type
    IS
        nuNotificationId   ge_notification.notification_id%type;

        CURSOR cuNotification
        (
            inuClassId  in  ge_notification.notification_class_id%type
        )
        IS
            SELECT ge_notification.notification_id
            FROM ge_notification
            WHERE ge_notification.notification_class_id = inuClassId;

    BEGIN

        open cuNotification(inuNotClassId);
        fetch cuNotification INTO nuNotificationId;
        close cuNotification;

        return nuNotificationId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetNotification;

    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : frfGetDischargeItems
    Descripci�n : Consultar �tems rechazados
    Autor       : Juan Alexander Gut�errez
    Fecha       : 27-08-2012
    Parametros  :
      Entrada:
        inuOperatingUnit    Unidad Operativa
        idtInitialDate      Fecha inicial
        idtInitialDate      Fecha Final
      Salida:

    Historia de Modificaciones
    Fecha       Autor                  Modificaci�n
    ==========  ====================   ===================================
    07-09-2012  jgutierrez.SAO190191   Se cambia nombre de variable.
    27-08-2012  jgutierrez.SAO186228   Creaci�n.
    ***************************************************************************/
    FUNCTION frfGetDischargeItems
    (
        inuOperatingUnit IN or_operating_unit.operating_unit_id%type,
        idtInitialDate   IN or_uni_item_bala_mov.move_date%type,
        idtFinalDate     IN or_uni_item_bala_mov.move_date%type
    )
    RETURN Constants.tyRefCursor
    IS
        rfDataCursor Constants.tyRefCursor;
    BEGIN
        ut_trace.trace('INICIO GE_BCItemsRequest.frfGetDischargeItems', 3);

        OPEN rfDataCursor FOR
            SELECT /*+ index(or_uni_item_bala_mov IDX_OR_UNI_ITEM_BALA_MOV_01)
                       use_nl(or_uni_item_bala_mov ge_check_reje_move)
                       index(ge_check_reje_move PK_GE_CHECK_REJE_MOVE)
                       use_nl(or_uni_item_bala_mov ge_items)
                       index(ge_items PK_GE_ITEMS)
                       use_nl(or_uni_item_bala_mov ge_items_seriado)
                       index(ge_items_seriado PK_GE_ITEMS_SERIADO)
                    */
                    or_uni_item_bala_mov.items_id ITEM_ID,
                    ge_items.code ITEM_CODE,
                    or_uni_item_bala_mov.amount QUANTITY,
                    ge_items_seriado.serie SERIE
                FROM or_uni_item_bala_mov, ge_check_reje_move, ge_items, ge_items_seriado
                WHERE  or_uni_item_bala_mov.operating_unit_id = inuOperatingUnit
                AND or_uni_item_bala_mov.item_moveme_caus_id = cnuMovCauseIngRecha
                AND or_uni_item_bala_mov.movement_type = csbIncreaseMoveType
                AND or_uni_item_bala_mov.move_date BETWEEN idtInitialDate AND idtFinalDate
                AND or_uni_item_bala_mov.uni_item_bala_mov_id = ge_check_reje_move.uni_item_bala_mov_id
                AND ge_check_reje_move.checked = csbNotCheckedValue
                AND or_uni_item_bala_mov.items_id = ge_items.items_id
                AND or_uni_item_bala_mov.id_items_seriado = ge_items_seriado.id_items_seriado (+);

        ut_trace.trace('FIN GE_BCItemsRequest.frfGetDischargeItems', 3);

        RETURN rfDataCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
       		ut_trace.trace('EXCEPTION CONTROLLED_ERROR GE_BCItemsRequest.frfGetDischargeItems', 3);
            RAISE ex.CONTROLLED_ERROR;
    	WHEN OTHERS THEN
            ut_trace.trace('EXCEPTION OTHERS ERROR GE_BCItemsRequest.frfGetDischargeItems', 3);
            Errors.setError;
    		RAISE ex.CONTROLLED_ERROR;
    END frfGetDischargeItems;

    /*****************************************************************
    M�todo      : frfGetTransitItems
    Descripcion	: Obtiene los �tems en transito de una unidad de trabajo por causal
                  y por documento de soporte

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuOperUnitId               Identificador de la unidad operativa
        inuCausal                   Identificador de la causal
        isbSuppoDocu                Documento de soporte
        sbWhere                     Cadena con la parte final del WHERE para relacionar
                                    inuCausal e isbSuppoDocu en el CURSOR

    Salida:
        Cursor referenciado con los �tems en transito de una unidad de trabajo

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    21-Nov-2012 llopezSAO195576         Se adiciona
                                            ITEM_CLASSIF_ID
                                            DOCUMENT_ID
                                            ORIG_OPER_UNIT_NAME
                                            TARG_OPER_UNIT_NAME
    30-Ago-2012 JGarcia.SAO189710       Creaci�n
    ******************************************************************/
    FUNCTION frfGetTransitItems
    (
        inuOperUnitId   in  or_operating_unit.operating_unit_id%type,
        inuCausal       in  ge_causal.causal_id%type,
        isbSuppoDocu    in  varchar2,
        sbWhere         in  VARCHAR2
    )
    RETURN constants.tyRefCursor
    IS
        sbSql           VARCHAR2(8000);
        rfCursor        constants.tyRefCursor;
    BEGIN

        UT_TRACE.TRACE('Inicio - GE_BCItemsRequest.frfGetTransitItems',5);

        sbSql :=
            'SELECT
                /*+index(GE_ITEMS_DOCUMENTO IDX_GE_ITEMS_DOCUMENTO_01)
                   index(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV_01)
                   use_nl(GE_ITEMS_DOCUMENTO OR_UNI_ITEM_BALA_MOV)
                   index(GE_ITEMS PK_GE_ITEMS)
                   use_nl(OR_UNI_ITEM_BALA_MOV GE_ITEMS)
                   index(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
                   use_nl(OR_UNI_ITEM_BALA_MOV GE_ITEMS_SERIADO)
                   use_nl(OR_UNI_ITEM_BALA_MOV orig_operating_unit)
                   index(orig_operating_unit PK_OR_OPERATING_UNIT)
                   use_nl(OR_UNI_ITEM_BALA_MOV targ_operating_unit)
                   index(targ_operating_unit PK_OR_OPERATING_UNIT)
                */
                ge_items.code                               "ITEM_CODE",
                ge_items.items_id                           "ITEM_ID",
                ge_items.item_classif_id                    "ITEM_CLASSIF_ID",
                or_uni_item_bala_mov.amount                 "TRANSIT_QUANTITY",
                ge_items_seriado.serie                      "SERIE",
                or_uni_item_bala_mov.total_value            "VALUE",
                docmov.id_items_documento                   "DOCUMENT_ID",
                docmov.documento_externo                    "SUPPORT_DOCUMENT",
                docmov.comentario                           "COMMENT",
                or_uni_item_bala_mov.operating_unit_id      "ORIG_OPER_UNIT",
                orig_operating_unit.name                    "ORIG_OPER_UNIT_NAME",
                or_uni_item_bala_mov.target_oper_unit_id    "TARG_OPER_UNIT",
                targ_operating_unit.name                    "TARG_OPER_UNIT_NAME"
            FROM  ge_items_documento docmov,  -- documentos que tienen el movimiento, factura y traslado
                ge_items_doc_rel,           -- relacion entre orden y factura o traslado y traslado
                or_uni_item_bala_mov,
                ge_items_seriado,
                ge_items,
                or_operating_unit orig_operating_unit,
                or_operating_unit targ_operating_unit
            WHERE  or_uni_item_bala_mov.items_id = ge_items.items_id
            AND  orig_operating_unit.operating_unit_id = or_uni_item_bala_mov.operating_unit_id
            AND  targ_operating_unit.operating_unit_id (+) = or_uni_item_bala_mov.target_oper_unit_id
            AND  or_uni_item_bala_mov.operating_unit_id = :inuOperUnitId
            AND  or_uni_item_bala_mov.movement_type =  ''' || or_boitemsmove.csbNeutralMoveType ||  ''' --or_boitemsmove.csbNeutralMoveType - N
            AND  or_uni_item_bala_mov.item_moveme_caus_id
            IN  (   ' || ge_boitemsconstants.cnuMovCauseTrans || ', --ge_boitemsconstants.cnuMovCauseTrans - 6
                    ' || ge_boitemsconstants.cnuCausalTranslate || ',--ge_boitemsconstants.cnuCausalTranslate  - 20
                    ' || ge_boitemsconstants.cnuCausalEntFactCompra || ' --ge_boitemsconstants.cnuCausalEntFactCompra - 15
                )
            AND  or_uni_item_bala_mov.support_document = '' ''
            AND  or_uni_item_bala_mov.id_items_seriado = ge_items_seriado.id_items_seriado (+)
            AND  docmov.id_items_documento = or_uni_item_bala_mov.id_items_documento
            AND  ge_items_doc_rel.id_items_doc_origen = docmov.id_items_documento ' || sbWhere;

        UT_TRACE.TRACE('sbSql = '||sbSql,10);

        --Cursor referenciado con la informaci�n de los �tems en transito.
        OPEN rfCursor FOR sbSql using inuOperUnitId, inuCausal, isbSuppoDocu;

        UT_TRACE.TRACE('Fin - GE_BCItemsRequest.frfGetTransitItems',5);

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTransitItems;

    /*****************************************************************
    M�todo      : frfGetTransItemByItem
    Descripcion	: Obtiene los �tems en transito de una unidad de trabajo por el
                  item o item seriado

    Parametros          	        Descripcion
    ============	   	   	        ===================
    Entrada:
        inuOperUnitId               Identificador de la unidad operativa
        inuItemId                   Identificador del item
        inuItemSeriId               Identificador del item seriado

    Salida:
        Cursor referenciado con los �tems en transito de una unidad de trabajo

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========== ======================= ====================
    08-09-2012  jgarciaSAO190114       Se modifica el manejo de variables bind
                                       por la secuencia de llamado.
    30-08-2012 JGarcia.SAO189710       Creaci�n
    ******************************************************************/
    FUNCTION frfGetTransItemByItem
    (
        inuOperUnitId  in  or_operating_unit.operating_unit_id%type,
        inuItemId      in  ge_items.items_id%type,
        inuItemSeriId  in  ge_items_seriado.id_items_seriado%type,
        sbWhere        in  VARCHAR2
    )
    RETURN constants.tyRefCursor
    IS
        sbSql           VARCHAR2(8000);
        rfCursor        constants.tyRefCursor;
    BEGIN

        UT_TRACE.TRACE('Inicio - GE_BCItemsRequest.frfGetTransItemByItem',5);

        sbSql :=
            'SELECT or_uni_item_bala_mov.uni_item_bala_mov_id,
                   or_uni_item_bala_mov.amount
            FROM   or_uni_item_bala_mov
            WHERE  or_uni_item_bala_mov.operating_unit_id = :inuOperUnitId
            AND    or_uni_item_bala_mov.items_id = :items_id
            AND  or_uni_item_bala_mov.movement_type =  ''' || or_boitemsmove.csbNeutralMoveType ||  ''' --or_boitemsmove.csbNeutralMoveType - N
            AND  or_uni_item_bala_mov.item_moveme_caus_id
            IN  (   ' || ge_boitemsconstants.cnuMovCauseTrans || ', --ge_boitemsconstants.cnuMovCauseTrans - 6
                    ' || ge_boitemsconstants.cnuCausalTranslate || ',--ge_boitemsconstants.cnuCausalTranslate  - 20
                    ' || ge_boitemsconstants.cnuCausalEntFactCompra || ' --ge_boitemsconstants.cnuCausalEntFactCompra - 15
                )
            AND  or_uni_item_bala_mov.support_document = '' '' ' || sbWhere;

        UT_TRACE.TRACE('sbSql = '||sbSql,10);

        --Cursor referenciado con la informaci�n de los �tems en transito.
        OPEN rfCursor FOR sbSql using inuOperUnitId, inuItemId, inuItemSeriId;

        UT_TRACE.TRACE('Fin - GE_BCItemsRequest.frfGetTransItemByItem',5);

        RETURN rfCursor;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        WHEN others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTransItemByItem;


    -- valida si hay items pendientes por confirmar
    function fsbHavePendItemRequ
    (
        inuDocumentId   in  ge_items_documento.id_items_documento%type
    )
    return varchar2
    IS
        sbPendingItems varchar2(1);

        CURSOR GetPendingItems(nuDocumentId in  ge_items_documento.id_items_documento%type)
        IS
        SELECT ge_boconstants.GetYes FROM ge_items_request
            WHERE ge_items_request.confirmed_amount > 0
                AND ge_items_request.id_items_documento = inuDocumentId
                AND rownum = 1;

    BEGIN

        open GetPendingItems(inuDocumentId);
        fetch GetPendingItems INTO sbPendingItems;
        close GetPendingItems;

        return nvl(sbPendingItems, ge_boconstants.GetNO);

    END fsbHavePendItemRequ;

    -- Bloquea el registro
	PROCEDURE LockBalbyOperUnit
	(
		inuItems_Id in OR_ope_uni_item_bala.Items_Id%type,
		inuOperating_Unit_Id in OR_ope_uni_item_bala.Operating_Unit_Id%type,
		orcOR_ope_uni_item_bala  out DAOR_ope_uni_item_bala.styOR_ope_uni_item_bala
	)
	IS

    	/* Cursor para bloqueo de un registro por llave primaria */
	   CURSOR cuLockBalbyOperUnit
	   (
		inuItems_Id in OR_ope_uni_item_bala.Items_Id%type,
		inuOperating_Unit_Id in OR_ope_uni_item_bala.Operating_Unit_Id%type
	   )
	    IS
		      SELECT OR_ope_uni_item_bala.*,OR_ope_uni_item_bala.rowid
		      FROM   OR_ope_uni_item_bala
		      WHERE  Items_Id = inuItems_Id
		      AND    Operating_Unit_Id = inuOperating_Unit_Id
		      FOR UPDATE;

	BEGIN

        UT_TRACE.TRACE('Inicio - GE_BCItemsRequest.LockBalbyOperUnit',5);

		Open cuLockBalbyOperUnit
		(
			inuItems_Id,
			inuOperating_Unit_Id
		);

		fetch cuLockBalbyOperUnit into orcOR_ope_uni_item_bala;
		if cuLockBalbyOperUnit%notfound  then
			close cuLockBalbyOperUnit;
			raise no_data_found;
		end if;
		close cuLockBalbyOperUnit ;

		UT_TRACE.TRACE('Fin - GE_BCItemsRequest.LockBalbyOperUnit',5);
	EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuLockBalbyOperUnit%isopen then close cuLockBalbyOperUnit; END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if cuLockBalbyOperUnit%isopen then close cuLockBalbyOperUnit; END if;
            raise ex.CONTROLLED_ERROR;
	END LockBalbyOperUnit;


END GE_BCItemsRequest;
/
