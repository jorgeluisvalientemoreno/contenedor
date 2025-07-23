CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bcsegmentacioncomercial IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   02-04-2025
		Descripcion :   Paquete con las consultas de segmentación comercial
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	02-04-2025	OSF-4155	Creación
	*******************************************************************************/
	
	-- Record de planes de financiación activos
	TYPE tyrcPlanesFinanActivos IS RECORD(nuSegmento 			NUMBER,
										  nuPlanFinanciacion	NUMBER,
										  nuSegmeFinanId		NUMBER,
										  nuPrioridad 			NUMBER
										  );

	-- Tipo tabla con los criterios por concepto y el tipo de producto
	TYPE tytbPlanesFinanActivos IS TABLE OF tyrcPlanesFinanActivos INDEX BY BINARY_INTEGER;
	
	-- Record de datos geopoliticos
	TYPE tyrcDatosGeopoliticos IS RECORD(nuSegmentoComercial 	NUMBER,
										 nuLocaliGeografica		NUMBER,
										 nuGeolocaInicial		NUMBER,
										 nuGeolocaFinal 		NUMBER,
										 nuGeolocaSegment		NUMBER,
										 nuDireccionSegmen		NUMBER,
										 nuCategoria			NUMBER,
										 nuSubcategoria			NUMBER,
										 nuCaracteristica		NUMBER
										 );

	-- Tipo tabla con los datos geopoliticos
	TYPE tytbDatosGeopoliticos IS TABLE OF tyrcDatosGeopoliticos INDEX BY BINARY_INTEGER;
	
	-- Record de datos Financieros
	TYPE tyrcDatosFinancieros IS RECORD(nuSegmentoComercial	NUMBER,
										nuEstadoCorte		NUMBER,
										nuPlanComercial		NUMBER,
										nuCaracteristica 	NUMBER
										);

	-- Tipo tabla con los datos geopoliticos
	TYPE tytbDatosFinancieros IS TABLE OF tyrcDatosFinancieros INDEX BY BINARY_INTEGER;
	
	-- Record de datos Comerciales
	TYPE tyrcDatosComerciales IS RECORD(nuSegmentoComercial	NUMBER,
										nuCantidadFinanciac	NUMBER,
										nuCuentasSaldo		NUMBER,
										sbEstadoFinanciero 	VARCHAR2(1),
										nuUltiPlanFinanc	NUMBER,
										nuCaracteristica	NUMBER
										);

	-- Tipo tabla con los datos Comerciales
	TYPE tytbDatosComerciales IS TABLE OF tyrcDatosComerciales INDEX BY BINARY_INTEGER;
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Obtiene en tipo tabla los planes de financiación activos	
	PROCEDURE prcObtPlanesFinanActivos(otbPlanesFinanActivos OUT tytbPlanesFinanActivos);
	
	-- Obtiene en tipo tabla los datos geopoliticos por segmento	
	PROCEDURE prcObtDatosGeopoxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
									  otbDatosGeopoliticos 	OUT tytbDatosGeopoliticos
									  );
									  
	-- Obtiene en tipo tabla los datos Financieros por segmento	
	PROCEDURE prcObtDatosFinanxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
									  otbDatosFinancieros 	OUT tytbDatosFinancieros
									  );
									  
	-- Obtiene en tipo tabla los datos comerciales por segmento	
	PROCEDURE prcObtDatosComerciaxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
										 otbDatosComerciales 	OUT tytbDatosComerciales
										 );
	
	-- Obtiene la cantidad de politicas por segmento	
	FUNCTION fnuObtCantiPolitixSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER;
	
	-- Obtiene la cantidad de financieras por segmento	
	FUNCTION fnuObtCantiFinanxSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER;
	
	-- Obtiene la cantidad de comerciales por segmento	
	FUNCTION fnuObtCantiComercxSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER;
									
