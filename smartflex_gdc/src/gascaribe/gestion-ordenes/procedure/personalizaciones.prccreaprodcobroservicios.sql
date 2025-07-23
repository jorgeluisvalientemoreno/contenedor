create or replace PROCEDURE PERSONALIZACIONES.PRCCREAPRODCOBROSERVICIOS IS
/******************************************************************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 21-02-2025
	Descripcion : Procedimiento que crea producto de tipo 3 - Cobro de Servicios

	Parametros Entrada

	Valor de salida
		nuCodigoError  	codigo del error
		sbMensajeError  Descripción del mensaje
		

	HISTORIA DE MODIFICACIONES
	FECHA        	AUTOR   		DESCRIPCION 
	21-02-2025		jerazomvm		OSF:4024: Creación
*******************************************************************************************************************************/

	-- Caso última modificación
	csbVersion          CONSTANT VARCHAR2(10) := 'OSF-4024';
	
	--Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
	nuCodigoError   NUMBER;
	nuorderid    	or_order.order_id%TYPE;
	nucausalid   	ge_causal.causal_id%TYPE;
	sbMensajeError	VARCHAR2(4000);

BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

	-- Obtiene la orden
	nuorderid     := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
	pkg_traza.trace('nuorderid: ' || nuorderid, csbNivelTraza); 
	
	-- Obtiene la causal de legalizacion de la orden
	nucausalid    := pkg_bcordenes.fnuobtienecausal(nuorderid);
	pkg_traza.trace('nucausalid: ' || nucausalid, csbNivelTraza); 
	
	-- Crea producto de tipo 3 - Cobro de Servicios
	oal_creaprodcobroservicios(nuorderid,
							   nucausalid,
							   NULL,
							   NULL,
							   NULL,
							   NULL,
							   NULL,
							   NULL,
							   NULL,
							   NULL
							   );
	
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_error.CONTROLLED_ERROR THEN
		pkg_error.setError;
		pkg_Error.getError(nuCodigoError, sbMensajeError);
		pkg_traza.trace('nuCodigoError: ' || nuCodigoError || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
		RAISE pkg_error.CONTROLLED_ERROR;
	WHEN others THEN
		pkg_Error.setError;
		pkg_Error.getError(nuCodigoError, sbMensajeError);
		pkg_traza.trace('nuCodigoError: ' || nuCodigoError || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;		
END PRCCREAPRODCOBROSERVICIOS;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO PRCCREAPRODCOBROSERVICIOS
BEGIN
    pkg_utilidades.prAplicarPermisos('PRCCREAPRODCOBROSERVICIOS', 'PERSONALIZACIONES'); 
END;
/