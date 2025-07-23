CREATE OR REPLACE PACKAGE adm_person.pkg_sistema IS
    SUBTYPE sbtSistema IS sistema%ROWTYPE;
     FUNCTION fsbVersion RETURN VARCHAR2;
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-01-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      15-01-2025   OSF-3855    Creacion
      ***************************************************************************/
     FUNCTION frcObtInfoSistema RETURN sbtSistema;
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtInfoSistema
        Descripcion     : Retona informacion del sistema
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-01-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      15-01-2025   OSF-3855    Creacion
      ***************************************************************************/
END pkg_sistema;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_sistema IS
 -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3855';

    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.'; 
    cnuNVLTRC      CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
    nuError     NUMBER; 
    sbError     VARCHAR2(4000);
    FUNCTION fsbVersion RETURN VARCHAR2 IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-11-2024   OSF-3540    Creacion
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbVersion;
    
    FUNCTION frcObtInfoSistema RETURN sbtSistema IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtInfoSistema
        Descripcion     : Retona informacion del sistema
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-01-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      15-01-2025   OSF-3855    Creacion
     ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcObtInfoSistema';
      rcSistema  sbtSistema;
      CURSOR cuObtInfoSistema IS
      SELECT *
      FROM sistema;
      
      PROCEDURE prCierraCursor IS
        csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.frcObtInfoSistema';
      BEGIN
         pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
         IF cuObtInfoSistema%ISOPEN THEN CLOSE cuObtInfoSistema; END IF;
         pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      END prCierraCursor;
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        prCierraCursor;
        OPEN cuObtInfoSistema;
        FETCH cuObtInfoSistema INTO rcSistema;
        CLOSE cuObtInfoSistema;
        
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN rcSistema;
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursor;
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;    
    END frcObtInfoSistema;
END pkg_sistema;
/
PROMPT Otorgando permisos de ejecucion a PKG_SISTEMA
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_SISTEMA','ADM_PERSON');
END;
/