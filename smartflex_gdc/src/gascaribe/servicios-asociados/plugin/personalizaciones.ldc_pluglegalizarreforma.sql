create or replace PROCEDURE personalizaciones.LDC_PLUGLEGALIZARREFORMA
IS
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad>LDC_PLUGLEGALIZARREFORMA</Unidad>
        <Autor>Eduardo Luis Tapia Pugliese - Horbath</Autor>
        <Fecha>05-04-2023</Fecha>
        <Descripcion>
            PLUGIN de validacion de estado de carpeta de reforma
        </Descripcion>
        <Historial>
            <Modificacion Autor="etapia" Fecha="05-04-2023" Inc="PE-382" Empresa="GDC">
                Creacion
            </Modificacion>
            <Modificacion Autor="adrianavg" Fecha="06-10-2023" Inc="OSF-1709" Empresa="GDC">
                Reemplazar llamado al servicio ldc_boConsGenerales.fnuGetLegaliceOrder por el servicio servicio pkg_bcordenes.fnuObtenerOTInstanciaLegal
            <Modificacion Autor="adrianavg" Fecha="24-10-2023" Inc="OSF-1709" Empresa="GDC">
                Reemplazar ut_trace por PKG_TRAZA.TRACE. Reemplazar ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                Reemplazar Errors.setError por PKG_ERROR.SETERROR. Reemplazar GE_BOERRORS.SETERRORCODEARGUMENT por
                PKG_ERROR.SETERRORMESSAGE. Se retira el esquema OPEN antepuesto a los objetos: or_order_activity, pr_product, or_order
                Se retira esquema antepuesto a pkg_bcordenes.fnuObtenerOTInstanciaLegal
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    --Constantes
    csbVersion  CONSTANT VARCHAR2(100) := 'OSF-1709';

    -- Para el control de traza:
    csbMetodo  CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
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
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;  
    nuOrderId       NUMBER; --se almacena orden de trabajo
    nuPackageId     NUMBER; --se almacena numero de solicitud
    nuCountFolder   NUMBER; --se almacena contador 

    --Cursores
    CURSOR cuObtieneSolicitud
    (
        inuOrderId      IN    or_order_activity.order_id%TYPE
    )
    IS
        SELECT ooa.PACKAGE_ID
            FROM OR_ORDER_ACTIVITY ooa
            INNER JOIN PR_PRODUCT pp ON pp.PRODUCT_ID = ooa.PRODUCT_ID
        WHERE ORDER_ID = inuOrderId
            AND ROWNUM = 1;

    CURSOR cuVerificaEstadoCarpeta
    (
         inuPackageId  IN    or_order_activity.PACKAGE_ID%TYPE
    )
    IS
        SELECT COUNT(1)
          FROM OR_ORDER_ACTIVITY ooa
          INNER JOIN OR_ORDER oo ON oo.ORDER_ID = ooa.ORDER_ID
        WHERE ooa.PACKAGE_ID = inuPackageId
          AND oo.TASK_TYPE_ID IN (11249)
          AND oo.ORDER_STATUS_ID = 8
          AND oo.CAUSAL_ID IN (1)
          AND ooa.SUBSCRIPTION_ID IS NOT NULL;

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        nuOrderId   := pkg_bcordenes.fnuObtenerOTInstanciaLegal;

        --obtiene el numero de solicitud asociado a la orden
        OPEN cuObtieneSolicitud(nuOrderId);
        FETCH cuObtieneSolicitud INTO nuPackageId;
        CLOSE cuObtieneSolicitud;

        IF nuPackageId IS NULL THEN
            PKG_ERROR.SETERRORMESSAGE(cnuGenericError, 'La orden no esta asociada a una solicitud');            
        END IF;

        --verifica  si la solicitud tiene asociada una OT de gestion documental(TT11249,11201,11202) legalizada
        OPEN cuVerificaEstadoCarpeta(nuPackageId);
        FETCH cuVerificaEstadoCarpeta INTO nuCountFolder;
        CLOSE cuVerificaEstadoCarpeta;

        IF nuCountFolder = 0 THEN
            PKG_ERROR.SETERRORMESSAGE(cnuGenericError,'Esta accion no esta permitida en Smartflex. La carpeta asociada a esta orden en el Portal de Reformas no ha sido gestionada por el contratista');
        END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        PKG_ERROR.SETERROR;
        RAISE PKG_ERROR.CONTROLLED_ERROR;
END LDC_PLUGLEGALIZARREFORMA;
/
PROMPT Otorgando permisos de ejecucion a LDC_PLUGLEGALIZARREFORMA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PLUGLEGALIZARREFORMA','PERSONALIZACIONES');
END;
/