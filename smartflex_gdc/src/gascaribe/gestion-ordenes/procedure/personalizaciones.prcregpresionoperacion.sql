create or replace PROCEDURE personalizaciones.PRCREGPRESIONOPERACION IS
/******************************************************************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 21-11-2024
	Descripcion : Procedimiento que Registra o actualiza la presion en la tabla CM_VAVAFACO

	Parametros Entrada

	Valor de salida
		sbmen  mensaje
		error  codigo del error

	HISTORIA DE MODIFICACIONES
	FECHA        	AUTOR   		DESCRIPCION 
	21-11-2024		jeerazomvm		OSF:3629: Creación
*******************************************************************************************************************************/

	--Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
	nuErrorCode     NUMBER;
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
	
	-- Registra o actualiza la presion operacion
	OAL_RegPresionOperacion(nuorderid,
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
		pkg_Error.getError(nuErrorCode, sbMensajeError);
		pkg_traza.trace('nuErrorCode: ' || nuErrorCode || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
		RAISE pkg_error.CONTROLLED_ERROR;
	WHEN others THEN
		pkg_Error.setError;
		pkg_Error.getError(nuErrorCode, sbMensajeError);
		pkg_traza.trace('nuErrorCode: ' || nuErrorCode || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;		
END PRCREGPRESIONOPERACION;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO PRCREGPRESIONOPERACION
BEGIN
    pkg_utilidades.prAplicarPermisos('PRCREGPRESIONOPERACION', 'PERSONALIZACIONES'); 
END;
/