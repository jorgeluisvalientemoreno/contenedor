CREATE OR REPLACE PROCEDURE adm_person.PR_VALID_INCLUD_MAT
/*****************************************************************
Propiedad intelectual de Gas Caribe.

Unidad         : PR_VALID_INCLUD_MAT
Descripcion    : Valida que la orden contenga al menos un material (ítems clasificación 8)
Autor          :
Fecha          : 18/11/2016

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
30/04/2024        PACOSTA           OSF-2598: Se crea el objeto en el esquema adm_person 
******************************************************************/
IS
    cursor cuMaterials(inuOrderId in or_order.order_id%type)
    is
        select count(1)
        from or_order_items, ge_items
        where or_order_items.items_id = ge_items.items_id
        and ge_items.item_classif_id = 8
        and or_order_items.order_id = inuOrderId
        and or_order_items.legal_item_amount > 0
        and rownum = 1;

    nuOrderId   or_order.order_id%type;
    nuCantidad  number := 0;
    nuCausalId  ge_causal.causal_id%type;
BEGIN

    ut_trace.trace('Inicia PR_VALID_INCLUD_MAT',10);
    nuOrderId := or_bolegalizeorder.fnugetcurrentorder;
    ut_trace.trace('nuOrderId '||nuOrderId,10);

    nuCausalId := daor_order.fnugetcausal_id(nuOrderId,null);
    ut_trace.trace('nuCausalId '||nuCausalId,10);

    -- Valida si la orden tiene causal de legalizacion
    if nuCausalId is null then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
            'La orden no tiene causal');
        raise ex.controlled_error;
    end if;

    -- Valida si la causal debe validar materiales
    if instr(dald_parameter.fsbGetValue_Chain('COD_CAUS_VALID_MAT'),nuCausalId) > 0 then

        open cuMaterials(nuOrderId);
        fetch cuMaterials into nuCantidad;
        close cuMaterials;

        if nuCantidad = 0 then
            ut_trace.trace('PR_VALID_INCLUD_MAT - No tiene materiales',10);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                'Debe adicionar al menos un material');
            raise ex.controlled_error;

        end if;

    end if;

    ut_trace.trace('Fin PR_VALID_INCLUD_MAT',10);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END PR_VALID_INCLUD_MAT;
/
PROMPT Otorgando permisos de ejecucion a PR_VALID_INCLUD_MAT
BEGIN
    pkg_utilidades.praplicarpermisos('PR_VALID_INCLUD_MAT', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre PR_VALID_INCLUD_MAT para reportes
GRANT EXECUTE ON adm_person.PR_VALID_INCLUD_MAT TO rexereportes;
/