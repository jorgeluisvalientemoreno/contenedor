CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBGETPENDORDERSCM" 
(
    inuProductId    IN  pr_product.product_id%TYPE
)
RETURN VARCHAR2
IS
    /**************************************************************************
    <Function Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad>fsbGetPendOrdersCM</Unidad>
        <Autor>Harrinson Henao Camelo - Horbath</Autor>
        <Fecha>21-02-2022</Fecha>
        <Descripcion>
            Funcion que indica si un producto tienen solicitudes de cambio de medidor
            con ordenes pendientes x legalizar
        </Descripcion>
        <Historial>
            <Modificacion Autor="hahenao" Fecha="21-02-2022" Inc="CA875" Empresa="GDC">
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    --Constantes
    csbVersion  CONSTANT VARCHAR2(100) := 'CA875';

    -- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnuLEVELPUSHPOP             CONSTANT NUMBER := 1;
    cnuLEVEL                    CONSTANT NUMBER := 9;
    cnuGenericError             CONSTANT NUMBER := 2741;

    --Variables
    sbMethodName    VARCHAR2(50) := 'ldc_fsbGetPendOrdersCM';
    sbReturn        VARCHAR2(1);
    nuCount         NUMBER;

    --Cursores
    CURSOR cuPendOrders
    IS
        SELECT COUNT(*)
        FROM ldc_ctrllectura a, 
             mo_packages b, 
             or_order_activity c, 
             or_order d
        WHERE b.package_id = a.id_solicitud
        AND a.num_producto = inuProductId
        AND c.package_id = b.package_id
        AND d.order_id = c.order_id
        AND d.order_status_id not in (8,12);

BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        sbReturn := 'N';

        OPEN cuPendOrders;
        FETCH cuPendOrders INTO nuCount;
        IF (cuPendOrders%NOTFOUND) THEN
            nuCount := 0;
        END IF;
        CLOSE cuPendOrders;

        IF (nuCount > 0) THEN
            sbReturn := 'Y';
        END IF;

        ut_trace.trace('--sbReturn: '||sbReturn,cnuLEVEL);
    ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
        RETURN sbReturn;
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVELPUSHPOP);
        RETURN 'N';
        RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVELPUSHPOP);
        Errors.setError;
        RETURN 'N';
        RAISE ex.CONTROLLED_ERROR;
END ldc_fsbGetPendOrdersCM;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBGETPENDORDERSCM', 'ADM_PERSON');
END;
/
