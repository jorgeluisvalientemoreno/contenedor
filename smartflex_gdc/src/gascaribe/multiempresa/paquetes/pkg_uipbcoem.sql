create or replace package pkg_uipbcoem AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 12-04-2025

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
    Descripcion     : procesa la informacion para PB PBCOEM

    Autor           : Jhon Jairo Soto
    Fecha           : 12-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  PROCEDURE prcReglaIniEmpresa;
  
  PROCEDURE prcReglaIniContratista;

  END pkg_uipbcoem;
  
  /
  
  create or replace PACKAGE BODY pkg_uipbcoem IS

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
    Fecha           : 12/02/2025

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
    Descripcion     : proceso para PB PBCOEM

    Autor           : Jhon Jairo Soto
    Fecha           : 12/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

    sbContratista       VARCHAR2(2000);
	sbSQL				VARCHAR2(2000);
	nuContratista		NUMBER;
    sbEmpresa           VARCHAR2(200);
	sbAsignaEmpresa		VARCHAR2(200);

	onuErrorCode    	NUMBER;
	osbErrorMessage 	VARCHAR2(4000);
    csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcObjeto';



BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --se consultan datos de entrada
    sbContratista       := ge_boinstancecontrol.fsbgetfieldvalue ('OR_OPERATING_UNIT', 'NAME');
	
	sbAsignaEmpresa     := ge_boinstancecontrol.fsbgetfieldvalue ('OR_OPERATING_UNIT', 'PHONE_NUMBER');

	pkg_traza.trace( 'sbContratista: ' || sbContratista);
	pkg_traza.trace( 'sbAsignaEmpresa: ' || sbAsignaEmpresa);
	
	pkg_bopbcoem.prcProcesaPBCOEM(TO_NUMBER(sbContratista),sbAsignaEmpresa);

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
    Descripcion     : Regla para inicializar el campo empresa en el PB PBCOEM

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
nuContratista   NUMBER;
sbContratista   VARCHAR2(200);
sbEmpresa       VARCHAR2(2000);

csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcReglaIniEmpresa';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	sbContratista       := ge_boinstancecontrol.fsbgetfieldvalue ('OR_OPERATING_UNIT', 'NAME');
     
    nuContratista       := to_number(sbContratista);
	 
	sbEmpresa := pkg_contratista.fsbObtEmpresa(nuContratista);
	
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
    Programa        : prcReglaIniContratista
    Descripcion     : Regla para inicializar el campo contratista en el PB PBCOEM

    Autor           : Jhon Jairo Soto
    Fecha           : 12/02/2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
PROCEDURE prcReglaIniContratista IS


nuError			NUMBER;
sbError			VARCHAR2(4000);
nuContratista   NUMBER;
sbContratista   VARCHAR2(200);
sbEmpresa       VARCHAR2(2000);

csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcReglaIniContratista';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	ge_boinstancecontrol.getattributenewvalue ('WORK_INSTANCE',NULL,'GE_CONTRATISTA', 'ID_CONTRATISTA',sbContratista);

	ge_boinstancecontrol.setentityattribute(sbContratista);

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
END prcReglaIniContratista;


END pkg_uipbcoem;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_uipbcoem'), upper('open'));
END;
/