CREATE OR REPLACE PROCEDURE adm_person.PR_UPDATE_VALUE_COTI
IS
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE GASES DEl CARIBE S.A E.S.P
    
    UNIDAD         : PR_UPDATE_VALUE_COTI
    DESCRIPCION    : 
    AUTOR          :  
    FECHA          : 
    
    PARAMETROS              DESCRIPCION
    ============         ===================
    
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    29/04/2024       PACOSTA           OSF-2598: Se crea el objeto en el esquema adm_person
    ******************************************************************/

    sbOrderId           ge_boInstanceControl.stysbValue;
    sbOrderIdb          ge_boInstanceControl.stysbValue;
    nuValorTotal        LDC_ITEMADIC_LDCRIAIC.valor_total_sec%type;
    nuValorTotalB       LDC_ITEMADICINTE_LDCRIAIC.valor_total_sec%type;

    cursor cuLDCRIAIC(nuOrderId  in LDC_ITEMCOTI_LDCRIAIC.order_id%type)
    is
        select  LDC_ITEMCOTI_LDCRIAIC.order_id,
                min(LDC_ITEMCOTI_LDCRIAIC.codigo) codi,
                max(LDC_ITEMADIC_LDCRIAIC.secuencia) maxi,
                sum(LDC_ITEMADIC_LDCRIAIC.total) total
        from    LDC_ITEMCOTI_LDCRIAIC, LDC_ITEMADIC_LDCRIAIC
        where   LDC_ITEMCOTI_LDCRIAIC.codigo = LDC_ITEMADIC_LDCRIAIC.codigo
        and     LDC_ITEMCOTI_LDCRIAIC.order_id = nuOrderId
        group by LDC_ITEMCOTI_LDCRIAIC.order_id;

    rgLDCRIAIC    cuLDCRIAIC%rowtype;

    cursor cuLDCRIAICI(nuOrderId  in LDC_ITEMCOTIINTE_LDCRIAIC.order_id%type)
    is
        select  LDC_ITEMCOTIINTE_LDCRIAIC.order_id,
                min(LDC_ITEMCOTIINTE_LDCRIAIC.codigo) codi,
                max(LDC_ITEMADICINTE_LDCRIAIC.secuencia) maxi,
                sum(LDC_ITEMADICINTE_LDCRIAIC.total) total
        from    LDC_ITEMCOTIINTE_LDCRIAIC, LDC_ITEMADICINTE_LDCRIAIC
        where   LDC_ITEMCOTIINTE_LDCRIAIC.codigo = LDC_ITEMADICINTE_LDCRIAIC.codigo
        and     LDC_ITEMCOTIINTE_LDCRIAIC.order_id = nuOrderId
        group by LDC_ITEMCOTIINTE_LDCRIAIC.order_id;

    rgLDCRIAICI    cuLDCRIAICI%rowtype;

BEGIN

    ut_trace.trace('Inicia el metodo PR_UPDATE_VALUE_COTI',10);

    sbOrderId := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER', 'ORDER_ID');
    sbOrderIdb := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER_ACTIVITY', 'ORDER_ID');

    if sbOrderId is null and sbOrderIdb is null then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Debe diligenciar únicamente un campo.');
        raise ex.controlled_error;
    end if;

    if sbOrderId is not null and sbOrderIdb is not null then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Debe diligenciar únicamente un campo.');
        raise ex.controlled_error;
    end if;

    -- Actualiza datos de la forma LDCRIAIC
    if sbOrderId is not null then

        open cuLDCRIAIC(to_number(sbOrderId));
        fetch cuLDCRIAIC into rgLDCRIAIC;
        close cuLDCRIAIC;

        if rgLDCRIAIC.order_id is not null then

            update LDC_ITEMADIC_LDCRIAIC
                set valor_total_sec = rgLDCRIAIC.total
            where codigo = rgLDCRIAIC.codi
            and secuencia = rgLDCRIAIC.maxi;

            commit;

        end if;
    end if;

    -- Actualiza datos de la forma LDCRIAICI
    if sbOrderIdb is not null then

        open cuLDCRIAICI(to_number(sbOrderIdb));
        fetch cuLDCRIAICI into rgLDCRIAICI;
        close cuLDCRIAICI;

        if rgLDCRIAICI.order_id is not null then

            update LDC_ITEMADICINTE_LDCRIAIC
                set valor_total_sec = rgLDCRIAICI.total
            where codigo = rgLDCRIAICI.codi
            and secuencia = rgLDCRIAICI.maxi;

            commit;

        end if;
    end if;

    ut_trace.trace('Fin metodo PR_UPDATE_VALUE_COTI',10);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END PR_UPDATE_VALUE_COTI;
/
PROMPT Otorgando permisos de ejecucion a PR_UPDATE_VALUE_COTI
BEGIN
    pkg_utilidades.praplicarpermisos('PR_UPDATE_VALUE_COTI', 'ADM_PERSON');
END;
/