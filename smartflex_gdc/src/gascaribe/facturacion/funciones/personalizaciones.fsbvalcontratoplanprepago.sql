CREATE OR REPLACE FUNCTION PERSONALIZACIONES.FSBVALCONTRATOPLANPREPAGO(inuContrato IN SUSCRIPC.SUSCCODI%TYPE)
RETURN VARCHAR2														 
IS
/**************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 06/02/2025
	Descripcion : POP-UP que Valida si un contrato tiene productos con plan prepago

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
	nuProductoIdx  			BINARY_INTEGER;
	nuParamPlanMediPrepa	ld_parameter.numeric_value%TYPE	:= NULL;
    sberrormessage      	VARCHAR2(2000)					:= NULL;
	sbContraProdPlanfactu	VARCHAR2(1)						:= 'N';	
	tbProducto 				pkg_bcproducto.tytbsbtServsusc;
    
BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
	
    pkg_error.prInicializaError(nuerrorcode, sberrormessage);
	
	pkg_traza.trace('inuContrato: ' || inuContrato, csbNivelTraza);
	
	pkg_bccontrato.prcObtProductosXTipoYContrato(inuContrato, constants_per.COD_SERVICIO_GAS, tbProducto);
	
	nuProductoIdx := tbProducto.first;
    
	-- Si el contrato tiene producto de gas
	WHILE nuProductoIdx IS NOT NULL LOOP
		pkg_traza.trace('Validando el producto: ' || tbProducto(nuProductoIdx).sesunuse, csbNivelTraza);
			
		-- Obtiene el valor del parametro PLAN_FACTU_MEDIDOR_PREPAGO
		nuParamPlanMediPrepa := pkg_bcld_parameter.fnuObtieneValorNumerico('PLAN_FACTU_MEDIDOR_PREPAGO');
		pkg_traza.trace('nuParamPlanMediPrepa: ' || nuParamPlanMediPrepa, csbNivelTraza); 
		
		-- Valida si el plan de facturación del producto es igual al del parametro PLAN_FACTU_MEDIDOR_PREPAGO
		IF (nuParamPlanMediPrepa = tbProducto(nuProductoIdx).sesuplfa) THEN
			sbContraProdPlanfactu := 'Y';
			EXIT;
		END IF;
		
		nuProductoIdx := tbProducto.NEXT(nuProductoIdx);
		
	END LOOP;
	
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
	  
END FSBVALCONTRATOPLANPREPAGO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBVALCONTRATOPLANPREPAGO
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBVALCONTRATOPLANPREPAGO', 'PERSONALIZACIONES');
END;
/