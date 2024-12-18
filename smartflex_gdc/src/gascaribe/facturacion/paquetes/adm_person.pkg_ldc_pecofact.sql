CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_pecofact IS
  FUNCTION fsbVersion RETURN VARCHAR2;
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prActualizaObse ( inuPeriodo     IN ldc_pecofact.pcfapefa%TYPE,
                              isbObservacion IN ldc_pecofact.pcfaobse%TYPE);
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaObse
        Descripcion     : Actualiza observacion de tabla de periodo fidf

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 27-06-2024

        Parametros de Entrada
          inuPeriodo      codigo del periodo
          isbObservacion  observacion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       27-06-2024   OSF-2913    Creacion
    ***************************************************************************/
END pkg_ldc_pecofact;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_pecofact IS
    -- Para el control de traza:
   csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
   csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2913';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prActualizaObse ( inuPeriodo     IN ldc_pecofact.pcfapefa%TYPE,
                              isbObservacion IN ldc_pecofact.pcfaobse%TYPE) IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaObse
        Descripcion     : Actualiza observacion de tabla de periodo fidf

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 27-06-2024

        Parametros de Entrada
          inuPeriodo      codigo del periodo
          isbObservacion  observacion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       27-06-2024   OSF-2913    Creacion
    ***************************************************************************/
     csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  '.prActualizaObse';
     nuError   NUMBER;
     sbError   VARCHAR2(4000);
  BEGIN
     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    UPDATE ldc_pecofact SET pcfaobse = isbObservacion WHERE pcfapefa = inuPeriodo;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
        pkg_Error.getError( nuError, sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef); 
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError( nuError, sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);    
        RAISE pkg_Error.Controlled_Error;
  END prActualizaObse;
END pkg_ldc_pecofact;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LDC_PECOFACT','ADM_PERSON');
END;
/