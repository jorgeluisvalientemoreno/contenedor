create or replace PACKAGE PKG_UILDICU AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 26-11-2024

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
    Descripcion     : procesa la informacion para PB RCST

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  END PKG_UILDICU;
/

CREATE OR REPLACE PACKAGE BODY PKG_UILDICU IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3636';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

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
    Descripcion     : procesa la informacion para PB LDICU

    Autor           : Jhon Jairo Soto
    Fecha           : 26-11-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

	Cnunull_Attribute CONSTANT number := 2126;

    sbCupoNume ge_boInstanceControl.stysbValue;
	onuErrorCode    NUMBER;
	osbErrorMessage VARCHAR2(4000);
    csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'prcObjeto';


BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


    --  Obtiene la solicitud instanciada

    sbCupoNume := ge_boInstanceControl.fsbGetFieldValue ('CUPON', 'CUPONUME');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
    if (sbCupoNume is null) then
        pkg_Error.SetErrorMessage(Cnunull_Attribute, 'Numero de Cupon');
    end if;

	pkg_boldicu.prcProcesaLDICU(TO_NUMBER(sbCupoNume));

    ------------------------------------------------
    -- user code
    ------------------------------------------------

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

END PKG_UILDICU;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion PKG_UILDICU
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UILDICU', 'OPEN'); 
END;
/