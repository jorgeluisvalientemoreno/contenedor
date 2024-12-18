CREATE OR REPLACE PACKAGE  adm_person.pkg_bcparametros_open IS

    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    FUNCTION fsbGetValorCadena
    (
        isbNombreParametro     IN    ge_parameter.parameter_id%TYPE 
    ) 
    RETURN VARCHAR2;

END pkg_bcparametros_open;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcparametros_open IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-1909';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
     
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado 
        Autor           : Luis Felipe Valencia
        Fecha           : 02-02-2024

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida         
        Modificaciones  :
        =========================================================
        Autor             Fecha         Caso        Descripción
        felipe.valencia   02-02-2024    OSF-1909    Creación
    ***************************************************************************/
    FUNCTION fsbGetValorCadena
    (
        isbNombreParametro     IN    ge_parameter.parameter_id%TYPE 
    ) 
    RETURN VARCHAR2 IS

        sbValor   ge_parameter.value%TYPE;
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fsbGetValorCadena';

        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        CURSOR cuGetValorParametro IS
        SELECT  value
        FROM ge_parameter
        WHERE parameter_id  = isbNombreParametro;
   
    BEGIN
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      IF cuGetValorParametro%ISOPEN THEN
        CLOSE cuGetValorParametro;
      END IF;
      
      OPEN cuGetValorParametro;
      FETCH cuGetValorParametro INTO sbValor;
      CLOSE cuGetValorParametro;

      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      
      RETURN sbValor;

    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RETURN sbValor;
    --Validación de error no controlado
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RETURN sbValor;
    END fsbGetValorCadena;

END pkg_bcparametros_open;
/
PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcordenes_industriales
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bcparametros_open'), 'ADM_PERSON');
END;
/