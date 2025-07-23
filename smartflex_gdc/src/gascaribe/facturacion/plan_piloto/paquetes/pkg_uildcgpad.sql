create or replace PACKAGE pkg_uildcgpad IS
  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  PROCEDURE prcObjeto(inuCiclo  IN  NUMBER);
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGPAD

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
       inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/ 
 PROCEDURE prcValidaProceso;
  /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcValidaProceso
	Descripcion     : proceso para colocar en proceso de validacion

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
       inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/ 

END pkg_uildcgpad;
/
create or replace PACKAGE BODY pkg_uildcgpad IS
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3650';
  csbPrograma         CONSTANT VARCHAR2(15) := 'LDCGPAD';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
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
  PROCEDURE prcObjeto(inuCiclo  IN  NUMBER) IS
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGPAD

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
      inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/ 
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObjeto';
 BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuCiclo => ' || inuCiclo, pkg_traza.cnuNivelTrzDef);
    pkg_boldcgpad.prcObjeto(inuCiclo);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);    
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' osbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
 END prcObjeto;
 PROCEDURE prcValidaProceso IS
  /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcValidaProceso
	Descripcion     : proceso para colocar en proceso de validacion de la forma LDCGPAD

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
       inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/ 
     csbMT_NAME     VARCHAR2(100) := csbSP_NAME || '.prcNoValida';
     sbCiclo        VARCHAR2(10);
     rcPeriodo      perifact%ROWTYPE;
 BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    sbCiclo := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACICL');
    pkg_traza.trace(' sbCiclo => ' || sbCiclo, pkg_traza.cnuNivelTrzDef);
    rcPeriodo := pkg_bogestionperiodos.frcObtPeriodoFacturacionActual(TO_NUMBER(sbCiclo));
    pkg_traza.trace(' rcPeriodo.pefacodi => ' || rcPeriodo.pefacodi, pkg_traza.cnuNivelTrzDef);
    pkg_BOGestionEjecucionProcesos.prcValidaEjecuProceso ( rcPeriodo.pefacodi,
                                                           csbPrograma);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);    
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' osbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
 END prcValidaProceso;
END pkg_uildcgpad;
/
BEGIN
    pkg_Utilidades.prAplicarPermisos('PKG_UILDCGPAD', 'OPEN');
END;
/