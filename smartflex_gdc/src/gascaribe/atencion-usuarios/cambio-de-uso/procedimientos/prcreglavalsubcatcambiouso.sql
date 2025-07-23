CREATE OR REPLACE PROCEDURE prcReglaValSubCatCambioUso IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : oal_actualizacategoria
    Descripcion     : servicio para validar la subcategoria legalizada.
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 26-06-2025
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  csbMetodo CONSTANT VARCHAR2(100) := 'prcReglaValSubCatCambioUso';
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(4000);
  cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  sbAttribute VARCHAR2(4000);
  sbValue     VARCHAR2(4000);
  nuMotive_id NUMBER;
  nuCateg     NUMBER;
  nuSubcateg  NUMBER;

  nuSubcategAtributo NUMBER;

  nuSolicitud           NUMBER;
  onuCategoriaActual    NUMBER;
  onuCategriaNueva      NUMBER;
  nuSubcategoriaInicial NUMBER;

  --Obtener codigo de la categoria residencial de parametro
  nuCATEGORIA_RESIDENCIAL NUMBER := pkg_parametros.fnuGetValorNumerico('CATEGORIA_RESIDENCIAL');

BEGIN

  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

  --Inicio Logica previa de la regla 121057740
  GE_BOINSTANCE.GETINSTANCE(sbAttribute, sbValue);

  pkg_traza.trace('Atributo: ' || sbAttribute, cnuNVLTRC);
  pkg_traza.trace('Valor: ' || sbValue, cnuNVLTRC);

  nuMotive_id := OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE;
  pkg_traza.trace('Motivo: ' || nuMotive_id, cnuNVLTRC);

  nuCateg := MO_BODATA.FNUGETVALUE('MO_MOTIVE', 'CATEGORY_ID', nuMotive_id);
  pkg_traza.trace('Categoria: ' || nuCateg, cnuNVLTRC);

  IF (nuCateg != 1) THEN
    nuSubcateg := MO_BODATA.FNUGETVALUE('MO_MOTIVE',
                                        'SUBCATEGORY_ID',
                                        nuMotive_id);
    pkg_traza.trace('SubCategoria: ' || nuSubcateg, cnuNVLTRC);
  ELSE
    nuSubcategAtributo := UT_CONVERT.FNUCHARTONUMBER(sbValue);
    IF (nuSubcategAtributo != nuSubcateg) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No se permite cambiar la Subcategoría, si la Categoría es diferente a Residencial');
    END IF;
  END IF;
  --Fin Logica previa de la regla 121057740

  --Inicio OSF-3541
  --Obtener Nueva Categoria de la solicitud
  nuSolicitud := pkg_bcsolicitudes.fnuGetSolicitudDelMotivo(nuMotive_id);
  pkg_traza.trace('Solicitud: ' || nuSolicitud, cnuNVLTRC);

  pkg_boGestionSolicitudes.prcObtCategoriasPorSolicitud(nuSolicitud,
                                                        onuCategoriaActual,
                                                        onuCategriaNueva);
  pkg_traza.trace('Categoria Actual: ' || onuCategoriaActual, cnuNVLTRC);
  pkg_traza.trace('Nueva Categoria: ' || onuCategriaNueva, cnuNVLTRC);

  pkg_traza.trace('Parametro Categoria Residencial: ' ||
                  nuCATEGORIA_RESIDENCIAL,
                  cnuNVLTRC);

  --Valida categoria seleccionada en el tramite de cambio de uso con la categoria residencial parametrizada. 
  IF onuCategriaNueva = nuCATEGORIA_RESIDENCIAL THEN
  
    --Obtiene Subcategoria definida en el morivo del tramite de cambio. 
    nuSubcategoriaInicial := pkg_bocambio_de_uso.fnuObtieneSubCategoria(nuMotive_id);
    pkg_traza.trace('Subcategoria Incializada: ' || nuSubcategoriaInicial,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Subcategoria Seleccionada: ' || nuSubcategAtributo,
                    pkg_traza.cnuNivelTrzDef);
  
    IF nuSubcategoriaInicial <> nuSubcategAtributo THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No se debe cambiar la subcategoría inicializada en la orden del tramite de cambio de uso. Usuario residencial');
    END IF; --IF nuSubcategoriaInicial <> nuSubcategAtributo THEN
  
  END IF;
  --Fin OSF-3541

  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
END;
/
