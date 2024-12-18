CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcconfiguoespeciales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcconfiguoespeciales
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   16-09-2024
    Descripcion :   Paquete con los metodos para manejo de información de  
                    Configuración de unidad operativa para usuarios especiales
                    

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Felipe.valencia         16-09-2024   OSF-2758   Creación
*******************************************************************************/
    -- Retorna la causal de la orden
	FUNCTION fsbVersion 
	RETURN VARCHAR2;

    FUNCTION fnuObtineUnidadOperativa
    ( 
        inuCiclo        IN  ciclo.ciclcodi%TYPE,
        inuSector       IN  NUMBER
    ) 
    RETURN or_operating_unit.operating_unit_id%TYPE;

    FUNCTION fnuObtineUnidadOperativaCiclo
    ( 
        inuCiclo        IN  ciclo.ciclcodi%TYPE
    ) 
    RETURN or_operating_unit.operating_unit_id%TYPE;    

END pkg_bcconfiguoespeciales;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcconfiguoespeciales IS

	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2758';

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 16-09-2024

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Felipe.valencia         16-09-2024   OSF-2758   Creación
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtineUnidadOperativa
        Descripcion     : funcion que obtiene la unidad operativa de 
                          acuerdo al sector operativo y el ciclo
        Fecha           : 16-09-2024
        Parametros de Entrada
            inuCiclo             Ciclo
            inuSector            Sector operativo   
        Parametros de Salida
            Unidad Operativa
        Modificaciones  :
        =========================================================
        Autor               Fecha           Caso        Descripción
        felipe.valencia     16/09/2024      OSF-2758    Creación
    ***************************************************************************/
    FUNCTION fnuObtineUnidadOperativa
    ( 
        inuCiclo        IN  ciclo.ciclcodi%TYPE,
        inuSector       IN  NUMBER
    ) 
    RETURN or_operating_unit.operating_unit_id%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuObtineUnidadOperativa:';   

        nuUnidadOperativa   or_operating_unit.operating_unit_id%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        CURSOR cuObtieneUnidadOperativa
        IS
        SELECT  unidad_operativa
        FROM    conf_uo_usu_especiales
        WHERE   ciclo = inuCiclo
        AND     sector_operativo = inuSector;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF (cuObtieneUnidadOperativa%ISOPEN) THEN
            CLOSE cuObtieneUnidadOperativa;
        END IF;

        OPEN cuObtieneUnidadOperativa;
        FETCH cuObtieneUnidadOperativa INTO nuUnidadOperativa; 
        CLOSE cuObtieneUnidadOperativa;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuUnidadOperativa;
    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RETURN nuUnidadOperativa;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RETURN nuUnidadOperativa;  
    END fnuObtineUnidadOperativa;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtineUnidadOperativa
        Descripcion     : funcion que obtiene la primera unidad operativa de 
                          acuerdo con el ciclo
        Fecha           : 16-09-2024
        Parametros de Entrada
            inuCiclo             Ciclo
            inuSector            Sector operativo   
        Parametros de Salida
            Unidad Operativa
        Modificaciones  :
        =========================================================
        Autor               Fecha           Caso        Descripción
        felipe.valencia     16/09/2024      OSF-2758    Creación
    ***************************************************************************/
    FUNCTION fnuObtineUnidadOperativaCiclo
    ( 
        inuCiclo        IN  ciclo.ciclcodi%TYPE
    ) 
    RETURN or_operating_unit.operating_unit_id%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuObtineUnidadOperativaCiclo:';   

        nuUnidadOperativa   or_operating_unit.operating_unit_id%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        CURSOR cuObtieneUnidadOperativa
        IS
        SELECT  unidad_operativa
        FROM    conf_uo_usu_especiales
        WHERE   ciclo = inuCiclo;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF (cuObtieneUnidadOperativa%ISOPEN) THEN
            CLOSE cuObtieneUnidadOperativa;
        END IF;

        OPEN cuObtieneUnidadOperativa;
        FETCH cuObtieneUnidadOperativa INTO nuUnidadOperativa; 
        CLOSE cuObtieneUnidadOperativa;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuUnidadOperativa;
    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RETURN nuUnidadOperativa;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RETURN nuUnidadOperativa;  
    END fnuObtineUnidadOperativaCiclo;    
END pkg_bcconfiguoespeciales;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcconfiguoespeciales
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bcconfiguoespeciales'), 'PERSONALIZACIONES');
END;
/