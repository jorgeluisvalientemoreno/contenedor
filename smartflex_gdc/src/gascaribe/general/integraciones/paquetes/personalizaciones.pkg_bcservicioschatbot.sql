CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bcservicioschatbot IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcservicioschatbot
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   03-07-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre servicios
                    chatbot

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     03-07-2024      OSF-2917    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

    FUNCTION fnuSolicitudSAC
    (
        inuContrato     IN  mo_motive.subscription_id%TYPE,
        inuActividad    IN  or_order_activity.activity_id%TYPE
    )
    RETURN NUMBER;

END pkg_bcservicioschatbot;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bcservicioschatbot IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2917';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 03/07/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     03/07/2024  OSF-2917    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuSolicitudSAC
        Descripcion     : Obtiene solicitud SAC
        Autor           :
        Fecha           : 03/07/2024
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     03/07/2024          OSF-2917: Creación
    ***************************************************************************/
    FUNCTION fnuSolicitudSAC
    (
        inuContrato     IN  mo_motive.subscription_id%TYPE,
        inuActividad    IN  or_order_activity.activity_id%TYPE
    )
    RETURN NUMBER
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fnuSolicitudSAC';

        nuSolictud          mo_packages.package_id%TYPE;

        CURSOR cuObtieneSolicitud
        (
            inuContrato IN  mo_motive.subscription_id%TYPE,
            inuActividad IN  or_order_activity.activity_id%TYPE
        )
        IS
        SELECT  mo.package_id
        FROM    mo_motive mt, mo_packages mo,  or_order_activity oa
        WHERE   mt.package_id = mo.package_id
        AND     oa.package_id = mo.package_id
        AND     mo.package_type_id = 100306
        AND     mo.motive_status_id = 13
        AND     oa.activity_id = inuActividad
        AND     mt.subscription_id = inuContrato;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneSolicitud%ISOPEN) THEN
            CLOSE cuObtieneSolicitud;
        END IF;

        OPEN cuObtieneSolicitud (inuContrato,inuActividad);
        FETCH cuObtieneSolicitud INTO nuSolictud;
        CLOSE cuObtieneSolicitud;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuSolictud;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuSolictud;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuSolictud;
    END fnuSolicitudSAC;
END pkg_bcservicioschatbot;
/
BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_BCSERVICIOSCHATBOT', 'PERSONALIZACIONES');
END;
/    