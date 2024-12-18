CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcmaestromateriales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcmaestromateriales
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   28-06-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					interfaz de materiales

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     28-06-2024      OSF-2793    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna la causal de la orden
    FUNCTION fblExisteEstructuraMaterial
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;

    FUNCTION fblExisteItemRecuperado
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;

END pkg_bcmaestromateriales;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcmaestromateriales IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2793';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 28/06/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     28/06/2024  OSF-2793    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblExisteEstructuraMaterial 
        Descripcion     : Consulta si existe control de estructura de material
        Autor           : 
        Fecha           : 28/06/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     28/06/2024          OSF-2793: Creación
    ***************************************************************************/
    FUNCTION fblExisteEstructuraMaterial
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblExisteEstructuraMaterial';

        blExiste            BOOLEAN := FALSE;
        nuContar            NUMBER;

        CURSOR cuConteoControl
        IS
        SELECT  COUNT (*)
        FROM    LDCI_CONTESSE c
        WHERE   c.COESCOSA = TO_NUMBER (inuItem);
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuConteoControl%ISOPEN) THEN
            CLOSE cuConteoControl;
        END IF;

        OPEN cuConteoControl;
        FETCH cuConteoControl INTO nuContar;
        CLOSE cuConteoControl;

        IF (nuContar > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN blExiste;  
    END fblExisteEstructuraMaterial;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblExisteItemRecuperado 
        Descripcion     : Valida si existe material recuperado
        Autor           : 
        Fecha           : 28/06/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     28/06/2024          OSF-2793: Creación
    ***************************************************************************/
    FUNCTION fblExisteItemRecuperado
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblExisteItemRecuperado';

        blExiste            BOOLEAN := FALSE;
        nuContar            NUMBER;

        CURSOR cuConteoControl
        IS
        SELECT 'X'
        FROM LDCI_MATERECU
        WHERE items_id = inuItem;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuConteoControl%ISOPEN) THEN
            CLOSE cuConteoControl;
        END IF;

        OPEN cuConteoControl;
        FETCH cuConteoControl INTO nuContar;
        CLOSE cuConteoControl;

        IF (nuContar > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN blExiste;  
    END fblExisteItemRecuperado;
END pkg_bcmaestromateriales;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcmaestromateriales
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCMAESTROMATERIALES', 'personalizaciones');
END;
/