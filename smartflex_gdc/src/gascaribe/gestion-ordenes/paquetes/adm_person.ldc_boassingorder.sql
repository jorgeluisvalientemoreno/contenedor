CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BOASSINGORDER IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_BoAssingOrder
    Descripcion    : Servicios para asignar ordenes desde plugin
    Autor          : Horbath
	Caso           : 720
    Fecha          : 08-06-2021

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : AssingOrder
    Descripcion    : Plugin para asignacion de orden
  ******************************************************************/
    PROCEDURE AssingOrder;

END LDC_BOASSINGORDER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BOASSINGORDER IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_BoAssingOrder
    Descripcion    : Servicios para asignar ordenes desde plugin
    Autor          : Horbath
	Caso           : 720
    Fecha          : 08-06-2021

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

    csbLDC_ADDATA_OPER_UNIT     CONSTANT    ldc_pararepe.parecodi%TYPE := 'LDC_ADDATA_OPER_UNIT';
    csbLDC_COD_SET_ADDATA       CONSTANT    ldc_pararepe.parecodi%TYPE := 'LDC_COD_SET_ADDATA';
    cnuERROR_CODE               CONSTANT    ge_error_log.error_log_id%TYPE := 2741;
    csbCA720                    CONSTANT    VARCHAR2(10) := '0000720';

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbOperUnitValid
    Descripcion    : Valida si el valor ingresado corresponde a una unidad de trabajo
    Autor          : Horbath
    Fecha          : 08-06-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    FUNCTION fsbOperUnitValid
    (
        inuOperUnit     IN      or_operating_unit.operating_unit_id%TYPE
    )
    RETURN VARCHAR2
    IS

    BEGIN
        ut_trace.trace('Inicia Ldc_BoAssingOrder.fsbOperUnitValid - inuOperUnit: '||inuOperUnit,10);

        IF daor_operating_unit.fblexist(inuOperUnit) THEN
            ut_trace.trace('Fin Ldc_BoAssingOrder.fsbOperUnitValid RETURN Y',10);
            RETURN 'Y';
        END IF;

        ut_trace.trace('Fin Ldc_BoAssingOrder.fsbOperUnitValid RETURN N',10);
        RETURN 'N';

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END fsbOperUnitValid;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetOrderRegenera
    Descripcion    : Obtiene la orden regenerada
    Autor          : Horbath
	Caso           : 720
    Fecha          : 08-06-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE GetOrderRegenera
    (
        inuOrder        IN      or_related_order.order_id%TYPE,
        onuOrderRelated OUT     or_related_order.related_order_id%TYPE
    )
    IS
        CURSOR cuGetOrder
        IS
            SELECT related_order_id
            FROM   or_related_order
            WHERE  order_id = inuOrder
            AND    rela_order_type_id = 2;

    BEGIN
        ut_trace.trace('Inicia Ldc_BoAssingOrder.GetOrderRegenera - inuOrder: '||inuOrder,10);

            IF cuGetOrder%ISOPEN THEN
                CLOSE cuGetOrder;
            END IF;

            OPEN cuGetOrder;
            FETCH cuGetOrder INTO onuOrderRelated;
            CLOSE cuGetOrder;

        ut_trace.trace('Fin Ldc_BoAssingOrder.GetOrderRegenera - onuOrderRelated: '||onuOrderRelated,10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END GetOrderRegenera;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : AssingOrder
    Descripcion    : Plugin para asignacion de orden
    Autor          : Horbath
	Caso           : 720
    Fecha          : 08-06-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE AssingOrder
    IS

        nuOrderId       OR_order.order_id%TYPE;
        nuCausalId      ge_causal.causal_id%TYPE;
        sbNameAttrib    ldc_pararepe.paravast%TYPE;
        nuCodSetAttri   ldc_pararepe.parevanu%TYPE;
        nuOperUnitId    or_operating_unit.operating_unit_id%TYPE;
        nuOrderRelate   OR_order.order_id%TYPE := NULL;
        nuErrorCode     ge_error_log.error_log_id%TYPE;
        sbMessaError    ge_error_log.description%TYPE;

        CURSOR cuAddataValue
        (
            inuOrderId      IN  or_temp_data_values.order_id%TYPE,
            inuSetAdd       IN  or_temp_data_values.attribute_set_id%TYPE,
            isbNameAttr     IN  or_temp_data_values.attribute_name%TYPE
        )
        IS
            SELECT  data_value
            FROM    or_temp_data_values
            WHERE   order_id = inuOrderId
            AND     attribute_set_id = inuSetAdd
            AND     attribute_name = isbNameAttr;


    BEGIN
        ut_trace.trace('Inicia Ldc_BoAssingOrder.AssingOrder',10);

        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        nuCausalId := daor_order.fnugetcausal_id(nuOrderId,0);

        IF dage_causal.fnugetclass_causal_id(nuCausalId,0) = 2 AND fblaplicaentregaxcaso(csbCA720) THEN
            sbNameAttrib := daldc_pararepe.fsbGetPARAVAST(csbLDC_ADDATA_OPER_UNIT, 0);
            nuCodSetAttri := daldc_pararepe.fnuGetPAREVANU(csbLDC_COD_SET_ADDATA, 0);

            OPEN cuAddataValue(nuOrderId, nuCodSetAttri, sbNameAttrib);
            FETCH cuAddataValue INTO nuOperUnitId;
            CLOSE cuAddataValue;

            IF nuOperUnitId IS NULL THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnuERROR_CODE,
                    'El valor del atributo ['||sbNameAttrib||'] no puede ser nulo.'
                );
                raise ex.CONTROLLED_ERROR;
            END IF;

            IF fsbOperUnitValid(nuOperUnitId) = 'N' THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnuERROR_CODE,
                    'El valor ['||nuOperUnitId||'] del atributo ['||sbNameAttrib||'] no corresponde a una unidad operativa v¿lida'
                );
                raise ex.CONTROLLED_ERROR;
            END IF;

            -- Se obtiene la orden relacionada
            GetOrderRegenera(nuOrderId, nuOrderRelate);

            -- Se valida si existe la orden relacionada
            IF nuOrderRelate IS NOT NULL THEN
                -- Se valida si la orden se encuentra en estado registrado
                IF daor_order.fnugetorder_status_id(nuOrderRelate, 0) = 0 THEN

                    ut_trace.trace('Se asigna la orden',10);

                    os_assign_order
                    (
                        nuOrderRelate,
                        nuOperUnitId,
                        ut_date.fdtsysdate,
                        ut_date.fdtsysdate,
                        nuErrorCode,
                        sbMessaError
                    );

                    ut_trace.trace('os_assign_order nuErrorCode: '||nuErrorCode||' sbMessaError: '||sbMessaError,10);

                    IF NVL(nuErrorCode,0) <> 0 THEN
                        ge_boerrors.seterrorcodeargument
                        (
                            nuErrorCode,
                            sbMessaError
                        );
                        raise ex.CONTROLLED_ERROR;
                    END IF;

                END IF;
            END IF;

        END IF;

        ut_trace.trace('Fin Ldc_BoAssingOrder.AssingOrder',10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END AssingOrder;



END LDC_BOASSINGORDER;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOASSINGORDER', 'ADM_PERSON');
END;
/