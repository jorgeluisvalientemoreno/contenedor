	/***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcRegisExencionCobro
      Descripcion     : Plugin de legalización de orden de exención de cobro
						
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 14-05-2025
      
      Parametros de Entrada          

      Parametros de Salida
      
      
      Modificaciones  :
      =========================================================
      Autor       	Fecha       Caso    	Descripcion
	  fvalencia		14/05/2025	OSF-4468	Creación
	***************************************************************************/
CREATE OR REPLACE PROCEDURE personalizaciones.prcRegisExencionCobro
IS
	csbProcedimiento       	CONSTANT VARCHAR2(100):= $$plsql_unit;
    sbError             	VARCHAR2(4000);
    nuError             	NUMBER;

	nuOrden  NUMBER;
	nuCausal NUMBER;
BEGIN
	pkg_traza.trace(csbProcedimiento, pkg_traza.cnuniveltrzdef, pkg_traza.csbInicio);

	-- Obtenemos la orden que se esta legalizando
	nuOrden := pkg_bcordenes.fnuobtenerotinstancialegal; 
	
	pkg_traza.trace('Orden: ' || nuOrden, pkg_traza.cnuNivelTrzDef);

	nuCausal := pkg_bcordenes.fnuObtieneCausal(nuOrden);
	pkg_traza.trace('Causal: ' || nuCausal, pkg_traza.cnuNivelTrzDef);

	oal_exencion_cobro_factura
	(   
		inuOrden            => nuOrden,
		inuCausal           => nuCausal,
		inuPersona          => NULL,
		idtFechIniEje       => NULL,
		idtFechaFinEje      => NULL,
		isbDatosAdic        => NULL,
		isbActividades      => NULL,
		isbItemsElementos   => NULL,
		isbLecturaElementos => NULL,
		isbComentariosOrden => NULL
	);

	pkg_traza.trace(csbProcedimiento, pkg_traza.cnuniveltrzdef, pkg_traza.csbFin);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;  
END prcRegisExencionCobro;
/

begin
  pkg_utilidades.prAplicarPermisos(upper('prcRegisExencionCobro'), 'PERSONALIZACIONES');
end;
/