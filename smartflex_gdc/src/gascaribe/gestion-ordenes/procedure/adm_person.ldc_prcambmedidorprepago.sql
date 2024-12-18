CREATE OR REPLACE PROCEDURE adm_person.ldc_prcambmedidorprepago
IS
    /**************************************************************************
    Propiedad Intelectual de Gases del Caribe SA ESP"
    Nombre: LDC_PRCAMBMEDIDORPREPAGO
    Autor:DSALTARIN
    Fecha:02-05-2022
    Descripcion: PLUGIN de Medidor prepago
    
    HISTORIA DE MODIFICACIONES
    FECHA           AUTOR               DESCRIPCION
    -----           -----               -----------------------
    17/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
                                        Se retira la referencia al esquema open (OPEN.)
    **************************************************************************/
    --Constantes
    csbversion  CONSTANT VARCHAR2(100) := 'OSF-275';

    -- Para el control de traza:
    csbsp_name  CONSTANT VARCHAR2(100) := $$plsql_unit||'.';
    csbpush     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbpop      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbpop_erc  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbpop_err  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbldc      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnulevelpushpop             CONSTANT NUMBER := 1;
    cnulevel                    CONSTANT NUMBER := 9;
    cnugenericerror             CONSTANT NUMBER := 2741;

    --Variables
    sbmethodname    VARCHAR2(50) := 'LDC_PRCAMBMEDIDORPREPAGO';
    nuorderid       or_order.order_id%TYPE;
    nucausalid      ge_causal.causal_id%TYPE;
	nucontrato		suscripc.susccodi%TYPE;

    --Cursores
    CURSOR cuorderactivity
    (
        inuorderid      IN    or_order_activity.order_id%TYPE
    )
    IS
        SELECT  *
        FROM    or_order_activity
        WHERE order_id = inuorderid;

    --Registros
    rcorderactivity    cuorderactivity%rowtype;

BEGIN
    ut_trace.TRACE(csbldc||csbsp_name||csbpush||sbmethodname,cnulevelpushpop);

    IF fblaplicaentregaxcaso('OSF-275') THEN
        nuorderid   := or_bolegalizeorder.fnugetcurrentorder;
        nucausalid  := daor_order.fnugetcausal_id(nuorderid, 0);
        
        -- Se valida si la causal es de exito
        IF dage_causal.fnugetclass_causal_id(nucausalid, 0) = 1 THEN
            OPEN cuorderactivity(nuorderid);
            FETCH cuorderactivity INTO rcorderactivity;
            CLOSE cuorderactivity;
        
            IF rcorderactivity.subscription_id IS NOT NULL THEN
                nucontrato := rcorderactivity.subscription_id;
            ELSIF rcorderactivity.product_id IS NOT NULL THEN
                nucontrato := dapr_product.fnugetsubscription_id(rcorderactivity.product_id, NULL);
            END IF;
        
            IF nucontrato IS NULL THEN
                ge_boerrors.seterrorcodeargument(cnugenericerror,
                                                 'No se pudo identificar el contrato de la orden');
            END IF;
            
            ldc_pgeneratebillprep(nucontrato);
        END IF;
    END IF;
    
    ut_trace.TRACE(csbldc||csbsp_name||csbpop||sbmethodname,cnulevelpushpop);
EXCEPTION
    WHEN ex.controlled_error THEN
        ut_trace.TRACE(csbldc||csbsp_name||csbpop_erc||sbmethodname,cnulevelpushpop);
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ut_trace.TRACE(csbldc||csbsp_name||csbpop_err||sbmethodname,cnulevelpushpop);
        ERRORS.seterror;
        RAISE ex.controlled_error;
END ldc_prcambmedidorprepago;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRCAMBMEDIDORPREPAGO
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PRCAMBMEDIDORPREPAGO','ADM_PERSON');
END;
/