CREATE OR REPLACE PROCEDURE personalizaciones.prcactualizacategoriacambiouso IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcactualizacategoriacambiouso
    Descripcion     : servicio para actualizar categoria en tramite de cambio de uso.
    Autor           : Jorge Valiente
    Fecha           : 11-03-2025
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  csbMetodo   VARCHAR2(70) := 'prcactualizacategoriacambiouso';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  nuNivelTrzDef NUMBER := pkg_traza.cnuNivelTrzDef;
  sbINICIO      VARCHAR2(100) := pkg_traza.csbINICIO;
  sbFIN         VARCHAR2(100) := pkg_traza.csbFIN;

  nuOrden  NUMBER;
  nuCausal NUMBER;

BEGIN

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbINICIO);

  nuOrden := pkg_bcordenes.fnuobtenerotinstancialegal; -- Obtenemos la orden que se esta legalizando
  pkg_traza.trace('Orden: ' || nuOrden, nuNivelTrzDef);

  nuCausal := pkg_bcordenes.fnuObtieneCausal(nuOrden);
  pkg_traza.trace('Causal: ' || nuCausal, nuNivelTrzDef);

  oal_actualizacategoria(inuOrden            => nuOrden,
                         inuCausal           => nuCausal,
                         inuPersona          => NULL,
                         idtFechIniEje       => NULL,
                         idtFechaFinEje      => NULL,
                         isbDatosAdic        => NULL,
                         isbActividades      => NULL,
                         isbItemsElementos   => NULL,
                         isbLecturaElementos => NULL,
                         isbComentariosOrden => NULL);

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbFIN);

EXCEPTION

  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, nuNivelTrzDef);
    pkg_traza.trace(csbMetodo, nuNivelTrzDef, pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, nuNivelTrzDef);
    pkg_traza.trace(csbMetodo, nuNivelTrzDef, pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
  
END;
/
BEGIN
  pkg_utilidades.praplicarpermisos(upper('prcactualizacategoriacambiouso'),
                                   'PERSONALIZACIONES');
END;
/
