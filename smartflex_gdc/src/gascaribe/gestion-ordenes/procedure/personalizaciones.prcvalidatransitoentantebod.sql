create or replace procedure personalizaciones.prcValidaTransitoEntanteBod is

  csbMetodo   VARCHAR2(70) := 'prcValidaTransitoEntanteBod';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  nuOrden number;

begin

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  nuOrden := pkg_BcOrdenes.FnuObtenerOtInstanciaLegal;

  oal_ValidaTransitoEntranteBod(nuOrden,
                           null,
                           null,
                           null,
                           null,
                           null,
                           null,
                           null,
                           null,
                           null);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION

  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RAISE pkg_Error.Controlled_Error;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;
  
end prcValidaTransitoEntanteBod;
/
begin
  PKG_UTILIDADES.PRAPLICARPERMISOS('PRCVALIDATRANSITOENTANTEBOD',
                                   'PERSONALIZACIONES');
end;
/