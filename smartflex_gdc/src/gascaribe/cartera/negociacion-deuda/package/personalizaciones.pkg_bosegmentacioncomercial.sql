CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bosegmentacioncomercial IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   02-04-2025
		Descripcion :   Paquete con logica para segmentación comercial
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	02-04-2025	OSF-4155	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Obtiene el plan de financiación de mayor prioridad
	FUNCTION fnuPlanFinanMayorPrioridad(inuProducto   		IN ldc_osf_sesucier.producto%TYPE,
										inuLocalidad		IN ldc_osf_sesucier.localidad%TYPE,
										inuSegmentoPredio	IN ldc_osf_sesucier.segmento_predio%TYPE,
										inuDireccion  		IN pr_product.address_id%TYPE,
										inuCategoria  		IN ldc_osf_sesucier.categoria%TYPE,
										inuSubcategoria   	IN ldc_osf_sesucier.subcategoria%TYPE,
										inuEstadoCorte  	IN ldc_osf_sesucier.estado_corte%TYPE,
										inuPlanComercial  	IN pr_product.commercial_plan_id%TYPE,
										inuCantFinanciacion IN NUMBER,
										inuCuentasSaldo  	IN ldc_osf_sesucier.nro_ctas_con_saldo%TYPE,
										isbEstadoFinancie  	IN ldc_osf_sesucier.estado_financiero%TYPE,
										inuUltimPlanFinan  	IN ldc_osf_sesucier.ultimo_plan_fina%TYPE
										)
	RETURN NUMBER;
									
