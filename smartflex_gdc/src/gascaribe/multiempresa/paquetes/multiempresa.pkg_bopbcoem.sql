create or replace package multiempresa.pkg_bopbcoem AS

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
    Programa        : fsbEmpresaActual
    Descripcion     : Obtiene el dato de empresa para PB PBCOEM

    Autor           : Jhon Jairo Soto
    Fecha           : 12-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/


	PROCEDURE prcProcesaPBCOEM(
								inuContratista   contratista.contratista%TYPE,
								isbAsignaEmpresa contratista.empresa%TYPE
							  );
						  

  END pkg_bopbcoem;
  
  /
  
  create or replace PACKAGE BODY multiempresa.pkg_bopbcoem IS

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


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcProcesaPBCOEM
    Descripcion     : Contiene la lógica de negocio de PBCOEM
    Autor           : Jhon Jairo Soto
    Fecha           : 12/02/2025
	
	Parametros de Entrada
	inuContratista   Contratista
	isbEmpresa		 Empresa
	
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

PROCEDURE prcProcesaPBCOEM(
							inuContratista   contratista.contratista%TYPE,
							isbAsignaEmpresa contratista.empresa%TYPE
						  )
IS

	nuError				NUMBER;
	sbError				VARCHAR2(4000);

	csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcProcesaPBCOEM';

	sbEmpresa       	VARCHAR2(2000);

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	sbEmpresa := pkg_contratista.fsbObtEmpresa(inuContratista);
	
	IF sbEmpresa IS NOT NULL THEN
		       pkg_error.setErrorMessage(isbMsgErrr => 'El contratista '||inuContratista ||' esta actualmente configurado para la empresa '
														|| sbEmpresa || ',  No se puede actualizar ');
	END IF;

	IF isbAsignaEmpresa IS NOT NULL THEN
	
		IF pkg_contratista.fblexiste(inuContratista) THEN
		
			pkg_contratista.prAcEmpresa(inuContratista,isbAsignaEmpresa);
		ELSE
			pkg_contratista.prInsertaRegisto(inuContratista,isbAsignaEmpresa);
		END IF;
	
	END IF;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.controlled_error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.controlled_error;
END prcProcesaPBCOEM;

END pkg_bopbcoem;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bopbcoem'), upper('multiempresa'));
END;
/