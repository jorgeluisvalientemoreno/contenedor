create or replace PACKAGE  adm_person.pkg_ldc_periprog IS
 subtype styPeriodoProgramado  is  ldc_periprog%rowtype;
 FUNCTION fsbVersion RETURN VARCHAR2;
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Modificaciones  :
        Autor       Fecha        Caso       Descripcion
        LJLB        13-12-2024   OSF-3741     Creacion
    ***************************************************************************/
  PROCEDURE prInsertarPeriodoProgramado( iregPeriodoProg IN  styPeriodoProgramado);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarPeriodoProgramado
    Descripcion     : proceso que inserta en la tabla de periodo programado

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2024

    Parametros de Entrada
      iregPeriodoProg        registro de periodo programado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        13-12-2024   OSF-3741     Creacion
  ***************************************************************************/


END pkg_ldc_periprog;
/
create or replace PACKAGE BODY adm_person.pkg_ldc_periprog IS

 csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3540';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-12-2024

    Modificaciones  :
    Autor       Fecha        Caso       Descripcion
    LJLB        09-12-2024   OSF-3741     Creacion
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
   PROCEDURE prInsertarPeriodoProgramado( iregPeriodoProg IN  styPeriodoProgramado) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarPeriodoProgramado
    Descripcion     : proceso que inserta en la tabla de periodo programado

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2024

    Parametros de Entrada
      iregPeriodoProg        registro de periodo programado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        13-12-2024   OSF-3741     Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarPeriodoProgramado';
   BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' iregPeriodoProg.peprpefa => ' || iregPeriodoProg.peprpefa, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.peprcicl => ' || iregPeriodoProg.peprcicl, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.peprprog => ' || iregPeriodoProg.peprprog, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.peprusua => ' || iregPeriodoProg.peprusua, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.peprterm => ' || iregPeriodoProg.peprterm, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.peprfein => ' || iregPeriodoProg.peprfein, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' iregPeriodoProg.proceso => ' || iregPeriodoProg.proceso, pkg_traza.cnuNivelTrzDef);
      INSERT INTO LDC_PERIPROG(peprpefa,    
                                peprcicl,
                                peprprog,
                                peprusua,
                                peprterm,
                                peprfein,
                                proceso
                                )
        VALUES
        (
            iregPeriodoProg.peprpefa,    
            iregPeriodoProg.peprcicl,
            iregPeriodoProg.peprprog,
            iregPeriodoProg.peprusua,
            iregPeriodoProg.peprterm,
            iregPeriodoProg.peprfein,
            iregPeriodoProg.proceso
         );
       
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
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
  END prInsertarPeriodoProgramado;

END pkg_ldc_periprog;
/
PROMPT Otorgando permisos de ejecucion a pkg_ldc_periprog
BEGIN
    pkg_utilidades.praplicarpermisos('PKG_LDC_PERIPROG', 'ADM_PERSON');
END;
/