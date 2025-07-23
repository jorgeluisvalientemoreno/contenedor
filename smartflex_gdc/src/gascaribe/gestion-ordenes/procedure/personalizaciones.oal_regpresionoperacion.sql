create or replace PROCEDURE personalizaciones.OAL_REGPRESIONOPERACION(inuOrden				IN NUMBER,
																	  inuCausal				IN NUMBER,
																	  inuPersona 			IN NUMBER,
																	  idtFechIniEje 		IN DATE,
																	  idtFechaFinEje 		IN DATE,
																	  isbDatosAdic 			IN VARCHAR2,
																	  isbActividades 		IN VARCHAR2,
																	  isbItemsElementos 	IN VARCHAR2,
																	  isbLecturaElementos	IN VARCHAR2,
																	  isbComentariosOrden 	IN VARCHAR2
																	  ) 
IS
/******************************************************************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 21-11-2024
	Descripcion : Procedimiento que Registra o actualiza la presion en la tabla CM_VAVAFACO

	Parametros Entrada
		inuOrden 				Identificador de la orden
		inuCausal				Idenditificador de la causal de legalizacion
		inuPersona 				Idenditificador de la persona
		idtFechIniEje 			Fecha de inicio de la ejecucion
		idtFechaFinEje 			Fecha de fin de la ejecucion
		isbDatosAdic 			Datos adicionales
		isbActividades 			Actividades
		isbItemsElementos 		Items elementos
		isbLecturaElementos		Lecturas elementos
		isbComentariosOrden 	Comentario de la orden

	Valor de salida

	HISTORIA DE MODIFICACIONES
	FECHA        	AUTOR   		DESCRIPCION 
	21-11-2024		jeerazomvm		OSF:3629: Creación
*******************************************************************************************************************************/

	--Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
	nuErrorCode     		NUMBER;
	nuClaseCausal			ge_causal.class_causal_id%type;
	nuProductId   			pr_product.product_id%type;
	nuValorGrupoAtributo				NUMBER;
	nuValorPresion 			cm_vavafaco.vvfcvalo%type;
	nuVvfccons				cm_vavafaco.vvfccons%type;
	sbMensajeError    		VARCHAR2(4000);
	sbQuery         		VARCHAR2(200); 
	sbValorDatoAdicional	or_requ_data_value.value_1%TYPE;
	dtFechaSistema			DATE 	:= LDC_BOCONSGENERALES.FDTGETSYSDATE;
	dtFechaInicialVige		DATE;
	ocuCursorR      		constants_per.tyrefcursor;
	
	CURSOR cuDatosVavafaco(inuProductId pr_product.product_id%type) 
	IS
		SELECT vvfccons
		FROM cm_vavafaco 
		WHERE vvfcsesu = inuProductId
		AND vvfcvafc = 'PRESION_OPERACION' 
		AND vvfcfefv > dtFechaSistema;
		
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcInscm_vavafaco </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 02-12-2024 </Fecha>
    <Descripcion> 
        Inserta el record de cm_vavafaco
    </Descripcion>
	<Parametros> 
		Entrada:
			idtFechaInicialVige		Fecha inicial de vigencia
			inuValorVariable		Valor de la variable
			inuProductoId			Identificador del producto
		
		Salida:	
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="02-12-2024" Inc="OSF-3926" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prcInscm_vavafaco(idtFechaInicialVige	IN cm_vavafaco.vvfcfeiv%type,
								inuValorVariable	IN cm_vavafaco.vvfcvalo%type,
								inuProductoId		IN pr_product.product_id%type
								) 
	IS
	
        csbProcedure       CONSTANT VARCHAR2(70) := csbMetodo||'.prcInscm_vavafaco';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
		rccm_vavafacao	cm_vavafaco%ROWTYPE;
		
    BEGIN
	
        pkg_traza.trace(csbProcedure, csbNivelTraza, pkg_traza.csbINICIO);
		
		pkg_traza.trace('idtFechaInicialVige: ' || idtFechaInicialVige || chr(10) ||
						'inuValorVariable: ' 	|| inuValorVariable	   || chr(10) ||
						'inuProductoId: '		|| inuProductoId, csbNivelTraza); 
		
        -- Llena el registro de cm_vavafaco
		rccm_vavafacao.VVFCCONS := pkg_cm_vavafaco.cnuSequence;
		rccm_vavafacao.VVFCVAFC := 'PRESION_OPERACION';
		rccm_vavafacao.VVFCFEIV := idtFechaInicialVige;
		rccm_vavafacao.VVFCFEFV := ldc_boConsGenerales.fdtGetMaxDate;
		rccm_vavafacao.VVFCVALO := inuValorVariable;
		rccm_vavafacao.VVFCVAPR := inuValorVariable;
		rccm_vavafacao.VVFCUBGE := NULL;
		rccm_vavafacao.VVFCSESU := inuProductoId;
	
		-- Crea el nuevo registro de presion
		pkg_cm_vavafaco.prcInsRegistro(rccm_vavafacao);
		
        pkg_traza.trace(csbProcedure, csbNivelTraza, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.Controlled_Error THEN
			pkg_traza.trace(csbProcedure, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
			pkg_traza.trace(csbProcedure, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcInscm_vavafaco;

BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

	pkg_traza.trace('inuOrden: ' 			|| inuOrden 			|| chr(10) ||
					'inuCausal: ' 			|| inuCausal 			|| chr(10) ||
					'inuPersona: ' 			|| inuPersona 			|| chr(10) ||
					'idtFechIniEje: ' 		|| idtFechIniEje 		|| chr(10) ||
					'idtFechaFinEje: ' 		|| idtFechaFinEje 		|| chr(10) ||
					'isbDatosAdic: ' 		|| isbDatosAdic 		|| chr(10) ||
					'isbActividades: ' 		|| isbActividades 		|| chr(10) ||
					'isbItemsElementos: ' 	|| isbItemsElementos 	|| chr(10) ||
					'isbLecturaElementos: ' || isbLecturaElementos  || chr(10) ||
					'isbComentariosOrden: ' || isbComentariosOrden, csbNivelTraza); 
					
	-- Obtiene la clase de causal de legalización
	nuClaseCausal	:= pkg_bcordenes.fnuObtieneClaseCausal(inuCausal);
	pkg_traza.trace('nuClaseCausal: ' || nuClaseCausal, csbNivelTraza); 
	
	-- Si la clase de la causal es de exito
	IF (nuClaseCausal = 1) THEN
	
		-- Obtiene el producto asociado a la orden
		nuProductId	:= pkg_bcordenes.fnuObtieneProducto(inuOrden);
		pkg_traza.trace('nuProductId: ' || nuProductId, csbNivelTraza);
		
		-- Obtiene el valor del grupo de atributos configurado en el parametro GRUPO_ATRI_PRESION_FINAL 
		nuValorGrupoAtributo 	:= pkg_parametros.fnuGetValorNumerico('GRUPO_ATRI_PRESION_FINAL');
		pkg_traza.trace('nuValorGrupoAtributo: ' || nuValorGrupoAtributo, csbNivelTraza); 
		
		-- Obtiene el valor adicional de la orden, grupo de atributo y nombre del atributo
		sbValorDatoAdicional := pkg_bcordenes.fsbObtValorDatoAdicional(inuOrden,
																	   nuValorGrupoAtributo,
																	   'PRESION'
																	   );
		pkg_traza.trace('sbValorDatoAdicional: ' || sbValorDatoAdicional, csbNivelTraza); 
			
		nuValorPresion := TO_NUMBER(sbValorDatoAdicional);
		pkg_traza.trace('nuValorPresion: ' || nuValorPresion, csbNivelTraza); 

		IF cuDatosVavafaco%ISOPEN THEN
			CLOSE cuDatosVavafaco;
		END IF;
			
		-- Consulta si tiene registros vigentes en CM_VAVFACO
		OPEN cuDatosVavafaco(nuProductId);
		FETCH cuDatosVavafaco INTO nuVvfccons;
		CLOSE cuDatosVavafaco;
			
		pkg_traza.trace('El producto tiene vigente la presion operación nuVvfccons: ' || nuVvfccons, csbNivelTraza);
			
		-- Si NO tiene vigente presion operación
		IF (nuVvfccons IS NULL) THEN
		
			-- LLena los datos del nuevo registro de presion
			dtFechaInicialVige	:= TRUNC(dtFechaSistema);
			
		ELSE
		
			-- Actualiza la fecha final de vigencia
			pkg_cm_vavafaco.prcActfechaFinalVigencia(nuVvfccons,
													 TO_DATE(TRUNC(dtFechaSistema + 1) - 1/86400) -- DD/MM/YYYY 23:59:59
													 );
			
			-- LLena los datos del nuevo registro de presion
			dtFechaInicialVige := TO_DATE(TRUNC(dtFechaSistema) + 1);
							  
		END IF;
		
		-- Crea el nuevo registro de presion
		prcInscm_vavafaco(dtFechaInicialVige,
						  nuValorPresion,
						  nuProductId
						  );
		
	END IF;
	
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
END OAL_REGPRESIONOPERACION;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO OAL_REGPRESIONOPERACION
BEGIN
    pkg_utilidades.prAplicarPermisos('OAL_REGPRESIONOPERACION', 'personalizaciones'); 
END;
/