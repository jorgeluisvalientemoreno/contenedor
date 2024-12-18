CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcautoreconectados IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Car2024ibe
    pkg_bcautoreconectados
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   19/03/2024
    Descripcion :   Paquete con consultas para autoreconectados
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     19/03/2024      OSF-2443    Creacion
    dsaltarin           08/10/2024      OSF-2443    Se corrige la consulta del parametro TT_AUTORECO_REPARACION,
                                                    el cual se encuentra configurado en LD_PARAMETER y no en PARAMETROS
*******************************************************************************/

    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    FUNCTION fnuObtieneUltimaOrden
    (
        inuContrato     IN NUMBER
    )
    RETURN NUMBER;

END pkg_bcautoreconectados;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcautoreconectados IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-2443';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

    csbTiposTrabajo		CONSTANT VARCHAR2(4000) := pkg_bcld_parameter.fsbObtieneValorCadena('TT_AUTORECO_REPARACION');

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 19/03/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     19/03/2024  OSF-2443 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtieneUltimaOrden
        Descripcion     : Obtiene la ultima orden de reparación
        Autor           : 
        Fecha           : 19/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     19/03/2024          OSF-2443: Creación
    ***************************************************************************/
    FUNCTION fnuObtieneUltimaOrden
    (
        inuContrato     IN NUMBER
    )
    RETURN NUMBER
    IS
        nuOrden             or_order.order_id%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'.fnuObtieneUltimaOrden';

        CURSOR cuObtOrden
        (
            inuContrato     IN NUMBER
        )
        IS
        SELECT  order_id
        FROM (
                SELECT  oo.order_id
                FROM    or_order oo,
                        or_order_activity ooa,
                        ge_causal ooc
                WHERE   oo.order_id = ooa.order_id
                AND     ooc.causal_id = oo.causal_id
                AND     ooc.class_causal_id = 1
                AND     oo.order_status_id = 8
                AND     ooa.subscription_id = inuContrato
                AND     oo.task_type_id IN (SELECT TO_NUMBER(regexp_substr(csbTiposTrabajo,'[^,]+', 1, level)) as valores
                                                    FROM dual
                                                    connect by regexp_substr(csbTiposTrabajo, '[^,]+', 1, level) is not null)
                ORDER BY oo.legalization_date DESC
        );

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtOrden%ISOPEN) THEN
            CLOSE cuObtOrden;
        END IF;

        OPEN cuObtOrden(inuContrato);
        FETCH cuObtOrden INTO nuOrden;
        CLOSE cuObtOrden;
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuOrden;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN null;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN null;    
    END fnuObtieneUltimaOrden;


END pkg_bcautoreconectados;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcautoreconectados
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCAUTORECONECTADOS', 'PERSONALIZACIONES');
END;
/