CREATE OR REPLACE FUNCTION FSBNOTIFICACONTPLANPREPAGO 
RETURN VARCHAR2													 	
IS
/**************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 06/02/2025
	Descripcion : POP-UP Notificacion a contrato con producto de plan prepago"

	Parametros Entrada

	HISTORIA DE MODIFICACIONES
	FECHA        	AUTOR     	DESCRIPCION
	06/02/2025		jerazomvm 	OSF-3878: creación
***************************************************************************/

    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)  	:= $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)     	:= pkg_traza.cnuNivelTrzDef; 
    csbInicio   	    CONSTANT VARCHAR2(35)	:= pkg_traza.csbINICIO;   
	
    nuerrorcode         	NUMBER;
	nuContrato				NUMBER;
    sberrormessage      	VARCHAR2(2000)	:= NULL;
	sbContraProdPlanfactu	VARCHAR2(1);
	
BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
	
    pkg_error.prInicializaError(nuerrorcode, sberrormessage);
	
	-- Obtiene el valor del contrato
	prc_obtienevalorinstancia('NOTIFICATION_INSTANCE',
							  NULL,
							  'CONTRACT',
							  'SUBSCRIPTION_ID',
							  nuContrato
							  );
	pkg_traza.trace('Contrato: ' || nuContrato, csbNivelTraza);
	
	sbContraProdPlanfactu := fsbValContratoPlanPrepago(nuContrato);  
	pkg_traza.trace('sbContraProdPlanfactu: ' || sbContraProdPlanfactu, csbNivelTraza);  	
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
	
	RETURN sbContraProdPlanfactu; 
	
EXCEPTION
	WHEN OTHERS THEN 
		pkg_Error.setError;
		pkg_Error.getError(nuerrorcode, sberrormessage);
		pkg_traza.trace(csbMetodo ||' sberrormessage: ' || sberrormessage, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);   
		RAISE pkg_Error.Controlled_Error;		
	  
END FSBNOTIFICACONTPLANPREPAGO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBNOTIFICACONTPLANPREPAGO
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBNOTIFICACONTPLANPREPAGO', 'OPEN');
END;
/