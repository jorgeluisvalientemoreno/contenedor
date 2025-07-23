CREATE OR REPLACE FUNCTION fnureglaliqsegurodeudorII

 RETURN NUMBER IS

  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnureglaliqsegurodeudorII
  Descripcion    : Metodo para obtener valor a cobrar del serguro deudor
  Autor          : Jorge Valiente
  Fecha          : 03-12-2024
  Caso           : OSF-3667
  
  Parametros           Descripcion
  ============         ===================
  Salida
    nuValor              Valor de cobro deudor

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/

  csbMetodo CONSTANT VARCHAR2(100) := 'fnureglaliqsegurodeudorII'; --nombre del metodo

  nuINSURANCE_RATE_II NUMBER := pkg_ld_parameter.fnuObtNUMERIC_VALUE('INSURANCE_RATE_II');
  nuProducto          NUMBER;

  nuValor NUMBER := 0;

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  PKINSTANCEDATAMGR.GETCG_SUBSSERVICE(nuProducto);

  pkg_traza.trace('Producto: ' || nuProducto, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Tasa: ' || nuINSURANCE_RATE_II,
                  pkg_traza.cnuNivelTrzDef);

  nuValor := fnureglacobrosegurodeudor(nuProducto, nuINSURANCE_RATE_II);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  RETURN(nuValor);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbErrorMessage);
    pkg_traza.trace('sberror: ' || sbErrorMessage,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RETURN(nuValor);
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbErrorMessage);
    pkg_traza.trace('sberror: ' || sbErrorMessage,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RETURN(nuValor);
END fnureglaliqsegurodeudorII;
/
