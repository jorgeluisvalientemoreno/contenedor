	/***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : oal_exencion_cobro_factura
      Descripcion     : Servicio para agregar exención de cobro en factura
						
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 14-05-2025
      
      Parametros de Entrada          
        inuOrden              numero de orden
        InuCausal             causal de legalizacion
        InuPersona            persona que legaliza
        idtFechIniEje         fecha de inicio de ejecucion
        idtFechaFinEje        fecha fin de ejecucion
        IsbDatosAdic          datos adicionales
        IsbActividades        actividad principal y de apoyo
        IsbItemsElementos     items a legalizar
        IsbLecturaElementos   lecturas
        IsbComentariosOrden   comentario de la orden
      Parametros de Salida
      
      
      Modificaciones  :
      =========================================================
      Autor       	Fecha       Caso    	Descripcion
	  fvalencia		14/05/2025	OSF-4171	Creación
	***************************************************************************/
CREATE OR REPLACE PROCEDURE personalizaciones.oal_exencion_cobro_factura
(
	inuOrden            IN NUMBER,
	InuCausal           IN NUMBER,
	InuPersona          IN NUMBER,
	idtFechIniEje       IN DATE,
	idtFechaFinEje      IN DATE,
	IsbDatosAdic        IN VARCHAR2,
	IsbActividades      IN VARCHAR2,
	IsbItemsElementos   IN VARCHAR2,
	IsbLecturaElementos IN VARCHAR2,
	IsbComentariosOrden IN VARCHAR2
) 
IS
	csbProcedimiento       	CONSTANT VARCHAR2(100):= $$plsql_unit;
    sbError             	VARCHAR2(4000);
    nuError             	NUMBER;

	nuClasificadorCausal 	NUMBER;
	nuTotaExenciones 		NUMBER;
	nuProducto             	NUMBER;
	nuSolicitud          	NUMBER;
	nuContrato             	NUMBER;
	rcExencion 			pkg_exencion_cobro_factura.cuEXENCION_COBRO_FACTURA%ROWTYPE;
	nuNumeroDias		NUMBER := pkg_parametros.fnuGetValorNumerico('NRO_DIAS_EXENCION_COBRO_FACTURA');
BEGIN
	pkg_traza.trace(csbProcedimiento, pkg_traza.cnuniveltrzdef, pkg_traza.csbInicio);

	pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('Causal: ' || inuCausal, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('Persona: ' || inuPersona, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('FechIniEje: ' || idtFechIniEje, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('FechaFinEje: ' || idtFechaFinEje, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('DatosAdic: ' || isbDatosAdic, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('Actividades: ' || isbActividades, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('ItemsElementos: ' || isbItemsElementos, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('LecturaElementos: ' || isbLecturaElementos, pkg_traza.cnuniveltrzdef);
	pkg_traza.trace('ComentariosOrden: ' || isbComentariosOrden, pkg_traza.cnuniveltrzdef);
	
	--Obtener la clasificación (clase) de la causal
	nuClasificadorCausal := pkg_bcordenes.fnuobtieneclasecausal(inuCausal);
	pkg_traza.trace('Clasificacion Causal: ' || nuClasificadorCausal, pkg_traza.cnuniveltrzdef);
	
	--Si la clasificación de la causal es de 1 - éxito
	IF nuClasificadorCausal = 1 THEN

		--Obtener solicitud de la orden
		nuSolicitud := pkg_bcordenes.fnuObtieneSolicitud(inuOrden);
		pkg_traza.trace('Solicitud: ' || nuSolicitud, pkg_traza.cnuniveltrzdef);

		--Obtener producto de la solicitud
		nuProducto := pkg_bcsolicitudes.fnuGetProducto(nuSolicitud);
		pkg_traza.trace('Producto: ' || nuProducto, pkg_traza.cnuniveltrzdef);

		--Obtener Contrato
		nuContrato := pkg_bcproducto.fnuContrato(nuProducto);

		pkg_boexencion_cobro_factura.prcValidaFacturacionEnProceso(nuContrato);

		--Obtiene total de exenciones
		nuTotaExenciones := pkg_bcexencion_cobro_factura.fnuObtTotalExencionesVigentes(nuProducto);
		pkg_traza.trace('Total Exenciones: ' || nuTotaExenciones, pkg_traza.cnuniveltrzdef);

		IF (nuTotaExenciones > 0) THEN
			-- Actuliza exenciones vigentes con fecha fin sysdate
			pkg_exencion_cobro_factura.prActExencionesVigentes(nuProducto);
		ENd IF;

		rcExencion.solicitud := nuSolicitud;
		rcExencion.producto := nuProducto;
		rcExencion.fecha_ini_vigencia := SYSDATE;
		rcExencion.fecha_fin_vigencia := SYSDATE+nuNumeroDias;

		pkg_exencion_cobro_factura.prinsRegistro( rcExencion);
	END IF;

	pkg_traza.trace(csbProcedimiento, pkg_traza.cnuniveltrzdef, pkg_traza.csbFin);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    --Validación de error no controlado
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbProcedimiento, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;  
END oal_exencion_cobro_factura;
/

begin
  pkg_utilidades.prAplicarPermisos(upper('oal_exencion_cobro_factura'), 'PERSONALIZACIONES');
end;
/