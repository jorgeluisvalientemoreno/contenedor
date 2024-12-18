create or replace trigger PERSONALIZACIONES.TRGBIFACTURAFE
  before insert on FACTURA
  for each row
declare
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : PERSONALIZACIONES.TRGBIFACTURAFE
    Descripcion    : Trigger encargada de Validar si la hora del sistema es válida para generar facturas.
    Autor          : Dsaltarin
    Fecha          : 29/07/2024

    Parámetros              Descripcion
    ============            ===================
        
    Fecha           Autor               Modificación
    =========       =========           ====================
	29-07-2024      dsaltarin         OSF-3038: Creación
******************************************************************/
  csbSP_NAME          VARCHAR2(70) := 'TRGBIFACTURAFE';
  nuErrorCode         NUMBER; -- se almacena codigo de error
  sbMensError         VARCHAR2(2000); -- se almacena descripcion del error
  nuPermiteFactura   NUMBER;
begin
    pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

    nuPermiteFactura := fnuPermiteFacturar(:new.factsusc);
    pkg_traza.trace('nuPermiteFactura: '||nuPermiteFactura, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    if nuPermiteFactura = 0  then
        pkg_error.setErrorMessage(isbMsgErrr => 'El sistema se encuentra fuera de Horario para Facturar por proceso de Facturación Electrónica.  Intente mañana a partir de las 00:00:00 horas');
    end if;
  
    pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
end TRGBIFACTURAFE;
/