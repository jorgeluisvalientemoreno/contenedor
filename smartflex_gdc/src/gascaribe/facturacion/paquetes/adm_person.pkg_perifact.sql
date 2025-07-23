create or replace PACKAGE adm_person.pkg_perifact IS
  CURSOR cuObtRegistro (inuPeriodo IN perifact.pefacodi%type) IS
  SELECT perifact.*, perifact.rowid
  FROM perifact
  WHERE perifact.pefacodi = inuPeriodo;

  SUBTYPE sbtPeriodofact IS perifact%ROWTYPE;
  SUBTYPE sbtRegPeriodofact IS cuObtRegistro%ROWTYPE;

  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  
  FUNCTION frcObtInfoPeriodo (inuPerifact IN perifact.pefacodi%type) RETURN sbtRegPeriodofact;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoPeriodo
    Descripcion     : Retona informacion de periodo de facturacion
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Parametros Entrada
     inuperifact  codigo del perifact
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  FUNCTION fblExisteperifact (inuperifact IN perifact.pefacodi%type) RETURN BOOLEAN;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExisteperifact
    Descripcion     :  valida si existe periodo de facturacion
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Parametros Entrada
     inuperifact  codigo del periodo de facturacion
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  
  FUNCTION fnuObtCicloDelPeriodo(inuPeriodo IN perifact.pefacodi%TYPE) RETURN NUMBER;
	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtCiloDelPeriodo
	Descripcion     : Retona el identificador del ciclo del periodo de facturacion
	Autor           : Jsoto
	Fecha           : 21-04-2025

	Modificaciones  :
	Autor       Fecha       Caso       Descripcion
	jsoto      21-04-2025   OSF-4279    Creacion
  ***************************************************************************/

END pkg_perifact;
/
create or replace PACKAGE BODY  adm_person.pkg_perifact IS
  -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(22) := 'OSF-4279';

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
        Fecha           : 22-01-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-01-2025   OSF-3855    Creacion
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

  PROCEDURE prCierracuObtRegistro IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCierracuObtRegistro
    Descripcion     : proceso que cierra cursor cuObtRegistro
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertarMoviDife';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     IF cuObtRegistro%ISOPEN THEN CLOSE cuObtRegistro; END IF;
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
  END prCierracuObtRegistro;
  FUNCTION frcObtInfoPeriodo (inuPerifact IN perifact.pefacodi%type) RETURN sbtRegPeriodofact IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoPeriodo
    Descripcion     : Retona informacion de periodo de facturacion
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Parametros Entrada
     inuperifact  codigo del perifact
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcObtInfoPeriodo';
    rcPeriodo       sbtRegPeriodofact;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuPerifact => ' || inuPerifact, pkg_traza.cnuNivelTrzDef);
    prCierracuObtRegistro;
    OPEN cuObtRegistro(inuPerifact);
    FETCH cuObtRegistro INTO rcPeriodo;
    CLOSE cuObtRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rcPeriodo;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END frcObtInfoPeriodo;
  FUNCTION fblExisteperifact (inuperifact IN perifact.pefacodi%type) RETURN BOOLEAN IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExisteperifact
    Descripcion     :  valida si existe periodo de facturacion
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2025

    Parametros Entrada
     inuperifact  codigo del periodo de facturacion
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       22-01-2025   OSF-3855    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fblExisteperifact';
    blExistePeriodo    BOOLEAN := TRUE;
    rcPeriodo      sbtRegPeriodofact;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuperifact => ' || inuperifact, pkg_traza.cnuNivelTrzDef);
    prCierracuObtRegistro;
    OPEN cuObtRegistro(inuperifact);
    FETCH cuObtRegistro INTO rcPeriodo;
    IF cuObtRegistro%NOTFOUND THEN
       blExistePeriodo := FALSE;
    END IF;
    CLOSE cuObtRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN blExistePeriodo;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END fblExisteperifact;
  
  FUNCTION fnuObtCicloDelPeriodo(inuPeriodo IN perifact.pefacodi%TYPE) RETURN NUMBER IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuObtCicloDelPeriodo
        Descripcion     : Retona el identificador del ciclo del periodo de facturacion
        Autor           : Jsoto
        Fecha           : 21-04-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        jsoto      21-04-2025   OSF-4279    Creacion
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtCicloDelPeriodo';
	  
	  CURSOR cuCiclo IS
	  SELECT pefacicl 
	  FROM perifact
	  WHERE pefacodi = inuPeriodo;
	  
	  nuCiclo NUMBER;
	  
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
		OPEN cuCiclo;
		FETCH cuCiclo INTO nuCiclo;
		CLOSE cuCiclo;
		
		pkg_traza.trace('nuCiclo => ' || nuCiclo, pkg_traza.cnuNivelTrzDef);
		
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuCiclo;
		
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuCiclo;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuCiclo;
  END fnuObtCicloDelPeriodo;


END pkg_perifact;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_PERIFACT', 'ADM_PERSON'); 
END;
/
