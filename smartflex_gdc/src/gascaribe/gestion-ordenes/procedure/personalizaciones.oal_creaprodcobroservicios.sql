create or replace PROCEDURE PERSONALIZACIONES.OAL_CREAPRODCOBROSERVICIOS(inuOrden				IN NUMBER,
																	 inuCausal				IN NUMBER,
																	 inuPersona 			IN NUMBER,
																	 idtFechIniEje 			IN DATE,
																	 idtFechaFinEje 		IN DATE,
																	 isbDatosAdic 			IN VARCHAR2,
																	 isbActividades 		IN VARCHAR2,
																	 isbItemsElementos 		IN VARCHAR2,
																	 isbLecturaElementos	IN VARCHAR2,
																	 isbComentariosOrden 	IN VARCHAR2
																	 ) 
IS
/******************************************************************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 21-11-2024
	Descripcion : Procedimiento que crea producto de tipo 3 - Cobro de Servicios

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
	21-11-2024		jeerazomvm		OSF:4024: Creación
*******************************************************************************************************************************/

	-- Caso última modificación
	csbVersion         CONSTANT VARCHAR2(10) := 'OSF-4024';
	
	--Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
	nuCodigoError		NUMBER;
	nuClaseCausal		NUMBER;
	nuContrato			NUMBER;
	nuProducCobroServ	NUMBER;
	nuProductoIdx  		BINARY_INTEGER;
	nuCategoria			NUMBER;
	nuSubcategoria		NUMBER;
	nuTipoProducto		NUMBER := 3;
	nuPlanComercial		NUMBER := 4;
	nuDireccion			NUMBER;
	nuProductoCreado	NUMBER;
	nuComponente		NUMBER;
	nuProductoMotivo	NUMBER;
	sbMensajeError  	VARCHAR2(4000);
	sbTagName           VARCHAR2(250);	
	tbProducto 			pkg_bcproducto.tytbsbtServsusc;
	rcDireccion			pkg_bcdirecciones.styDirecciones;	

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
	
		-- Obtiene el contrato asociado a la orden
		nuContrato := pkg_bcordenes.fnuObtieneContrato(inuOrden);
		pkg_traza.trace('nuContrato: ' || nuContrato, csbNivelTraza); 
		
		-- Obtiene el producto de Cobro de Servicios con el estado de corte 1 del contrato
		nuProducCobroServ := pkg_bccontrato.fnuObtProdPorTipoYEstado(nuContrato,
																	 nuTipoProducto,
																	 pkg_gestion_producto.CNUESTADO_CONEXION_SERVSUSC
																	 );
		pkg_traza.trace('nuProducCobroServ: ' || nuProducCobroServ, csbNivelTraza); 
		
		-- Si el contrato NO tiene un producto de Cobro de Servicios con el estado de corte 1, procede a crear producto tipo 3
		IF (nuProducCobroServ IS NULL) THEN
		
			-- Obtiene la dirección asociada a la orden
			nuDireccion := pkg_bcordenes.fnuObtieneDireccion(inuOrden);
			pkg_traza.trace('nuDireccion: ' || nuDireccion, csbNivelTraza); 
		
			-- Obtiene el record de la direccion 
			rcDireccion := pkg_bcdirecciones.frcgetrecord(nuDireccion);
			
			-- Obtiene los datos del producto de gas
			pkg_bccontrato.prcObtProductosXTipoYContrato(nuContrato, 
														 constants_per.COD_SERVICIO_GAS, 
														 tbProducto
														 );
			
			nuProductoIdx := tbProducto.first;
		
			-- Si el contrato tiene producto de gas
			WHILE nuProductoIdx IS NOT NULL LOOP
				pkg_traza.trace('Validando el producto: ' || tbProducto(nuProductoIdx).sesunuse, csbNivelTraza);
			
				-- Obtiene la categoria y subcategoria del producto
				nuCategoria 	:= tbProducto(nuProductoIdx).sesucate;
				nuSubcategoria  := tbProducto(nuProductoIdx).sesusuca;
				
				pkg_traza.trace('nuCategoria: ' 	|| nuCategoria || CHR(10) || 
								'nuSubcategoria: '  || nuSubcategoria, csbNivelTraza); 
			
				nuProductoIdx := tbProducto.NEXT(nuProductoIdx);
			
			END LOOP;
		
			nuProductoMotivo := pkg_bogestionestructura_prod.fnuObtieneMotivoporNombreTag('M_INSTALACION_DE_COBRO_DE_SERVICIOS_121');
			pkg_traza.trace('nuProductoMotivo: ' || nuProductoMotivo, csbNivelTraza); 
	
			pkg_bsgestion_producto.prcRegistraProductoyComponente
			(
				nuContrato,
				nuTipoProducto,
				nuPlanComercial,
				ldc_boConsGenerales.fdtGetSysDate,
				nuDireccion,
				nuCategoria,
				nuSubcategoria,
				pkg_session.fnugetempresadeusuario,
				pkg_bopersonal.fnuGetPersonaId,
				pkg_bopersonal.fnuGetPuntoAtencionId(pkg_bopersonal.fnuGetPersonaId),
				nuProductoCreado,
				pkg_gestion_producto.CNUESTADO_ACTIVO_PRODUCTO,
				NULL, 				-- estado de corte
				NULL,
				NULL,
				NULL,
				NULL,
				--Componente
				null,    			/* inuClassServiceId */
				NULL,               /* isbServiceNumber */
				NULL,               /* idtServiceDate */
				NULL,               /* idtMediationDate */
				NULL,               /* inuQuantity */
				NULL,               /* inuUnchargedTime */
				NULL,               /* isbDirectionality */
				NULL,               /* inuDistributAdminId */
				NULL,               /* inuMeter */
				NULL,               /* inuBuildingId */
				NULL,               /* inuAssignRouteId */
				NULL,               /* isbDistrictId */
				NULL,               /* isbincluded */
				rcDireccion.geograp_location_id,   /* inugeograp_location_id */
				rcDireccion.neighborthood_id,      /* inuneighborthood_id */
				rcDireccion.address,               /* isbaddress */
				NULL,               /* inuProductOrigin */
				NULL,               /* inuIncluded_Features_Id */
				NULL,               /* isbIsMain */
				nuComponente,        /* onuComponentId */
				FALSE,              /* iblRegAddress */
				FALSE,              /* iblElemmedi */
				FALSE,              /* iblSpecialPhone */
				NULL,               /* inuCompProdProvisionId */
				pkg_gestion_producto.CNUESTADO_ACTIVO_COMPONENTE,   /* inuComponentStatusId */
				FALSE,              /* iblValidate */
				nuProductoMotivo,   /*inuMotivoProducto*/
				nuCodigoError,
				sbMensajeError
			);
		
			pkg_traza.trace('nuProductoCreado: ' || nuProductoCreado || CHR(10) || 
							'nuComponente: ' 	 || nuComponente 	 || CHR(10) || 
							'nuCodigoError: ' 	 || nuCodigoError 	 || CHR(10) ||
							'sbMensajeError: '   || sbMensajeError, csbNivelTraza); 
							
			IF (nuCodigoError <> 0) THEN
				pkg_error.setErrorMessage(nuCodigoError, sbMensajeError);
			END IF;
			
		END IF;
	END IF;
	
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
END OAL_CREAPRODCOBROSERVICIOS;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO OAL_CREAPRODCOBROSERVICIOS
BEGIN
    pkg_utilidades.prAplicarPermisos('OAL_CREAPRODCOBROSERVICIOS', 'PERSONALIZACIONES'); 
END;
/