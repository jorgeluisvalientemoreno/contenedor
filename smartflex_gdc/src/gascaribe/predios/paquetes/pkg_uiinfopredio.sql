CREATE OR REPLACE PACKAGE pkg_uiinfopredio IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_uiinfopredio
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   05-07-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre información
                    del predio

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     05-07-2024      OSF-2752    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;


    PROCEDURE prcValidaPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    );

END pkg_uiInfoPredio;

/
CREATE OR REPLACE PACKAGE BODY pkg_uiInfoPredio IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2752';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 05/07/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     05/07/2024  OSF-2752    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcValidaPredioCastigado 
        Descripcion     : Valida si el predio se ecuentra castigado
        Autor           : 
        Fecha           : 05/07/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/07/2024          OSF-2752: Creación
    ***************************************************************************/
    PROCEDURE prcValidaPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcValidaPredioCastigado';

        blCastigado         BOOLEAN := FALSE;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

        pkg_traza.trace('inudireccion: ' || inudireccion, pkg_traza.cnuNivelTrzDef);    

        pkg_boinfopredio.prcValidaPredioCastigado(inudireccion);

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcValidaPredioCastigado;
END pkg_uiinfopredio;
/

PROMPT Otorgando permisos de ejecución para open.pkg_uiinfopredio
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UIINFOPREDIO', 'OPEN');
END;
/