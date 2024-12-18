CREATE OR REPLACE PROCEDURE personalizaciones.prcCrearActividadNotifica
(
    inuProducto     NUMBER
)
IS
/*
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Unidad:       prcCrearActividadNotifica
    Descripcion:  procedimiento que crea la actividad de impresión tercera notificación
    Autor:        German Dario Guevara Alzate - GlobalMVM

    Caso:         OSF-2647
    Fecha:        10/may/2024
        
    Modificaciones
    11/jun/2024   GDGuevara   Se elimina la 2 validacion de la direccion de cualquier producto
*/
    csbMetodo      CONSTANT VARCHAR2(70) := 'prcCrearActividadNotifica';
    cnuNivelTraza  CONSTANT NUMBER       := 5;
    -- Notificacion Suspension x Ausencia de Certificado
    cnuProdMotSusp CONSTANT NUMBER       := 100248;
    -- se almacena actividad a generar
    nuActiviImpr60 CONSTANT NUMBER       := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_ACTICARM60');

    -- Se obtiene el cliente y la direccion del producto
    CURSOR cugetDireccion (inuProduct IN NUMBER) IS
        SELECT p.address_id,
               s.suscclie,
               s.susccodi
        FROM pr_product p,
             suscripc s
        WHERE p.product_id = inuProduct
          AND s.susccodi   = p.subscription_id;

    nuCliente           NUMBER;
    nuContrato          NUMBER;
    nuDireccion         NUMBER;
    nuRefValue          NUMBER;
    nuOrderId           NUMBER;
    nuError             NUMBER;
    nuOrderActivityId   NUMBER;
    dtExecDate          DATE;
    sbError             VARCHAR2(4000);
    sbComment           VARCHAR2(4000);

BEGIN
    pkg_traza.trace('Inicia '||csbMetodo, cnuNivelTraza);

    IF (nvl(inuProducto,0) = 0) THEN
        nuError := 9059;        -- producto no existe
        pkg_error.setError;
        RAISE pkg_error.Controlled_Error;
    END IF;

    nuRefValue := 0;
    dtExecDate := SYSDATE + 1/24*60;
    sbComment  := 'ORDEN GENERADA POR PROCESO DE JOB (JOB_SUSPENSION_XNO_CERT)';

    -- Trae la direccion del producto
    OPEN cugetDireccion (inuProducto);
    FETCH cugetDireccion INTO nuDireccion, nuCliente, nuContrato;
    CLOSE cugetDireccion;

    --se crea orden de trabajo y la actividad
    api_createorder
    (
        nuActiviImpr60,     -- inuItemsid
        null,               -- inuPackageid
        null,               -- inuMotiveid
        null,               -- inuComponentid
        null,               -- inuInstanceid
        nuDireccion,        -- inuAddressid
        null,               -- inuElementid
        nuCliente,          -- inuSubscriberid
        nuContrato,         -- inuSubscriptionid
        inuProducto,        -- inuProducto
        null,               -- inuOperunitid
        dtExecDate,         -- idtExecestimdate
        null,               -- inuProcessid
        sbComment,          -- isbComment
        true,               -- iblProcessorder
        null,               -- inuPriorityid
        null,               -- inuOrdertemplateid
        null,               -- isbCompensate
        null,               -- inuConsecutive
        null,               -- inuRouteid
        null,               -- inuRouteConsecutive
        null,               -- inuLegalizetrytimes
        null,               -- isbTagname
        null,               -- iblIsacttoGroup
        nuRefValue,         -- inuRefvalue
        null,               -- inuActionid
        nuOrderId,          -- ionuOrderid
        nuOrderActivityId,  -- ionuOrderactivityid
        nuError,            -- onuErrorCode
        sbError             -- osbErrorMessage
    );

    IF (nuError = 0) THEN
        pkg_traza.trace ('Creada ORDER_ACTIVITY_ID: ' || nuOrderActivityId, cnuNivelTraza);
    ELSE
        pkg_traza.trace ('Error en api_createorder => ' || sbError, cnuNivelTraza);
    END IF;

    pkg_traza.trace('Termina '||csbMetodo, cnuNivelTraza);

EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace (csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError (nuError, sbError);
        pkg_traza.trace ('sbError => ' || sbError, cnuNivelTraza);
    WHEN OTHERS THEN
        pkg_traza.trace (csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_error.setError;
        pkg_Error.getError (nuError, sbError);
        pkg_traza.trace ('sbError => ' || sbError, cnuNivelTraza);
END prcCrearActividadNotifica;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRCCREARACTIVIDADNOTIFICA','PERSONALIZACIONES');
END;
/