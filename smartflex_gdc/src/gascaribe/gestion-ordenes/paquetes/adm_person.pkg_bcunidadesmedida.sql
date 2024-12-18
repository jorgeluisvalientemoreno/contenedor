CREATE OR REPLACE PACKAGE adm_person.pkg_bcunidadesmedida IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcunidadesmedida
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   27-06-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					tablas OPEN.GE_MEASURE_UNIT

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    fvalencia   27-06-2024  OSF-2793 Creación
*******************************************************************************/

    CURSOR cuRecord(isbAbreviacion IN ge_measure_unit.abbreviation%TYPE) IS
    SELECT  ge_measure_unit.*, ge_measure_unit.rowid
    FROM    ge_measure_unit
    WHERE   abbreviation = isbAbreviacion;

    SUBTYPE styUnidadMedida  IS cuRecord%ROWTYPE;

    TYPE tytbUnidadMedida IS TABLE OF styUnidadMedida INDEX BY BINARY_INTEGER;

    FUNCTION fsbVersion RETURN VARCHAR2;

    FUNCTION frcObtieneRegistro(isbAbreviacion IN ge_measure_unit.abbreviation%TYPE)
    RETURN styUnidadMedida;

END pkg_bcunidadesmedida;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcunidadesmedida IS

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
    Programa        : frcObtieneRegistro 
    Descripcion     : retorna el registro de la unidad de medida
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 28-06-2024
    Caso            : OSF-2793
      
    Parametros de entrada
    inuAbreviacion  Abreviación de unidad a consultar en la tabla ge_measure_unit
      
    Parametros de salida
    styUnidadMedida   Registro de la unidad de medida
      
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   28-06-2024  OSF-2793    Creación
    ***************************************************************************/
    FUNCTION frcObtieneRegistro(isbAbreviacion IN ge_measure_unit.abbreviation%TYPE)
    RETURN styUnidadMedida IS
    
      csbMetodo VARCHAR2(70) := csbSP_NAME || 'frcObtieneRegistro';
    
      rcDatos      styUnidadMedida;
      nuError  NUMBER;
      sbError VARCHAR2(2000);
    
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        pkg_traza.trace('isbAbreviacion: ' || isbAbreviacion, pkg_traza.cnuNivelTrzDef);

        IF cuRecord%ISOPEN THEN
            CLOSE cuRecord;
        END IF;

        OPEN cuRecord(isbAbreviacion);
        FETCH cuRecord INTO rcDatos;
        CLOSE cuRecord;

        pkg_traza.trace('rcDatos.measure_unit_id: '||rcDatos.measure_unit_id, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

        RETURN rcDatos;    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN rcDatos;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
           RETURN rcDatos;
    END frcObtieneRegistro;
END pkg_bcunidadesmedida;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcunidadesmedida
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCUNIDADESMEDIDA', 'ADM_PERSON');
END;
/