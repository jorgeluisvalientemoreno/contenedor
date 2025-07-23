CREATE OR REPLACE PROCEDURE adm_person.api_generarfactura( inuSubscripcion IN  SUSCRIPC.SUSCCODI%TYPE,
                                                           inuProducto     IN  SERVSUSC.SESUNUSE%TYPE,
                                                           isbDocuSoporte  IN  CARGOS.CARGDOSO%TYPE,
                                                           onuFactura      OUT FACTURA.FACTCODI%TYPE,
                                                           onuCuentaCobro  OUT CUENCOBR.CUCOCODI%TYPE,
                                                           onuSaldoFactura OUT PKBCFACTURA.STYFACTSPFA,
                                                           onuCodigoError  OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                           osbMensajeError OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : api_generarfactura
    Descripcion    : Api encargado de generar factura por producti
    Autor          : Luis Javier Lopez Barrios
    Fecha          : 03/07/2025

    Entrada
      inuSubscripcion    Numero del contrato
      inuProducto        producto
      isbDocuSoporte     documento de soporte
    Salida
      onuFactura         factura generada
      onuCuentaCobro     cuenta de cobro generada
      onuSaldoFactura    saldo factura
      onuCodigoError     codigo del error
      osbMensajeError    mensaje de error
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
  	03/07/2025          LJLB              OSF-4679: Creación
 ****************************************************************/
  
   csbMT_NAME  CONSTANT VARCHAR2(100) := 'API_GENERARFACTURA';
   
BEGIN
  pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  pkg_traza.trace(' inuSubscripcion => ' || inuSubscripcion, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' inuProducto => ' || inuProducto, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' isbDocuSoporte => ' || isbDocuSoporte, pkg_traza.cnuNivelTrzDef);
  
  os_generateinvoice( inuSubscripcion,
                      inuProducto,
                      isbDocuSoporte, 
                      onuFactura, 
                      onuCuentaCobro, 
                      onuSaldoFactura, 
                      onuCodigoError, 
                      osbMensajeError);
  pkg_traza.trace(' onuFactura => ' || onuFactura, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' onuCuentaCobro => ' || onuCuentaCobro, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' onuSaldoFactura => ' || onuSaldoFactura, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' onuCodigoError => ' || onuCodigoError, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(' osbMensajeError => ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);

  pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(onuCodigoError,osbMensajeError);
       pkg_traza.trace(' osbMensajeError => ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_Error.SETERROR;
       pkg_error.getError(onuCodigoError, osbMensajeError);
       pkg_traza.trace(' osbMensajeError => ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
END api_generarfactura;
/
begin
    pkg_utilidades.prAplicarPermisos('API_GENERARFACTURA','ADM_PERSON');    
end;
/