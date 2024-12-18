CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBGETORDERCOMENTS" 
/*****************************************************************
    Propiedad intelectual de CSC.

    Nombre: LDC_fsbGetOrderComents
    Descripcion    : Obtiene los comentarios para la sentencia de la notificación
                     100380  - LDC_INSP_CERT_NUEVAS

    Autor          : Carlos Alberto Ramírez
    Fecha          : 23/01/2017

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========      ============        ====================
    23/01/2017    carlosr@arqs.co
    Creación
******************************************************************/
(
    inuOrder_id     in or_order.order_id%type,
    inuPackage_id   in mo_packages.package_id%type,
    inuPacageType   in mo_packages.package_type_id%type
)
return varchar2
IS

    sbPackageTypes  ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('LDC_SOLIC_INSP_CERT_NUEVAS');
    nuValida        number;

    cursor cuGetRelatedOrder
    is
        SELECT  relaor.order_id
        FROM    or_order_activity ord, or_order_activity relaor
        WHERE   ord.order_id = inuOrder_id
        AND     ord.origin_activity_id = relaor.order_activity_id;

    nuOrder_id  or_order.order_id%type;
BEGIN
    ut_trace.trace('Empieza  => LDC_fsbGetOrderComents ',10);
    -- Valida que el tipo de solicitud esté configurado
    nuValida := instr(sbPackageTypes,inuPacageType);

    open  cuGetRelatedOrder;
    fetch cuGetRelatedOrder into nuOrder_id;
    close cuGetRelatedOrder;

    if(nuValida = 0) then
        return damo_packages.fsbgetcomment_(inuPackage_id,null)||'//'||ldc_bonotificaciones.fsbgetcommentrpasociados(inuOrder_id)||'//'||ldc_reportesconsulta.fsbobservacionot(inuOrder_id)||'//'||ldc_reportesconsulta.fsbobservacionot(nuOrder_id);
    else
        return damo_packages.fsbgetcomment_(inuPackage_id,null)||'//'||ldc_bcperiodicreview.fsbgetcommentrp(inuOrder_id)||'//'||ldc_bcperiodicreview.fsbgetdefectsrp(inuOrder_id)||'//'||ldc_reportesconsulta.fsbobservacionot(inuOrder_id)||'//'||ldc_reportesconsulta.fsbobservacionot(nuOrder_id);
    end if;

    ut_trace.trace('Finaliza  => nuOrderId => ' ||inuOrder_id,10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
        gw_boerrors.checkerror(SQLCODE, SQLERRM);
        raise;
    when others then
        gw_boerrors.checkerror(SQLCODE, SQLERRM);
        raise ex.CONTROLLED_ERROR;
END LDC_fsbGetOrderComents;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBGETORDERCOMENTS', 'ADM_PERSON');
END;
/
