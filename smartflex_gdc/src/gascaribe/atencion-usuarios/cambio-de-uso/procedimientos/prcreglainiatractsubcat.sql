CREATE OR REPLACE PROCEDURE prcReglaIniAtrActSubCat IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReglaIniAtrActSubCat
    Descripcion     : servicio para inicializar Subcategoria de actividad 4000916 - REGISTRO CAMBIO DE USO DEL SERVICIO.
    Autor           : Jorge Valiente
    Fecha           : 26-11-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  csbMetodo   VARCHAR2(70) := 'prcReglaIniAtrActSubCat';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  nuMotivo       NUMBER;
  nuSubcategoria NUMBER;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  nuMotivo := pkg_bogestion_ordenes.fnuObtMotivoActividad;
  pkg_traza.trace('Motivo: ' || nuMotivo, pkg_traza.cnuNivelTrzDef);

  nuSubcategoria := pkg_bocambio_de_uso.fnuObtieneSubCategoria(nuMotivo);
  pkg_traza.trace('Subcategoria: ' || nuSubcategoria,
                  pkg_traza.cnuNivelTrzDef);

  ge_boinstancecontrol.setentityattribute(nuSubcategoria);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
  
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
  
    raise pkg_error.CONTROLLED_ERROR;
END prcReglaIniAtrActSubCat;
/
