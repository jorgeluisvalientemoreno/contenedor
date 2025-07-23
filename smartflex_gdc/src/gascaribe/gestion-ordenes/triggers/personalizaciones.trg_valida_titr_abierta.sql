CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_VALIDA_TITR_ABIERTA
FOR INSERT OR UPDATE OF ORDER_ID ON OR_ORDER_ACTIVITY
COMPOUND TRIGGER
	/************************************************************************************************************
	Autor       : Jhon Erazo
	Fecha       : 23-01-2025
	Proceso     : PERSONALIZACIONES.TRG_VALIDA_TITR_ABIERTA
	Ticket      : OSF-3876
	Descripcion : Trigger para evitar duplicados de ordenes de presión final para el producto

	Historia de ModIFicaciones
	Fecha           Autor               ModIFicacion
	=========       =========           ====================
	23-01-2025		jerazomvm			OSF-3876: Creación                                                     
	*************************************************************************************************************/
	
     --Constantes
	csbSP_NAME  	CONSTANT VARCHAR2(100)	:= $$PLSQL_UNIT;
	cnuNVLTRC   	CONSTANT NUMBER       	:= pkg_traza.cnuNivelTrzDef;
	csbInicio   	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;

	nuError         NUMBER;
	nuTipoTrabajo	or_order.task_type_id%TYPE;
	nuProducto		or_order_activity.product_id%TYPE;
	nuOrden			or_order.order_id%TYPE;
	sbError         VARCHAR(4000);
	
	-- Ejecucion antes de cada fila, variables :NEW, :OLD son permitidas
	AFTER EACH ROW IS
		
		csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.AFTER EACH ROW';

	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbINICIO);

		nuTipoTrabajo	:= :NEW.task_type_id;
		nuProducto    	:= :NEW.product_id;
		nuOrden			:= :NEW.order_id;
		
		pkg_traza.trace('nuTipoTrabajo: ' || nuTipoTrabajo  || CHR(10) ||
						'nuProducto: ' 	  || nuProducto		|| CHR(10) || 
						'nuOrden: ' 	  || nuOrden, cnuNVLTRC);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace(' sbError => ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace(' sbError => ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.CONTROLLED_ERROR;
	END AFTER EACH ROW;

	/*Despues de la sentencia de insertar o actualizar*/
	AFTER STATEMENT IS
	
		csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.AFTER STATEMENT';

	BEGIN
	
		pkg_traza.trace( csbMT_NAME, cnuNVLTRC, csbINICIO);
	  
		-- Valida si el producto tiene ordenes abiertas con el tipo de trabajo
		pkg_bovalida_titr_abierta.prcValTitrProducto(nuProducto,
													 nuTipoTrabajo,
													 nuOrden
													 );

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace(' sbError => ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace(' sbError => ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.CONTROLLED_ERROR;
	END AFTER STATEMENT;
	
END TRG_VALIDA_TITR_ABIERTA;
/