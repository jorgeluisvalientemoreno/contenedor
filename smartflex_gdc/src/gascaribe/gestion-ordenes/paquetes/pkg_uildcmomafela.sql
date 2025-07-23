create or replace package pkg_uildcmomafela AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : procesa la informacion para PB LDCMOMAFELA

    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  END pkg_uildcmomafela;
/
create or replace package body pkg_uildcmomafela is

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3889';
  
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;


  
PROCEDURE prcObjeto IS

    /*******************************************************************************
     Propiedad intelectual de Gases del Caribe.

     Nombre         :  prcObjeto
     Descripcion    :  Forma para validar generacion Interfaz Contable
     Autor          :  Jhon Soto
     Fecha          :  20/02/2025
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/
      nuError                      NUMBER;
	  sbError    		   		   VARCHAR2(2000);
	  csbMT_NAME  				   VARCHAR2(200) := csbSP_NAME || 'prcObjeto';

   BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	NULL;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END prcObjeto;

END pkg_uildcmomafela;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre PKG_UILDCMOMAFELA
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UILDCMOMAFELA', 'OPEN'); 
END;
/
