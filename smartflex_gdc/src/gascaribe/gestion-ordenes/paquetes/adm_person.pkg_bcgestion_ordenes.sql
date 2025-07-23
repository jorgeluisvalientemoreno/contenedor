CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCGESTION_ORDENES AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 04-12-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  SUBTYPE tytbActividades IS OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;


  FUNCTION fsbVersion RETURN VARCHAR2;
  


 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtActivPorOrden
    Descripcion     : procesa la informacion para PB CERTLAB

    Autor           : Jhon Jairo Soto
    Fecha           : 04-12-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

PROCEDURE prcObtActivPorOrden (inuOrden			IN or_order.order_id%TYPE,
							   otbActividades 	OUT tytbActividades
							  );

 
  END PKG_BCGESTION_ORDENES;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCGESTION_ORDENES IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3805';
  

  
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 04-12-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  
PROCEDURE prcObtActivPorOrden (inuOrden			IN or_order.order_id%TYPE,
							   otbActividades 	OUT tytbActividades
							  )
IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtActivPorOrden
    Descripcion     : Obtener actividades de la orden

    Autor           : Jhon Jairo Soto
    Fecha           : 04-12-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/


	onuErrorCode    	NUMBER;
	osbErrorMessage 	VARCHAR2(4000);
	csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcObtActivPorOrden';
	

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	or_bcorderactivities.getactivitiesbyorder(inuOrden,otbActividades);

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
END prcObtActivPorOrden;

END PKG_BCGESTION_ORDENES;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion PKG_BCGESTION_ORDENES
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCGESTION_ORDENES', 'ADM_PERSON'); 
END;
/