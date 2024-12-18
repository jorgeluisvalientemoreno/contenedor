CREATE OR REPLACE PACKAGE adm_person.pkg_bcgamaitems IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcgamaitems
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   28-06-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					tablas OPEN.GE_ITEMS_GAMA y OPEN.GE_ITEMS_GAMA_ITEM

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     28-06-2024      OSF-2793    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna la causal de la orden
    FUNCTION fblTieneGamaItem 
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;

END pkg_bcgamaitems;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcgamaitems IS

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
        Programa        : fblTieneGamaItem 
        Descripcion     : Valida si el item tiene gama
        Autor           : 
        Fecha           : 28/06/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     28/06/2024          OSF-2793: Creación
    ***************************************************************************/
    FUNCTION fblTieneGamaItem
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblTieneGamaItem';

        blExiste            BOOLEAN := FALSE;
        nuContar            NUMBER;

        CURSOR cuObtieneGama
        IS
        SELECT  COUNT (*)
        FROM    ge_items_gama_item gi
        WHERE   gi.items_id = inuItem;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneGama%ISOPEN) THEN
            CLOSE cuObtieneGama;
        END IF;

        OPEN cuObtieneGama;
        FETCH cuObtieneGama INTO nuContar;
        CLOSE cuObtieneGama;

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
    END fblTieneGamaItem;
END pkg_bcgamaitems;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcgamaitems
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCGAMAITEMS', 'ADM_PERSON');
END;
/