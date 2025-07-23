create or replace package pkg_uipbciem AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 19-02-2025

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
    Descripcion     : procesa la informacion para PB PBCIEM

    Autor           : Jhon Jairo Soto
    Fecha           : 19-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  PROCEDURE prcReglaIniEmpresa;
  
  PROCEDURE prcReglaIniCiclofact;

  END pkg_uipbciem;
  
  /
  
  create or replace PACKAGE BODY pkg_uipbciem IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3970';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 19/02/2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;



PROCEDURE prcObjeto IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : proceso para PB PBCIEM

    Autor           : Jhon Jairo Soto
    Fecha           : 19/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

    sbCiclo       		VARCHAR2(2000);
	sbAsignaEmpresa		VARCHAR2(200);

	onuErrorCode    	NUMBER;
	osbErrorMessage 	VARCHAR2(4000);
    csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcObjeto';



BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --se consultan datos de entrada
    sbCiclo       := ge_boinstancecontrol.fsbgetfieldvalue ('PERIFACT', 'PEFACICL');
	
	sbAsignaEmpresa     := ge_boinstancecontrol.fsbgetfieldvalue ('PERIFACT', 'PEFADESC');

	pkg_traza.trace( 'sbCiclo: ' || sbCiclo);
	pkg_traza.trace( 'sbAsignaEmpresa: ' || sbAsignaEmpresa);
	
	pkg_bopbciem.prcProcesaPBCIEM(TO_NUMBER(sbCiclo),sbAsignaEmpresa);

	commit;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END prcObjeto;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReglaIniEmpresa
    Descripcion     : Regla para inicializar el campo empresa en el PB PBCIEM

    Autor           : Jhon Jairo Soto
    Fecha           : 12/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
PROCEDURE prcReglaIniEmpresa IS


nuError			NUMBER;
sbError			VARCHAR2(4000);
nuCiclo   		NUMBER;
sbCiclo  		VARCHAR2(200);
sbEmpresa       VARCHAR2(2000);

csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'prcReglaIniEmpresa';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	sbCiclo       := ge_boinstancecontrol.fsbgetfieldvalue ('PERIFACT', 'PEFACICL');
     
    nuCiclo       := to_number(sbCiclo);
	 
	sbEmpresa := pkg_ciclo_facturacion.fsbObtEmpresa(nuCiclo);
	
	ge_boinstancecontrol.setentityattribute(sbEmpresa);

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
END prcReglaIniEmpresa;


 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReglaIniCiclofact
    Descripcion     : Regla para inicializar el campo ciclo en el PB PBCIEM

    Autor           : Jhon Jairo Soto
    Fecha           : 19/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
PROCEDURE prcReglaIniCiclofact IS


nuError			NUMBER;
sbError			VARCHAR2(4000);
sbCiclo   		VARCHAR2(200);

csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcReglaIniCiclofact';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	ge_boinstancecontrol.getattributenewvalue ('WORK_INSTANCE',NULL,'CICLO', 'CICLCODI',sbCiclo);

	ge_boinstancecontrol.setentityattribute(sbCiclo);

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
END prcReglaIniCiclofact;


END pkg_uipbciem;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_uipbciem'), upper('open'));
END;
/