END pkg_bosegmentacioncomercial;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bosegmentacioncomercial IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4155';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 02-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="02-04-2025" Inc="OSF-4155" Empresa="GDC"> 
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuPlanFinanMayorPrioridad
    Descripcion     : Obtiene el plan de financiación de mayor prioridad
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuProducto        		Producto
        inuLocalidad       		Localidad
        inuSegmentoPredio       Segmento
        inuDireccion       		Direción
        inuCategoria       		Categoría
        inuSubcategoria        	Subcategoría
        inuEstadoCorte       	Estado de corte
        inuPlanComercial       	Plan comercial
        inuCantFinanciacion		Estado corte
        inuCuentasSaldo       	Cuentas con saldo
        isbEstadoFinancie       Estado financiero
        inuUltimPlanFinan       Ultimo plan de financiación
	  
    Parametros de Salida
		nuPlanFinanciacion       	Plan de financiación	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	26/06/2024 	jcatuche        OSF-2865	Ajuste para restrigir en la obtención del plan prioritario un plan especial determinado por el parámetro SPECIALS_PLAN
											Se estandariza traza y se ajusta objeto según lineamientos.
    10/12/2018  Eduardo Cerón   			Creación
	***************************************************************************/	
	FUNCTION fnuPlanFinanMayorPrioridad(inuProducto   		IN ldc_osf_sesucier.producto%TYPE,
										inuLocalidad		IN ldc_osf_sesucier.localidad%TYPE,
										inuSegmentoPredio	IN ldc_osf_sesucier.segmento_predio%TYPE,
										inuDireccion  		IN pr_product.address_id%TYPE,
										inuCategoria  		IN ldc_osf_sesucier.categoria%TYPE,
										inuSubcategoria   	IN ldc_osf_sesucier.subcategoria%TYPE,
										inuEstadoCorte  	IN ldc_osf_sesucier.estado_corte%TYPE,
										inuPlanComercial  	IN pr_product.commercial_plan_id%TYPE,
										inuCantFinanciacion IN NUMBER,
										inuCuentasSaldo  	IN ldc_osf_sesucier.nro_ctas_con_saldo%TYPE,
										isbEstadoFinancie  	IN ldc_osf_sesucier.estado_financiero%TYPE,
										inuUltimPlanFinan  	IN ldc_osf_sesucier.ultimo_plan_fina%TYPE
										)
	RETURN NUMBER
	IS
	
		PRAGMA AUTONOMOUS_TRANSACTION;
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuPlanFinanMayorPrioridad';
		
		nuError					NUMBER;  
		nuPlanesFinanActIdx		BINARY_INTEGER;
		nuDatosGeopoliIdx		BINARY_INTEGER;
		nuDatosFinancieIdx		BINARY_INTEGER;
		nuDatosComercialesIdx	BINARY_INTEGER;
		nucontageopolitico      NUMBER;
		nucontafinanciero       NUMBER;
		nucontacomercial        NUMBER;
		nulocalidconf           cc_com_seg_fea_val.geog_geogph_loc_id%TYPE;
		nulocalidprod           cc_com_seg_fea_val.geog_geogph_loc_id%TYPE;
		nusegmentconf           cc_com_seg_fea_val.geog_segment_id%TYPE;
		nusegmentprod           cc_com_seg_fea_val.geog_segment_id%TYPE;
		nudirecciconf           cc_com_seg_fea_val.geog_address_id%TYPE;
		nudirecciprod           cc_com_seg_fea_val.geog_address_id%TYPE;
		nucategorconf           cc_com_seg_fea_val.geog_category_id%TYPE;
		nucategorprod           cc_com_seg_fea_val.geog_category_id%TYPE;
		nusubcateconf           cc_com_seg_fea_val.geog_subcategory_id%TYPE;
		nusubcateprod           cc_com_seg_fea_val.geog_subcategory_id%TYPE;
		nuestacorconf           cc_com_seg_fea_val.prod_cutting_state%TYPE;
		nuestacorprod           cc_com_seg_fea_val.prod_cutting_state%TYPE;
		nuplnacomconf           cc_com_seg_fea_val.prod_commercial_plan%TYPE;
		nuplnacomprod           cc_com_seg_fea_val.prod_commercial_plan%TYPE;
		nucantfinconf           cc_com_seg_fea_val.finan_finan_count%TYPE;
		nucantfinprod           cc_com_seg_fea_val.finan_finan_count%TYPE;
		nucuentasconf           cc_com_seg_fea_val.finan_acc_balance%TYPE;
		nucuentasprod           cc_com_seg_fea_val.finan_acc_balance%TYPE;
		nuultplanconf           cc_com_seg_fea_val.finan_last_fin_plan%TYPE;
		nuultplanprod           cc_com_seg_fea_val.finan_last_fin_plan%TYPE;
		nucontaaplica           NUMBER;
		nuPlanFinanciacion      plandife.pldicodi%TYPE;
		sbmensaje				VARCHAR2(1000);	
		sbestfinaconf           cc_com_seg_fea_val.finan_finan_state%TYPE;
		sbestfinaprod           cc_com_seg_fea_val.finan_finan_state%TYPE;
		tbPlanesFinanActivos	pkg_bcsegmentacioncomercial.tytbPlanesFinanActivos;
		tbDatosGeopoliticos		pkg_bcsegmentacioncomercial.tytbDatosGeopoliticos;
		tbDatosFinancieros		pkg_bcsegmentacioncomercial.tytbDatosFinancieros;
		tbDatosComerciales		pkg_bcsegmentacioncomercial.tytbDatosComerciales;	
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' 		|| inuProducto 			|| CHR(10) ||
						'inuLocalidad: ' 		|| inuLocalidad 		|| CHR(10) ||
						'inuSegmentoPredio: ' 	|| inuSegmentoPredio 	|| CHR(10) ||
						'inuDireccion: ' 		|| inuDireccion 		|| CHR(10) ||
						'inuCategoria: ' 		|| inuCategoria 		|| CHR(10) ||
						'inuSubcategoria: ' 	|| inuSubcategoria 		|| CHR(10) ||
						'inuEstadoCorte: ' 		|| inuEstadoCorte 		|| CHR(10) ||
						'inuPlanComercial: ' 	|| inuPlanComercial 	|| CHR(10) ||
						'inuCantFinanciacion: '	|| inuCantFinanciacion  || CHR(10) ||
						'inuCuentasSaldo: ' 	|| inuCuentasSaldo 		|| CHR(10) ||
						'isbEstadoFinancie: ' 	|| isbEstadoFinancie 	|| CHR(10) ||
						'inuUltimPlanFinan: ' 	|| inuUltimPlanFinan, cnuNVLTRC);
    
		pkg_traza.trace('Borrando ldc_plfiaplpro para el producto: ' || inuProducto, cnuNVLTRC);
		
		-- Elimina el registro del producto en ldc_plfiaplpro
		pkg_ldc_plfiaplpro.prcBorraRegistxProduc(inuProducto);

		-- Obtiene los planes de financiación activos	
		pkg_bcsegmentacioncomercial.prcObtPlanesFinanActivos(tbPlanesFinanActivos);
		
		nuPlanesFinanActIdx := tbPlanesFinanActivos.FIRST;
		
		WHILE nuPlanesFinanActIdx IS NOT NULL LOOP
		
			-- Caracteristicas geopoliticas
			nucontageopolitico := 0;
			
			-- Obtiene la cantidad de politicas por segmento	
			nucontageopolitico := pkg_bcsegmentacioncomercial.fnuObtCantiPolitixSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento);
        
			-- Características financieras
			nucontafinanciero := 0;
			
			-- Obtiene la cantidad de financieras por segmento	
			nucontafinanciero := pkg_bcsegmentacioncomercial.fnuObtCantiFinanxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento);
			
			-- Características comerciales
			nucontacomercial :=  0;
			
			-- Obtiene la cantidad de comerciales por segmento	
			nucontacomercial := pkg_bcsegmentacioncomercial.fnuObtCantiComercxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento);
			
			-- Validamos si tiene configuración en características geopoliticas, financieras y comerciales
			IF (nucontageopolitico >= 1 AND nucontafinanciero >= 1 AND nucontacomercial >= 1) THEN
				
				-- Obtiene en tipo tabla los datos geopoliticos por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosGeopoxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosGeopoliticos
																	);
																	
				nuDatosGeopoliIdx := tbDatosGeopoliticos.FIRST;
				
				-- Características geopoliticas
				WHILE nuDatosGeopoliIdx IS NOT NULL LOOP

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica IS NOT NULL) THEN
						nulocalidconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica;
						nulocalidprod := inuLocalidad;
					ELSE
						nulocalidconf := -1;
						nulocalidprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment IS NOT NULL) THEN
					
						nusegmentconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment;
						nusegmentprod := inuSegmentoPredio;
					ELSE
						nusegmentconf := -1;
						nusegmentprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen IS NOT NULL) THEN					
						nudirecciconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen;
						nudirecciprod := inuDireccion;
					ELSE
						nudirecciconf := -1;
						nudirecciprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria IS NOT NULL) THEN
						nucategorconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria;
						nucategorprod := inuCategoria;
					ELSE
						nucategorconf := -1;
						nucategorprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria IS NOT NULL) THEN
						nusubcateconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria;
						nusubcateprod := inuSubcategoria;
					ELSE
						nusubcateconf := -1;
						nusubcateprod := -1;
					END IF;


					-- Obtiene en tipo tabla los datos Financieros por segmento	
					pkg_bcsegmentacioncomercial.prcObtDatosFinanxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																		tbDatosFinancieros
																		);
																	
					nuDatosFinancieIdx := tbDatosFinancieros.FIRST;
					
					-- Caracteristicas financieras
					WHILE nuDatosFinancieIdx IS NOT NULL LOOP
					
						IF (tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte IS NOT NULL) THEN
							nuestacorconf := tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte;
							nuestacorprod := inuEstadoCorte;
						ELSE
							nuestacorconf := -1;
							nuestacorprod := -1;
						END IF;

						IF (tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial IS NOT NULL) THEN
							nuplnacomconf := tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial;
							nuplnacomprod := inuPlanComercial;
						ELSE
							nuplnacomconf := -1;
							nuplnacomprod := -1;
						END IF;

						-- Obtiene en tipo tabla los datos comerciales por segmento	
						pkg_bcsegmentacioncomercial.prcObtDatosComerciaxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																			   tbDatosComerciales
																			  );
																	
						nuDatosComercialesIdx := tbDatosComerciales.FIRST;
						
						-- Características comerciales
						WHILE nuDatosComercialesIdx IS NOT NULL LOOP
						
							IF (tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac IS NOT NULL) THEN
								nucantfinconf := tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac;
								nucantfinprod := inuCantFinanciacion;
							ELSE
								nucantfinconf := -1;
								nucantfinprod := -1;
							END IF;

							IF (tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo IS NOT NULL) THEN
								nucuentasconf := tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo;
								nucuentasprod := inuCuentasSaldo; 
							ELSE
								nucuentasconf := -1;
								nucuentasprod := -1;
							END IF;

							IF (tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero IS NOT NULL) THEN
								sbestfinaconf := tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero;
								sbestfinaprod := isbEstadoFinancie;
							ELSE
								sbestfinaconf := '-';
								sbestfinaprod := '-';
							END IF;

							IF (tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc IS NOT NULL) THEN
								nuultplanconf := tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc;
								nuultplanprod := inuUltimPlanFinan;
							ELSE
								nuultplanconf := -1;
								nuultplanprod := -1;
							END IF;

							IF (nulocalidconf = nulocalidprod AND nusegmentconf = nusegmentprod AND nudirecciconf = nudirecciprod AND 
								nucategorconf = nucategorprod AND nusubcateconf = nusubcateprod AND nuestacorconf = nuestacorprod AND 
								nuplnacomconf = nuplnacomprod AND nucantfinconf = nucantfinprod AND nucuentasconf = nucuentasprod AND 
								sbestfinaconf = sbestfinaprod AND nuultplanconf = nuultplanprod) THEN
								
								pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
								pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico 	|| CHR(10) ||
												'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) ||
												'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
								pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
								pkg_traza.trace('Segmento: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) ||
												'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad	|| CHR(10) ||
												'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
								pkg_traza.trace('=======================================================', cnuNVLTRC);
								
								-- Inserta registros en ldc_plfiaplpro
								pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
																	tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
																	tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
																	tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
																	);
								COMMIT;
							END IF;

							COMMIT;
							
							nuDatosComercialesIdx := tbDatosComerciales.NEXT(nuDatosComercialesIdx);
							
						END LOOP;
					
						nuDatosFinancieIdx := tbDatosFinancieros.NEXT(nuDatosFinancieIdx);
					
					END LOOP;
					
					nuDatosGeopoliIdx := tbDatosGeopoliticos.NEXT(nuDatosGeopoliIdx);
				
				END LOOP;
			-- Validamos si tiene configuración en características geopoliticas y financieras
			ELSIF (nucontageopolitico >= 1 AND nucontafinanciero >= 1 AND nucontacomercial = 0) THEN
				-- Obtiene en tipo tabla los datos geopoliticos por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosGeopoxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosGeopoliticos
																	);
																	
				nuDatosGeopoliIdx := tbDatosGeopoliticos.FIRST;
				
				-- Características geopoliticas
				WHILE nuDatosGeopoliIdx IS NOT NULL LOOP
					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica IS NOT NULL) THEN
						nulocalidconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica;
						nulocalidprod := inuLocalidad;
					ELSE
						nulocalidconf := -1;
						nulocalidprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment IS NOT NULL) THEN
						nusegmentconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment;
						nusegmentprod := inuSegmentoPredio;
					ELSE
						nusegmentconf := -1;
						nusegmentprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen IS NOT NULL) THEN
						nudirecciconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen;
						nudirecciprod := inuDireccion;
					ELSE
						nudirecciconf := -1;
						nudirecciprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria IS NOT NULL) THEN
						nucategorconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria;
						nucategorprod := inuCategoria;
					ELSE
						nucategorconf := -1;
						nucategorprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria IS NOT NULL) THEN
						nusubcateconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria;
						nusubcateprod := inuSubcategoria;
					ELSE
						nusubcateconf := -1;
						nusubcateprod := -1;
					END IF;

					-- Obtiene en tipo tabla los datos Financieros por segmento	
					pkg_bcsegmentacioncomercial.prcObtDatosFinanxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																		tbDatosFinancieros
																		);
																	
					nuDatosFinancieIdx := tbDatosFinancieros.FIRST;
					
					-- Características financieras
					WHILE nuDatosFinancieIdx IS NOT NULL LOOP
						IF (tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte IS NOT NULL) THEN
							nuestacorconf := tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte;
							nuestacorprod := inuEstadoCorte;
						ELSE
							nuestacorconf := -1;
							nuestacorprod := -1;
						END IF;

						IF (tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial IS NOT NULL) THEN
							nuplnacomconf := tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial;
							nuplnacomprod := inuPlanComercial;
						ELSE
							nuplnacomconf := -1;
							nuplnacomprod := -1;
						END IF;

						IF (nulocalidconf = nulocalidprod AND nusegmentconf = nusegmentprod AND nudirecciconf = nudirecciprod AND 
							nucategorconf = nucategorprod AND nusubcateconf = nusubcateprod AND nuestacorconf = nuestacorprod AND 
							nuplnacomconf = nuplnacomprod) THEN
							
							pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
							pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico	|| CHR(10) || 
											'Conteo Financiero: '	|| nucontafinanciero 	|| CHR(10) || 
											'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
							pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
							pkg_traza.trace('Segmento: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) || 
											'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad	|| CHR(10) ||
											'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
							pkg_traza.trace('=======================================================', cnuNVLTRC);
							
							-- Inserta registros en ldc_plfiaplpro
							pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
																);
							COMMIT;
						END IF;

						COMMIT;
					
						nuDatosFinancieIdx := tbDatosFinancieros.NEXT(nuDatosFinancieIdx);
					
					END LOOP;
				
					nuDatosGeopoliIdx := tbDatosGeopoliticos.NEXT(nuDatosGeopoliIdx);
				
				END LOOP;
			-- Validamos si tiene configuración en características geopoliticas y comercial
			ELSIF (nucontageopolitico >= 1 AND nucontafinanciero = 0 AND nucontacomercial >= 1) THEN
				-- Obtiene en tipo tabla los datos geopoliticos por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosGeopoxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosGeopoliticos
																	);
																	
				nuDatosGeopoliIdx := tbDatosGeopoliticos.FIRST;
				
				-- Características geopoliticas
				WHILE nuDatosGeopoliIdx IS NOT NULL LOOP
					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica IS NOT NULL) THEN
						nulocalidconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica;
						nulocalidprod := inuLocalidad;
					ELSE
						nulocalidconf := -1;
						nulocalidprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment IS NOT NULL) THEN
						nusegmentconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment;
						nusegmentprod := inuSegmentoPredio;
					ELSE
						nusegmentconf := -1;
						nusegmentprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen IS NOT NULL) THEN
						nudirecciconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen;
						nudirecciprod := inuDireccion;
					ELSE
						nudirecciconf := -1;
						nudirecciprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria IS NOT NULL) THEN
						nucategorconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria;
						nucategorprod := inuCategoria;
					ELSE
						nucategorconf := -1;
						nucategorprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria IS NOT NULL) THEN
						nusubcateconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria;
						nusubcateprod := inuSubcategoria;
					ELSE
						nusubcateconf := -1;
						nusubcateprod := -1;
					END IF;

					-- Obtiene en tipo tabla los datos comerciales por segmento	
					pkg_bcsegmentacioncomercial.prcObtDatosComerciaxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																		   tbDatosComerciales
																		  );
																	
					nuDatosComercialesIdx := tbDatosComerciales.FIRST;
					
					-- Características comerciales
					WHILE nuDatosComercialesIdx IS NOT NULL LOOP
						IF (tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac IS NOT NULL) THEN
							nucantfinconf := tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac;
							nucantfinprod := inuCantFinanciacion;
						ELSE
							nucantfinconf := -1;
							nucantfinprod := -1;
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo IS NOT NULL) THEN
							nucuentasconf := tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo;
							nucuentasprod := inuCuentasSaldo;
						ELSE
							nucuentasconf := -1;
							nucuentasprod := -1;
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero IS NOT NULL) THEN
							sbestfinaconf := tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero;
							sbestfinaprod := isbEstadoFinancie;
						ELSE
							sbestfinaconf := '-';
							sbestfinaprod := '-';
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc IS NOT NULL) THEN
							nuultplanconf := tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc;
							nuultplanprod := inuUltimPlanFinan;
						ELSE
							nuultplanconf := -1;
							nuultplanprod := -1;
						END IF;

						IF (nulocalidconf = nulocalidprod AND nusegmentconf = nusegmentprod AND nudirecciconf = nudirecciprod AND 
							nucategorconf = nucategorprod AND nusubcateconf = nusubcateprod AND nucantfinconf = nucantfinprod AND 
							nucuentasconf = nucuentasprod AND sbestfinaconf = sbestfinaprod AND nuultplanconf = nuultplanprod) THEN
							pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
							pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico 	|| CHR(10) || 
											'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) || 
											'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
							pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
							pkg_traza.trace('Segmento: '			||tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) ||
											'Prioridad: '			||tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad		|| CHR(10) ||
											'Plan Financiación: '	||tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
							pkg_traza.trace('=======================================================', cnuNVLTRC);
							
							-- Inserta registros en ldc_plfiaplpro
							pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
																);
							COMMIT;
						END IF;
					
						nuDatosComercialesIdx := tbDatosComerciales.NEXT(nuDatosComercialesIdx);
					
					END LOOP;
				
					nuDatosGeopoliIdx := tbDatosGeopoliticos.NEXT(nuDatosGeopoliIdx);
				
				END LOOP;
			-- Validamos si solo tiene configuración en características geopoliticas
			ELSIF (nucontageopolitico >= 1 AND nucontafinanciero = 0 AND nucontacomercial = 0) THEN
				-- Obtiene en tipo tabla los datos geopoliticos por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosGeopoxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosGeopoliticos
																	);
																	
				nuDatosGeopoliIdx := tbDatosGeopoliticos.FIRST;
				
				-- Características geopoliticas
				WHILE nuDatosGeopoliIdx IS NOT NULL LOOP
					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica IS NOT NULL) THEN
						nulocalidconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuLocaliGeografica;
						nulocalidprod := inuLocalidad;
					ELSE
						nulocalidconf := -1;
						nulocalidprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment IS NOT NULL) THEN
						nusegmentconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuGeolocaSegment;
						nusegmentprod := inuSegmentoPredio;
					ELSE
						nusegmentconf := -1;
						nusegmentprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen IS NOT NULL) THEN
						nudirecciconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuDireccionSegmen;
						nudirecciprod := inuDireccion;
					ELSE
						nudirecciconf := -1;
						nudirecciprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria IS NOT NULL) THEN
						nucategorconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuCategoria;
						nucategorprod := inuCategoria;
					ELSE
						nucategorconf := -1;
						nucategorprod := -1;
					END IF;

					IF (tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria IS NOT NULL) THEN
						nusubcateconf := tbDatosGeopoliticos(nuDatosGeopoliIdx).nuSubcategoria;
						nusubcateprod := inuSubcategoria;
					ELSE
						nusubcateconf := -1;
						nusubcateprod := -1;
					END IF;

					nucontaaplica := 0;

					IF (nulocalidconf = nulocalidprod AND nusegmentconf = nusegmentprod AND nudirecciconf = nudirecciprod AND 
						nucategorconf = nucategorprod AND nusubcateconf = nusubcateprod) THEN
						pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
						pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico	|| CHR(10) || 
										'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) || 
										'Conteo Comercial: ' 	|| nucontacomercial, cnuNVLTRC);
						pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
						pkg_traza.trace('Segmento: ' 			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) || 
										'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad	|| CHR(10) || 
										'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
						pkg_traza.trace('=======================================================', cnuNVLTRC);
						
						-- Inserta registros en ldc_plfiaplpro
						pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
															);
						COMMIT;
					END IF;
				
					nuDatosGeopoliIdx := tbDatosGeopoliticos.NEXT(nuDatosGeopoliIdx);
				
				END LOOP;
			-- Validamos si tiene configuración en características financieras y comercial
			ELSIF (nucontageopolitico = 0 AND nucontafinanciero >= 1 AND nucontacomercial >= 1) THEN
				-- Obtiene en tipo tabla los datos Financieros por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosFinanxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosFinancieros
				    												);
																	
				nuDatosFinancieIdx := tbDatosFinancieros.FIRST;
					
				-- Características financieras
				WHILE nuDatosFinancieIdx IS NOT NULL LOOP
					IF (tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte IS NOT NULL) THEN
						nuestacorconf := tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte;
						nuestacorprod := inuEstadoCorte;
					ELSE
						nuestacorconf := -1;
						nuestacorprod := -1;
					END IF;

					IF (tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial IS NOT NULL) THEN
						nuplnacomconf := tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial;
						nuplnacomprod := inuPlanComercial;
					ELSE
						nuplnacomconf := -1;
						nuplnacomprod := -1;
					END IF;

					-- Obtiene en tipo tabla los datos comerciales por segmento	
					pkg_bcsegmentacioncomercial.prcObtDatosComerciaxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																		   tbDatosComerciales
																		  );
																	
					nuDatosComercialesIdx := tbDatosComerciales.FIRST;
					
					-- Características comerciales
					WHILE nuDatosComercialesIdx IS NOT NULL LOOP
						IF (tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac IS NOT NULL) THEN
							nucantfinconf := tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac;
							nucantfinprod := inuCantFinanciacion;
						ELSE
							nucantfinconf := -1;
							nucantfinprod := -1;
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo IS NOT NULL) THEN
							nucuentasconf := tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo;
							nucuentasprod := inuCuentasSaldo;
						ELSE
							nucuentasconf := -1;
							nucuentasprod := -1;
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero IS NOT NULL) THEN
							sbestfinaconf := tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero;
							sbestfinaprod := isbEstadoFinancie;
						ELSE
							sbestfinaconf := '-';
							sbestfinaprod := '-';
						END IF;

						IF (tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc IS NOT NULL) THEN
							nuultplanconf := tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc;
							nuultplanprod := inuUltimPlanFinan;
						ELSE
							nuultplanconf := -1;
							nuultplanprod := -1;
						END IF;

						IF (nuestacorconf = nuestacorprod AND nuplnacomconf = nuplnacomprod AND nucantfinconf = nucantfinprod AND 
							nucuentasconf = nucuentasprod AND sbestfinaconf = sbestfinaprod AND nuultplanconf = nuultplanprod) THEN
							pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
							pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico 	|| CHR(10) ||
											'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) ||
											'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
							pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
							pkg_traza.trace('Segmento: ' 			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) ||
											'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad	|| CHR(10) ||
											'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
							pkg_traza.trace('=======================================================', cnuNVLTRC);
							
							-- Inserta registros en ldc_plfiaplpro
							pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
																tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
																);
							COMMIT;
						END IF;
					
						nuDatosComercialesIdx := tbDatosComerciales.NEXT(nuDatosComercialesIdx);
					
					END LOOP;
				
					nuDatosFinancieIdx := tbDatosFinancieros.NEXT(nuDatosFinancieIdx);
				
				END LOOP;
			-- Validamos si solo tiene configuración en características financieras
			ELSIF (nucontageopolitico = 0 AND nucontafinanciero >= 1 AND nucontacomercial = 0) THEN
				-- Obtiene en tipo tabla los datos Financieros por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosFinanxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	tbDatosFinancieros
				    												);
																	
				nuDatosFinancieIdx := tbDatosFinancieros.FIRST;
					
				-- Características financieras
				WHILE nuDatosFinancieIdx IS NOT NULL LOOP
					IF (tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte IS NOT NULL) THEN
						nuestacorconf := tbDatosFinancieros(nuDatosFinancieIdx).nuEstadoCorte;
						nuestacorprod := inuEstadoCorte;
					ELSE
						nuestacorconf := -1;
						nuestacorprod := -1;
					END IF;

					IF (tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial IS NOT NULL) THEN
						nuplnacomconf := tbDatosFinancieros(nuDatosFinancieIdx).nuPlanComercial;
						nuplnacomprod := inuPlanComercial;
					ELSE
						nuplnacomconf := -1;
						nuplnacomprod := -1;
					END IF;

					nucontaaplica := 0;

					IF (nuestacorconf = nuestacorprod AND nuplnacomconf = nuplnacomprod) THEN
						pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
						pkg_traza.trace('Conteo Geopolítico: '	|| nucontageopolitico	|| CHR(10) ||
										'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) ||
										'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
						pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
						pkg_traza.trace('Segmento: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId	|| CHR(10) ||
										'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad	|| CHR(10) ||
										'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
						pkg_traza.trace('=======================================================', cnuNVLTRC);
						
						-- Inserta registros en ldc_plfiaplpro
						pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
															);
						COMMIT;
					END IF;
				
					nuDatosFinancieIdx := tbDatosFinancieros.NEXT(nuDatosFinancieIdx);
				
				END LOOP;
			-- Validamos si solo tiene configuración en características comerciales
			ELSIF (nucontageopolitico = 0 AND nucontafinanciero = 0 AND nucontacomercial >= 1) THEN
				-- Obtiene en tipo tabla los datos comerciales por segmento	
				pkg_bcsegmentacioncomercial.prcObtDatosComerciaxSegmen(tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmento, 
																	   tbDatosComerciales
																	  );
																	
				nuDatosComercialesIdx := tbDatosComerciales.FIRST;
					
				-- Características comerciales
				WHILE nuDatosComercialesIdx IS NOT NULL LOOP
					IF (tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac IS NOT NULL) THEN
						nucantfinconf := tbDatosComerciales(nuDatosComercialesIdx).nuCantidadFinanciac;
						nucantfinprod := inuCantFinanciacion;
					ELSE
						nucantfinconf := -1;
						nucantfinprod := -1;
					END IF;

					IF (tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo IS NOT NULL) THEN
						nucuentasconf := tbDatosComerciales(nuDatosComercialesIdx).nuCuentasSaldo;
						nucuentasprod := inuCuentasSaldo;
					ELSE
						nucuentasconf := -1;
						nucuentasprod := -1;
					END IF;

					IF (tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero IS NOT NULL) THEN
						sbestfinaconf := tbDatosComerciales(nuDatosComercialesIdx).sbEstadoFinanciero;
						sbestfinaprod := isbEstadoFinancie;
					ELSE
						sbestfinaconf := '-';
						sbestfinaprod := '-';
					END IF;

					IF (tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc IS NOT NULL) THEN
						nuultplanconf := tbDatosComerciales(nuDatosComercialesIdx).nuUltiPlanFinanc;
						nuultplanprod := inuUltimPlanFinan;
					ELSE
						nuultplanconf := -1;
						nuultplanprod := -1;
					END IF;

					nucontaaplica := 0;

					IF (nucantfinconf = nucantfinprod AND nucuentasconf = nucuentasprod AND 
						sbestfinaconf = sbestfinaprod AND nuultplanconf = nuultplanprod) THEN
						pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', cnuNVLTRC);
						pkg_traza.trace('Conteo Geopolítico: ' 	|| nucontageopolitico 	|| CHR(10) ||
										'Conteo Financiero: '	|| nucontafinanciero	|| CHR(10) ||
										'Conteo Comercial: '	|| nucontacomercial, cnuNVLTRC);
						pkg_traza.trace('-------------------------------------------------------', cnuNVLTRC);
						pkg_traza.trace('Segmento: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId		|| CHR(10) ||
										'Prioridad: '			|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad		|| CHR(10) ||
										'Plan Financiación: '	|| tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion, cnuNVLTRC);
						pkg_traza.trace('=======================================================', cnuNVLTRC);
						
						-- Inserta registros en ldc_plfiaplpro
						pkg_ldc_plfiaplpro.prcInserRegistro(inuProducto,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPlanFinanciacion,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuPrioridad,
															tbPlanesFinanActivos(nuPlanesFinanActIdx).nuSegmeFinanId
															);
						COMMIT;
					END IF;
				
					nuDatosComercialesIdx := tbDatosComerciales.NEXT(nuDatosComercialesIdx);
				
				END LOOP;
			END IF;
		
			nuPlanesFinanActIdx := tbPlanesFinanActivos.NEXT(nuPlanesFinanActIdx);
		
		END LOOP;
    
		nuPlanFinanciacion := NULL;
		
		-- Obtiene el plan de financiación por producto
		nuPlanFinanciacion := pkg_ldc_plfiaplpro.fnuObtPlanFinanxProducto(inuProducto);
		pkg_traza.trace('nuPlanFinanciacion: '||nuPlanFinanciacion, cnuNVLTRC); 

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuPlanFinanciacion;  

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fnuPlanFinanMayorPrioridad;

END pkg_bosegmentacioncomercial;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_bosegmentacioncomercial
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bosegmentacioncomercial'), 'PERSONALIZACIONES');
END;
/