END pkg_bcsegmentacioncomercial;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bcsegmentacioncomercial IS

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
    Programa        : prcObtPlanesFinanActivos
    Descripcion     : Obtiene en tipo tabla los planes de financiación activos
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
	  
    Parametros de Salida
		otbPlanesFinanActivos       Tabla con los planes de financiación activos
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtPlanesFinanActivos(otbPlanesFinanActivos OUT tytbPlanesFinanActivos)
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtPlanesFinanActivos';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		sbSpecials_plan	ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbObtieneValorCadena('SPECIALS_PLAN');
		
		CURSOR cuplanesfinactivos 
		IS
			SELECT s.commercial_segm_id segmento,
				   f.financing_plan_id,
				   f.com_seg_finan_id,
				   f.priority
			FROM cc_commercial_segm s, 
				 cc_com_seg_finan f, 
				 plandife p
			WHERE s.active 			 = 'Y'
            AND f.offer_class 		 = 3
            AND p.pldifefi 			 >= SYSDATE
            AND s.commercial_segm_id = f.commercial_segm_id
            AND f.financing_plan_id  = p.pldicodi
            AND p.pldicodi 			 NOT IN (SELECT TO_NUMBER(regexp_substr(sbSpecials_plan,'[^|,]+', 1, level))
											 FROM DUAL A
											 CONNECT BY regexp_substr(sbSpecials_plan, '[^|,]+', 1, level) IS NOT NULL
											 );	
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		IF (cuplanesfinactivos%ISOPEN) THEN
			CLOSE cuplanesfinactivos;
		END IF;
		
		OPEN cuplanesfinactivos;
		FETCH cuplanesfinactivos BULK COLLECT INTO otbPlanesFinanActivos;
		CLOSE cuplanesfinactivos;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcObtPlanesFinanActivos;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtDatosGeopoxSegmen
    Descripcion     : Obtiene en tipo tabla los datos geopoliticos por segmento
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuSegmento				  Segmento
	  
    Parametros de Salida
		otbDatosGeopoliticos       Tabla con los datos geopoliticos
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtDatosGeopoxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
									  otbDatosGeopoliticos 	OUT tytbDatosGeopoliticos
									  )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtDatosGeopoxSegmen';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cudatogeopolitico
		IS
			SELECT t.commercial_segm_id,
				   t.geog_geogph_loc_id,
				   t.geog_initial_number,
				   t.geog_final_number,
				   t.geog_segment_id,
				   t.geog_address_id,
				   t.geog_category_id,
				   t.geog_subcategory_id,
				   t.com_seg_fea_val_id
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
			AND (t.geog_geogph_loc_id 		IS NOT NULL
				 OR t.geog_segment_id 		IS NOT NULL
				 OR t.geog_initial_number 	IS NOT NULL
				 OR t.geog_final_number 	IS NOT NULL
				 OR t.geog_address_id 		IS NOT NULL
				 OR t.geog_category_id 		IS NOT NULL
				 OR t.geog_subcategory_id 	IS NOT NULL
				 );
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cudatogeopolitico%ISOPEN) THEN
			CLOSE cudatogeopolitico;
		END IF;
		
		OPEN cudatogeopolitico;
		FETCH cudatogeopolitico BULK COLLECT INTO otbDatosGeopoliticos;
		CLOSE cudatogeopolitico;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcObtDatosGeopoxSegmen;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtDatosFinanxSegmen
    Descripcion     : Obtiene en tipo tabla los datos financieros por segmento
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuSegmento					Segmento
	  
    Parametros de Salida
		otbDatosFinancieros       Tabla con los datos financieros
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtDatosFinanxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
									  otbDatosFinancieros 	OUT tytbDatosFinancieros
									  )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtDatosFinanxSegmen';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cudatosfinancieros
		IS
			SELECT t.commercial_segm_id,
               t.prod_cutting_state,
               t.prod_commercial_plan,
               t.com_seg_fea_val_id
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
            AND (t.prod_cutting_state 		IS NOT NULL
                 OR t.prod_commercial_plan  IS NOT NULL
				);
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cudatosfinancieros%ISOPEN) THEN
			CLOSE cudatosfinancieros;
		END IF;
		
		OPEN cudatosfinancieros;
		FETCH cudatosfinancieros BULK COLLECT INTO otbDatosFinancieros;
		CLOSE cudatosfinancieros;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcObtDatosFinanxSegmen;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtDatosComerciaxSegmen
    Descripcion     : Obtiene en tipo tabla los datos comerciales por segmento
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuSegmento					Segmento
	  
    Parametros de Salida
		otbDatosComerciales       Tabla con los datos comerciales
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtDatosComerciaxSegmen(inuSegmento			IN cc_com_seg_fea_val.commercial_segm_id%TYPE,
										 otbDatosComerciales 	OUT tytbDatosComerciales
										 )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtDatosComerciaxSegmen';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cudatosComerciales
		IS
			SELECT t.commercial_segm_id,
				   t.finan_finan_count,
				   t.finan_acc_balance,
				   t.finan_finan_state,
				   t.finan_last_fin_plan,
				   t.com_seg_fea_val_id
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
            AND (t.finan_finan_count 		IS NOT NULL
                 OR t.finan_acc_balance 	IS NOT NULL
                 OR t.finan_finan_state 	IS NOT NULL
                 OR t.finan_last_fin_plan 	IS NOT NULL
				 );
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cudatosComerciales%ISOPEN) THEN
			CLOSE cudatosComerciales;
		END IF;
		
		OPEN cudatosComerciales;
		FETCH cudatosComerciales BULK COLLECT INTO otbDatosComerciales;
		CLOSE cudatosComerciales;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcObtDatosComerciaxSegmen;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCantiPolitixSegmen
    Descripcion     : Obtiene la cantidad de politicas por segmento
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuSegmento		Segmento
	  
    Parametros de Salida
		nuCantPoliticas		Cantidad de politicas
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fnuObtCantiPolitixSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtCantiPolitixSegmen';
		
		nuError			NUMBER;  
		nuCantPoliticas	NUMBER;
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cupoliticas
		IS
			SELECT COUNT (1)
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
			AND (t.geog_geogph_loc_id 		IS NOT NULL
				 OR t.geog_segment_id 		IS NOT NULL
				 OR t.geog_initial_number 	IS NOT NULL
				 OR t.geog_final_number 	IS NOT NULL
				 OR t.geog_address_id 		IS NOT NULL
				 OR t.geog_category_id 		IS NOT NULL
				 OR t.geog_subcategory_id 	IS NOT NULL
				);
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cupoliticas%ISOPEN) THEN
			CLOSE cupoliticas;
		END IF;
		
		OPEN cupoliticas;
		FETCH cupoliticas INTO nuCantPoliticas;
		CLOSE cupoliticas;
		
		pkg_traza.trace('nuCantPoliticas: ' || nuCantPoliticas, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCantPoliticas;

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
	END fnuObtCantiPolitixSegmen;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCantiFinanxSegmen
    Descripcion     : Obtiene la cantidad de financieras por segmento
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuSegmento		Segmento
	  
    Parametros de Salida
		nuCantFinancieras		Cantidad de financieras
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fnuObtCantiFinanxSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtCantiFinanxSegmen';
		
		nuError			NUMBER;  
		nuCantFinancieras	NUMBER;
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cufinancieras
		IS
			SELECT COUNT (1)
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
			AND (t.prod_cutting_state 		IS NOT NULL
				 OR t.prod_commercial_plan 	IS NOT NULL
				); 
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cufinancieras%ISOPEN) THEN
			CLOSE cufinancieras;
		END IF;
		
		OPEN cufinancieras;
		FETCH cufinancieras INTO nuCantFinancieras;
		CLOSE cufinancieras;
		
		pkg_traza.trace('nuCantFinancieras: ' || nuCantFinancieras, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCantFinancieras;

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
	END fnuObtCantiFinanxSegmen;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCantiComercxSegmen
    Descripcion     : Obtiene la cantidad de comerciales por segmento
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuSegmento		Segmento
	  
    Parametros de Salida
		nuCantiComerciales		Cantidad de comerciales
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fnuObtCantiComercxSegmen(inuSegmento IN cc_commercial_segm.commercial_segm_id%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtCantiComercxSegmen';
		
		nuError			NUMBER;  
		nuCantiComerciales	NUMBER;
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cucomerciales 
		IS
			SELECT COUNT (1)
			FROM cc_com_seg_fea_val t
			WHERE t.commercial_segm_id = inuSegmento
			AND (t.finan_finan_count 		IS NOT NULL
				 OR t.finan_acc_balance 	IS NOT NULL
				 OR t.finan_finan_state 	IS NOT NULL
				 OR t.finan_last_fin_plan 	IS NOT NULL
				 );
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSegmento: ' || inuSegmento, cnuNVLTRC);
		
		IF (cucomerciales%ISOPEN) THEN
			CLOSE cucomerciales;
		END IF;
		
		OPEN cucomerciales;
		FETCH cucomerciales INTO nuCantiComerciales;
		CLOSE cucomerciales;
		
		pkg_traza.trace('nuCantiComerciales: ' || nuCantiComerciales, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCantiComerciales;

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
	END fnuObtCantiComercxSegmen;

END pkg_bcsegmentacioncomercial;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_bcsegmentacioncomercial
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bcsegmentacioncomercial'), 'PERSONALIZACIONES');
END;
/