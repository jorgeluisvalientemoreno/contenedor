create or replace PACKAGE PKG_UIRCST AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

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
  
  END PKG_UIRCST;
/

CREATE OR REPLACE PACKAGE BODY PKG_UIRCST IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3604';

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
    Descripcion     : procesa la informacion para PB RCST

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

Cnunull_Attribute constant number := 2126;

sbTipoInfo_Id 	ge_boinstancecontrol.stysbvalue;
sbFechaReg 		ge_boinstancecontrol.stysbvalue;
sbObservacion 	ge_boinstancecontrol.stysbvalue;
csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'prcObjeto';
ONUERRORCODE    NUMBER;
OSBERRORMESSAGE VARCHAR2(4000);

begin

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


    sbTipoInfo_Id := ge_boInstanceControl.fsbGetFieldValue ('LDC_ACTCALLCENTER', 'TIPOINFO_ID');
    sbFechaReg := ge_boInstanceControl.fsbGetFieldValue ('LDC_ACTCALLCENTER', 'FECHAREG');
    sbObservacion := ge_boInstanceControl.fsbGetFieldValue ('LDC_ACTCALLCENTER', 'OBSERVACION');

    ------------------------------------------------
    -- required attributes
    ------------------------------------------------

    if (sbTipoInfo_Id is null) then
        pkg_Error.SetErrorMessage(Cnunull_Attribute, 'tipo de información ');
    end if;

    if (sbFechaReg is null) then
        pkg_Error.SetErrorMessage(Cnunull_Attribute, 'fecha de registro');
    end if;


    ------------------------------------------------
    -- user code
    ------------------------------------------------
	
	pkg_borcst.prcProcesaRCST(sbTipoInfo_Id,sbFechaReg, sbObservacion);

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

END PKG_UIRCST;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion PKG_UIRCST
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UIRCST', 'OPEN'); 
END;
/