CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcinfopredio IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcinfopredio
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   05-07-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre información
                    del predio

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     05-07-2024      OSF-2752    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;


    FUNCTION fblPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN BOOLEAN;

    FUNCTION fnuObtieneInfoPredio
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN NUMBER;

    FUNCTION fnuObtienePredio
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN NUMBER;

END pkg_bcInfoPredio;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcInfoPredio IS

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
        Programa        : fblPredioCastigado 
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
    FUNCTION fblPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblPredioCastigado';

        blCastigado         BOOLEAN := FALSE;
        sbCastigado         VARCHAR2(1) := 'N';

        CURSOR cuObtieneInfoPredio
        (
            inudireccion     IN  ab_address.address_id%TYPE
        )
        IS
        SELECT  c.predio_castigado 
        FROM    ab_address  a,
                ab_premise  b,
                ldc_info_predio c
        WHERE   b.premise_id = a.estate_number 
        AND     c.premise_id = b.premise_id
        AND     a.address_id = inudireccion;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneInfoPredio%ISOPEN) THEN
            CLOSE cuObtieneInfoPredio;
        END IF;

        OPEN cuObtieneInfoPredio(inudireccion);
        FETCH cuObtieneInfoPredio INTO sbCastigado;
        CLOSE cuObtieneInfoPredio;

        IF (NVL(sbCastigado,'N') = 'S') THEN
            blCastigado := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blCastigado;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN blCastigado;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN blCastigado;  
    END fblPredioCastigado;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtieneInfoPredio 
        Descripcion     : Obtiene el código de la información del predio
        Autor           : 
        Fecha           : 05/07/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/07/2024          OSF-2752: Creación
    ***************************************************************************/
    FUNCTION fnuObtieneInfoPredio
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN NUMBER
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fnuObtieneInfoPredio';

        nuInfoPredio         ldc_info_predio.ldc_info_predio_id%TYPE;

        CURSOR cuObtieneInfoPredio
        (
            inudireccion     IN  ab_address.address_id%TYPE
        )
        IS
        SELECT  c.ldc_info_predio_id 
        FROM    ab_address  a,
                ab_premise  b,
                ldc_info_predio c
        WHERE   b.premise_id = a.estate_number 
        AND     c.premise_id = b.premise_id
        AND     a.address_id = inudireccion;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneInfoPredio%ISOPEN) THEN
            CLOSE cuObtieneInfoPredio;
        END IF;

        OPEN cuObtieneInfoPredio(inudireccion);
        FETCH cuObtieneInfoPredio INTO nuInfoPredio;
        CLOSE cuObtieneInfoPredio;

        pkg_traza.trace('nuInfoPredio: ' || nuInfoPredio, pkg_traza.cnuNivelTrzDef);    

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuInfoPredio;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuInfoPredio;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuInfoPredio;  
    END fnuObtieneInfoPredio;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtienePredio 
        Descripcion     : Obtiene el código del predio
        Autor           : 
        Fecha           : 18/12/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     18/12/2024          OSF-3743: Creación
    ***************************************************************************/
    FUNCTION fnuObtienePredio
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    RETURN NUMBER
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fnuObtienePredio';

        nuPredio         ldc_info_predio.ldc_info_predio_id%TYPE;

        CURSOR cuObtienePredio
        (
            inudireccion     IN  ab_address.address_id%TYPE
        )
        IS
        SELECT  b.premise_id
        FROM    ab_address  a,
                ab_premise  b,
                ldc_info_predio c
        WHERE   b.premise_id = a.estate_number 
        AND     c.premise_id = b.premise_id
        AND     a.address_id = inudireccion;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtienePredio%ISOPEN) THEN
            CLOSE cuObtienePredio;
        END IF;

        OPEN cuObtienePredio(inudireccion);
        FETCH cuObtienePredio INTO nuPredio;
        CLOSE cuObtienePredio;

        pkg_traza.trace('nuInfoPredio: ' || nuPredio, pkg_traza.cnuNivelTrzDef);    

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuPredio;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuPredio;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuPredio;  
    END fnuObtienePredio;
END pkg_bcinfopredio;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcinfopredio
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCINFOPREDIO', 'PERSONALIZACIONES');
END;
/