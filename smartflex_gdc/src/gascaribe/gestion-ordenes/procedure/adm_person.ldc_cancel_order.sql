CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_CANCEL_ORDER
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_CANCEL_ORDER
  DESCRIPCION    : PROCEDIMIENTO PARA ANULAR ÿRDENES Y REGISTRAR LA CAUSAL.
  AUTOR          : KATHERINE CIENFUEGOS
  NC             : 622
  FECHA          : 07/08/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  inuOrderId           Númeo de la Orden
  inuCausalId          Código de la causal
  isbComment           Comentario de la Orden

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  14/05/2024      Paola Acosta        OSF-2674: Cambio de esquema ADM_PERSON  
  07/08/2014      KCienfuegos         Creación.  
  ******************************************************************/
    (
        inuOrderId          in  OR_order.order_id%type,
        inuCausalId         in  ge_causal.causal_id%type,
        isbComment          in  or_order_comment.order_comment%type default null,
        inuCommentType      in  ge_comment_type.comment_type_id%type,
        onuError            out number,
        osbErrorMessage     out varchar2
    )
    IS
        rcOrder                daor_order.styOr_order;
        nuFailureClass         ge_causal.class_causal_id%type;
        cnuERR_8681            CONSTANT NUMBER := 8681;
        cnuERR_8571            CONSTANT NUMBER := 8571;
        cnuERR_8571            CONSTANT NUMBER := 8571;
        cnuMensOk              CONSTANT NUMBER  := 4427;
        cnuFailureClass        CONSTANT NUMBER := 2;
        cnuRevokeClass         CONSTANT NUMBER := 11;

    BEGIN

        ut_trace.trace('INICIO - LDC_CANCEL_ORDER - Orden: '||inuOrderId||' Causal: '||inuCausalId,10);

        /* Obtiene registro de la orden */
        daor_order.getRecord(inuOrderId,rcOrder);
        rcOrder.Causal_id := inuCausalId;

        /* Valida estado de la orden */
        if(rcOrder.order_status_id not in (or_boconstants.cnuORDER_STAT_ASSIGNED, or_boconstants.cnuORDER_STAT_REGISTERED)) then
            osbErrorMessage := dage_message.fsbgetdescription(inuMessage_Id => cnuERR_8681);
            onuError := cnuERR_8681;
            return;
        end if;

        /* Obtiene la clasificación de la causal */
        nuFailureClass := DAGE_causal.fnugetclass_causal_id(inuCausalId);
        ut_trace.trace('Valida clase de causal: '||nuFailureClass, 15);
        if (nuFailureClass not in(cnuFailureClass,cnuRevokeClass)) then
          onuError := -1;
          osbErrorMessage := 'La clasificación de la causal no es válida para anulación';
          return;
        end if;

        if inuCommentType is null then
          onuError := -1;
          osbErrorMessage := 'El tipo de comentario no puede ser nulo';
          return;
        end if;

        /* Cancela la orden */
        ut_trace.trace('Cambia estado de la orden', 15);
        changeStatus(rcOrder,or_boconstants.cnuORDER_STAT_CANCELED,inuCommentType,nvl(isbComment,'Orden anulada'));

        /* Actualizacion de cantidad legalizada */
        ut_trace.trace('Actualizar Cantidad Legalizada', 15);
        UPDATE or_order_items t
           SET legal_item_amount =  -1,
               t.value = 0
        WHERE order_items_id in (
                                  SELECT i.order_items_id
                                    FROM or_order_activity a,
                                         OR_order_items    i
                                   WHERE i.ORDER_id = rcOrder.order_id
                                     AND i.order_items_id = a.order_item_id
                                 );


        ut_trace.trace('FIN - LDC_CANCEL_ORDER',10);

        osbErrorMessage := dage_message.fsbgetdescription(cnuMensOk);
        onuError := 0;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        onuError := -1;
        osbErrorMessage := sqlerrm;
        return;
    when others then
        onuError := -1;
        osbErrorMessage := sqlerrm;
        return;
END LDC_CANCEL_ORDER;
/
PROMPT Otorgando permisos de ejecucion a LDC_CANCEL_ORDER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_CANCEL_ORDER', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_CANCEL_ORDER para reportes
GRANT EXECUTE ON adm_person.LDC_CANCEL_ORDER TO rexereportes;
/