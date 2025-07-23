CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_plfiaplpro IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   02-04-2025
		Descripcion :   Paquete con la logica para la entidad ldc_plfiaplpro
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	02-04-2025	OSF-4155	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Borra registro por producto	
	PROCEDURE prcBorraRegistxProduc(inuProducto IN ldc_plfiaplpro.producto%TYPE);
	
	-- Inserta registros	
	PROCEDURE prcInserRegistro(inuProducto 			IN ldc_plfiaplpro.producto%TYPE,
							   inuPlanFinanSegme	IN ldc_plfiaplpro.idplafise%TYPE,
							   inuPrioridad			IN ldc_plfiaplpro.prioridad%TYPE,
							   inuFinanSegmenta		IN ldc_plfiaplpro.idplafise%TYPE
							   );
							   
	-- Obtiene el plan de financiación por producto
	FUNCTION fnuObtPlanFinanxProducto(inuProducto IN ldc_plfiaplpro.producto%TYPE)
	RETURN NUMBER;
									
END pkg_ldc_plfiaplpro;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_plfiaplpro IS

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
    Programa        : prcBorraRegistxProduc
    Descripcion     : Borra registro por producto
    Autor           : Jhon Erazo
    Fecha           : 02-04-2025
  
    Parametros de Entrada
		inuProducto 	Identificador del producto
	  
    Parametros de Salida	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	02/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcBorraRegistxProduc(inuProducto IN ldc_plfiaplpro.producto%TYPE)
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcBorraRegistxProduc';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		DELETE ldc_plfiaplpro
		WHERE producto = inuProducto;

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
	END prcBorraRegistxProduc;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInserRegistro
    Descripcion     : Inserta registros
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuProducto 		Identificador del producto
		inuPlanFinanSegme	Plan de financiación segmentado
		inuPrioridad		Prioridad
		inuFinanSegmenta	Financiación segmentada
	  
    Parametros de Salida	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcInserRegistro(inuProducto 			IN ldc_plfiaplpro.producto%TYPE,
							   inuPlanFinanSegme	IN ldc_plfiaplpro.idplafise%TYPE,
							   inuPrioridad			IN ldc_plfiaplpro.prioridad%TYPE,
							   inuFinanSegmenta		IN ldc_plfiaplpro.idplafise%TYPE
							   )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcInserRegistro';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' 		|| inuProducto 			|| CHR(10) ||
						'inuPlanFinanSegme: ' 	|| inuPlanFinanSegme 	|| CHR(10) ||
						'inuPrioridad: ' 		|| inuPrioridad 		|| CHR(10) ||
						'inuFinanSegmenta: ' 	|| inuFinanSegmenta, cnuNVLTRC);
		
		INSERT INTO ldc_plfiaplpro (producto,
									idplafise,
									prioridad,
									iden)
		VALUES (inuProducto,
				inuPlanFinanSegme,
				inuPrioridad,
				inuFinanSegmenta
				);

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
	END prcInserRegistro;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtPlanFinanxProducto
    Descripcion     : Obtiene el plan de financiación por producto
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuProducto		Producto
	  
    Parametros de Salida
		nuPlanFinanciacion		Plan de financiación
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fnuObtPlanFinanxProducto(inuProducto IN ldc_plfiaplpro.producto%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtPlanFinanxProducto';
		
		nuError				NUMBER;  
		nuPlanFinanciacion	NUMBER;
		sbmensaje			VARCHAR2(1000);	
		
		CURSOR cuplanfinan 
		IS
			SELECT planfinan
			FROM (SELECT x.idplafise planfinan
				  FROM ldc_plfiaplpro x
				  WHERE x.producto = inuProducto
				  ORDER BY x.prioridad
				  )
			WHERE ROWNUM = 1;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		IF (cuplanfinan%ISOPEN) THEN
			CLOSE cuplanfinan;
		END IF;
		
		OPEN cuplanfinan;
		FETCH cuplanfinan INTO nuPlanFinanciacion;
		CLOSE cuplanfinan;
		
		pkg_traza.trace('nuPlanFinanciacion: ' || nuPlanFinanciacion, cnuNVLTRC);

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
	END fnuObtPlanFinanxProducto;

END pkg_ldc_plfiaplpro;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_ldc_plfiaplpro
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_ldc_plfiaplpro'), 'adm_person');
END;
/