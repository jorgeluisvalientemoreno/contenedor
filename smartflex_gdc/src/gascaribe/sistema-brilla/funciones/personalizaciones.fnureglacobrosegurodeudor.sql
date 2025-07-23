CREATE OR REPLACE FUNCTION personalizaciones.fnuReglaCobroSeguroDeudor(inuProducto number,
                                                                       inuPorcTasa number)

 RETURN NUMBER IS

  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnuReglaCobroSeguroDeudor
  Descripcion    : Metodo para obtener valor a cobrar del seguro deudor
  Autor          : Jorge Valiente
  Fecha          : 03-12-2024
  Caso           : OSF-3667
  
  Parametros           Descripcion
  ============         ===================
  Entrada
  inuProducto          Codigo de producto
  inuPorcTasa          Codigo de Porcentaje de Tasa
  
  Salida
  nuValor              Valor de cobro deudor
  
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/

  csbMetodo CONSTANT VARCHAR2(100) := 'fnuReglaCobroSeguroDeudor'; --nombre del metodo

  nuValor NUMBER := 0;

  nuPorc                NUMBER;
  nuPRORECACT           NUMBER;
  nuValorCarterasinRecl NUMBER;
  nuValorDeudaTotal     NUMBER;

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  pkg_traza.trace('Producto: ' || inuProducto, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Tasa: ' || inuPorcTasa, pkg_traza.cnuNivelTrzDef);

  nuPorc                := inuPorcTasa;
  nuPRORECACT           := pkg_bcfinanciacion.fnuObtSaldoPendDifeSinReclamo(inuProducto);
  nuValorCarterasinRecl := pkg_bcfacturacion.fnuObtSaldoPendSinReclamos(inuProducto);
  nuValorDeudaTotal     := nuPRORECACT + nuValorCarterasinRecl;
  IF (nuValorDeudaTotal > 0) THEN
    nuValor := nuValorDeudaTotal * (nuPorc / 100);
  END IF;  

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  RETURN nuValor;

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
END;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('FNUREGLACOBROSEGURODEUDOR',
                                   'PERSONALIZACIONES');
END;
/
